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
lvim.colorscheme = "dracula"
vim.opt.cmdheight = 1 -- more space in the neovim command line for displaying messages
vim.opt.confirm = true
vim.opt.foldmethod = "syntax"
-- vim.opt.foldlevelstart = 1
-- vim.opt.spell = true

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
-- unmap a default keymapping
-- lvim.keys.normal_mode["<C-Up>"] = false
-- edit a default keymapping
-- lvim.keys.normal_mode["<C-q>"] = ":q<cr>"

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
-- lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
lvim.builtin.which_key.mappings["w"] = { "<cmd>w<CR>", "Save" }
lvim.builtin.which_key.mappings["q"] = { "<cmd>q<CR>", "Quit" }
lvim.builtin.which_key.mappings["Q"] = { "<cmd>qa<CR>", "QuitAll" }

lvim.builtin.which_key.mappings["t"] = { "<cmd>TroubleToggle<cr>", "Trouble" }
lvim.builtin.which_key.mappings["f"] = { "<cmd>Telescope find_files<cr>", "File" }
lvim.builtin.which_key.mappings["m"] = { "<cmd>MarksListAll<cr>", "Marks" }
lvim.builtin.which_key.mappings["ss"] = { "<cmd>SessionManager load_session<cr>", "Session" }
lvim.builtin.which_key.mappings["sT"] = { "<cmd>TodoTelescope<cr>", "Tag" }
lvim.builtin.which_key.mappings["sm"] = { "<cmd>Telescope harpoon marks<cr>", "Bookmark" }

lvim.builtin.which_key.mappings["gg"] = { "<cmd>G<cr>", "Status" }
lvim.builtin.which_key.mappings["gv"] = { "<cmd>DiffviewOpen<cr>", "Diffview" }
lvim.builtin.which_key.mappings["gl"] = { "<cmd>G blame --date=short<cr>", "File Blame" }

lvim.builtin.which_key.mappings["bc"] = { "<cmd>lcd %:p:h<cr>", "LCD" }
lvim.builtin.which_key.mappings["bc"] = { "<cmd>lua vim.api.nvim_input(':'..'lcd %:p:h')<cr>", "LCD" }
lvim.builtin.which_key.mappings["bC"] = { "<cmd>lua vim.api.nvim_input(':'..'cd %:p:h')<cr>", "CD" }
lvim.builtin.which_key.mappings["bp"] = { "<cmd>verbose pwd<cr>", "PWD" }

lvim.keys.normal_mode = {
	-- Page down/up
	-- ["[d"] = "<PageUp>",
	-- ["]d"] = "<PageDown>",

	-- Navigate buffers
	-- ["<Tab>"] = ":bnext<CR>",
	-- ["<S-Tab>"] = ":bprevious<CR>",
	["gI"] = "<cmd>lua vim.lsp.buf.implementation()<CR>",
	["gr"] = "<cmd>lua vim.lsp.buf.references()<CR>",
	["gd"] = "<cmd>lua vim.lsp.buf.definition()<CR>",
	["K"] = "<cmd>lua vim.lsp.buf.hover()<CR>",
	["M"] = "<cmd>lua require('harpoon.mark').add_file()<CR>",
	["g."] = "<cmd>lua vim.lsp.buf.code_action()<CR>",
	["[l"] = "<cmd>:lNext<CR>",
	["]l"] = "<cmd>:lnext<CR>",
	["<C-w>z"] = "<cmd>:res | :vertical res<CR>",
}

-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.alpha.dashboard.section.buttons.entries = {
	{ "SPC f", "  Find File", "<CMD>Telescope find_files<CR>" },
	{ "SPC n", "  New File", "<CMD>ene!<CR>" },
	{ "SPC s s", "  Recent Session", "<CMD>SessionManager load_session<CR>" },
	{ "SPC s r", "  Recently Used Files", "<CMD>Telescope oldfiles<CR>" },
	{ "SPC s t", "  Find Word", "<CMD>Telescope live_grep<CR>" },
	{
		"SPC L c",
		"  Configuration",
		"<CMD>edit " .. require("lvim.config").get_user_config_path() .. " <CR>",
	},
}

lvim.builtin.notify.active = true
lvim.builtin.terminal.active = true

lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.show_icons.git = 0
lvim.builtin.nvimtree.setup.update_focused_file.update_cwd = false -- if project active, this option will be ture implicitly.

lvim.builtin.project.active = false
lvim.builtin.dap.active = true

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
	"java",
	"yaml",
}

lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true

lvim.builtin.lualine.sections.lualine_a = { "mode" }
lvim.builtin.lualine.options = {
	component_separators = { left = "" },
	section_separators = { left = "" },
}

lvim.builtin.project.patterns = { ".git", "Makefile", "package.json", "go.mod", "Cargo.toml" }

-- lvim.builtin.lualine.style = "default"

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

-- -- set a formatter, this will override the language server formatting capabilities (if it exists)
local formatters = require("lvim.lsp.null-ls.formatters")
formatters.setup({
	{ command = "black", filetypes = { "python" } },
	{ command = "isort", filetypes = { "python" } },
	{ command = "stylua", filetypes = { "lua" } },
	{
		-- each formatter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
		command = "prettier",
		---@usage arguments to pass to the formatter
		-- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`

		---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
		filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
	},
})

-- -- set additional linters
-- local linters = require("lvim.lsp.null-ls.linters")
-- linters.setup({
-- { command = "flake8", filetypes = { "python" } },
-- {
--   -- each linter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
--   command = "shellcheck",
--   ---@usage arguments to pass to the formatter
--   -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
--   extra_args = { "--severity", "warning" },
-- },
-- {
-- 	command = "codespell",
---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
-- filetypes = { "javascript", "python" },
-- 	extra_args = { "-I", "/Users/hrli/.config/lvim/spell/en.utf-8.add" },
-- },
-- })

-- Additional Plugins
vim.cmd("packadd cfilter")

lvim.plugins = {
	{ "folke/tokyonight.nvim" },
	{
		"folke/trouble.nvim",
		cmd = "TroubleToggle",
	},
	{
		"f-person/git-blame.nvim",
		event = "BufRead",
		config = function()
			vim.cmd("highlight default link gitblame SpecialComment")
		end,
	},
	{
		"phaazon/hop.nvim",
		branch = "v1", -- optional but strongly recommended
		config = function()
			-- you can configure Hop the way you like here; see :h hop-config
			require("hop").setup({ keys = "etovxqpdygfblzhckisuran;" })
			vim.api.nvim_set_keymap("n", "s", ":HopChar2<cr>", { silent = true })
			vim.api.nvim_set_keymap("n", "S", ":HopWord<cr>", { silent = true })
		end,
	},
	{
		"tpope/vim-surround",
	},
	{
		"simrat39/rust-tools.nvim",
		config = function()
			require("rust-tools").setup({})
		end,
	},
	{ "sindrets/diffview.nvim", requires = "nvim-lua/plenary.nvim" },
	{
		"folke/todo-comments.nvim",
		requires = "nvim-lua/plenary.nvim",
		config = function()
			require("todo-comments").setup({})
		end,
	},
	{
		"ray-x/go.nvim",
		config = function()
			require("go").setup()
		end,
	},
	{
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end,
	},
	{ "Crescent617/dracula.nvim" },
	{
		"windwp/nvim-ts-autotag",
		event = "InsertEnter",
		config = function()
			require("nvim-ts-autotag").setup()
		end,
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
			require("dressing").setup({ select = { backend = "builtin" } })
		end,
	},
	{
		"gelguy/wilder.nvim",
		config = function()
			require("wilder").setup({ modes = { ":" } })
			vim.cmd([[call wilder#set_option('renderer', wilder#popupmenu_renderer(wilder#popupmenu_border_theme({
			   \ 'highlights': {
			   \   'border': 'Normal',
			   \ },
			   \ 'border': 'rounded',
			   \ })))]])
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
	{
		"chentau/marks.nvim",
		config = function()
			require("marks").setup({
				force_write_shada = true, -- https://github.com/neovim/neovim/issues/4295
				mappings = {
					toggle = "mm",
					prev = false,
				},
			})
		end,
	},
	{
		"ThePrimeagen/harpoon",
		config = function()
			require("harpoon").setup({})
			require("telescope").load_extension("harpoon")
		end,
	},
	{ "kevinhwang91/nvim-bqf", ft = "qf" },
	-- {
	-- 	"Pocco81/AutoSave.nvim",
	-- 	config = function()
	-- 		require("autosave").setup({ events = { "InsertLeave" } })
	-- 	end,
	-- },
}

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
-- lvim.autocommands.custom_groups = {
-- 	{ "BufEnter", "*", "verbose pwd" },
-- }
