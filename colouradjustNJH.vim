" Sourcing this file resets some of my preferences after changing colourscheme
" from what was set in .vimrc / _vimrc
"
set background=dark
" removes italic from comments, must be after setting colorscheme
highlight Comment cterm=NONE gui=NONE   
highlight normal guibg=black

set colorcolumn=80
highlight ColorColumn ctermbg=0 guibg=grey13

" tweak the insert mode cursor a bit
highlight iCursor guifg=white guibg=yellow
set guicursor+=i:ver25-iCursor
" tweek the normal mode cursor a bit
highlight Cursor guifg=blue guibg=GreenYellow



