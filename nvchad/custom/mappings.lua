local M = {}

-- add this table only when you want to disable default keys
M.disabled = {
   n = {
      ["<leader>h"] = "",
      ["<leader>v"] = "",
      ["<leader>D"] = "",
      ["<leader>f"] = "",
      ["<leader>q"] = "",
      ["<leader>pt"] = "",
      ["<leader>uu"] = "",
      ["<leader>tp"] = "",
      ["<leader>tn"] = "",
      ["<leader>tt"] = "",
      ["<leader>ls"] = "",
      ["<leader>bc"] = "",
      ["<leader>wa"] = "",
      ["<leader>wk"] = "",
      ["<leader>wK"] = "",
      ["<leader>wl"] = "",
      ["<leader>wr"] = "",
      ["<S-b>"] = "",
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
      ["<C-w>z"] = { "<cmd>:resize | :vertical resize<CR>", "Zoom in window" },
      ["<leader>"] = {
         ["q"] = { "<cmd>q<cr>", "   quit" },
         ["w"] = { "<cmd>w<cr>", "﬚  save" },
         ["."] = { ":<Up><CR>", "   last cmd" },
         ["S"] = { "<cmd>lua require('spectre').open()<CR>", "   spectre" },
         ["p"] = { "<cmd>TroubleToggle<CR>", "  problems" },
      },
   },
}

M.neotest = {
   n = {
      ["<leader>t"] = {
         f = { '<cmd>lua require("neotest").run.run(vim.fn.expand("%"))<cr>', "Test File" },
         n = { '<cmd>lua require("neotest").run.run()<cr>', "Test Nearest" },
         o = { '<cmd>lua require("neotest").output.open({ enter = true })<cr>', "Show Test Output" },
         a = { '<cmd>lua require("neotest").run.attach()<cr>', "Attach Test" },
         s = { '<cmd>lua require("neotest").run.stop()<cr>', "Stop Test" },
         t = { '<cmd>lua require("neotest").summary.toggle()<cr>', "Toggle Test Outline" },
      },
   },
}

M.debug = {
   n = {
      ["<leader>"] = {
         ["d"] = {
            name = "debug",
            b = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Toggle Breakpoint" },
            S = { "<cmd>lua require'dap'.step_back()<cr>", "Step Back" },
            c = { "<cmd>lua require'dap'.continue()<cr>", "Continue" },
            C = { "<cmd>lua require'dap'.run_to_cursor()<cr>", "Run To Cursor" },
            d = { "<cmd>lua require'dap'.disconnect()<cr>", "Disconnect" },
            g = { "<cmd>lua require'dap'.session()<cr>", "Get Session" },
            s = { "<cmd>lua require'dap'.step_into()<cr>", "Step Into" },
            n = { "<cmd>lua require'dap'.step_over()<cr>", "Next" },
            o = { "<cmd>lua require'dap'.step_out()<cr>", "Step Out" },
            p = { "<cmd>lua require'dap'.pause()<cr>", "Pause" },
            t = { "<cmd>lua require'dap'.repl.toggle()<cr>", "Toggle Terminal" },
            u = { "<cmd>lua require'dapui'.toggle()<cr>", "Toggle UI" },
            r = { "<cmd>lua require'dap'.continue()<cr>", "Run" },
            q = { "<cmd>lua require'dap'.close()<cr>", "Quit" },
            w = { "<cmd>lua require'dapui'.float_element()<cr>", "Float Window" },
         },
      },
   },
}

M.telescope = {
   n = {
      ["<leader>"] = {
         ["fk"] = { "<cmd> Telescope keymaps <CR>", "   show keys" },
         ["ft"] = { "<cmd> Telescope terms <CR>", "   pick hidden term" },
         ["fT"] = { "<cmd> Telescope themes <CR>", "   nvchad themes" },
         ["gc"] = { "<cmd> Telescope git_commits <CR>", "   git commits" },
         ["gt"] = { "<cmd> Telescope git_status <CR>", "   git status" },
      },
   },
}

M.lsp = {
   n = {
      ["<leader>"] = {
         l = {
            name = "lsp",
            a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
            d = { "<cmd>Telescope diagnostics bufnr=0 theme=get_ivy<cr>", "Buffer Diagnostics" },
            D = { "<cmd>Telescope diagnostics<cr>", "Workspace Diagnostics" },
            f = { "<cmd>Neoformat<cr>", "Format" },
            i = { "<cmd>LspInfo<cr>", "Info" },
            I = { "<cmd>LspInstallInfo<cr>", "Installer Info" },
            j = {
               vim.diagnostic.goto_next,
               "Next Diagnostic",
            },
            k = {
               vim.diagnostic.goto_prev,
               "Prev Diagnostic",
            },
            l = { vim.lsp.codelens.run, "CodeLens Action" },
            q = { vim.diagnostic.setloclist, "Quickfix" },
            r = { vim.lsp.buf.rename, "Rename" },
            s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
            S = {
               "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
               "Workspace Symbols",
            },
            e = { "<cmd>Telescope quickfix<cr>", "Telescope Quickfix" },
            w = {
               name = "Workspace",
               a = {
                  vim.lsp.buf.add_workspace_folder,
                  "   add workspace folder",
               },
               r = {
                  vim.lsp.buf.remove_workspace_folder,
                  "   remove workspace folder",
               },
               l = {
                  function()
                     print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                  end,
                  "   list workspace folders",
               },
            },
         },
      },
   },
}

M.packer = {
   n = {
      ["<leader>"] = {
         P = {
            name = "packer",
            c = { "<cmd>PackerCompile<cr>", "Compile" },
            i = { "<cmd>PackerInstall<cr>", "Install" },
            s = { "<cmd>PackerSync<cr>", "Sync" },
            S = { "<cmd>PackerStatus<cr>", "Status" },
            u = { "<cmd>PackerUpdate<cr>", "Update" },
         },
      },
   },
}

M.gitsigns = {
   n = {
      ["<leader>"] = {
         g = {
            name = "git",
            j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
            k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
            l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
            p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
            r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
            R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
            s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
            u = {
               "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
               "Undo Stage Hunk",
            },
            o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
            b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
            c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
            C = {
               "<cmd>Telescope git_bcommits<cr>",
               "Checkout commit(for current file)",
            },
            d = {
               "<cmd>Gitsigns diffthis HEAD<cr>",
               "Git Diff",
            },
            g = { "<cmd>Git<cr>", "   gitfutive" },
            v = { "<cmd>DiffviewOpen<cr>", "  diff view" },
            f = { "<cmd>DiffviewFileHistory<cr>", "  file diff view" },
         },
      },
   },
}

M.groups = {
   n = {
      ["<leader>"] = {
         f = { name = "find" },
         z = { name = "zk notes" },
         r = { name = "refactor" },
         c = { name = "code" },
         t = { name = "test/telescope" },
      },
   },
}

M.tabufline = {
   n = {
      ["L"] = { "<cmd> Tbufnext <CR>", "  goto next buffer" },
      ["H"] = { "<cmd> Tbufprev <CR> ", "  goto prev buffer" },
   },
}

return M
