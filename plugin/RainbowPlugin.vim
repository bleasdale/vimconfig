" RainbowPlugin.vim
"   Author: Charles E. Campbell
"   Date:   Oct 28, 2009
"   Version: 2t	ASTRO-ONLY
" ---------------------------------------------------------------------
"  Load Once: {{{1
if &cp || exists("g:loaded_Rainbow")
 finish
endif
let g:loaded_Rainbow= "v00"
let s:keepcpo       = &cpo
set cpo&vim

" ---------------------------------------------------------------------
"  Public Interface: {{{1
com! -nargs=? -bang Rainbow	call Rainbow#Rainbow(<bang>1,<q-args>)

if has("conceal")
 com -nargs=? SplitRainbow call Rainbow#SplitRainbow(<q-args>)
endif

" ---------------------------------------------------------------------
" Default: {{{1
if !exists("g:hlrainbow")
 let g:hlrainbow= "{("
endif

" ---------------------------------------------------------------------
"  Restore: {{{1
let &cpo= s:keepcpo
unlet s:keepcpo
" vim: ts=4 fdm=marker
