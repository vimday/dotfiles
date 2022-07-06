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
      "markdown",
      "c",
      "rust",
      "go",
      "python",
      "bash",
      "lua",
      "tsx",
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
