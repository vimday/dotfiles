---@type LazySpec
return {
  {
    "f-person/git-blame.nvim",
    event = "BufRead",
    opts = {
      enabled = true, -- if you want to enable the plugin
      message_template = "    <author> • <summary> • <<sha>> at <date>", -- template for the blame message, check the Message template section for more options
      date_format = "%Y-%m-%d %H:%M", -- template for the date, check Date format section for more options
      virtual_text_column = 1, -- virtual text start column, check Start virtual text at column section for more options
    },
  },
  {
    "akinsho/git-conflict.nvim",
    version = "*",
    config = function()
      require("git-conflict").setup {
        default_mappings = false,
      }
    end,
    init = function()
      vim.api.nvim_create_autocmd("User", {
        pattern = "GitConflictDetected",
        callback = function()
          local opts = { buffer = true }
          local map = vim.keymap.set
          map("n", "co", "<Plug>(git-conflict-ours)", opts)
          map("n", "ct", "<Plug>(git-conflict-theirs)", opts)
          map("n", "cb", "<Plug>(git-conflict-both)", opts)
          map("n", "c0", "<Plug>(git-conflict-none)", opts)
          map("n", "[x", "<Plug>(git-conflict-prev-conflict)", opts)
          map("n", "]x", "<Plug>(git-conflict-next-conflict)", opts)
        end,
      })
    end,
    event = "BufRead",
  },
  {
    "tpope/vim-fugitive",
    cmd = { "Git", "G" },
    event = "BufRead",
  },
  {
    "linrongbin16/gitlinker.nvim", -- generate git link at current line
    cmd = "GitLink",
    opts = {},
    keys = {
      { "<leader>gy", "<cmd>GitLink<cr>", mode = { "n", "v" }, desc = "Yank git link" },
      { "<leader>gY", "<cmd>GitLink!<cr>", mode = { "n", "v" }, desc = "Open git link" },
    },
    config = function()
      require("gitlinker").setup {
        router = {
          browse = {
            ["^github.freewheel.tv"] = require("gitlinker.routers").github_browse,
            ["^dev.msh.team"] = require("gitlinker.routers").github_browse,
          },
          blame = {
            ["^github.freewheel.tv"] = require("gitlinker.routers").github_blame,
            ["^dev.msh.team"] = require("gitlinker.routers").github_blame,
          },
        },
      }
    end,
  },
  {
    "sindrets/diffview.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    cmd = { "DiffviewOpen" },
  },
}
