local M = {
  -- utils
  ["folke/trouble.nvim"] = {},
  ["kosayoda/nvim-lightbulb"] = {
    config = function()
      vim.cmd [[autocmd CursorHold * lua require'nvim-lightbulb'.update_lightbulb()]]
    end,
  },
  -- lsp
  ["neovim/nvim-lspconfig"] = {
    config = function()
      require "custom.plugins.lspconfig"
    end,
  },
  -- format & linting
  ["jose-elias-alvarez/null-ls.nvim"] = {
    after = "nvim-lspconfig",
    config = function()
      require "custom.plugins.null-ls"
    end,
  },
  ["windwp/nvim-spectre"] = {
    config = function()
      require("spectre").setup { mapping = { ["send_to_qf"] = { map = "<localLeader>q" } } }
    end,
  },
  ["m-demare/hlargs.nvim"] = {
    requires = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("hlargs").setup()
      vim.cmd [[highlight! link Hlargs TSParameter]]
    end,
  },
  -- { "f-person/git-blame.nvim", event = "BufRead" },
  ["ggandor/lightspeed.nvim"] = {
    config = function()
      require("lightspeed").setup {
        ignore_case = true,
      }
    end,
  },
  ["tpope/vim-surround"] = {},
  ["simrat39/rust-tools.nvim"] = {
    after = "nvim-lspconfig",
    config = function()
      require("rust-tools").setup {
        server = {
          standalone = false,
          on_attach = require("plugins.configs.lspconfig").on_attach,
        },
      }
    end,
  },
  ["sindrets/diffview.nvim"] = { requires = "nvim-lua/plenary.nvim" },
  ["tpope/vim-fugitive"] = {},
  ["tpope/vim-rhubarb"] = {},
  ["NTBBloodbath/rest.nvim"] = {
    config = function()
      require("rest-nvim").setup {}
      vim.cmd [[
             nnoremap <leader>rr <Plug>RestNvim
             nnoremap <leader>rp <Plug>RestNvimPreview
             nnoremap <leader>rl <Plug>RestNvimLast
         ]]
    end,
  },
  ["jbyuki/venn.nvim"] = {
    config = function()
      local venn = require "venn"
      venn.set_line({ "s", "s", " ", " " }, "|")
      venn.set_line({ " ", "s", " ", "s" }, "+")
      venn.set_line({ "s", " ", " ", "s" }, "+")
      venn.set_line({ " ", "s", "s", " " }, "+")
      venn.set_line({ "s", " ", "s", " " }, "+")
      venn.set_line({ " ", "s", "s", "s" }, "+")
      venn.set_line({ "s", " ", "s", "s" }, "+")
      venn.set_line({ "s", "s", " ", "s" }, "+")
      venn.set_line({ "s", "s", "s", " " }, "+")
      venn.set_line({ "s", "s", "s", "s" }, "+")
      venn.set_line({ " ", " ", "s", "s" }, "-")
      venn.set_arrow("up", "^")
      venn.set_arrow("down", "v")
      venn.set_arrow("left", "<")
      venn.set_arrow("right", ">")

      -- venn.nvim: enable or disable keymappings
      function _G.ToggleVenn()
        local venn_enabled = vim.inspect(vim.b.venn_enabled)
        if venn_enabled == "nil" then
          vim.b.venn_enabled = true
          vim.cmd [[setlocal ve=all]]
          -- draw a line on HJKL keystrokes
          vim.api.nvim_buf_set_keymap(0, "n", "J", "<C-v>j:VBox<CR>", { noremap = true })
          vim.api.nvim_buf_set_keymap(0, "n", "K", "<C-v>k:VBox<CR>", { noremap = true })
          vim.api.nvim_buf_set_keymap(0, "n", "L", "<C-v>l:VBox<CR>", { noremap = true })
          vim.api.nvim_buf_set_keymap(0, "n", "H", "<C-v>h:VBox<CR>", { noremap = true })
          -- draw a box by pressing "f" with visual selection
          vim.api.nvim_buf_set_keymap(0, "v", "f", ":VBox<CR>", { noremap = true })
        else
          vim.cmd [[setlocal ve=]]
          vim.cmd [[mapclear <buffer>]]
          vim.b.venn_enabled = nil
        end
      end

      vim.api.nvim_set_keymap("n", "<leader>tv", ":lua ToggleVenn()<CR>", { noremap = true })
    end,
  },
  ["stevearc/dressing.nvim"] = {
    config = function()
      require("dressing").setup {}
    end,
  },
  ["Shatur/neovim-session-manager"] = {
    requires = "nvim-lua/plenary.nvim",
    config = function()
      require("session_manager").setup {
        autoload_mode = require("session_manager.config").AutoloadMode.CurrentDir,
      }
    end,
  },
  ["kevinhwang91/nvim-bqf"] = { ft = "qf" },
  ["editorconfig/editorconfig-vim"] = {
    config = function()
      vim.g.EditorConfig_exclude_patterns = { "fugitive://.*", "scp://.*", "term://*" }
    end,
  },
  ["nvim-treesitter/playground"] = {},
  ["simrat39/symbols-outline.nvim"] = {},
  ["toppair/reach.nvim"] = {
    config = function()
      -- default config
      require("reach").setup {
        notifications = true,
      }
      vim.cmd [[
        nnoremap B <cmd>:ReachOpen buffers<CR>
        nnoremap M <cmd>:ReachOpen marks<CR>
      ]]
    end,
  },
  ["simnalamburt/vim-mundo"] = {},
  ["ellisonleao/glow.nvim"] = {
    config = function()
      require("glow").setup {}
    end,
  },
  ["chentoast/marks.nvim"] = {
    config = function()
      require("marks").setup {
        default_mappings = false,
      }
    end,
  },
  ["AndrewRadev/bufferize.vim"] = {},
  ["haringsrob/nvim_context_vt"] = {
    config = function()
      require("nvim_context_vt").setup {
        prefix = "➜",
        min_rows = 20,
        disable_virtual_lines = true,
      }
    end,
  },
  ["ray-x/go.nvim"] = {
    after = "nvim-lspconfig",
    ft = { "go" },
    config = function()
      require("go").setup()
    end,
  },
  ["nvim-telescope/telescope.nvim"] = { module = "telescope" },
  ["mfussenegger/nvim-dap"] = {
    config = function()
      require "custom.plugins.dap"
    end,
  },
  ["rcarriga/nvim-dap-ui"] = {
    requires = { "mfussenegger/nvim-dap" },
    config = function()
      require("dapui").setup {}
    end,
  },
  ["theHamsta/nvim-dap-virtual-text"] = {
    config = function()
      require("nvim-dap-virtual-text").setup()
    end,
    requires = { "mfussenegger/nvim-dap" },
  },
  ["danymat/neogen"] = {
    config = function()
      require("neogen").setup {}
    end,
    requires = "nvim-treesitter/nvim-treesitter",
  },
  ["padde/jump.vim"] = {}, -- use for autojump
  ["tpope/vim-unimpaired"] = {},
  ["mickael-menu/zk-nvim"] = {
    config = function()
      require("zk").setup {
        picker = "telescope",
      }
      local m = function(mode, lhs, rhs)
        vim.api.nvim_set_keymap(mode, lhs, rhs, { noremap = true, silent = false })
      end

      -- Create a new note after asking for its title.
      m("n", "<leader>zn", "<Cmd>ZkNew { title = vim.fn.input('Title: ') }<CR>")
      -- Open notes.
      m("n", "<leader>zo", "<Cmd>ZkNotes { sort = { 'modified' } }<CR>")
      -- Open notes associated with the selected tags.
      m("n", "<leader>zt", "<Cmd>ZkTags<CR>")
      -- Open notes linking to the current buffer.
      m("n", "<leader>zb", "<Cmd>ZkBacklinks<CR>")
      -- Alternative for backlinks using pure LSP and showing the source context.
      --map('n', '<leader>zb', '<Cmd>lua vim.lsp.buf.references()<CR>')
      -- Open notes linked by the current buffer.
      m("n", "<leader>zl", "<Cmd>ZkLinks<CR>")
      -- Search for the notes matching a given query.
      m("n", "<leader>zf", "<Cmd>ZkNotes { sort = { 'modified' }, match = vim.fn.input('Search: ') }<CR>")
      -- Search for the notes matching the current visual selection.
      m("v", "<leader>zf", ":'<,'>ZkMatch<CR>")
      -- Create a new daily note
      m("n", "<leader>zd", "<Cmd>ZkNew { group = 'daily' }<CR>")
    end,
  },
  ["preservim/vim-markdown"] = { requires = "godlygeek/tabular", ft = "markdown" },
  ["jbyuki/nabla.nvim"] = {
    config = function()
      vim.cmd "command! Nabla :lua require('nabla').popup()<CR>[]"
    end,
  },
  ["wellle/targets.vim"] = {},
  -- { "psliwka/vim-dirtytalk", run = "DirtytalkUpdate" },
  ["nvim-neotest/neotest"] = {
    requires = {
      "vim-test/vim-test",
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-neotest/neotest-plenary",
      "nvim-neotest/neotest-go",
      "nvim-neotest/neotest-vim-test",
    },
    config = function()
      require("neotest").setup {
        adapters = {
          require "neotest-plenary",
          require "neotest-go",
          require "neotest-vim-test" {
            ignore_file_types = { "vim", "lua", "go" },
          },
        },
      }
    end,
  },
  ["freitass/todo.txt-vim"] = {},
  ["sbdchd/neoformat"] = {},
  ["chrisbra/csv.vim"] = {
    ft = "csv",
    config = function()
      vim.g.no_csv_maps = 1
    end,
  },
  -- { "github/copilot.vim" },
}

return M
