local plugin_groups = {
  require "plugins.lang",
  require "plugins.ai",
  require "plugins.dap",
  require "plugins.git",
  require "plugins.tool",
  require "plugins.editor",
}

---@type LazySpec
local M = {
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  }, -- format & linting
  {
    "nvim-tree/nvim-tree.lua",
    opts = {
      git = { enable = true },
      notify = { threshold = vim.log.levels.WARN },
      renderer = {
        highlight_git = true,
        icons = {
          show = {
            git = true,
          },
        },
      },
    },
  },
  {
    "hrsh7th/cmp-cmdline",
    dependencies = { "hrsh7th/nvim-cmp", "hrsh7th/cmp-buffer" },
    event = "CmdlineEnter",
    config = function()
      local cmp = require "cmp"
      local mapping = cmp.mapping.preset.cmdline {}
      cmp.setup.cmdline("/", {
        mapping = mapping,
        sources = {
          { name = "buffer" },
        },
      })
      cmp.setup.cmdline("?", {
        mapping = mapping,
        sources = {
          { name = "buffer" },
        },
      })
      cmp.setup.cmdline(":", {
        mapping = mapping,
        sources = cmp.config.sources({
          { name = "path" },
        }, {
          {
            name = "cmdline",
            option = {
              ignore_cmds = { "Man", "!" },
            },
          },
        }),
      })
    end,
  },
}

for _, g in ipairs(plugin_groups) do
  M = vim.list_extend(M, g)
end

return M
