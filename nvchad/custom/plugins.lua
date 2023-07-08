local M = { -- utils
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
      local on_attach = require("plugins.configs.lspconfig").on_attach
      local capabilities = require("plugins.configs.lspconfig").capabilities

      local lspconfig = require "lspconfig"

      local servers = {
        "vimls",
        "html",
        "cssls",
        "bashls",
        "pyright",
        "gopls",
        "tsserver",
        "jsonls",
        "yamlls",
        "taplo",
        "prosemd_lsp",
        "eslint",
      }

      for _, lsp in ipairs(servers) do
        if lsp == "clangd" then
          -- fix bug
          local capabilities4clangd = vim.deepcopy(capabilities)
          capabilities4clangd.offsetEncoding = { "utf-16" }
          lspconfig.clangd.setup {
            capabilities = capabilities4clangd,
            on_attach = on_attach,
          }
        else
          lspconfig[lsp].setup {
            on_attach = on_attach,
            capabilities = capabilities,
          }
        end
      end
    end,
  }, -- format & linting
  {
    "jose-elias-alvarez/null-ls.nvim",
    dependencies = "neovim/nvim-lspconfig",
    event = "BufRead",
    config = function()
      local present, null_ls = pcall(require, "null-ls")

      if not present then
        return
      end

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
        },
        require "typescript.extensions.null-ls.code-actions",
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
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
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
        updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
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
  -- {
  --   "ggandor/lightspeed.nvim",
  --   event = "VeryLazy",
  --   config = function()
  --     require("lightspeed").setup {
  --       ignore_case = true,
  --     }
  --   end,
  -- },
  {
    "ggandor/leap.nvim",
    event = "VeryLazy",
    config = function()
      require("leap").add_default_mappings()
      vim.cmd [[nnoremap gs <Plug>(leap-from-window)]]
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
    "tpope/vim-surround",
    event = "VeryLazy",
  },
  {
    "simrat39/rust-tools.nvim",
    dependencies = "neovim/nvim-lspconfig",
    ft = "rust",
    config = function()
      require("rust-tools").setup {
        tools = {
          inlay_hints = {
            -- automatically set inlay hints (type hints)
            -- default: true
            auto = false,
          },
        },
        server = {
          on_attach = require("plugins.configs.lspconfig").on_attach,
          settings = {
            {
              "rust-analyzer",
              inlayHints = {
                locationLinks = false,
              },
            },
          },
        },
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
    event = "BufRead",
  },
  {
    "NTBBloodbath/rest.nvim",
    ft = "http",
    config = function()
      require("rest-nvim").setup {}
      vim.cmd [[
         nnoremap <leader>rr <Plug>RestNvim
         nnoremap <leader>rp <Plug>RestNvimPreview
         nnoremap <leader>rl <Plug>RestNvimLast
      ]]
    end,
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
    "simnalamburt/vim-mundo",
    event = "VeryLazy",
  },
  {
    "ellisonleao/glow.nvim",
    ft = "markdown",
    config = function()
      require("glow").setup {
        width = 120,
      }
    end,
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
    "mickael-menu/zk-nvim",
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
      {
        "vim-test/vim-test",
        config = function()
          vim.cmd 'let test#strategy ="neovim"'
        end,
      },
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "nvim-neotest/neotest-plenary",
      "nvim-neotest/neotest-go",
      "nvim-neotest/neotest-vim-test",
    },
    config = function()
      vim.cmd [[let test#strategy ="neovim"]]
      require("neotest").setup {
        adapters = {
          require "neotest-go",
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
          enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
          suggestions = 20, -- how many suggestions should be shown in the list?
        },
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "VeryLazy",
    config = function()
      vim.cmd [[hi TreesitterContextBottom gui=underline guisp=Grey]]
      require("treesitter-context").setup {}
    end,
  },
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
    "NvChad/nvterm",
    enabled = false,
  },
  {
    "rafcamlet/nvim-luapad",
    dependencies = "antoinemadec/FixCursorHold.nvim",
  },
  {
    "michaelb/sniprun",
    lazy = false,
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
  {
    "b0o/incline.nvim",
    event = "BufRead",
    config = function()
      require("incline").setup()
    end,
  },
  -- {
  --   "hrsh7th/cmp-cmdline",
  --   dependencies = "hrsh7th/nvim-cmp",
  --   event = "VeryLazy",
  --   config = function()
  --     local cmp = require "cmp"
  --     cmp.setup.cmdline({ "/", "?" }, {
  --       mapping = cmp.mapping.preset.cmdline(),
  --       sources = { {
  --         name = "buffer",
  --       } },
  --     })
  --
  --     cmp.setup.cmdline(":", {
  --       mapping = cmp.mapping.preset.cmdline(),
  --       sources = cmp.config.sources(
  --         { {
  --           name = "path",
  --         } },
  --         { {
  --           name = "cmdline",
  --         } }
  --       ),
  --     })
  --   end,
  -- },
  {
    "iamcco/markdown-preview.nvim",
    ft = "markdown",
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
  },
  -- {
  --   "folke/noice.nvim",
  --   event = "VeryLazy",
  --   config = function()
  --     require("noice").setup {
  --       -- you can enable a preset for easier configuration
  --       presets = {
  --         bottom_search = true, -- use a classic bottom cmdline for search
  --         command_palette = true, -- position the cmdline and popupmenu together
  --         long_message_to_split = true, -- long messages will be sent to a split
  --         inc_rename = false, -- enables an input dialog for inc-rename.nvim
  --         lsp_doc_border = false, -- add a border to hover docs and signature help
  --       },
  --       lsp = {
  --         hover = { enabled = false },
  --         progress = { enabled = false },
  --         signature = { enabled = false },
  --         messages = { view = "mini" },
  --       },
  --       popupmenu = { enabled = false },
  --       messages = {
  --         view = "mini",
  --       },
  --     }
  --   end,
  --   dependencies = {
  --     -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
  --     "MunifTanjim/nui.nvim",
  --     -- OPTIONAL:
  --     --   `nvim-notify` is only needed, if you want to use the notification view.
  --     --   If not available, we use `mini` as the fallback
  --     {
  --       "rcarriga/nvim-notify",
  --       config = function()
  --         require("notify").setup { render = "compact" }
  --       end,
  --     },
  --   },
  -- },
  { "AndrewRadev/bufferize.vim", event = "VeryLazy" },
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
    ft = "rust",
    config = function()
      require("crates").setup()
    end,
  },
  {
    "folke/neodev.nvim",
    dependencies = "neovim/nvim-lspconfig",
    ft = "lua",
    config = function()
      -- IMPORTANT: make sure to setup neodev BEFORE lspconfig
      require("neodev").setup {}

      -- then setup your lsp server as usual
      local lspconfig = require "lspconfig"
      -- example to setup lua_ls and enable call snippets
      lspconfig.lua_ls.setup {
        settings = {
          Lua = {
            completion = {
              callSnippet = "Replace",
            },
          },
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
  { "jose-elias-alvarez/typescript.nvim" },
  {
    "danymat/neogen",
    dependencies = "nvim-treesitter/nvim-treesitter",
    event = "VeryLazy",
    config = true,
  },
  {
    "github/copilot.vim",
    event = "VeryLazy",
    config = function()
      vim.cmd [[
        imap <silent><script><expr> <C-J> copilot#Accept("\<CR>")
        let g:copilot_no_tab_map = v:true
      ]]
      vim.api.nvim_set_var("copilot_filetypes", {
        ["dap-repl"] = false,
      })
    end,
  },
  {
    "rcarriga/nvim-notify",
    event = "VeryLazy",
    config = function()
      local banned_messages = {}
      local last_msg = nil
      local last_ts = vim.fn.localtime()
      local timeout = 6

      vim.notify = function(msg, ...)
        local now = vim.fn.localtime()
        if msg == last_msg and now - last_ts <= timeout then
          return
        end

        last_msg = msg
        last_ts = now
        for _, banned in ipairs(banned_messages) do
          if string.match(msg, banned) then
            return
          end
        end
        require "notify"(msg, ...)
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
}

return M
