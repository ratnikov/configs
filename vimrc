set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'

Plugin 'google/vim-maktaba'
Plugin 'google/vim-codefmt'
Plugin 'google/vim-glaive'

Plugin 'google/vim-jsonnet'

call vundle#end()            " required
call glaive#Install()

syntax on
filetype indent plugin on
set autoindent
set smarttab
set sw=2
set mouse=a

command -range Comment :<line1>,<line2>s/^\(\s*\)\(.\)/\1# \2/
command -range Uncomment :<line1>,<line2>s/^\(\s*\)#\s*/\1/

vmap co : Comment<CR>
vmap uc : Uncomment<CR>

set clipboard=unnamed,exclude:cons\|linux

" set nofoldenable foldmethod=manual

command -nargs=? RunRailsTest :!echo "Running % -n \"/<args>/\""; ruby -Itest % -n "/<args>/"

cmap <expr> run<Space> "!ruby -Itest " . expand("%") . ' -n "//"<Left><Left>'
map <expr> gt ":RunRailsTest " . expand("<cword>") . "<CR>"

augroup autoformat_settings
  autocmd FileType bzl,BUILD AutoFormatBuffer buildifier
augroup END

set expandtab

" Make TABs visible.
set list
set listchars=tab:▸\ 
