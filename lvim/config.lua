--[[
lvim is the global options object

Linters should be
filled in as strings with either
a global executable or a path to
an executable
]]
-- THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT

-- general
lvim.log.level = "warn"
lvim.format_on_save = true

-- colorscheme
lvim.colorscheme = "dracula"

-- vim config
vim.cmd([[
  command! ClearBuf %d a
  command! DiffOrig w !diff -u % -
  command! DiffOrigVim vert new | set buftype=nofile | read ++edit # | 0d_ | diffthis | wincmd p | diffthis
]])
vim.opt.cmdheight = 1 -- more space in the neovim command line for displaying messages
vim.opt.confirm = true
vim.opt.foldmethod = "indent"
vim.opt.foldlevelstart = 99
vim.opt.swapfile = true
-- vim.opt.scrolloff = 0
-- vim.opt.updatetime = 512
-- vim.opt.timeoutlen = 400
-- vim.opt.spell = true
vim.opt.spelloptions = "camel"
vim.opt.spelllang = "en,cjk,programming"
-- vim.opt.conceallevel = 2
-- vim.opt.concealcursor = "nc"

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"

-- add your own keymapping
lvim.keys.normal_mode = {
  ["<C-w>z"] = "<cmd>:resize | :vertical resize<CR>", -- zoom in
}

-- unmap a default keymapping
local unmap_i = { "jj", "jk", "kj", "kk" }
for _, value in ipairs(unmap_i) do
  lvim.keys.insert_mode[value] = false
end

local unmap_t = { "<C-h>", "<C-j>", "<C-k>", "<C-l>" }
for _, value in ipairs(unmap_t) do
  lvim.keys.term_mode[value] = false
end

-- Use which-key to add extra bindings with the leader-key prefix
-- enable all presets
local presets = lvim.builtin.which_key.setup.plugins.presets
for k, _ in pairs(presets) do
  presets[k] = true
end

lvim.builtin.which_key.mappings["P"] = lvim.builtin.which_key.mappings["p"] -- Packer.nvim
lvim.builtin.which_key.mappings["p"] = { "<cmd>TroubleToggle<CR>", "Problems" }
lvim.builtin.which_key.mappings["w"] = { "<cmd>w<CR>", "Save" }
lvim.builtin.which_key.mappings["."] = { ":<Up><CR>", "Run Last" }
lvim.builtin.which_key.mappings["C"] = { "<cmd>tabclose<CR>", "Close Tab" }

lvim.builtin.which_key.mappings["q"] = { "<cmd>q<CR>", "Quit" }
lvim.builtin.which_key.mappings["Q"] = { "<cmd>qa<CR>", "Quit All" }
lvim.builtin.which_key.mappings["bb"] = { "<cmd>b#<CR>", "Previous" }

lvim.builtin.which_key.mappings[":"] = { "<cmd>Telescope commands<cr>", "Find Cmd" }
lvim.builtin.which_key.mappings["ss"] = { "<cmd>SessionManager load_session<cr>", "Session" }
lvim.builtin.which_key.mappings["S"] = { "<cmd>lua require('spectre').open()<CR>", "Spectre" }

lvim.builtin.which_key.mappings["gg"] = { "<cmd>Git<cr>", "Status" }
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

-- TODO User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.alpha.active = true
lvim.builtin.notify.active = true
lvim.builtin.terminal.active = true
lvim.builtin.project.active = false
lvim.builtin.dap.active = true

lvim.builtin.terminal.execs = {}

lvim.builtin.nvimtree.setup.view.width = 35

lvim.builtin.nvimtree.setup.disable_netrw = false
lvim.builtin.nvimtree.setup.update_cwd = true -- if project active, this option will be true implicitly.
lvim.builtin.nvimtree.setup.update_focused_file.update_cwd = false -- if project active, this option will be true implicitly.

lvim.builtin.bufferline.options.show_buffer_close_icons = false

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "c",
  "javascript",
  "json",
  "lua",
  "python",
  "typescript",
  "tsx",
  "css",
  "rust",
  "go",
  "yaml",
  "toml",
}

lvim.builtin.lualine.sections.lualine_a = { "mode" }

-- generic LSP settings
lvim.lsp.automatic_servers_installation = false
lvim.lsp.automatic_configuration.skipped_filetypes = { "rst", "plaintext" }

-- fix bug
-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities.offsetEncoding = { "utf-16" }
-- require("lspconfig").clangd.setup({ capabilities = capabilities })

local skipped_servers = lvim.lsp.automatic_configuration.skipped_servers
local unskipped_servers = { "eslint" }

lvim.lsp.automatic_configuration.skipped_servers = vim.tbl_filter(function(s)
  return not vim.tbl_contains(unskipped_servers, s)
end, skipped_servers)

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
  null_ls.builtins.diagnostics.codespell.with({
    diagnostics_postprocess = function(diagnostic)
      diagnostic.severity = vim.diagnostic.severity.HINT
    end,
    extra_args = { "-I", vim.fn.expand("~/.config/lvim/spell/en.utf-8.add") },
  }),
}

-- Additional Plugins
lvim.plugins = {
  -- colorscheme
  { "dracula/vim", as = "dracula" },
  { "folke/tokyonight.nvim" },
  -- utils
  { "folke/trouble.nvim" },
  {
    "kosayoda/nvim-lightbulb",
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
    config = function()
      require("lightspeed").setup({
        ignore_case = true,
      })
    end,
  },
  { "tpope/vim-surround" },
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
  { 'jbyuki/venn.nvim', config = function()
    local venn = require("venn")
    venn.set_line({ "s", "s", " ", " " }, '|')
    venn.set_line({ " ", "s", " ", "s" }, '+')
    venn.set_line({ "s", " ", " ", "s" }, '+')
    venn.set_line({ " ", "s", "s", " " }, '+')
    venn.set_line({ "s", " ", "s", " " }, '+')
    venn.set_line({ " ", "s", "s", "s" }, '+')
    venn.set_line({ "s", " ", "s", "s" }, '+')
    venn.set_line({ "s", "s", " ", "s" }, '+')
    venn.set_line({ "s", "s", "s", " " }, '+')
    venn.set_line({ "s", "s", "s", "s" }, '+')
    venn.set_line({ " ", " ", "s", "s" }, '-')
    venn.set_arrow("up", '^')
    venn.set_arrow("down", 'v')
    venn.set_arrow("left", '<')
    venn.set_arrow("right", '>')

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

    -- toggle keymappings for venn using <leader>v
    vim.api.nvim_set_keymap('n', '<leader>v', ":lua ToggleVenn()<CR>", { noremap = true })
  end },
  {
    "stevearc/dressing.nvim",
    config = function()
      require("dressing").setup({})
    end,
  },
  {
    "Shatur/neovim-session-manager",
    requires = "nvim-lua/plenary.nvim",
    config = function()
      require("session_manager").setup({
        autoload_mode = require("session_manager.config").AutoloadMode.CurrentDir,
      })
    end,
  },
  { "kevinhwang91/nvim-bqf", ft = "qf" },
  {
    "editorconfig/editorconfig-vim",
    config = function()
      vim.g.EditorConfig_exclude_patterns = { "fugitive://.*", "scp://.*", "term://*" }
    end,
  },
  { "nvim-treesitter/playground" },
  { "simrat39/symbols-outline.nvim" },
  {
    "toppair/reach.nvim",
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
  { "simnalamburt/vim-mundo" },
  { "ellisonleao/glow.nvim", ft = { "md" } },
  {
    "chentoast/marks.nvim",
    config = function()
      require("marks").setup({
        default_mappings = false,
      })
    end,
  },
  { "AndrewRadev/bufferize.vim" },
  {
    "haringsrob/nvim_context_vt",
    config = function()
      require("nvim_context_vt").setup({
        prefix = "➜",
        min_rows = 20,
        disable_virtual_lines = true,
      })
    end,
  },
  { 'ray-x/go.nvim', ft = { "go" }, config = function()
    require('go').setup()
  end },
  {
    "leoluz/nvim-dap-go",
    config = function()
      require("dap-go").setup()
    end,
    ft = "go",
  },
  {
    "theHamsta/nvim-dap-virtual-text",
    config = function()
      require("nvim-dap-virtual-text").setup()
    end,
  },
  {
    "danymat/neogen",
    config = function()
      require("neogen").setup({})
    end,
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
    config = function()
      vim.cmd("command! Nabla :lua require('nabla').popup()<CR>")
    end,
  },
  {
    "axieax/urlview.nvim",
    config = function()
      require("urlview").setup({})
    end,
  },
  { "wellle/targets.vim" },
  {
    "psliwka/vim-dirtytalk",
    run = function()
      vim.cmd(":DirtytalkUpdate")
      local frm = vim.call("spellfile#WritableSpellDir")
      local to = vim.call("spellfile#GetDirChoices")[1][1]
      local code = os.execute(string.format("cp -f %s/*.spl %s", frm, to))
      if code ~= 0 then
        vim.notify(string.format("Fail to sync dictionary from %s to %s", frm, to), vim.log.levels.ERROR)
      else
        vim.notify(string.format("Success to sync dictionary from %s to %s", frm, to), vim.log.levels.INFO)
      end
    end,
  },
  {
    "nvim-neotest/neotest",
    requires = {
      "vim-test/vim-test",
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-neotest/neotest-plenary",
      'nvim-neotest/neotest-go',
      "nvim-neotest/neotest-vim-test",
    },
    config = function()
      require("neotest").setup({
        adapters = {
          require("neotest-plenary"),
          require('neotest-go'),
          require("neotest-vim-test")({
            ignore_file_types = { "vim", "lua", "go" },
          }),
        },
      })
    end
  },
  { "freitass/todo.txt-vim" },
  { "sbdchd/neoformat" },
  { "chrisbra/csv.vim", ft = "csv" },
}

-- plugin overwrite option
vim.g.gitblame_date_format = "%r"
vim.g.no_csv_maps = 1

local vim_enter_autocmd = {
  -- treesitter highlight
  "hi! link LspCodeLens Comment",
  "hi! link typescriptDestructureVariable TSVariable",
  "hi! link SpellBad DiagnosticUnderlineHint",

  -- diagnostics underline
  "hi! DiagnosticUnderlineError guifg=NONE gui=undercurl guisp=#FF5555",
  "hi! DiagnosticUnderlineWarn guifg=NONE gui=undercurl guisp=#FFB86C",
  "hi! DiagnosticUnderlineInfo guifg=NONE gui=undercurl guisp=#8BE9FD",
  "hi! link DiagnosticUnderlineHint DiagnosticUnderlineInfo",

  -- diagnostics vt
  "hi! DiagnosticVirtualTextError guifg=#FF5555 guibg=#362C3D",
  "hi! DiagnosticVirtualTextInfo guifg=#8BE9FD guibg=#22304B",
  "hi! DiagnosticVirtualTextWarn guifg=#e0af68 guibg=#373640",
  "hi! link DiagnosticVirtualTextHint DiagnosticVirtualTextInfo",

  -- diagnostics vt
  "lua vim.diagnostic.config({ virtual_text = { prefix = '' } })",
}

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
local autocmds = {
  { "VimEnter", "*", table.concat(vim_enter_autocmd, " | ") },
  { "InsertLeave", "*", ":set relativenumber" },
  { "InsertEnter", "*", ":set norelativenumber" },
  -- { "InsertLeave", "*", ":lua vim.diagnostic.show(nil, 0)" },
  -- { "InsertEnter", "*", ":lua vim.diagnostic.hide(nil, 0)" },
}

-- Autocommands when "dracula"
local dracula_overwrite = {
  -- highlight
  "hi! link Search DraculaSelection",
  "hi! link GitSignsAdd DraculaGreen",
  "hi! link GitSignsAdd DraculaGreen",
  "hi! link GitSignsChange DraculaOrange",
  "hi! link GitSignsDelete DraculaRed",
  "hi! link TSNamespace Identifier",

  -- telescope
  "hi! link TelescopeBorder DraculaPurple",
  -- "hi! link TelescopeNormal DraculaBgDark",

  -- diff
  "hi DiffAdd guibg=#2d453f",
  "hi DiffChange guibg=#273d53",
  "hi DiffDelete guifg=#f8f8f2 guibg=#6b373f gui=NONE",
  "hi DiffText guifg=NONE guibg=#44475A",
  "hi CursorLine guibg=#33354F",
}

if lvim.colorscheme == "dracula" then
  table.insert(autocmds, { "VimEnter", "*", table.concat(dracula_overwrite, " | ") })
end

for _, v in ipairs(autocmds) do
  vim.api.nvim_create_autocmd(v[1], { pattern = v[2], command = v[3] })
end

-- GUI
if vim.g.neovide then
  vim.o.guifont = "JetBrainsMono Nerd Font Fix Line Height" --:h13"
  vim.g.neovide_remember_window_size = true
  vim.g.neovide_cursor_vfx_mode = "railgun"
  vim.g.neovide_input_use_logo = 1
  vim.cmd([[
    nmap <D-v> "+p<CR>
    imap <D-v> <C-R>+
    tmap <D-v> <C-R>+
    map ˙ <a-h>
    map ∆ <a-j>
    map ˚ <a-k>
    map ¬ <a-l> 
  ]])
end
