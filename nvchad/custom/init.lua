-- vim config
vim.cmd [[
  command! ClearBuf %d a
  command! DiffOrig w !diff -u % -
  command! DiffOrigVim vert new | set buftype=nofile | read ++edit # | 0d_ | diffthis | wincmd p | diffthis
]]
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
-- vim.opt.concealcursor = "nc

local init_autocmd = {
   -- diff
   "hi DiffText guifg=NONE guibg=#44475A",
   "hi CursorLine guibg=#33354F",

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

   "hi CursorLine guibg=#33354F",
   "lua vim.diagnostic.config({ virtual_text = { prefix = '' } })",
}

local autocmds = {
   { "UIEnter", "*", table.concat(init_autocmd, " | ") },
   { "InsertLeave", "*", ":set relativenumber" },
   -- { "BufEnter", "*", "lua vim.diagnostic.config({ virtual_text = { prefix = '' } })" },
   { "InsertEnter", "*", ":set norelativenumber" },
   -- { "InsertLeave", "*", ":lua vim.diagnostic.show(nil, 0)" },
   -- { "InsertEnter", "*", ":lua vim.diagnostic.hide(nil, 0)" },
}

for _, v in ipairs(autocmds) do
   vim.api.nvim_create_autocmd(v[1], { pattern = v[2], command = v[3] })
end

-- GUI
if vim.g.neovide then
   vim.o.guifont = "JetBrainsMono Nerd Font Fix Line Height:h12"
   vim.g.neovide_remember_window_size = true
   vim.g.neovide_cursor_vfx_mode = "railgun"
   vim.g.neovide_input_use_logo = 1
   vim.cmd [[
    nmap <D-v> "+p<CR>
    imap <D-v> <C-R>+
    tmap <D-v> <C-R>+
    map ˙ <a-h>
    map ∆ <a-j>
    map ˚ <a-k>
    map ¬ <a-l> 
  ]]
end
