local o = vim.o
local g = vim.g

-- vim config
vim.cmd [[
  command! DiffOrig w !diff -u % -
  command! DiffOrigVim vert new | setlocal buftype=nofile | setlocal nobuflisted | read ++edit # | 0d_ | diffthis | wincmd p | diffthis | wincmd p
  command! CSpell e ~/.cspell.json
  command! -range -nargs=1 Search /\%><line1>l\%<<line2>l<args>
  packadd cfilter

  function! QuickFixToggle()
    if empty(filter(getwininfo(), 'v:val.quickfix'))
      copen
    else
      cclose
    endif
  endfunction

  " user-defined plugins
  lua require('custom.my-plugins.printf').setup()
]]

o.cmdheight = 1 -- more space in the neovim command line for displaying messages
o.confirm = true
o.foldmethod = "indent"
o.foldlevelstart = 99
o.swapfile = true
o.scrolloff = 8
o.wrap = true
o.relativenumber = true
-- opt.updatetime = 512
-- opt.timeoutlen = 400
-- opt.spell = true
-- opt.spelloptions = "camel"
g.conflict_marker_enable_mappings = 0
g.loaded_python3_provider = nil

local highlights = {
  -- diff
  "hi! DiffText guifg=black guibg=orange",
  "hi CursorLine guibg=#33354F",

  -- diagnostics underline
  "hi! DiagnosticUnderlineError guisp=#FF5555 gui=undercurl",
  "hi! DiagnosticUnderlineWarn guisp=#e0af68 gui=undercurl",
  "hi! DiagnosticUnderlineInfo guisp=#6ad8ed gui=undercurl",
  "hi! DiagnosticUnderlineHint guisp=#bd93f9 gui=undercurl",

  -- diagnostics vt
  "hi! DiagnosticVirtualTextError guifg=#FF5555 guibg=#362C3D",
  "hi! DiagnosticVirtualTextWarn guifg=#e0af68 guibg=#373640",
  "hi! DiagnosticVirtualTextInfo guifg=#6ad8eD guibg=#30385f",
  "hi! DiagnosticVirtualTextHint guifg=#bd93f9 guibg=#3d3059",

  -- conflict marker
  "highlight ConflictMarkerBegin guibg=#2f7366",
  "highlight ConflictMarkerOurs guibg=#2e5049",
  "highlight ConflictMarkerTheirs guibg=#344f69",
  "highlight ConflictMarkerEnd guibg=#2f628e",
  "highlight ConflictMarkerCommonAncestorsHunk guibg=#754a81",

  -- vim-matchup
  "hi MatchWord guifg=NONE guibg=#5e5f69",
}

local autocmds = {
  { "UIEnter", "*", table.concat(highlights, " | ") },
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
  o.guifont = "JetBrainsMono Nerd Font:h13"
  g.neovide_remember_window_size = true
  g.neovide_cursor_vfx_mode = "railgun"
  g.neovide_confirm_quit = true
  g.neovide_input_use_logo = 1
  g.neovide_no_idle = true

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
