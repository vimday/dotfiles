#!/usr/bin/env bash

input=$(cat)

null2zero() {
  local v="$1"
  [[ "$v" == "null" || -z "$v" ]] && echo "0" || echo "$v"
}

# ── Modern Cyberpunk palette ──────────────────────────────────
CYAN="\033[38;5;87m"        # Soft cyan
MAGENTA="\033[38;5;176m"    # Muted magenta
LIME="\033[38;5;120m"       # Soft lime
ORANGE="\033[38;5;180m"     # Warm orange
PURPLE="\033[38;5;147m"     # Soft purple
PINK="\033[38;5;182m"       # Muted pink
YELLOW="\033[38;5;186m"     # Soft yellow
RED="\033[38;5;174m"        # Soft red
BLUE="\033[38;5;111m"       # Muted blue
GRAY="\033[38;5;246m"       # Light gray
DIM="\033[38;5;240m"        # Dark gray
BOLD="\033[1m"
RST="\033[0m"

# ── Extract ───────────────────────────────────────────────────
MDL=$(echo "$input" | jq -r '.model.id // "?"')
CWD=$(echo "$input" | jq -r '.workspace.current_dir // "?"')
LINES_ADDED=$(null2zero "$(echo "$input" | jq -r '.cost.total_lines_added')")
LINES_REMOVED=$(null2zero "$(echo "$input" | jq -r '.cost.total_lines_removed')")
COST=$(echo "$input" | jq -r '.cost.total_cost_usd' | awk '{printf "%.2f", $0}')
DURATION_S=$(echo "$input" | jq -r '.cost.total_duration_ms' | awk '{printf "%.0f", $0 / 1000}')

# ── Shorten model ─────────────────────────────────────────────
SHORT_MDL=$(echo "$MDL" | sed -E 's/^claude-//; s/\[([0-9]+)m\]/[\1M]/; s/-([0-9]+)-([0-9]+)/\1.\2/')

# ── Shorten dir: last 2 components ───────────────────────────
SHORT_DIR=$(echo "$CWD" | awk -F/ '{if(NF>=2) print $(NF-1)"/"$NF; else print $NF}')

# ── Git branch + status ───────────────────────────────────────
BRANCH=$(git -C "$CWD" rev-parse --abbrev-ref HEAD 2>/dev/null)
GIT_STATUS=""
if [ -n "$BRANCH" ]; then
  # Trim branch name if too long - show last 20 chars
  if [ "${#BRANCH}" -gt 20 ]; then
    BRANCH="…${BRANCH: -20}"
  fi

  UNCOMMITTED=$(git -C "$CWD" status --porcelain 2>/dev/null | wc -l | tr -d ' ')
  if [ "$UNCOMMITTED" -gt 0 ]; then
    GIT_STATUS=" ${DIM}(${UNCOMMITTED})${RST}"
  fi
fi

# ── Duration format ───────────────────────────────────────────
if [ "$DURATION_S" -ge 3600 ]; then
  DURATION="$((DURATION_S/3600))h$((DURATION_S%3600/60))m"
elif [ "$DURATION_S" -ge 60 ]; then
  M_=$((DURATION_S/60)); S_=$((DURATION_S%60))
  [ "$S_" -eq 0 ] && DURATION="${M_}m" || DURATION="${M_}m${S_}s"
else
  DURATION="${DURATION_S}s"
fi

# ── Time-based greeting ───────────────────────────────────────
HOUR=$(date +%H)
if [ "$HOUR" -ge 5 ] && [ "$HOUR" -lt 12 ]; then
  GREETING="morning"
elif [ "$HOUR" -ge 12 ] && [ "$HOUR" -lt 18 ]; then
  GREETING="afternoon"
elif [ "$HOUR" -ge 18 ] && [ "$HOUR" -lt 23 ]; then
  GREETING="evening"
else
  GREETING="late night"
fi

# ── Tokens + throughput ───────────────────────────────────────
TOTAL_INPUT=$(echo "$input" | jq -r '.context_window.total_input_tokens // 0')
TOTAL_OUTPUT=$(echo "$input" | jq -r '.context_window.total_output_tokens // 0')
TOTAL_TOKENS=$(( TOTAL_INPUT + TOTAL_OUTPUT ))

# Calculate throughput with color coding
TPS=0
TPS_COLOR="$GRAY"
if [ "$DURATION_S" -gt 0 ] && [ "$TOTAL_TOKENS" -gt 0 ]; then
  TPS=$(( TOTAL_TOKENS / DURATION_S ))
  # Color code based on speed
  if [ "$TPS" -ge 100 ]; then
    TPS_COLOR="$LIME"    # Fast
  elif [ "$TPS" -ge 50 ]; then
    TPS_COLOR="$CYAN"    # Medium
  else
    TPS_COLOR="$ORANGE"  # Slow
  fi
fi

# ── Efficiency: tokens per dollar (removed for simplicity) ────

# ── Context bar with smart warnings ───────────────────────────
USED_PCT=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
CONTEXT_SIZE=$(echo "$input" | jq -r '.context_window.context_window_size // 0')

CTX=""
CTX_HINT=""
if [ -n "$USED_PCT" ]; then
  USED_INT=${USED_PCT%.*}
  USED_INT=${USED_INT:-0}

  # Color and hint based on usage
  if [ "$USED_INT" -lt 30 ]; then
    CTXC="$CYAN"
    CTX_HINT="plenty of room"
  elif [ "$USED_INT" -lt 60 ]; then
    CTXC="$LIME"
    CTX_HINT="cruising"
  elif [ "$USED_INT" -lt 80 ]; then
    CTXC="$YELLOW"
    CTX_HINT="getting full"
  elif [ "$USED_INT" -lt 90 ]; then
    CTXC="$ORANGE"
    CTX_HINT="consider /compact"
  else
    CTXC="$RED"
    CTX_HINT="⚠ running low"
  fi

  BAR_LEN=10
  FILLED=$(( (USED_INT * BAR_LEN + 50) / 100 ))
  EMPTY=$(( BAR_LEN - FILLED ))
  BAR=""
  for ((i=0; i<FILLED; i++)); do BAR+="━"; done
  for ((i=0; i<EMPTY; i++)); do BAR+="╌"; done

  CTX="${DIM}[${RST}${CTXC}${BAR}${RST}${DIM}]${RST} ${CTXC}${USED_INT}%${RST}"
fi

# ── Dynamic fun quotes based on state ─────────────────────────
# Choose quote based on context
if [ "$USED_INT" -ge 80 ]; then
  QUOTES=("memory pressure" "context filling" "tokens piling up" "brain getting full")
elif [ "$DURATION_S" -ge 600 ]; then
  QUOTES=("marathon mode" "long haul" "deep session" "in the zone")
elif [ "$LINES_ADDED" -ge 100 ] || [ "$LINES_REMOVED" -ge 100 ]; then
  QUOTES=("code tsunami" "refactor party" "diff explosion" "busy fingers")
else
  QUOTES=("beep boop" "silicon dreams" "neural nets firing" "AI go brr" "tokens flowing" "compiling reality" "parsing universe" "quantum vibes" "hallucinating responsibly" "dreaming in tensors" "gradient descent" "backprop life" "$GREETING hacking")
fi

QUOTE_IDX=$(( DURATION_S % ${#QUOTES[@]} ))
QUOTE="${QUOTES[$QUOTE_IDX]}"

# ── Cost tracking (removed for simplicity) ────────────────────

# ── Assemble ──────────────────────────────────────────────────
SEP="${DIM}│${RST}"

# Header: ⬡ root@model
printf "${CYAN}⬡${RST} ${MAGENTA}${BOLD}root${RST}${DIM}@${RST}${PURPLE}${BOLD}${SHORT_MDL}${RST}"

# Directory + branch + uncommitted files
printf " ${SEP} "
printf "${BLUE}▸ %s${RST}" "$SHORT_DIR"
if [ -n "$BRANCH" ]; then
  printf "${DIM}:${RST}${PINK}%s${RST}%b" "$BRANCH" "$GIT_STATUS"
fi

# Code changes
printf " ${SEP} "
printf "${LIME}+${LINES_ADDED}${RST} ${RED}-${LINES_REMOVED}${RST}"

# Cost
printf " ${SEP} "
printf "${ORANGE}◈ \$${COST}${RST}"

# Duration + throughput (color coded)
printf " ${SEP} "
printf "${PURPLE}◷ ${DURATION}${RST}"
if [ "$TPS" -gt 0 ]; then
  printf " ${TPS_COLOR}⚡${TPS}t/s${RST}"
fi

# Context bar with hint
if [ -n "$CTX" ]; then
  printf " ${SEP} %b %b" "$CTX" "${DIM}${CTX_HINT}${RST}"
fi

# Fun quote
printf " ${SEP} ${DIM}${QUOTE}${RST}"
