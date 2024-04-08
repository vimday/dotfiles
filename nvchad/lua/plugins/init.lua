return {
  {
    "stevearc/conform.nvim",
    config = function()
      require "configs.conform"
    end,
  },
  {
    "nvim-tree/nvim-tree.lua",
    opts = {
      git = { enable = true },
    },
  },
  {
    "folke/trouble.nvim",
    event = "BufRead",
  },
  {
    "goolord/alpha-nvim",
    lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("alpha").setup(require("alpha.themes.startify").config)
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  }, -- format & linting
  {
    "nvimtools/none-ls.nvim",
    dependencies = "neovim/nvim-lspconfig",
    event = "BufRead",
    config = function()
      local null_ls = require "null-ls"
      local b = null_ls.builtins

      local sources = {
        b.formatting.shfmt,
        b.formatting.black,
        -- b.formatting.clang_format.with {
        --   filetypes = { "proto" },
        -- },
        b.formatting.pg_format,
        b.formatting.prettier.with {
          disabled_filetypes = { "json" },
        },
        b.completion.spell.with {
          filetypes = { "markdown" },
        },
        b.diagnostics.codespell.with {
          diagnostics_postprocess = function(diagnostic)
            diagnostic.severity = vim.diagnostic.severity.INFO
          end,
          disabled_filetypes = { "NvimTree" },
          args = { "-L", "crate,ans,ratatui", "-" },
        },
      }
      null_ls.setup {
        -- debug = true,
        sources = sources,
      }
    end,
  },
  {
    "windwp/nvim-spectre",
    config = function()
      require("spectre").setup {
        mapping = {
          ["send_to_qf"] = {
            map = "<C-q>",
          },
        },
      }
    end,
  },
  {
    "f-person/git-blame.nvim",
    event = "BufRead",
  },
  {
    "folke/todo-comments.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    event = "BufRead",
    config = function()
      require("todo-comments").setup {}
    end,
  },
  {
    "nvim-tree/nvim-tree.lua",
    opts = {
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
    },
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "bash-language-server",
        "black",
        "codelldb",
        "codespell",
        "css-lsp",
        "json-lsp",
        "lua-language-server",
        "prettier",
        "prosemd-lsp",
        "pyright",
        "shfmt",
        "stylua",
        "yaml-language-server",
        "zk",
        "vim-language-server",
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "vimdoc",
        "html",
        "lua",
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
        "tsx",
        "http",
        "query",
      },
      highlight = {
        disable = function(_, bufnr)
          return vim.api.nvim_buf_line_count(bufnr) > 5000
        end,
      },
      playground = {
        enable = true,
        disable = {},
        updatetime = 25,         -- Debounced time for highlighting nodes in the playground from source code
        persist_queries = false, -- Whether the query persists across vim sessions
        keybindings = {
          toggle_query_editor = "o",
          toggle_hl_groups = "i",
          toggle_injected_languages = "t",
          toggle_anonymous_nodes = "a",
          toggle_language_display = "I",
          focus_language = "f",
          unfocus_language = "F",
          update = "R",
          goto_node = "<cr>",
          show_help = "?",
        },
      },
    },
  },
  { "nvim-treesitter/playground", event = "VeryLazy" },
  {
    "rhysd/conflict-marker.vim",
    event = "BufRead",
  },
  {
    "ggandor/leap.nvim",
    event = "VeryLazy",
    config = function()
      require("leap").add_default_mappings()
      vim.cmd [[nnoremap gs <Plug>(leap-from-window)]]
      vim.api.nvim_set_hl(0, "LeapBackdrop", { link = "Comment" }) -- or some grey
    end,
  },
  {
    "ggandor/flit.nvim",
    event = "VeryLazy",
    config = function()
      require("flit").setup()
    end,
  },
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup {
        -- Configuration here, or leave empty to use defaults
      }
    end,
  },
  {
    "sindrets/diffview.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    event = "VeryLazy",
  },
  {
    "tpope/vim-fugitive",
    cmd = {
      "Git",
      "G",
      "Gread"
    }
  },
  {
    "stevearc/dressing.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function()
      require("dressing").setup {}
    end,
  },
  {
    "kevinhwang91/nvim-bqf",
    ft = "qf",
    config = function()
      require("bqf").setup {
        auto_enabled = true,
        auto_resize_height = true, -- highly recommended enable
        preview = {
          should_preview_cb = function(bufnr, qwinid)
            local ret = true
            local bufname = vim.api.nvim_buf_get_name(bufnr)
            local fsize = vim.fn.getfsize(bufname)
            if fsize > 100 * 1024 or fsize == 0 then
              -- skip file size greater than 100k
              ret = false
            elseif bufname:match "^fugitive://" then
              -- skip fugitive buffer
              ret = false
            else
              ret = vim.fn.isdirectory(vim.fs.dirname(bufname))
            end
            return ret
          end,
        },
      }
    end,
  },
  {
    "editorconfig/editorconfig-vim",
    event = "VeryLazy",
    config = function()
      vim.g.EditorConfig_exclude_patterns = { "fugitive://.*", "scp://.*", "term://*" }
    end,
  },
  {
    "simrat39/symbols-outline.nvim",
    event = "BufRead",
    config = function()
      require("symbols-outline").setup()
    end,
  },
  {
    "toppair/reach.nvim",
    event = "BufRead",
    config = function()
      -- default config
      require("reach").setup {}
      vim.cmd [[
        hi! link ReachHandleDelete DiffRemoved
      ]]
    end,
  },
  {
    "ellisonleao/glow.nvim",
    ft = "markdown",
    config = true,
  },
  {
    "chentoast/marks.nvim",
    event = "VeryLazy",
    config = function()
      require("marks").setup {
        default_mappings = false,
      }
    end,
  },
  {
    "haringsrob/nvim_context_vt",
    event = "BufRead",
    config = function()
      require("nvim_context_vt").setup {
        prefix = "➜",
        min_rows = 20,
        disable_virtual_lines = true,
      }
    end,
  },
  {
    "SmiteshP/nvim-navic",
    dependencies = "neovim/nvim-lspconfig",
  },
  {
    "utilyre/barbecue.nvim",
    name = "barbecue",
    event = "BufRead",
    version = "*",
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons", -- optional dependency
    },
    opts = {
      attach_navic = false,
    },
  },
  {
    "ray-x/go.nvim",
    ft = { "go" },
    dependencies = { "neovim/nvim-lspconfig", "ray-x/guihua.lua" },
    config = function()
      require("go").setup()
    end,
  },
  {
    "mfussenegger/nvim-dap",
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap" },
    config = function()
      require("dapui").setup {}
      vim.api.nvim_create_user_command("DapEval", 'lua require("dapui").eval()', {})
    end,
  },
  {
    "theHamsta/nvim-dap-virtual-text",
    dependencies = { "mfussenegger/nvim-dap" },
    config = function()
      require("nvim-dap-virtual-text").setup {}
    end,
  },
  {
    "padde/jump.vim",
    event = "VeryLazy",
    config = function()
      vim.g.autojump_vim_command = "tcd"
    end,
  }, -- use for autojump
  {
    "tpope/vim-unimpaired",
    event = "VeryLazy",
  },
  {
    "windwp/nvim-ts-autotag",
    event = "BufRead",
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },
  {
    "zk-org/zk-nvim",
    event = "VeryLazy",
    config = function()
      require("zk").setup {
        picker = "telescope",
      }
      local opts = { noremap = true, silent = false }

      -- Create a new note after asking for its title.
      vim.api.nvim_set_keymap("n", "<leader>zn", "<Cmd>ZkNew { title = vim.fn.input('Title: ') }<CR>", opts)

      -- Open notes.
      vim.api.nvim_set_keymap("n", "<leader>zo", "<Cmd>ZkNotes { sort = { 'modified' } }<CR>", opts)
      -- Open notes associated with the selected tags.
      vim.api.nvim_set_keymap("n", "<leader>zt", "<Cmd>ZkTags<CR>", opts)

      -- Search for the notes matching a given query.
      vim.api.nvim_set_keymap(
        "n",
        "<leader>zf",
        "<Cmd>ZkNotes { sort = { 'modified' }, match = { vim.fn.input('Search: ') } }<CR>",
        opts
      )
    end,
  },
  {
    "preservim/vim-markdown",
    dependencies = "godlygeek/tabular",
    ft = "markdown",
  },
  {
    "godlygeek/tabular",
    ft = "markdown",
  },
  {
    "jbyuki/nabla.nvim",
    ft = "markdown",
    config = function()
      vim.cmd "command! Nabla :lua require('nabla').popup()<CR>[]"
    end,
  },
  {
    "wellle/targets.vim",
    event = "VeryLazy",
  },
  {
    "nvim-neotest/neotest",
    event = "BufRead",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      {
        "vim-test/vim-test",
        config = function()
          vim.cmd 'let test#strategy ="neovim"'
        end,
      },
      "nvim-neotest/neotest-plenary",
      "nvim-neotest/neotest-vim-test",
      -- "nvim-neotest/neotest-go",
      -- "rouge8/neotest-rust",
    },
    config = function()
      require("neotest").setup {
        adapters = {
          -- require "neotest-rust",
          -- require "neotest-go",
          require "neotest-plenary",
          require "neotest-vim-test",
        },
      }
    end,
  },
  {
    "sbdchd/neoformat",
    event = "VeryLazy",
    config = function()
      vim.g.neoformat_go_gofmt = {
        exe = "gofmt",
        args = { "-s" },
      }
    end,
  },
  -- {
  --   "chrisbra/csv.vim",
  --   ft = "csv",
  --   config = function()
  --     vim.g.no_csv_maps = 1
  --   end,
  -- },
  {
    "mechatroner/rainbow_csv",
    ft = "csv",
    config = function()
      vim.g.rbql_with_headers = 1
    end,
  },
  {
    "folke/which-key.nvim",
    enabled = true,
    keys = { "<leader>", '"', "'", "`", "z", "g" },
    opts = {
      plugins = {
        spelling = {
          enabled = true,   -- enabling this will show WhichKey when pressing z= to select spelling suggestions
          suggestions = 20, -- how many suggestions should be shown in the list?
        },
      },
    },
  },
  -- {
  --   "nvim-treesitter/nvim-treesitter-context",
  --   event = "BufRead",
  --   config = function()
  --     vim.cmd [[hi TreesitterContextBottom gui=underline guisp=Grey]]
  --     require("treesitter-context").setup {}
  --   end,
  -- },
  {
    "j-hui/fidget.nvim",
    enabled = false,
    config = function()
      require("fidget").setup {}
    end,
  },
  {
    "smjonas/live-command.nvim",
    event = "VeryLazy",
    config = function()
      require("live-command").setup {
        commands = {
          Norm = {
            cmd = "norm",
          },
        },
      }
    end,
  },
  {
    "rafcamlet/nvim-luapad",
    dependencies = "antoinemadec/FixCursorHold.nvim",
  },
  {
    "michaelb/sniprun",
    enabled = false,
    build = "bash ./install.sh",
    config = function()
      require("sniprun").setup {
        repl_enable = { "Python3_original" },
      }
    end,
  },
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    event = "VeryLazy",
    config = function()
      require("toggleterm").setup {
        open_mapping = [[<c-\>]],
        -- start_in_insert = false,
        shade_terminals = true,
        auto_scroll = false,
        float_opts = {
          border = "curved",
        },
      }
      vim.keymap.set("t", "jk", [[<C-\><C-n>]])
    end,
  },
  { "AndrewRadev/bufferize.vim",  cmd = "Bufferize" },
  {
    "leoluz/nvim-dap-go",
    ft = "go",
    config = function()
      require("dap-go").setup {
        -- Additional dap configurations can be added.
        -- dap_configurations accepts a list of tables where each entry
        -- represents a dap configuration. For more details do:
        -- :help dap-configuration
        dap_configurations = {
          {
            -- Must be "go" or it will be ignored by the plugin
            type = "go",
            name = "Attach remote",
            mode = "remote",
            request = "attach",
          },
        },
        -- delve configurations
        delve = {
          -- time to wait for delve to initialize the debug session.
          -- default to 20 seconds
          initialize_timeout_sec = 20,
          -- a string that defines the port to start delve debugger.
          -- default to string "${port}" which instructs nvim-dap
          -- to start the process in a random available port
          port = "${port}",
        },
      }
    end,
  },
  {
    "saecki/crates.nvim",
    version = "*",
    dependencies = "nvim-lua/plenary.nvim",
    event = { "BufRead Cargo.toml" },
    config = function()
      require("crates").setup {
        null_ls = {
          enabled = true,
          name = "crates.nvim",
        },
      }
    end,
  },
  {
    "dnlhc/glance.nvim",
    event = "VeryLazy",
    config = function()
      require("glance").setup {}
      -- Lua
      vim.keymap.set("n", "gpd", "<CMD>Glance definitions<CR>")
      vim.keymap.set("n", "gpr", "<CMD>Glance references<CR>")
      vim.keymap.set("n", "gpt", "<CMD>Glance type_definitions<CR>")
      vim.keymap.set("n", "gpi", "<CMD>Glance implementations<CR>")
    end,
  },
  { "tpope/vim-repeat", event = "VeryLazy" },
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    opts = {},
    ft = { "typescript", "typescriptreact" },
  },
  {
    "danymat/neogen",
    dependencies = "nvim-treesitter/nvim-treesitter",
    event = "VeryLazy",
    config = true,
  },
  -- {
  --   "github/copilot.vim",
  --   event = "VeryLazy",
  --   config = function()
  --     vim.cmd [[
  --       imap <silent><script><expr> <C-J> copilot#Accept("\<CR>")
  --       let g:copilot_no_tab_map = v:true
  --     ]]
  --     vim.api.nvim_set_var("copilot_filetypes", {
  --       ["dap-repl"] = false,
  --     })
  --   end,
  -- },
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup {
        suggestion = {
          enabled = true,
          auto_trigger = true,
          keymap = {
            accept = "<C-j>",
          },
        },
        filetypes = {
          yaml = true,
          markdown = true,
          gitcommit = true,
          gitrebase = true,
          ["dap-repl"] = false,
        },
      }
    end,
  },
  {
    "rcarriga/nvim-notify",
    event = "VeryLazy",
    config = function()
      vim.notify = require "notify"
    end,
  },
  {
    "gbprod/yanky.nvim",
    event = "BufRead",
    config = function()
      require("yanky").setup {
        highlight = {
          on_put = false,
          on_yank = false,
        },
      }
      require("telescope").load_extension "yank_history"
    end,
  },
  {
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    event = "VeryLazy",
    dependencies = "neovim/nvim-lspconfig",
    config = function()
      require("lsp_lines").setup()
      vim.diagnostic.config { virtual_lines = false }

      local function toggle_lsp_lines()
        local lsp_lines = require "lsp_lines"
        lsp_lines.toggle()

        local diag_config = vim.diagnostic.config()
        diag_config.virtual_text = not diag_config.virtual_lines
        vim.diagnostic.config(diag_config)
      end

      vim.api.nvim_create_user_command("LspLinesToggle", toggle_lsp_lines, { nargs = 0 })
    end,
  },
  {
    "andrewferrier/debugprint.nvim",
    opts = {
      create_keymaps = true,
      create_commands = true,
    },
    -- Remove the following line to use development versions,
    -- not just the formal releases
    version = "*",
    event = "BufRead",
  },
  {
    'kevinhwang91/nvim-hlslens',
    event = "VeryLazy",
    config = function()
      require('hlslens').setup()

      local kopts = { noremap = true, silent = true }

      vim.api.nvim_set_keymap('n', 'n',
        [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]],
        kopts)
      vim.api.nvim_set_keymap('n', 'N',
        [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]],
        kopts)
      vim.api.nvim_set_keymap('n', '*', [[*<Cmd>lua require('hlslens').start()<CR>]], kopts)
      vim.api.nvim_set_keymap('n', '#', [[#<Cmd>lua require('hlslens').start()<CR>]], kopts)
      vim.api.nvim_set_keymap('n', 'g*', [[g*<Cmd>lua require('hlslens').start()<CR>]], kopts)
      vim.api.nvim_set_keymap('n', 'g#', [[g#<Cmd>lua require('hlslens').start()<CR>]], kopts)
    end
  },
  {
    'NoahTheDuke/vim-just',
    ft = 'just',
  },
}
