local opt = vim.opt
local g = vim.g

-- vim config
vim.cmd [[
  command! ClearBuf %d a
  command! DiffOrig w !diff -u % -
  command! DiffOrigVim vert new | set buftype=nofile | read ++edit # | 0d_ | diffthis | wincmd p | diffthis
  command! CSpell e ~/.cspell.json
  packadd cfilter

  function! QuickFixToggle()
    if empty(filter(getwininfo(), 'v:val.quickfix'))
      copen
    else
      cclose
    endif
  endfunction
]]

opt.cmdheight = 1 -- more space in the neovim command line for displaying messages
opt.confirm = true
opt.foldmethod = "indent"
opt.foldlevelstart = 99
opt.swapfile = true
opt.scrolloff = 8
opt.wrap = true
-- opt.updatetime = 512
-- opt.timeoutlen = 400
-- opt.spell = true
-- opt.spelloptions = "camel"
g.conflict_marker_enable_mappings = 0

local theme_cmd = {
  -- diff
  "hi DiffText guifg=#FFB86C guibg=#33354f gui=NONE",
  "hi CursorLine guibg=#33354F",

  -- treesitter highlight
  -- "hi! link LspCodeLens Comment",
  -- "hi! link typescriptDestructureVariable TSVariable",
  "hi! link SpellBad DiagnosticUnderlineHint",
  -- "hi NormalFloat guibg=#44455F",

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

  -- conflict marker
  "highlight ConflictMarkerBegin guibg=#2f7366",
  "highlight ConflictMarkerOurs guibg=#2e5049",
  "highlight ConflictMarkerTheirs guibg=#344f69",
  "highlight ConflictMarkerEnd guibg=#2f628e",
  "highlight ConflictMarkerCommonAncestorsHunk guibg=#754a81",
}

local autocmds = {
  { "UIEnter", "*", table.concat(theme_cmd, " | ") },
  { "InsertLeave", "*", "lua vim.diagnostic.config({ virtual_text = { prefix = '' } })" },
  { "InsertLeave", "*", ":set relativenumber" },
  { "InsertEnter", "*", ":set norelativenumber" },
  { "InsertLeave", "*", ":lua vim.diagnostic.show(nil, 0)" },
  { "InsertEnter", "*", ":lua vim.diagnostic.hide(nil, 0)" },
}

for _, v in ipairs(autocmds) do
  vim.api.nvim_create_autocmd(v[1], { pattern = v[2], command = v[3] })
end

-- GUI
if g.neovide then
  opt.guifont = "JetBrainsMono Nerd Font:h13"
  g.neovide_remember_window_size = true
  g.neovide_cursor_vfx_mode = "railgun"
  g.neovide_input_use_logo = 1
  vim.cmd [[
    nmap <D-v> "+p<CR>
    imap <D-v> <C-R>+
    tmap <D-v> <C-R>+
    map ˙ <a-h>
    map ∆ <a-j>
    map ˚ <a-k>
    map ¬ <a-l> 
    map √ <a-v>
    map ˆ <a-i>
    tmap √ <a-v>
    tmap ˆ <a-i>
  ]]
end
