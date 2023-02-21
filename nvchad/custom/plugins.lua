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
    "kosayoda/nvim-lightbulb",
    event = "BufRead",
    config = function()
      vim.cmd [[autocmd CursorHold * lua require'nvim-lightbulb'.update_lightbulb()]]
    end,
  },
  {
    "andymass/vim-matchup",
    event = "BufRead",
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
    dependencies = "nvim-lspconfig",
    event = "BufRead",
    config = function()
      local present, null_ls = pcall(require, "null-ls")

      if not present then
        return
      end

      local b = null_ls.builtins

      local sources = {
        b.formatting.shfmt, -- b.formatting.stylua,
        b.formatting.black, -- b.formatting.clang_format.with {
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
    event = "BufRead",
    config = function()
      require("lightspeed").setup {
        ignore_case = true,
      }
    end,
  },
  {
    "tpope/vim-surround",
    event = "BufRead",
  },
  {
    "simrat39/rust-tools.nvim",
    dependencies = "nvim-lspconfig",
    ft = "rust",
    config = function()
      require("rust-tools").setup {
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
    dependencies = "nvim-telescope/telescope.nvim",
    lazy = false,
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
          win_height = 12,
          win_vheight = 12,
          delay_syntax = 80,
          border_chars = { "┃", "┃", "━", "━", "┏", "┓", "┗", "┛", "█" },
          show_title = false,
          should_preview_cb = function(bufnr, qwinid)
            local ret = true
            local bufname = vim.api.nvim_buf_get_name(bufnr)
            local fsize = vim.fn.getfsize(bufname)
            if fsize > 100 * 1024 then
              -- skip file size greater than 100k
              ret = false
            elseif bufname:match "^fugitive://" then
              -- skip fugitive buffer
              ret = false
            end
            return ret
          end,
        },
        -- make `drop` and `tab drop` to become preferred
        -- func_map = {
        --   drop = 'o',
        --   openc = 'O',
        --   split = '<C-s>',
        --   tabdrop = '<C-t>',
        --   tabc = '',
        --   ptogglemode = 'z,',
        -- },
        -- filter = {
        --   fzf = {
        --     action_for = { ['ctrl-s'] = 'split', ['ctrl-t'] = 'tab drop' },
        --     extra_opts = { '--bind', 'ctrl-o:toggle-all', '--prompt', '> ' }
        --   }
        -- }
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
    "simnalamburt/vim-mundo",
    event = "BufRead",
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
    "ray-x/go.nvim",
    ft = { "go" },
    dependencies = { "nvim-lspconfig", "ray-x/guihua.lua" },
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
    lazy = false,
    config = function()
      vim.g.autojump_vim_command = "tcd"
    end,
  }, -- use for autojump
  {
    "tpope/vim-unimpaired",
    event = "BufRead",
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
    lazy = false,
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
    event = "BufRead",
  },
  {
    "nvim-neotest/neotest",
    event = "BufRead",
    dependencies = {
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
          require "neotest-go",
          require "neotest-plenary",
          require "neotest-vim-test" {
            ignore_file_types = { "go", "vim", "lua" },
          },
        },
      }
    end,
  },
  {
    "sbdchd/neoformat",
    event = "BufRead",
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
    opts = {
      plugins = {
        spelling = {
          enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
          suggestions = 20, -- how many suggestions should be shown in the list?
        },
      },
    },
    config = function()
      require "plugins.configs.whichkey"
      local wk = require "which-key"
      wk.register({
        f = {
          name = "find",
        },
        t = {
          name = "test",
        },
        l = {
          name = "lsp",
        },
        g = {
          name = "git",
        },
        d = {
          name = "debug",
        },
      }, {
        prefix = "<leader>",
      }) -- insert any whichkey opts here
    end,
  },
  -- {"rcarriga/nvim-notify",
  --     enabled = false,
  --     dependencies = "nvim-lspconfig",
  --     config = function()
  --         local banned_words = {"textDocument/", "multiple different client offset_encodings detected"}
  --         local notify = require "notify"
  --         vim.notify = function(msg, ...)
  --             for _, banned in ipairs(banned_words) do
  --                 if string.find(msg, banned) then
  --                     return
  --                 end
  --             end
  --             notify(msg, ...)
  --         end
  --     end
  -- },
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "BufRead",
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
    event = "BufRead",
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
    "folke/neodev.nvim",
    ft = "lua",
    config = function()
      require("neodev").setup {}
      vim.lsp.start {
        name = "lua-language-server",
        cmd = { "lua-language-server" },
        before_init = require("neodev.lsp").before_init,
        root_dir = vim.fn.getcwd(),
        settings = {
          Lua = {},
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
    build = "bash ./install.sh",
    config = function()
      require("sniprun").setup {}
    end,
  },
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    lazy = false,
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
    dependencies = "nvim-cmp",
    lazy = false,
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
}
return M
