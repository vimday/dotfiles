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
local dracula_customize = {
	-- "hi DraculaBgDark guibg=#282A36",
	"hi DraculaWinSeparator ctermfg=61 ctermbg=235 guifg=#6272A4 guibg=#282A36",
	"hi CursorLine guibg=#33354F",
	-- "hi HopNextKey guifg=yellow gui=bold,reverse",
	"hi DiffAdd guibg=#2d4543",
	"hi DiffChange guibg=#33354F",
	"hi DiffDelete guifg=#f8f8f2 guibg=#6b3742 gui=NONE",
	"hi DiffText guibg=#554738 gui=NONE",
	"hi DraculaErrorLine guifg=NONE gui=undercurl guisp=#FF5555",
	"hi DraculaWarnLine guifg=NONE gui=undercurl guisp=#FFB86C",
	"hi DraculaInfoLine guifg=NONE gui=undercurl guisp==#8BE9FD",
	-- link
	"hi! link DraculaSearch DraculaSelection",
	"hi! link typescriptDestructureVariable TSVariable",
	"hi! link GitSignsAdd DraculaGreen",
	"hi! link GitSignsChange DraculaOrange",
	"hi! link GitSignsDelete DraculaRed",
	"hi! link Keyword DraculaPinkItalic",
	"hi! link Include DraculaPinkItalic",
	"hi! link TSNamespace Identifier",
}

-- vim config
vim.cmd([[
  tnoremap <Esc> <C-\><C-n>
  command! DiffOrig w !diff % -
  command! VimdiffOrig diffthis | vnew | read ++edit # | 0d_ | diffthis
  command! CSpellEdit e ~/.config/cspell.json
]])
vim.opt.cmdheight = 1 -- more space in the neovim command line for displaying messages
vim.opt.confirm = true
vim.opt.foldmethod = "syntax"
vim.opt.foldlevelstart = 99
vim.opt.swapfile = true
vim.opt.updatetime = 1000
-- vim.o.scrolloff = "0"

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"

-- add your own keymapping
lvim.keys.normal_mode = {
	["gI"] = "<cmd>lua vim.lsp.buf.implementation()<CR>",
	["gr"] = "<cmd>lua vim.lsp.buf.references()<CR>",
	["gd"] = "<cmd>lua vim.lsp.buf.definition()<CR>",
	["K"] = "<cmd>lua vim.lsp.buf.hover()<CR>",
	["B"] = "<cmd>:ReachOpen buffers<CR>",
	["ga"] = "<cmd>lua vim.lsp.buf.code_action()<CR>",
	["[l"] = "<cmd>:lNext<CR>",
	["]l"] = "<cmd>:lnext<CR>",
	["<C-w>z"] = "<cmd>:res | :vertical res<CR>", -- zoom in
}

-- unmap a default keymapping
-- lvim.keys.normal_mode["<C-Up>"] = false
lvim.keys.insert_mode["jj"] = false
lvim.keys.insert_mode["jk"] = false
lvim.keys.insert_mode["kj"] = false
lvim.keys.insert_mode["kk"] = false

-- Change Telescope navigation to use j and k for navigation and n and p for history in both input and normal mode.
-- we use protected-mode (pcall) just in case the plugin wasn't loaded yet.
-- local _, actions = pcall(require, "telescope.actions")
-- lvim.builtin.telescope.defaults.mappings = {
--   -- for input mode
--   i = {
--     ["<C-j>"] = actions.move_selection_next,
--     ["<C-k>"] = actions.move_selection_previous,
--     ["<C-n>"] = actions.cycle_history_next,
--     ["<C-p>"] = actions.cycle_history_prev,
--   },
--   -- for normal mode
--   n = {
--     ["<C-j>"] = actions.move_selection_next,
--     ["<C-k>"] = actions.move_selection_previous,
--   },
-- }

-- Use which-key to add extra bindings with the leader-key prefix
lvim.builtin.which_key.setup.layout.width.max = 111

-- lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
lvim.builtin.which_key.mappings["w"] = { "<cmd>w<CR>", "Save" }
lvim.builtin.which_key.mappings["."] = { ":<Up><CR>", "Run Last" }
lvim.builtin.which_key.mappings["C"] = { "<cmd>:tabclose<CR>", "Close Tab" }
lvim.builtin.which_key.mappings["q"] = { "<cmd>q<CR>", "Quit" }
lvim.builtin.which_key.mappings["Q"] = { "<cmd>qa<CR>", "QuitAll" }

lvim.builtin.which_key.mappings["t"] = { "<cmd>TroubleToggle<cr>", "Trouble" }
lvim.builtin.which_key.mappings["f"] = { "<cmd>Telescope find_files<cr>", "File" }
lvim.builtin.which_key.mappings["m"] = { "<cmd>MarksListAll<cr>", "Marks" }
lvim.builtin.which_key.mappings["ss"] = { "<cmd>SessionManager load_session<cr>", "Session" }
lvim.builtin.which_key.mappings["sb"] = { "<cmd>Telescope buffers<cr>", "Buffers" }
lvim.builtin.which_key.mappings["sT"] = { "<cmd>TodoTelescope<cr>", "Tag" }

lvim.builtin.which_key.mappings["gg"] = { "<cmd>G<cr>", "Status" }
lvim.builtin.which_key.mappings["gv"] = { "<cmd>DiffviewOpen<cr>", "Diffview" }
lvim.builtin.which_key.mappings["gf"] = { "<cmd>DiffviewFileHistory<cr>", "DiffviewFileHistory" }
lvim.builtin.which_key.mappings["gl"] = { "<cmd>G blame --date=short<cr>", "File Blame" }

-- TODO User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.alpha.dashboard.section.buttons.entries[3] = {
	"SPC s s",
	"  Recent Session",
	"<CMD>SessionManager load_session<CR>",
}

lvim.builtin.notify.active = true
lvim.builtin.terminal.active = true
lvim.builtin.terminal.execs = {}
lvim.builtin.project.active = false
-- lvim.builtin.dap.active = true

lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.view.width = 35
lvim.builtin.nvimtree.setup.hijack_netrw = false
lvim.builtin.nvimtree.setup.disable_netrw = false
lvim.builtin.nvimtree.show_icons.git = 1
lvim.builtin.nvimtree.icons.git.staged = "✔"
lvim.builtin.nvimtree.icons.git.unstaged = "✗"
lvim.builtin.nvimtree.icons.git.untracked = "*"
lvim.builtin.nvimtree.setup.update_cwd = true -- if project active, this option will be ture implicitly.
lvim.builtin.nvimtree.setup.update_focused_file.update_cwd = false -- if project active, this option will be ture implicitly.

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

lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true

lvim.builtin.lualine.sections.lualine_a = { "mode" }
lvim.builtin.lualine.options = {
	component_separators = { left = "" }, -- , right = "│" },
	section_separators = { left = "" },
}

-- generic LSP settings
-- ---@usage disable automatic installation of servers
-- lvim.lsp.automatic_servers_installation = false

-- ---@usage Select which servers should be configured manually. Requires `:LvimCacheReset` to take effect.
-- See the full default list `:lua print(vim.inspect(lvim.lsp.override))`
-- vim.list_extend(lvim.lsp.override, { "pyright" })

-- ---@usage setup a server -- see: https://www.lunarvim.org/languages/#overriding-the-default-configuration
-- local opts = {} -- check the lspconfig documentation for a list of all possible options
-- require("lvim.lsp.manager").setup("pylsp", opts)

-- -- you can set a custom on_attach function that will be used for all the language servers
-- -- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end

-- cmp config
table.insert(lvim.builtin.cmp.sources, { name = "orgmode" })

-- null-ls config
local null_ls = require("null-ls")
null_ls.setup({
	sources = {
		null_ls.builtins.formatting.shfmt,
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.diagnostics.eslint,
		null_ls.builtins.formatting.prettier,
		null_ls.builtins.diagnostics.cspell.with({
			diagnostics_postprocess = function(diagnostic)
				diagnostic.severity = vim.diagnostic.severity.HINT
			end,
			disabled_filetypes = { "NvimTree", "qf" },
			extra_args = { "-u", "-c", vim.fn.expand("~/.config/cspell.json") },
		}),
	},
})

-- Additional Plugins
lvim.plugins = {
	{ "folke/trouble.nvim" },
	{
		"f-person/git-blame.nvim",
		event = "BufRead",
		config = function()
			vim.cmd("highlight default link gitblame SpecialComment")
		end,
	},
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
			require("rust-tools").setup({})
		end,
	},
	{ "sindrets/diffview.nvim", requires = "nvim-lua/plenary.nvim" },
	{ "fatih/vim-go" },
	{
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end,
	},
	{
		"dracula/vim",
		as = "dracula",
	},
	{
		"ray-x/lsp_signature.nvim",
		config = function()
			require_clean("lsp_signature").setup()
		end,
	},
	{
		"tpope/vim-fugitive",
	},
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
				autoload_mode = require("session_manager.config").AutoloadMode.Disabled,
				autosave_only_in_session = true,
			})
		end,
	},
	{
		"chentau/marks.nvim",
		config = function()
			require("marks").setup({
				mappings = {
					toggle = "mm",
					prev = false,
					delete_buf = "dm<space>",
				},
				default_mappings = false,
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
	{ "jremmen/vim-ripgrep" },
	{ "nvim-treesitter/playground" },
	{ "simrat39/symbols-outline.nvim" },
	{
		"toppair/reach.nvim",
		config = function()
			-- default config
			require("reach").setup({
				notifications = true,
			})
		end,
	},
	{ "simnalamburt/vim-mundo" },
	{ "ellisonleao/glow.nvim" },
	{ "AndrewRadev/bufferize.vim" },
	{ "lewis6991/impatient.nvim" },
	{
		"haringsrob/nvim_context_vt",
		config = function()
			require("nvim_context_vt").setup({
				prefix = "➜",
			})
		end,
	},
	{
		"nvim-orgmode/orgmode",
		config = function()
			require("orgmode").setup_ts_grammar()
			require("orgmode").setup({
				org_agenda_files = { "~/OneDrive - Comcast APAC/orgmode/*" },
				org_default_notes_file = "~/OneDrive - Comcast APAC/orgmode/refile.org",
				org_capture_templates = {
					j = {
						description = "Journal",
						template = "* %<%Y-%m-%d %A> :JOURNAL:\n  %?\n  %U",
						target = "~/OneDrive - Comcast APAC/orgmode/journal.org",
					},
					n = {
						description = "Note",
						template = "* %? :NOTE:\n%U\n%a\n",
						target = "~/OneDrive - Comcast APAC/orgmode/note.org",
					},
				},
			})
		end,
	},
}

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
lvim.autocommands.custom_groups = {
	-- { "ColorScheme", "dracula", table.concat(color_conf, " | ") },
	{ "VimEnter", "*", table.concat(dracula_customize, " | ") },
	{ "VimEnter", "*", "lua vim.diagnostic.config({ virtual_text = { prefix = '' } })" },
	{ "InsertLeave", "*", ":lua vim.diagnostic.show(nil, 0)" },
	{ "InsertEnter", "*", ":lua vim.diagnostic.hide(nil, 0)" },
	{ "InsertLeave", "*", ":set relativenumber" },
	{ "InsertEnter", "*", ":set norelativenumber" },
}

-- GUI
if vim.g.neovide then
	vim.o.guifont = "JetBrainsMono Nerd Font Fix Line Height:h13"
	vim.g.neovide_cursor_vfx_mode = "railgun"
	vim.g.neovide_remember_window_size = true
	vim.g.neovide_input_use_logo = true
end
