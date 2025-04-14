local M = {}

-- dracula colors
local cyan = "#8be9fd"
local green = "#50fa7b"

M.base46 = {
  theme = "chadracula",
  -- transparency = true,
  hl_override = {
    DiffAdd = { fg = "green", bg = "#123b1a" },
    DiffDelete = { fg = "red" },
    DiffChange = { fg = "orange" },
    WildMenu = { fg = "#6ad8eD", bg = "#30385f" },
    IncSearch = { bg = "#e0af68", fg = "#373640" },
    ["@keyword"] = { italic = true },
    ["@keyword.function"] = { link = "@keyword" },
    ["@keyword.return"] = { link = "@keyword" },
    ["@keyword.conditional"] = { link = "@keyword" },
    ["@keyword.repeat"] = { link = "@keyword" },
    FloatTitle = { bg = cyan, fg = "#000000" },
    -- FloatBorder = { fg = cyan },
  },
  theme_toggle = { "chadracula", "one_light" },
}

M.ui = {
  -- lazyload it when there are 1+ buffers
  tabufline = {
    lazyload = true,
  },
  cmp = {
    style = "atom_colored", -- default/flat_light/flat_dark/atom/atom_colored
  },
}

M.nvdash = {
  load_on_startup = true,
  buttons = {
    { txt = "  Find File", keys = "ff", cmd = "Telescope find_files" },
    { txt = "  Recent Files", keys = "fo", cmd = "Telescope oldfiles" },
    { txt = "󰈭  Find Word", keys = "fw", cmd = "Telescope live_grep" },
    -- { txt = "󱥚  Themes", keys = "th", cmd = ":lua require('nvchad.themes').open()" },
    -- { txt = "  Mappings", keys = "ch", cmd = "NvCheatsheet" },
    { txt = "󰒲  lazy", keys = "L", cmd = "Lazy" },
    { txt = "󰭻  Load Session", keys = "l", cmd = "lua require('configs.util').load_session_for_cwd()" },
    { txt = "  Sessions", keys = "s", cmd = "Telescope persisted" },
    { txt = "󰗼  Quit", keys = "q", cmd = "q" },
    { txt = "─", hl = "NvDashFooter", no_gap = true, rep = true },
    {
      txt = function()
        local stats = require("lazy").stats()
        local ms = math.floor(stats.startuptime) .. " ms"
        return "  Loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms
      end,
      hl = "NvDashFooter",
      no_gap = true,
    },
    { txt = "─", hl = "NvDashFooter", no_gap = true, rep = true },
  },
}

M.mason = {
  cmd = true,
  pkgs = {
    -- LSP servers
    "bash-language-server",
    "css-lsp",
    "eslint-lsp",
    "gopls",
    "helm-ls",
    "html-lsp",
    "json-lsp",
    "lua-language-server",
    "nil",
    "prosemd-lsp",
    "pyright",
    "rnix-lsp",
    "rust-analyzer",
    "tailwindcss-language-server",
    "typescript-language-server",
    "vim-language-server",
    "vue-language-server",
    "vtsls",
    "yaml-language-server",
    "zk",

    -- DAP
    "codelldb",

    -- Formatters
    "black",
    "gofumpt",
    "goimports",
    "golines",
    "isort",
    "prettier",
    "prettierd",
    "shfmt",
    "sqlfluff",
    "stylua",
    "taplo",

    -- Linters
    "ast-grep",
    "codespell",
    "golangci-lint",
    "golangci-lint-langserver",
    "ruff",
  },
}

return M
