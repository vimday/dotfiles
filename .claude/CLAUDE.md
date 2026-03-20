---
description: Global Claude Code Configuration - Applies to All Projects
alwaysApply: true
---

# Global CLAUDE.md

> Rust/Go/Python full-stack developer (macOS + Linux/WSL2). Communicates in Chinese. Uses yadm for cross-platform dotfiles, gstack for skills.

## Communication

- Respond in Chinese for conversations, confirmations, and workflow prompts
- Use English for code, comments, commit messages, and technical identifiers
- Before committing, always ask: "代码已验证通过。是否创建 commit？"

## Build System Respect (MANDATORY)

When a project has a build system (Makefile, npm scripts, gradle, etc.), PREFER using it over direct tool invocation. Build systems encode project-specific flags, dependencies, and environment setup.

- Makefile → `make test` not `cargo test`
- package.json → `npm test` not `jest`
- build.gradle → `./gradlew test` not direct commands

## Verification Protocol (MANDATORY)

1. **Test-before-commit**: verify changes with project's test command; never commit untested code
2. **Incremental**: verify each phase independently before proceeding; don't accumulate unverified changes
3. **No false claims**: never say "完成" or claim success without build verification output

## Session Hygiene

- `/clear` between major task switches
- `/compact` for long sessions (>20 turns)
- Don't mix unrelated tasks in one session

### Compact Priority

When compressing context, preserve in this order:
1. Architecture decisions and constraints (NEVER summarize)
2. Modified files with key changes
3. Verification status (pass/fail)
4. Open TODOs
5. Tool outputs (can delete, keep pass/fail only)

## Documentation Policy

- Don't create documentation files (*.md, README) unless explicitly requested
- Don't create CLAUDE.md in subdirectories without explicit request

## Dotfiles (yadm)

- `yadm` manages dotfiles (`~/.claude/`, `~/.config/`, `~/.zshrc`, etc.)
- Check `yadm status` before and after editing dotfiles
- Never `yadm push` without asking

## gstack

- Use /browse skill for all web browsing; never use mcp__claude-in-chrome__* tools
- If skills aren't working: `cd ~/.claude/skills/gstack && ./setup`
