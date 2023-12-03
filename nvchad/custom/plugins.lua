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
        "vim-language-server",
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
    "simrat39/rust-tools.nvim",
    dependencies = "neovim/nvim-lspconfig",
    ft = "rust",
    config = function()
      require("rust-tools").setup {
        tools = {
          inlay_hints = {
            -- automatically set inlay hints (type hints)
            -- default: true
            -- auto = false,
          },
        },
        server = {
          on_attach = require("plugins.configs.lspconfig").on_attach,
          -- settings = {
          --   {
          --     "rust-analyzer",
          --     inlayHints = {
          --       locationLinks = false,
          --     },
          --   },
          -- },
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
      local Path = require "plenary.path"

      --- Given a path, return a shortened version of it.
      --- @param path string an absolute or relative path
      --- @param opts table
      --- @return string | table
      ---
      --- The tail of the path (the last n components, where n is the value of
      --- opts.tail_count) is kept unshortened.
      ---
      --- Each component in the head of the path (the first components up to the tail)
      --- is shortened to opts.short_len characters.
      ---
      --- If opts.head_max is non-zero, the number of components in the head
      --- is limited to opts.head_max. Excess components are trimmed from left to right.
      --- If opts.head_max is zero, all components are kept.
      ---
      --- opts is a table with the following keys:
      ---   short_len: int - the number of chars to shorten each head component to (default: 1)
      ---   tail_count: int - the number of tail components to keep unshortened (default: 2)
      ---   head_max: int - the max number of components to keep, including the tail
      ---     components. If 0, keep all components. Excess components are
      ---     trimmed starting from the head. (default: 0)
      ---   relative: bool - if true, make the path relative to the current working
      ---     directory (default: true)
      ---   return_table: bool - if true, return a table of { head, tail } instead
      ---     of a string (default: false)
      ---
      --- Example: get_short_path_fancy('foo/bar/qux/baz.txt', {
      ---   short_len = 1,
      ---   tail_count = 2,
      ---   head_max = 0,
      --- }) -> 'f/b/qux/baz.txt'
      ---
      --- Example: get_short_path_fancy('foo/bar/qux/baz.txt', {
      ---   short_len = 2,
      ---   tail_count = 2,
      ---   head_max = 1,
      --- }) -> 'ba/baz.txt'
      ---
      local function shorten_path(path, opts)
        opts = opts or {}
        local short_len = opts.short_len or 1
        local tail_count = opts.tail_count or 2
        local head_max = opts.head_max or 0
        local relative = opts.relative == nil or opts.relative
        local return_table = opts.return_table or false
        if relative then
          path = vim.fn.fnamemodify(path, ":.")
        end
        local components = vim.split(path, Path.path.sep)
        if #components == 1 then
          if return_table then
            return { nil, path }
          end
          return path
        end
        local tail = { unpack(components, #components - tail_count + 1) }
        local head = { unpack(components, 1, #components - tail_count) }
        if head_max > 0 and #head > head_max then
          head = { unpack(head, #head - head_max + 1) }
        end
        local result = {
          #head > 0 and Path.new(unpack(head)):shorten(short_len, {}) or nil,
          table.concat(tail, Path.path.sep),
        }
        if return_table then
          return result
        end
        return table.concat(result, Path.path.sep)
      end

      local function modified_suffix(buf)
        if vim.api.nvim_buf_get_option(buf, "modified") then
          return " [+]"
        else
          return ""
        end
      end

      --- Given a path, return a shortened version of it, with additional styling.
      --- @param buf string the buffer to get the path for
      --- @param opts table see below
      --- @return table
      ---
      --- The arguments are the same as for shorten_path, with the following additional options:
      ---   head_style: table - a table of highlight groups to apply to the head (see
      ---      :help incline-render) (default: nil)
      ---   tail_style: table - a table of highlight groups to apply to the tail (default: nil)
      ---
      --- Example: get_short_path_fancy('foo/bar/qux/baz.txt', {
      ---   short_len = 1,
      ---   tail_count = 2,
      ---   head_max = 0,
      ---   head_style = { guibg = '#555555' },
      --- }) -> { 'f/b/', guibg = '#555555' }, { 'qux/baz.txt' }
      ---
      local function shorten_path_styled(buf, opts)
        local path = vim.api.nvim_buf_get_name(buf)
        opts = opts or {}
        local head_style = opts.head_style or {}
        local tail_style = opts.tail_style or {}
        local result = shorten_path(
          path,
          vim.tbl_extend("force", opts, {
            return_table = true,
          })
        )
        return {
          result[1] and vim.list_extend(head_style, { result[1], "/" }) or "",
          vim.list_extend(tail_style, { result[2] }),
          modified_suffix(buf),
        }
      end

      require("incline").setup {
        render = function(props)
          return shorten_path_styled(props.buf, {
            short_len = 1,
            tail_count = 2,
            head_max = 4,
            head_style = { group = "Comment" },
            tail_style = { guifg = "white" },
          })
        end,
      }
    end,
  },
  {
    "iamcco/markdown-preview.nvim",
    ft = "markdown",
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
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
      require("crates").setup {
        null_ls = {
          enabled = true,
          name = "crates.nvim",
        },
      }
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
    "dmmulroy/tsc.nvim",
    ft = { "typescript", "typescriptreact" },
    config = function()
      require("tsc").setup()
    end,
  },
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
      local last_ts = 0
      local timeout = 6
      local noti = require "notify"

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
        return noti(msg, ...)
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
  {
    "andymass/vim-matchup",
    event = "BufRead",
    config = function()
      -- may set any options here
      vim.g.matchup_matchparen_offscreen = { method = "popup" }
    end,
  },
}

return M
