-- overriding default plugin configs!

local M = {}

M.treesitter = {
  ensure_installed = {
    "vim",
    "html",
    "css",
    "javascript",
    "typescript",
    "json",
    "toml",
    "yaml",
    "markdown",
    "c",
    "rust",
    "go",
    "python",
    "bash",
    "lua",
    "tsx",
    "http",
  },
}

M.nvimtree = {
  git = {
    enable = true,
  },
  renderer = {
    highlight_git = true,
    icons = {
      show = {
        git = true,
      },
    },
  },
}

return M
