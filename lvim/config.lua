--[[
 THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT
 `lvim` is the global options object
]]

-- vim options
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.relativenumber = true
vim.opt.foldmethod = 'indent'
vim.opt.foldlevelstart = 99
vim.cmd([[
  command! ClearBuf %d a
  command! DiffOrig w !diff -u % -
  command! CSpell e ~/.cspell.json
  packadd cfilter
]])

-- general
lvim.log.level = "info"
lvim.format_on_save = {
  enabled = true,
  pattern = "*.lua",
  timeout = 1000,
}
-- to disable icons and use a minimalist setup, uncomment the following
-- lvim.use_icons = false

-- keymappings <https://www.lunarvim.org/docs/configuration/keybindings>
lvim.leader = "space"

-- add your own keymapping
lvim.keys.normal_mode["<S-l>"] = ":BufferLineCycleNext<CR>"
lvim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<CR>"
lvim.keys.normal_mode["<Esc>"] = ":nohl<CR>"
lvim.keys.normal_mode["[g"] = "<cmd>lua require 'gitsigns'.prev_hunk()<cr>"
lvim.keys.normal_mode["]g"] = "<cmd>lua require 'gitsigns'.next_hunk()<cr>"
lvim.keys.normal_mode["[d"] = "<cmd>lua vim.diagnostic.goto_prev()<cr>"
lvim.keys.normal_mode["]d"] = "<cmd>lua vim.diagnostic.goto_next()<cr>"

lvim.builtin.which_key.mappings["P"] = lvim.builtin.which_key.mappings["p"] -- Packer.nvim
lvim.builtin.which_key.mappings["p"] = { "<cmd>TroubleToggle<CR>", "Problems" }
lvim.builtin.which_key.mappings["."] = { ":<Up><CR>", "Run Last" }
lvim.builtin.which_key.mappings["X"] = { "<cmd>tabclose<CR>", "Close Tab" }
lvim.builtin.which_key.mappings["x"] = { "<cmd>bd<CR>", "Close Buffer" }
lvim.builtin.which_key.mappings["S"] = { "<cmd>lua require('spectre').open()<CR>", "Spectre" }
lvim.builtin.which_key.mappings["gv"] = { "<cmd>DiffviewOpen<cr>", "Diffview" }
lvim.builtin.which_key.mappings["gf"] = { "<cmd>DiffviewFileHistory<cr>", "DiffviewFileHistory" }
lvim.builtin.which_key.mappings["t"] = {
  name = "Test",
  f = { '<cmd>lua require("neotest").run.run(vim.fn.expand("%"))<cr>', "Test File" },
  n = { '<cmd>lua require("neotest").run.run()<cr>', "Test Nearest" },
  o = { '<cmd>lua require("neotest").output.open({ enter = true })<cr>', "Show Test Output" },
  a = { '<cmd>lua require("neotest").run.attach()<cr>', "Attach Test" },
  s = { '<cmd>lua require("neotest").run.stop()<cr>', "Stop Test" },
  t = { '<cmd>lua require("neotest").summary.toggle()<cr>', "Toggle Test Outline" },
}

-- -- Use which-key to add extra bindings with the leader-key prefix
-- lvim.builtin.which_key.mappings["W"] = { "<cmd>noautocmd w<cr>", "Save without formatting" }
-- lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }

-- -- Change theme settings
lvim.colorscheme = "tokyonight"

-- After changing plugin config exit and reopen LunarVim, Run :PackerSync
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "startify"
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = true
lvim.builtin.dap.active = true
lvim.builtin.project.active = false

-- Automatically install missing parsers when entering buffer
lvim.builtin.treesitter.auto_install = true

-- lvim.builtin.treesitter.ignore_install = { "haskell" }

-- -- generic LSP settings <https://www.lunarvim.org/docs/languages#lsp-support>
lvim.lsp.automatic_configuration.skipped_filetypes = { "rst", "plaintext" }
local skipped_servers = lvim.lsp.automatic_configuration.skipped_servers
local unskipped_servers = { "eslint", "sqls" }
lvim.lsp.automatic_configuration.skipped_servers = vim.tbl_filter(function(s)
  return not vim.tbl_contains(unskipped_servers, s)
end, skipped_servers)

-- --- disable automatic installation of servers
lvim.lsp.installer.setup.automatic_installation = false

-- ---configure a server manually. IMPORTANT: Requires `:LvimCacheReset` to take effect
-- ---see the full default list `:lua =lvim.lsp.automatic_configuration.skipped_servers`
-- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pyright" })
-- local opts = {} -- check the lspconfig documentation for a list of all possible options
-- require("lvim.lsp.manager").setup("pyright", opts)

-- ---remove a server from the skipped list, e.g. eslint, or emmet_ls. IMPORTANT: Requires `:LvimCacheReset` to take effect
-- ---`:LvimInfo` lists which server(s) are skipped for the current filetype
-- lvim.lsp.automatic_configuration.skipped_servers = vim.tbl_filter(function(server)
--   return server ~= "emmet_ls"
-- end, lvim.lsp.automatic_configuration.skipped_servers)

-- -- you can set a custom on_attach function that will be used for all the language servers
-- -- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end

-- -- linters and formatters <https://www.lunarvim.org/docs/languages#lintingformatting>
-- local formatters = require "lvim.lsp.null-ls.formatters"
-- formatters.setup {
--   { command = "stylua" },
--   {
--     command = "prettier",
--     extra_args = { "--print-with", "100" },
--     filetypes = { "typescript", "typescriptreact" },
--   },
-- }
-- local linters = require "lvim.lsp.null-ls.linters"
-- linters.setup {
--   { command = "flake8", filetypes = { "python" } },
--   {
--     command = "shellcheck",
--     args = { "--severity", "warning" },
--   },
-- }

-- null-ls config
local null_ls = require("null-ls")
lvim.lsp.null_ls.setup.sources = {
  null_ls.builtins.formatting.shfmt,
  -- null_ls.builtins.formatting.stylua,
  null_ls.builtins.formatting.black,
  null_ls.builtins.formatting.clang_format.with({
    filetypes = { "proto" },
  }),
  null_ls.builtins.formatting.pg_format,
  null_ls.builtins.formatting.prettier.with({
    extra_filetypes = { "markdown" },
    disabled_filetypes = { "json" },
  }),
  null_ls.builtins.completion.spell.with({
    filetypes = { "markdown" },
  }),
  null_ls.builtins.diagnostics.cspell.with({
    diagnostics_postprocess = function(diagnostic)
      diagnostic.severity = vim.diagnostic.severity.HINT
    end,
  }),
}

-- -- Additional Plugins <https://www.lunarvim.org/docs/plugins#user-plugins>
lvim.plugins = {
  { "folke/trouble.nvim", cmd = "TroubleToggle" },
  {
    "kosayoda/nvim-lightbulb",
    event = "BufRead",
    config = function()
      vim.cmd([[autocmd CursorHold * lua require'nvim-lightbulb'.update_lightbulb()]])
    end,
  },
  {
    "windwp/nvim-spectre",
    config = function()
      require("spectre").setup({ mapping = { ["send_to_qf"] = { map = "<localLeader>q" } } })
    end,
  },
  {
    "m-demare/hlargs.nvim",
    requires = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("hlargs").setup()
      vim.cmd([[highlight! link Hlargs TSParameter]])
    end,
  },
  { "f-person/git-blame.nvim", event = "BufRead" },
  {
    "ggandor/lightspeed.nvim",
    event = "BufRead",
    config = function()
      require("lightspeed").setup({
        ignore_case = true,
      })
    end,
  },
  { "tpope/vim-surround", event = "BufRead" },
  {
    "simrat39/rust-tools.nvim",
    config = function()
      require("rust-tools").setup({
        -- tools = { autoSetHints = false },
      })
    end,
    ft = "rust",
  },
  { "sindrets/diffview.nvim", requires = "nvim-lua/plenary.nvim" },
  {
    "norcalli/nvim-colorizer.lua",
    event = "BufRead",
    config = function()
      require("colorizer").setup()
    end,
  },
  {
    "ray-x/lsp_signature.nvim",
    config = function()
      require_clean("lsp_signature").setup()
    end,
  },
  { "tpope/vim-fugitive" },
  {
    "jbyuki/venn.nvim",
    ft = "markdown",
    config = function()
      local venn = require("venn")
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
          vim.cmd([[setlocal ve=all]])
          -- draw a line on HJKL keystrokes
          vim.api.nvim_buf_set_keymap(0, "n", "J", "<C-v>j:VBox<CR>", { noremap = true })
          vim.api.nvim_buf_set_keymap(0, "n", "K", "<C-v>k:VBox<CR>", { noremap = true })
          vim.api.nvim_buf_set_keymap(0, "n", "L", "<C-v>l:VBox<CR>", { noremap = true })
          vim.api.nvim_buf_set_keymap(0, "n", "H", "<C-v>h:VBox<CR>", { noremap = true })
          -- draw a box by pressing "f" with visual selection
          vim.api.nvim_buf_set_keymap(0, "v", "f", ":VBox<CR>", { noremap = true })
        else
          vim.cmd([[setlocal ve=]])
          vim.cmd([[mapclear <buffer>]])
          vim.b.venn_enabled = nil
        end
      end

      -- toggle keymappings for venn using <leader>v
      vim.api.nvim_set_keymap("n", "<leader>v", ":lua ToggleVenn()<CR>", { noremap = true })
    end,
  },
  {
    "stevearc/dressing.nvim",
    event = "BufRead",
    config = function()
      require("dressing").setup({})
    end,
  },
  { "kevinhwang91/nvim-bqf", ft = "qf" },
  {
    "editorconfig/editorconfig-vim",
    event = "BufRead",
    config = function()
      vim.g.EditorConfig_exclude_patterns = { "fugitive://.*", "scp://.*", "term://*" }
    end,
  },
  { "nvim-treesitter/playground", event = "BufRead" },
  { "simrat39/symbols-outline.nvim", event = "BufRead" },
  {
    "toppair/reach.nvim",
    event = "BufRead",
    config = function()
      -- default config
      require("reach").setup({
        notifications = true,
      })
      vim.cmd([[
        nnoremap B <cmd>:ReachOpen buffers<CR>
        nnoremap M <cmd>:ReachOpen marks<CR>
      ]])
    end,
  },
  { "simnalamburt/vim-mundo", event = "BufRead" },
  { "ellisonleao/glow.nvim", ft = { "md" } },
  {
    "chentoast/marks.nvim",
    event = "BufRead",
    config = function()
      require("marks").setup({
        default_mappings = false,
      })
    end,
  },
  { "AndrewRadev/bufferize.vim" },
  {
    "haringsrob/nvim_context_vt",
    event = "BufRead",
    config = function()
      require("nvim_context_vt").setup({
        prefix = "➜",
        min_rows = 20,
        disable_virtual_lines = true,
      })
    end,
  },
  {
    "ray-x/go.nvim",
    ft = { "go" },
    config = function()
      require("go").setup()
    end,
  },
  {
    "leoluz/nvim-dap-go",
    config = function()
      require("dap-go").setup()
    end,
    ft = "go",
  },
  {
    "theHamsta/nvim-dap-virtual-text",
    event = "BufRead",
    config = function()
      require("nvim-dap-virtual-text").setup()
    end,
  },
  {
    "danymat/neogen",
    config = function()
      require("neogen").setup({})
    end,
    event = "BufRead",
    requires = "nvim-treesitter/nvim-treesitter",
  },
  { "padde/jump.vim" }, -- use for autojump
  { "tpope/vim-unimpaired" },
  {
    "mickael-menu/zk-nvim",
    config = function()
      require("zk").setup({
        picker = "telescope",
      })

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
  { "preservim/vim-markdown", requires = "godlygeek/tabular", ft = "markdown" },
  {
    "jbyuki/nabla.nvim",
    ft = "markdown",
    config = function()
      vim.cmd("command! Nabla :lua require('nabla').popup()<CR>")
    end,
  },
  {
    "axieax/urlview.nvim",
    event = "BufRead",
    config = function()
      require("urlview").setup({})
    end,
  },
  { "wellle/targets.vim" },
  {
    "nvim-neotest/neotest",
    event = "BufRead",
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
      require("neotest").setup({
        adapters = {
          require("neotest-plenary"),
          require("neotest-go"),
          require("neotest-vim-test")({
            ignore_file_types = { "vim", "lua", "go" },
          }),
        },
      })
    end,
  },
  { "freitass/todo.txt-vim" },
  { "sbdchd/neoformat" },
  { "chrisbra/csv.vim", ft = "csv" },
  { "rhysd/conflict-marker.vim" },
  {
    "nanotee/sqls.nvim",
    ft = "sql",
    config = function()
      require("lspconfig").sqls.setup({
        on_attach = function(client, bufnr)
          require("sqls").on_attach(client, bufnr)
        end,
      })
    end,
  },
  {
    "smjonas/live-command.nvim",
    config = function()
      require("live-command").setup({
        commands = {
          Norm = { cmd = "norm" },
        },
      })
    end,
  },
  {
    "j-hui/fidget.nvim",
    config = function()
      require("fidget").setup({})
    end,
  },
}

-- -- Autocommands (`:help autocmd`) <https://neovim.io/doc/user/autocmd.html>
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "zsh",
--   callback = function()
--     -- let treesitter use bash highlight for zsh files as well
--     require("nvim-treesitter.highlight").attach(0, "bash")
--   end,
-- })
