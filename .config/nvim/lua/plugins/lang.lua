local frontend_formatter = { "prettierd", "prettier", stop_after_first = true }

---@type LazySpec
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
        mode = "",
        desc = "Format buffer",
      },
    },
    -- Everything in opts will be passed to setup()
    opts = {
      -- Define your formatters
      formatters_by_ft = {
        lua = { "stylua" },
        python = { "ruff_organize_imports", "ruff_format" },
        javascript = frontend_formatter,
        typescript = frontend_formatter,
        javascriptreact = frontend_formatter,
        typescriptreact = frontend_formatter,
        svelte = frontend_formatter,
        vue = frontend_formatter,
        go = { "goimports", "gofmt" },
        sql = { "pg_format", "sql_formatter", "sqlfluff", stop_after_first = true },
        json = frontend_formatter,
        proto = { "buf" },
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
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = require("chadrc").tree_sitter.ensure_installed

      -- Ensure highlighting is enabled
      opts.highlight = opts.highlight or {}
      opts.highlight.enable = true

      -- Add textobjects configuration
      opts.textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ic"] = "@class.inner",
          },
          selection_modes = {
            ["@parameter.outer"] = "v",
            ["@function.outer"] = "V",
            ["@class.outer"] = "<c-v>",
          },
        },
        swap = {
          enable = true,
          swap_next = { ["]p"] = "@parameter.inner" },
          swap_previous = { ["[p"] = "@parameter.inner" },
        },
        move = {
          enable = true,
          set_jumps = true,
          goto_next_start = {
            ["]m"] = "@function.outer",
            ["]]"] = { query = "@class.outer", desc = "Next class start" },
            ["]o"] = "@loop.*",
            ["]s"] = { query = "@local.scope", query_group = "locals", desc = "Next scope" },
            ["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
          },
          goto_next_end = {
            ["]M"] = "@function.outer",
            ["]["] = "@class.outer",
          },
          goto_previous_start = {
            ["[m"] = "@function.outer",
            ["[["] = "@class.outer",
          },
          goto_previous_end = {
            ["[M"] = "@function.outer",
            ["[]"] = "@class.outer",
          },
        },
      }

      return opts
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "BufRead",
    config = function()
      require("treesitter-context").setup {
        separator = "·",
        max_lines = "10%",
      }
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    event = "BufRead",
  },
  {
    "Wansmer/symbol-usage.nvim",
    event = "LspAttach",
    config = function()
      require "configs.symbol-usage"
    end,
  },
  {
    "hedyhli/outline.nvim",
    event = "BufRead",
    config = function()
      require("outline").setup({
        outline_window = {
          position = "right",
          width = 25,
          relative_width = true,
        },
        outline_items = {
          show_symbol_details = true,
        },
      })
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
    "Saecki/crates.nvim",
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
      local glance = require "glance"
      local actions = glance.actions
      glance.setup {
        mappings = {
          list = {
            ["<C-h>"] = actions.enter_win "preview", -- Focus preview window
          },
          preview = {
            ["<C-l>"] = actions.enter_win "list", -- Focus list window
          },
        },
      }
      -- Lua
      vim.keymap.set("n", "gpd", "<CMD>Glance definitions<CR>")
      vim.keymap.set("n", "gpr", "<CMD>Glance references<CR>")
      vim.keymap.set("n", "gpt", "<CMD>Glance type_definitions<CR>")
      vim.keymap.set("n", "gpi", "<CMD>Glance implementations<CR>")
    end,
  },
  { "NoahTheDuke/vim-just", ft = "just" },
  {
    "mrcjkb/rustaceanvim",
    version = "*", -- Recommended
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
            ["rust-analyzer"] = {
              -- cargo = { loadOutDirsFromCheck = true },
              -- check = { command = "clippy" },
              -- procMacro = { enable = false },
              -- diagnostics = { enable = true },
              -- completion = { postfix = { enable = false } },
              -- buildScripts = { enable = false }, -- 重点：关闭 build.rs 分析，加速
            },
          },
        },
        -- DAP configuration
        dap = {},
      }
    end,
  },
  {
    "nvim-neotest/neotest",
    cmd = "Neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "lawrence-laz/neotest-zig",
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "nvim-neotest/neotest-plenary",
      "nvim-neotest/neotest-go",
      -- "nvim-neotest/neotest-vim-test",
    },
    config = function()
      require("neotest").setup {
        adapters = {
          require "neotest-go",
          require "neotest-plenary",
          require "neotest-zig" { dap = { adapter = "lldb" } },
          require "rustaceanvim.neotest",
          -- require "neotest-vim-test",
        },
      }
    end,
  },
  {
    "b0o/schemastore.nvim",
  },
  {
    "qvalentin/helm-ls.nvim",
    ft = "helm",
    opts = {
      -- leave empty or see below
    },
  },
  {
    "vim-test/vim-test",
    event = "BufRead",
    config = function()
      vim.g["test#strategy"] = "toggleterm"
    end,
  },
  {
    "folke/lazydev.nvim",
    ft = "lua",
    cmd = "LazyDev",
    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        { path = "snacks.nvim", words = { "Snacks" } },
      },
    },
  },
  {
    "mfussenegger/nvim-lint",
    event = "BufRead",
    config = function()
      require("lint").linters_by_ft = {
        -- zig = { "zlint" },
        proto = { "buf_lint" },
      }
      vim.api.nvim_create_autocmd({ "BufWritePost" }, {
        callback = function()
          -- try_lint without arguments runs the linters defined in `linters_by_ft`
          -- for the current filetype
          require("lint").try_lint()

          -- You can call `try_lint` with a linter name or a list of names to always
          -- run specific linters, independent of the `linters_by_ft` configuration
          -- require("lint").try_lint "cspell"
        end,
      })
    end,
  },
}
