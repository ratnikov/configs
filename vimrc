syntax on
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
