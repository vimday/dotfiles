let mapleader = "\<space>"

nnoremap <leader>r :reg<enter>
nnoremap <leader>n :nohl<enter>

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.

Plugin 'tpope/vim-surround'

" inside plug#begin:
" use normal easymotion when in vim mode
" Plug 'easymotion/vim-easymotion'

" use vscode easymotion when in vscode mode
Plugin 'asvetliakov/vim-easymotion'

let g:EasyMotion_smartcase = 1
let g:EasyMotion_use_smartsign_us = 1
nmap <Leader><leader>. <Plug>(easymotion-repeat)
nmap s <Plug>(easymotion-s2)
vmap s <Plug>(easymotion-s2)

hi EasyMotionTarget guifg=#6BFFAD gui=bold

" All of your Plugins must be added before the following line
call vundle#end() " required

" filetype plugin indent on " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList - lists configured plugins
" :PluginInstall - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

if exists('g:vscode')
    " VSCode extension
    nmap gi <Cmd>call VSCodeCall("editor.action.goToImplementation")<CR>
    nmap gr <Cmd>call VSCodeCall("editor.action.goToReferences")<CR>
    
    nmap <Leader>j <Cmd>call VSCodeCall("workbench.action.editor.nextChange")<CR>
    nmap <Leader>k <Cmd>call VSCodeCall("workbench.action.editor.previousChange")<CR>

    nmap <Leader>m <Cmd>call VSCodeCall("bookmarks.toggle")<CR>
    nmap <Leader>b <Cmd>call VSCodeCall("bookmarks.list")<CR>

    nmap <Leader>f <Cmd>call VSCodeCall("editor.action.formatDocument")<CR>
    
    nmap <Leader>w <Cmd>call VSCodeCall("workbench.action.files.save")<CR>
    
    nnoremap <silent> za <Cmd>call VSCodeNotify('editor.toggleFold')<CR>
    nnoremap <silent> zR <Cmd>call VSCodeNotify('editor.unfoldAll')<CR>
    nnoremap <silent> zM <Cmd>call VSCodeNotify('editor.foldAll')<CR>
    nnoremap <silent> zo <Cmd>call VSCodeNotify('editor.unfold')<CR>
    nnoremap <silent> zO <Cmd>call VSCodeNotify('editor.unfoldRecursively')<CR>
    nnoremap <silent> zc <Cmd>call VSCodeNotify('editor.fold')<CR>
    nnoremap <silent> zC <Cmd>call VSCodeNotify('editor.foldRecursively')<CR>

    nnoremap <silent> z1 <Cmd>call VSCodeNotify('editor.foldLevel1')<CR>
    nnoremap <silent> z2 <Cmd>call VSCodeNotify('editor.foldLevel2')<CR>
    nnoremap <silent> z3 <Cmd>call VSCodeNotify('editor.foldLevel3')<CR>
    nnoremap <silent> z4 <Cmd>call VSCodeNotify('editor.foldLevel4')<CR>
    nnoremap <silent> z5 <Cmd>call VSCodeNotify('editor.foldLevel5')<CR>
    nnoremap <silent> z6 <Cmd>call VSCodeNotify('editor.foldLevel6')<CR>
    nnoremap <silent> z7 <Cmd>call VSCodeNotify('editor.foldLevel7')<CR>

    xnoremap <silent> zV <Cmd>call VSCodeNotify('editor.foldAllExcept')<CR>
else
    " ordinary neovim
    set nu
endif
