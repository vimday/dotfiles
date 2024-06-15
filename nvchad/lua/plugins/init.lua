return {
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      {
        -- Customize or remove this keymap to your liking
        "<leader>fm",
        function()
          require("conform").format { async = true, lsp_fallback = true }
        end,
        mode = "n",
        desc = "Format buffer",
      },
    },
    -- Everything in opts will be passed to setup()
    opts = {
      -- Define your formatters
      formatters_by_ft = {
        lua = { "stylua" },
        python = { "isort", "black" },
        javascript = { { "prettierd", "prettier" } },
        go = { "goimports", "gofmt" },
      },
      -- Set up format-on-save
      -- format_on_save = { timeout_ms = 500, lsp_fallback = true },
      -- Customize formatters
      formatters = {
        shfmt = {
          prepend_args = { "-i", "2" },
        },
      },
    },
  },
  {
    "nvim-tree/nvim-tree.lua",
    opts = {
      git = { enable = true },
    },
  },
  { "folke/trouble.nvim", cmd = "Trouble", opts = {} },
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
    },
  },
  { "akinsho/git-conflict.nvim", version = "*", config = true, event = "BufRead" },
  {
    "ggandor/leap.nvim",
    event = "BufRead",
    config = function()
      require("leap").add_default_mappings()
      vim.cmd [[nnoremap gs <Plug>(leap-from-window)]]
      vim.api.nvim_set_hl(0, "LeapBackdrop", { link = "Comment" }) -- or some grey
    end,
  },
  {
    "ggandor/flit.nvim",
    event = "BufRead",
    config = function()
      require("flit").setup()
    end,
  },
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "BufRead",
    config = function()
      require("nvim-surround").setup {
        -- Configuration here, or leave empty to use defaults
      }
    end,
  },
  {
    "sindrets/diffview.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    cmd = { "DiffviewOpen" },
  },
  {
    "tpope/vim-fugitive",
    cmd = { "Git", "G" },
    event = "BufRead",
  },
  { "stevearc/dressing.nvim", opts = {}, event = "VeryLazy" },
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
    event = "BufRead",
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
    event = "BufRead",
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
    dependencies = { -- optional packages
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("go").setup()
    end,
    ft = { "go", "gomod" },
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
  { "tpope/vim-unimpaired", event = "BufRead" },
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
    event = "BufRead",
  },
  {
    "nvim-neotest/neotest",
    event = "BufRead",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
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
          -- require "rustaceanvim.neotest",
          require "neotest-vim-test",
        },
      }
    end,
  },
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
          enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
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
    cmd = "Norm",
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
    opts = {
      open_mapping = [[<c-\>]],
      -- start_in_insert = false,
      size = 20,
      shade_terminals = true,
      auto_scroll = false,
      -- float_opts = {
      --   border = "curved",
      -- },
      -- winbar = {
      --   enabled = true,
      -- },
    },
  },
  { "AndrewRadev/bufferize.vim", cmd = "Bufferize" },
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
    event = "BufRead",
    config = function()
      require("glance").setup {}
      -- Lua
      vim.keymap.set("n", "gpd", "<CMD>Glance definitions<CR>")
      vim.keymap.set("n", "gpr", "<CMD>Glance references<CR>")
      vim.keymap.set("n", "gpt", "<CMD>Glance type_definitions<CR>")
      vim.keymap.set("n", "gpi", "<CMD>Glance implementations<CR>")
    end,
  },
  { "tpope/vim-repeat", event = "BufRead" },
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    opts = {},
    ft = { "typescript", "typescriptreact" },
  },
  {
    "danymat/neogen",
    dependencies = "nvim-treesitter/nvim-treesitter",
    event = "BufRead",
    config = true,
  },
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
      local builtin_notify = vim.notify
      local noti = require "notify"
      local blacklist = { "textDocument/" }

      vim.notify = function(msg, level, opts)
        for _, v in ipairs(blacklist) do
          if msg:find(v) then
            builtin_notify("Blacklisted notification: " .. msg, vim.log.levels.DEBUG)
            return
          end
        end
        noti(msg, level, opts)
      end
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
    "kevinhwang91/nvim-hlslens",
    event = "BufRead",
    config = function()
      require("hlslens").setup()

      local kopts = { noremap = true, silent = true }

      vim.api.nvim_set_keymap(
        "n",
        "n",
        [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]],
        kopts
      )
      vim.api.nvim_set_keymap(
        "n",
        "N",
        [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]],
        kopts
      )
      vim.api.nvim_set_keymap("n", "*", [[*<Cmd>lua require('hlslens').start()<CR>]], kopts)
      vim.api.nvim_set_keymap("n", "#", [[#<Cmd>lua require('hlslens').start()<CR>]], kopts)
      vim.api.nvim_set_keymap("n", "g*", [[g*<Cmd>lua require('hlslens').start()<CR>]], kopts)
      vim.api.nvim_set_keymap("n", "g#", [[g#<Cmd>lua require('hlslens').start()<CR>]], kopts)
    end,
  },
  {
    "NoahTheDuke/vim-just",
    ft = "just",
  },
  {
    "ThePrimeagen/refactoring.nvim",
    cmd = "Refactor",
    event = "BufRead",
    keys = {
      {
        "<leader>rr",
        function()
          require("refactoring").select_refactor()
        end,
        mode = "n",
        desc = "Refactor",
      },
      {
        "<leader>rp",
        function()
          require("refactoring").debug.printf { below = true }
        end,
        mode = "n",
        desc = "Refactor print",
      },
      {
        "<leader>rv",
        function()
          require("refactoring").debug.print_var()
        end,
        mode = "n",
        desc = "Refactor print var",
      },
      {
        "<leader>rc",
        function()
          require("refactoring").debug.cleanup {}
        end,
        mode = "n",
        desc = "Refactor cleanup",
      },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("refactoring").setup()
    end,
  },
  {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    config = function()
      local conf = require "configs.dashboard"
      require("dashboard").setup(conf)
    end,
    dependencies = { { "nvim-tree/nvim-web-devicons" } },
  },
  -- Minimal configuration
  {
    "David-Kunz/gen.nvim",
    cmd = "Gen",
    opts = {
      model = "llama3",
      -- display_mode = "split",
      -- debug = true
    },
  },
  {
    "mrcjkb/rustaceanvim",
    version = "^4", -- Recommended
    ft = "rust",
    config = function()
      local lspconfig = require "configs.lspconfig"
      vim.g.rustaceanvim = {
        -- Plugin configuration
        tools = {},
        -- LSP configuration
        server = {
          on_attach = lspconfig.on_attach,
          default_settings = {
            -- rust-analyzer language server configuration
            ["rust-analyzer"] = {},
          },
        },
        -- DAP configuration
        dap = {},
      }
    end,
  },
  -- Lua
  {
    "olimorris/persisted.nvim",
    event = "VeryLazy",
    config = function()
      require("persisted").setup {
        follow_cwd = false,
        should_autosave = function()
          local ft = vim.bo.filetype
          -- do not autosave if the alpha dashboard is the current filetype
          if ft == "alpha" or ft == "dashboard" or ft == "fugitive" then
            return false
          end
          return true
        end,
      }
    end,
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    event = "BufRead",
    dependencies = {
      { "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
      { "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
    },
    keys = {
      {
        "<leader>ai",
        function()
          vim.cmd "CopilotChatToggle"
        end,
        mode = "n",
        desc = "AI",
      },
    },
    opts = {
      debug = true, -- Enable debugging
      window = {
        layout = "float",
        width = 0.75,
        height = 0.75,
      },
    },
  },
  -- {
  --   "hrsh7th/nvim-cmp",
  --   event = "CmdlineEnter",
  --   dependencies = { "hrsh7th/cmp-cmdline" }, -- XXX: will this override the default cmdline completion?
  --   config = function(_, opts)
  --     local cmp = require "cmp"
  --     cmp.setup(opts)
  --
  --     -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  --     cmp.setup.cmdline(":", {
  --       mapping = cmp.mapping.preset.cmdline(), -- <C-y> select current
  --       sources = cmp.config.sources({
  --         { name = "path" },
  --       }, {
  --         { name = "cmdline" },
  --       }),
  --       matching = { disallow_symbol_nonprefix_matching = false },
  --     })
  --   end,
  -- },
}
