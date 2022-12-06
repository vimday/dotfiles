local M = {}

-- add this table only when you want to disable default keys
M.disabled = {
  n = {
    ["<C-q>"] = "",
    ["<S-b>"] = "",
    ["<leader>D"] = "",
    ["<leader>bc"] = "",
    ["<leader>f"] = "",
    ["<leader>h"] = "",
    ["<leader>ls"] = "",
    ["<leader>pt"] = "",
    ["<leader>q"] = "",
    ["<leader>ra"] = "",
    ["<leader>rn"] = "",
    ["<leader>tn"] = "",
    ["<leader>tp"] = "",
    ["<leader>tt"] = "",
    ["<leader>uu"] = "",
    ["<leader>v"] = "",
    ["<leader>wK"] = "",
    ["<leader>wa"] = "",
    ["<leader>wk"] = "",
    ["<leader>wl"] = "",
    ["<leader>wr"] = "",
    ["gx"] = ""
  },
  i = {
    ["<C-h>"] = "",
    ["<C-j>"] = "",
    ["<C-k>"] = "",
    ["<C-l>"] = "",
  },
}

M.general = {
  n = {
    ["<C-q>"] = { ":call QuickFixToggle()<CR>", "Toggle Quickfix" },
    ["<C-w>z"] = { "<cmd>:resize | :vertical resize<CR>", "Zoom in window" },
    ["<leader>q"] = { "<cmd>q<cr>", "quit" },
    ["<leader>w"] = { "<cmd>w<cr>", "save" },
    ["<leader>."] = { ":<Up><CR>", "last cmd" },
    ["<leader>;"] = { "<cmd>Alpha<CR>", "open dashboard" },
    ["<leader>S"] = { "<cmd>lua require('spectre').open()<CR>", "spectre" },
    ["<leader>p"] = { "<cmd>TroubleToggle<CR>", "problems" },
    ["<leader>b"] = { "<cmd>b#<cr>", "last buffer" },
    ["gx"] = { "<cmd>silent !open <cfile><cr>", "open cursor file with system default" }
  },
  c = {
    ["<C-j>"] = { 'pumvisible() ? "\\<C-n>" : "\\<C-j>"', "pre cmd" },
    ["<C-k>"] = { 'pumvisible() ? "\\<C-p>" : "\\<C-k>"', "nxt cmd" },
  },
}

M.neotest = {
  n = {
    ["<leader>tf"] = { '<cmd>lua require("neotest").run.run(vim.fn.expand("%"))<cr>', "Test File" },
    ["<leader>tn"] = { '<cmd>lua require("neotest").run.run()<cr>', "Test Nearest" },
    ["<leader>to"] = { '<cmd>lua require("neotest").output.open({ enter = true })<cr>', "Show Test Output" },
    ["<leader>ta"] = { '<cmd>lua require("neotest").run.attach()<cr>', "Attach Test" },
    ["<leader>ts"] = { '<cmd>lua require("neotest").run.stop()<cr>', "Stop Test" },
    ["<leader>tt"] = { '<cmd>lua require("neotest").summary.toggle()<cr>', "Toggle Test Outline" },
  },
}

M.debug = {
  n = {
    ["<leader>db"] = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Toggle Breakpoint" },
    ["<leader>dS"] = { "<cmd>lua require'dap'.step_back()<cr>", "Step Back" },
    ["<leader>dc"] = { "<cmd>lua require'dap'.continue()<cr>", "Continue" },
    ["<leader>dC"] = { "<cmd>lua require'dap'.run_to_cursor()<cr>", "Run To Cursor" },
    ["<leader>dd"] = { "<cmd>lua require'dap'.disconnect()<cr>", "Disconnect" },
    ["<leader>dg"] = { "<cmd>lua require'dap'.session()<cr>", "Get Session" },
    ["<leader>ds"] = { "<cmd>lua require'dap'.step_into()<cr>", "Step Into" },
    ["<leader>dn"] = { "<cmd>lua require'dap'.step_over()<cr>", "Next" },
    ["<leader>do"] = { "<cmd>lua require'dap'.step_out()<cr>", "Step Out" },
    ["<leader>dp"] = { "<cmd>lua require'dap'.pause()<cr>", "Pause" },
    ["<leader>dt"] = { "<cmd>lua require'dap'.repl.toggle()<cr>", "Toggle Terminal" },
    ["<leader>du"] = { "<cmd>lua require'dapui'.toggle()<cr>", "Toggle UI" },
    ["<leader>dq"] = { "<cmd>lua require'dap'.close()<cr>", "Quit" },
    ["<leader>dw"] = { "<cmd>lua require'dapui'.float_element()<cr>", "Float Window" },
  },
}

M.telescope = {
  n = {
    ["<leader>fk"] = { "<cmd> Telescope keymaps <CR>", "   show keys" },
    ["<leader>ft"] = { "<cmd> Telescope terms <CR>", "   pick hidden term" },
    ["<leader>fT"] = { "<cmd> Telescope themes <CR>", "   nvchad themes" },
    ["<leader>fs"] = { "<cmd> SessionManager load_session<CR>", "  session" },
    ["<leader>gc"] = { "<cmd> Telescope git_commits <CR>", "   git commits" },
    ["<leader>gt"] = { "<cmd> Telescope git_status <CR>", "   git status" },
  },
}

M.lsp = {
  n = {
    ["<leader>la"] = { vim.lsp.buf.code_action, "Code Action" },
    ["<leader>ld"] = { "<cmd>Telescope diagnostics bufnr=0 theme=get_ivy<cr>", "Buffer Diagnostics" },
    ["<leader>lD"] = { "<cmd>Telescope diagnostics<cr>", "Workspace Diagnostics" },
    ["<leader>lf"] = { vim.lsp.buf.format, "Format" },
    ["<leader>li"] = { "<cmd>LspInfo<cr>", "Info" },
    ["<leader>lI"] = { "<cmd>Mason<cr>", "Installer Info" },
    ["<leader>ll"] = { vim.lsp.codelens.run, "CodeLens Action" },
    ["<leader>lq"] = { function()
      vim.diagnostic.setloclist({ severity = vim.diagnostic.severity.ERROR })
    end, "Quickfix Document" },
    ["<leader>lQ"] = { function()
      vim.diagnostic.setqflist({ severity = vim.diagnostic.severity.ERROR })
    end, "Quickfix Workspace" },
    ["<leader>lr"] = { require("nvchad_ui.renamer").open, "Rename" },
    ["<leader>ls"] = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
    ["<leader>lS"] = {
      "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
      "Workspace Symbols",
    },
    ["<leader>lO"] = {
      "<cmd>SymbolsOutline<cr>",
      "Symbol Outline",
    },
    ["<leader>lwa"] = {
      vim.lsp.buf.add_workspace_folder,
      "   add workspace folder",
    },
    ["<leader>lwr"] = {
      vim.lsp.buf.remove_workspace_folder,
      "   remove workspace folder",
    },
    ["<leader>lwl"] = {
      function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end,
      "   list workspace folders",
    },
  },
}

M.gitsigns = {
  n = {
    ["<leader>gl"] = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
    ["<leader>gp"] = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
    ["<leader>gr"] = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
    ["<leader>gR"] = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
    ["<leader>gs"] = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
    ["<leader>gu"] = {
      "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
      "Undo Stage Hunk",
    },
    ["<leader>go"] = { "<cmd>Telescope git_status<cr>", "Open changed file" },
    ["<leader>gb"] = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
    ["<leader>gc"] = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
    ["<leader>gC"] = {
      "<cmd>Telescope git_bcommits<cr>",
      "Checkout commit(for current file)",
    },
    ["<leader>gd"] = {
      "<cmd>Gitsigns diffthis HEAD<cr>",
      "Git Diff",
    },
    ["<leader>gg"] = { "<cmd>Git<cr>", "   gitfutive" },
    ["<leader>gv"] = { "<cmd>DiffviewOpen<cr>", "  diff view" },
    ["<leader>gf"] = { "<cmd>DiffviewFileHistory<cr>", "  file diff view" },
  },
}

-- M.groups = {
--   n = {
--     ["<leader>"] = {
--       f = { name = "find" },
--       z = { name = "zk notes" },
--       r = { name = "rest" },
--       c = { name = "code" },
--       t = { name = "test/telescope" },
--     },
--   },
-- }

M.tabufline = {
  n = {
    ["L"] = { require("nvchad_ui.tabufline").tabuflineNext, "  goto next buffer" },
    ["H"] = { require("nvchad_ui.tabufline").tabuflinePrev, "  goto prev buffer" },
  },
}

return M
