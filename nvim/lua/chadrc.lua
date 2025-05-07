local M = {}

local telescopeInputFg = "pink"

M.base46 = {
  theme = "jabuti",
  -- transparency = true,
  hl_override = {
    DiffAdd = { fg = "green", bg = "#123b1a" },
    DiffDelete = { fg = "red" },
    DiffChange = { fg = "orange" },
    Folded = { link = "DiagnosticVirtualTextInfo" },
    ["@keyword"] = { italic = true },
    ["@keyword.function"] = { link = "@keyword" },
    ["@keyword.return"] = { link = "@keyword" },
    ["@keyword.conditional"] = { link = "@keyword" },
    ["@keyword.repeat"] = { link = "@keyword" },
    TelescopePromptTitle = { bg = telescopeInputFg, fg = "#000000" },
    TelescopePromptPrefix = { fg = telescopeInputFg },
    NvDashFooter = { fg = "blue" },
  },
  theme_toggle = { "jabuti", "chadracula", "one_light" },
}

M.ui = {
  -- lazyload it when there are 1+ buffers
  tabufline = {
    lazyload = true,
  },
  cmp = {
    style = "atom_colored", -- default/flat_light/flat_dark/atom/atom_colored
  },
  statusline = {
    modules = {
      lsp_msg = function()
        local clients = vim.lsp.get_clients { bufnr = 0 }
        for _, client in ipairs(clients) do
          if client.name == "copilot" then
            return "  Take it lazy 󰒲 "
          end
        end
        return "  Take it easy !"
      end,
    },
  },
}

M.nvdash = {
  load_on_startup = true,
  buttons = {
    { txt = "  AI Chat", keys = "a", cmd = "lua vim.cmd'CodeCompanionChat Toggle'; vim.cmd'wincmd p | q'" },
    { txt = "  New File", keys = "n", cmd = "enew" },
    { txt = "  Find File", keys = "f", cmd = "lua Snacks.picker.files()" },
    { txt = "󰈭  Find Word", keys = "w", cmd = "lua Snacks.picker.grep()" },
    -- { txt = "  Recent Files", keys = "r", cmd = "lua Snacks.picker.recent()" },
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
    {
      txt = "💎🙌 ₿ Ξ It's time to build!",
      hl = "NvDashFooter",
      no_gap = true,
    },
  },
}

M.term = {
  float = {
    row = 0.01,
    col = 0,
    width = 1,
    height = 0.9,
    border = "rounded",
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
