local M = { -- utils
  {
    "folke/trouble.nvim",
    event = "BufRead",
  },
  {
    "kosayoda/nvim-lightbulb",
    event = "BufRead",
    config = function()
      vim.cmd [[autocmd CursorHold * lua require 'nvim-lightbulb'.update_lightbulb()]]
    end,
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
    "andymass/vim-matchup",
    event = "VeryLazy",
    init = function()
      -- may set any options here
      vim.g.matchup_matchparen_offscreen = {
        method = "popup",
      }
    end,
  }, -- lsp
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
        "clangd",
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
        -- b.formatting.stylua,
        b.formatting.black,
        -- b.formatting.clang_format.with {
        --   filetypes = { "proto" },
        -- },
        b.formatting.pg_format,
        b.formatting.prettier.with {
          extra_filetypes = { "markdown" },
          disabled_filetypes = { "json" },
        },
        b.completion.spell.with {
          filetypes = { "markdown" },
        },
        b.diagnostics.cspell.with {
          diagnostics_postprocess = function(diagnostic)
            diagnostic.severity = vim.diagnostic.severity.INFO
          end,
          disabled_filetypes = { "NvimTree" },
        },
      }

      null_ls.setup {
        debug = true,
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
    event = "VeryLazy",
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
      },
    },
  },
  {
    "rhysd/conflict-marker.vim",
    event = "BufRead",
  },
  {
    "ggandor/lightspeed.nvim",
    event = "VeryLazy",
    config = function()
      require("lightspeed").setup {
        ignore_case = true,
      }
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
    dependencies = { "nvim-telescope/telescope.nvim", "folke/noice.nvim" },
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
    config = function()
      local dap = require "dap"

      -- dap config
      local text = {
        breakpoint = {
          text = "",
          texthl = "LspDiagnosticsSignError",
          linehl = "",
          numhl = "",
        },
        breakpoint_rejected = {
          text = "",
          texthl = "LspDiagnosticsSignHint",
          linehl = "",
          numhl = "",
        },
        stopped = {
          text = "",
          texthl = "LspDiagnosticsSignInformation",
          linehl = "DiagnosticUnderlineInfo",
          numhl = "LspDiagnosticsSignInformation",
        },
      }

      vim.fn.sign_define("DapBreakpoint", text.breakpoint)
      vim.fn.sign_define("DapBreakpointRejected", text.breakpoint_rejected)
      vim.fn.sign_define("DapStopped", text.stopped)
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap" },
    config = function()
      require("dapui").setup {}
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
  {
    "chrisbra/csv.vim",
    ft = "csv",
    config = function()
      vim.g.no_csv_maps = 1
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
  {
    "hrsh7th/cmp-cmdline",
    dependencies = "hrsh7th/nvim-cmp",
    event = "VeryLazy",
    config = function()
      local cmp = require "cmp"
      cmp.setup.cmdline({ "/", "?" }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = { {
          name = "buffer",
        } },
      })

      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources(
          { {
            name = "path",
          } },
          { {
            name = "cmdline",
          } }
        ),
      })
    end,
  },
  {
    "iamcco/markdown-preview.nvim",
    ft = "markdown",
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    config = function()
      require("noice").setup {
        -- you can enable a preset for easier configuration
        presets = {
          bottom_search = true, -- use a classic bottom cmdline for search
          command_palette = true, -- position the cmdline and popupmenu together
          long_message_to_split = true, -- long messages will be sent to a split
          inc_rename = false, -- enables an input dialog for inc-rename.nvim
          lsp_doc_border = false, -- add a border to hover docs and signature help
        },
        lsp = {
          hover = { enabled = false },
          progress = { enabled = false },
          signature = { enabled = false },
          messages = { view = "mini" },
        },
        popupmenu = { enabled = false },
        -- messages = {
        --   view = "mini",
        -- },
      }
    end,
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      {
        "rcarriga/nvim-notify",
        config = function()
          require("notify").setup { render = "compact" }
        end,
      },
    },
  },
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
}

return M
