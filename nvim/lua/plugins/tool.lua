---@type LazySpec
return {
  {
    "ellisonleao/glow.nvim",
    ft = "markdown",
    config = true,
  },
  {
    "2kabhishek/nerdy.nvim",
    dependencies = {
      "stevearc/dressing.nvim",
      "nvim-telescope/telescope.nvim",
    },
    cmd = "Nerdy",
  },
  {
    "MagicDuck/grug-far.nvim",
    cmd = "GrugFar",
    config = function()
      require("grug-far").setup {
        -- options, see Configuration section below
        -- there are no required options atm
        -- engine = 'ripgrep' is default, but 'astgrep' can be specified
      }
    end,
  },
  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
      { "tpope/vim-dadbod", lazy = true },
      { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true }, -- Optional
    },
    cmd = {
      "DBUI",
      "DBUIToggle",
      "DBUIAddConnection",
      "DBUIFindBuffer",
    },
    init = function()
      -- Your DBUI configuration
      vim.g.db_ui_use_nerd_fonts = 1
    end,
  },

  -- 自定义插件
  {
    dir = "~/.config/nvim/lua/custom/bufferjump",
    dependencies = { "MunifTanjim/nui.nvim" },
    keys = {
      {
        "B",
        function()
          require("custom.bufferjump").bufferjump()
        end,
        mode = "n",
        desc = "Buffer Jump",
      },
    },
  },
  {
    dir = "~/.config/nvim/lua/custom/betternoti",
    dependencies = { "rcarriga/nvim-notify" },
    event = "VeryLazy",
    config = function()
      local bt = require "custom.betternoti"
      bt.setup { blacklist = { "textDocument/" } }
      vim.notify = bt.notify
    end,
  },
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      bigfile = { enabled = true },
      -- dashboard = { enabled = true, },
      -- terminal = { enabled = true },
      -- notifier = { enabled = true, timeout = 5000 }, -- already have nvim-notify
      quickfile = { enabled = true },
      -- scroll = { enabled = true },
      indent = { enabled = true },
      -- input = { enabled = true }, -- already have dressing.nvim
      lazygit = { enabled = true },
      scope = { enabled = true },
      -- statuscolumn = { enabled = true },
      words = { enabled = true },
      picker = {
        prompt = "   ",
        layouts = {
          default = {
            layout = {
              box = "horizontal",
              width = 0.8,
              min_width = 120,
              height = 0.8,
              {
                box = "vertical",
                border = "solid",
                title = "{title} {live} {flags}",
                { win = "input", height = 2, border = "none" },
                { win = "list", border = "none" },
              },
              { win = "preview", title = "{preview}", border = "solid", width = 0.5 },
            },
          },
        },
      },
    },
    keys = {
      -- stylua: ignore start
      -- top
      { "<leader><space>", function() Snacks.picker.smart() end, desc = "Smart Find Files" },
      { "<leader>:", function() Snacks.picker.command_history() end, desc = "Command History" },
      { "<leader>gB", function() Snacks.gitbrowse() end, desc = "Git Browse", },
      { "<leader>gg", function() Snacks.lazygit() end, desc = "Lazygit", },

      -- Grep
      { "<leader>sb", function() Snacks.picker.lines() end, desc = "Buffer Lines" },
      { "<leader>sB", function() Snacks.picker.grep_buffers() end, desc = "Grep Open Buffers" },
      { "<leader>sg", function() Snacks.picker.grep() end, desc = "Grep" },
      { "<leader>sw", function() Snacks.picker.grep_word() end, desc = "Visual selection or word", mode = { "n", "x" } },
      -- find
      { "<leader>fb", function() Snacks.picker.buffers() end, desc = "Buffers" },
      { "<leader>fc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find Config File" },
      { "<leader>ff", function() Snacks.picker.files() end, desc = "Find Files" },
      { "<leader>fg", function() Snacks.picker.git_files() end, desc = "Find Git Files" },
      { "<leader>fp", function() Snacks.picker.projects() end, desc = "Projects" },
      { "<leader>fr", function() Snacks.picker.recent() end, desc = "Recent" },
      -- search
      { '<leader>s"', function() Snacks.picker.registers() end, desc = "Registers" },
      { '<leader>s/', function() Snacks.picker.search_history() end, desc = "Search History" },
      { "<leader>sa", function() Snacks.picker.autocmds() end, desc = "Autocmds" },
      { "<leader>sb", function() Snacks.picker.lines() end, desc = "Buffer Lines" },
      { "<leader>sc", function() Snacks.picker.command_history() end, desc = "Command History" },
      { "<leader>sC", function() Snacks.picker.commands() end, desc = "Commands" },
      { "<leader>sd", function() Snacks.picker.diagnostics() end, desc = "Diagnostics" },
      { "<leader>sD", function() Snacks.picker.diagnostics_buffer() end, desc = "Buffer Diagnostics" },
      { "<leader>sh", function() Snacks.picker.help() end, desc = "Help Pages" },
      { "<leader>sH", function() Snacks.picker.highlights() end, desc = "Highlights" },
      { "<leader>si", function() Snacks.picker.icons() end, desc = "Icons" },
      { "<leader>sj", function() Snacks.picker.jumps() end, desc = "Jumps" },
      { "<leader>sk", function() Snacks.picker.keymaps() end, desc = "Keymaps" },
      { "<leader>sl", function() Snacks.picker.loclist() end, desc = "Location List" },
      { "<leader>sm", function() Snacks.picker.marks() end, desc = "Marks" },
      { "<leader>sM", function() Snacks.picker.man() end, desc = "Man Pages" },
      { "<leader>sp", function() Snacks.picker.lazy() end, desc = "Search for Plugin Spec" },
      { "<leader>sq", function() Snacks.picker.qflist() end, desc = "Quickfix List" },
      { "<leader>sR", function() Snacks.picker.resume() end, desc = "Resume" },
      { "<leader>su", function() Snacks.picker.undo() end, desc = "Undo History" },
      -- stylua: ignore end
    },
    init = function()
      -- LSP-integrated file renaming with support for plugins
      local prev = { new_name = "", old_name = "" } -- Prevents duplicate events
      vim.api.nvim_create_autocmd("User", {
        pattern = "NvimTreeSetup",
        callback = function()
          local events = require("nvim-tree.api").events
          events.subscribe(events.Event.NodeRenamed, function(data)
            if prev.new_name ~= data.new_name or prev.old_name ~= data.old_name then
              data = data
              Snacks.rename.on_rename_file(data.old_name, data.new_name)
            end
          end)
        end,
      })
      vim.api.nvim_set_hl(0, "SnacksPickerTitle", { link = "TelescopePromptTitle" })
      vim.api.nvim_set_hl(0, "SnacksPickerPreviewTitle", { link = "TelescopePreviewTitle" })
      -- vim.api.nvim_set_hl(0, "SnacksPickerPrompt", { link = "TelescopePromptPrefix" })
      -- vim.api.nvim_set_hl(0, "SnacksPickerInput", { link = "TelescopePromptNormal" })
      -- vim.api.nvim_set_hl(0, "SnacksPickerBorder", { link = "TelescopeBorder" })
    end,
  },
}
