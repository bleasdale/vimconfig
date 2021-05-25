" DrChip's settings, LaTeX maps, and stub support
"   Author:		Charles E. Campbell
"   Date:			Oct 07, 2014
"   Version:	2i	ASTRO-ONLY
if exists("b:loaded_texmaps")
 finish
endif
let b:loaded_texmaps= "v2i"

" ---------------------------------------------------------------------
" Public Interface: {{{1
com! Drcstubs call s:TexHelp()

" ---------------------------------------------------------------------
" LaTeX settings: {{{1
setlocal ts=2
setlocal isk+=_
setlocal ai
set nohls

" ---------------------------------------------------------------------
" Normal mode maps: {{{1
nmap <buffer>  <Leader>ib :r $STUB/bar.tex<CR>
nmap <buffer>  <Leader>Tart :r $TEXSTUB/article.tex<CR>
nmap <buffer>  <Leader>Tasm :r $TEXSTUB/asme.tex<CR>
nmap <buffer>  <Leader>Tbgn :r $TEXSTUB/bgn.tex<CR>
nmap <buffer>  <Leader>Tbib :w<CR>:!bibtex %:r<CR>
nmap <buffer>  <Leader>Tcmd :r $STUB/stub_Tcmd<CR>
nmap <buffer>  <Leader>Tend :r $TEXSTUB/end.tex<CR>
nmap <buffer>  <Leader>Teps :r $TEXSTUB/eps.tex<CR>/xbox<CR>cw
nmap <buffer>  <Leader>Tfan :r $TEXSTUB/fancyhf.tex<CR>
nmap <buffer>  <Leader>Tfig :r $TEXSTUB/figure.tex<CR>
nmap <buffer>  <Leader>Tgv  :w<CR>:!latex %<CR>:!dvips %:r -o %:r.ps<CR>:!gv %:r.ps<CR>
nmap <buffer>  <Leader>Tiee :r $TEXSTUB/ieee.tex<CR>
nmap <buffer>  <Leader>Tind :r $TEXSTUB/indent.tex<CR>
nmap <buffer>  <Leader>Tlet :r $TEXSTUB/letter.tex<CR>
nmap <buffer>  <Leader>TLet :r $TEXSTUB/Letter.tex<CR>
nmap <buffer>  <Leader>TexHelp :r $TEXSTUB/vimlist<CR>
nmap <buffer>  <Leader>Tmin :r $TEXSTUB/minipage.tex<CR>
nmap <buffer>  <Leader>Tnst :r $TEXSTUB/nstabbing.tex<CR>
nmap <buffer>  <Leader>Tqud :r $TEXSTUB/quad.tex<CR>
nmap <buffer>  <Leader>Trep :r $TEXSTUB/report.tex<CR>
nmap <buffer>  <Leader>Tsli :r $TEXSTUB/slide.tex<CR>
nmap <buffer>  <Leader>Ttab :r $TEXSTUB/tabular.tex<CR>
nmap <buffer>  <Leader>Twid :r $TEXSTUB/wide.tex<CR>

imap <buffer>  <Leader>Talg <Esc>o\begin{alg} {Algorithm ?}\rm\footnotesize\label{Alg-?}<CR>\end{alg}<Esc>kf?xi
imap <buffer>  <Leader>Tctr <Esc>o\begin{center}<CR>\end{center}<Esc>O
imap <buffer>  <Leader>Tdes <Esc>o\begin{description}<CR>\end{description}<Esc>O \item[
imap <buffer>  <Leader>Tenu <Esc>o\begin{enumerate}<CR>\end{enumerate}<Esc>O \item
imap <buffer>  <Leader>Teqa <Esc>o\begin{eqnarray}<CR>\end{eqnarray}<Esc>O
imap <buffer>  <Leader>Teqn <Esc>o\begin{equation}<CR>\end{equation}<Esc>O
imap <buffer>  <Leader>Titm <Esc>o\begin{itemize}<CR>\end{itemize}<Esc>O \item
imap <buffer>  <Leader>Tsli <Esc>o\begin{slide}<cr>\end{slide}<esc>O

nmap <buffer> <silent> <c-a> :call <SID>Increment()<cr>
nmap <buffer> <silent> <c-x> :call <SID>Decrement()<cr>

nmap <buffer> <silent> <a-x>	:call <SID>TexSpecial()<CR>

" ---------------------------------------------------------------------
" Menus: {{{1
augroup DrcTexmapsEvents
 au!
 au BufEnter	*	call s:TexmapsMenu(1)
 au BufLeave	*	call s:TexmapsMenu(0)
augroup END

" ---------------------------------------------------------------------
" s:TexmapsMenu: toggle display of menu
fun! s:TexmapsMenu(menustate)
  if &ft == "tex" && has("gui") && has("gui_running") && has("menu")
"   call Dfunc("s:TexmapsMenu(menustate=".a:menustate.") ft<".&ft.">")
   if a:menustate
    menu DrChip.TexStubs.Help	:Drcstubs<cr>
    menu DrChip.TexStubs.Header.Article<tab>Tart	<Leader>Tart
    menu DrChip.TexStubs.Header.ASME<tab>Tasm	<Leader>Tasm
    menu DrChip.TexStubs.Header.Bibliography<tab>Tbib	<Leader>Tbib
    menu DrChip.TexStubs.Header.IEEE<tab>Tiee	<Leader>Tiee
    menu DrChip.TexStubs.Header.Begin<tab>Tbgn	<Leader>Tbgn
    menu DrChip.TexStubs.Header.End<tab>Tend	<Leader>Tend
    menu DrChip.TexStubs.Header.Fancy<tab>Tfan	<Leader>Tfan
    menu DrChip.TexStubs.Header.Letter<tab>Tlet	<Leader>Tlet
    menu DrChip.TexStubs.Header.Report<tab>Trep	<Leader>Trep
    menu DrChip.TexStubs.Header.Wide<tab>Twid	<Leader>Twid
    menu DrChip.TexStubs.Insert.Algorithm<tab>Talg	o<Leader>Talg
    menu DrChip.TexStubs.Insert.Bar<tab>\\ib	<Leader>ib
    menu DrChip.TexStubs.Insert.Center<tab>Tctr	o<Leader>Tctr
    menu DrChip.TexStubs.Insert.EqnArray<tab>Teqa	o<Leader>Teqa
    menu DrChip.TexStubs.Insert.Equation<tab>Teqn	o<Leader>Teqn
    menu DrChip.TexStubs.Insert.Figure<tab>Tfig	<Leader>Tfig
    menu DrChip.TexStubs.Insert.Indent<tab>Tind	<Leader>Tind
    menu DrChip.TexStubs.Insert.MiniPage<tab>Tmin	<Leader>Tmin
    menu DrChip.TexStubs.Insert.Quad<tab>Tqud	<Leader>Tqud
    menu DrChip.TexStubs.Insert.Tab<tab>Ttab	<Leader>Ttab
    menu DrChip.TexStubs.List.Description<tab>Tdes	o<Leader>Tdes
    menu DrChip.TexStubs.List.Enumerate<tab>Tenu	o<Leader>Tenu
    menu DrChip.TexStubs.List.Itemize<tab>Titm	o<Leader>Titm
    menu DrChip.TexStubs.Convert.PDF<tab>Tpdf	:Tpdf<cr>
    menu DrChip.TexStubs.Convert.PS<tab>Tps	:Tps<cr>
    menu DrChip.TexStubs.Display.GhostScript<tab>Tgs	<Leader>Tgs
    menu DrChip.TexStubs.Display.Latex+GhostScript<tab>Tlgs	:Tlgs<cr>
    menu DrChip.TexStubs.Display.Latex+Preview<tab>Vlp	:Vlp<cr>
    menu DrChip.TexStubs.Display.PDF<tab>Vpdf	:Vpdf<cr>
    menu DrChip.TexStubs.Display.Preview<tab>Vprv	:Vprv<cr>
    menu DrChip.TexStubs.Display.PS<tab>Vps	:Vps<cr>
    menu DrChip.TexStubs.Print.E142Color<tab>Tprl	:Tprl<cr>
    menu DrChip.TexStubs.Print.WF600<tab>Tprt	:Tprt<cr>
    menu DrChip.TexStubs.Print.Pdf<tab>Tpdf	:Tpdf<cr>
    menu DrChip.TexStubs.Print.HP4700Color<tab>Tphpc	:Tpc<cr>
    menu DrChip.TexStubs.Print.HP4000BW<tab>Tphpbw	:Tpbw<cr>
    menu DrChip.TexStubs.Queue.WF600<tab>Tqrt	:Tqrt<cr>
    menu DrChip.TexStubs.Queue.HP4700Color<tab>Tqhpc	:Tqc<cr>
    menu DrChip.TexStubs.Queue.HP4000BW<tab>Tqpbw	:Tqbw<cr>
   
    imenu DrChip.TexStubs.Insert.Algorithm<tab>Talg	<Leader>Talg
    imenu DrChip.TexStubs.Insert.Center<tab>Tctr	<Leader>Tctr
    imenu DrChip.TexStubs.Insert.EqnArray<tab>Teqa	<Leader>Teqa
    imenu DrChip.TexStubs.Insert.Equation<tab>Teqn	<Leader>Teqn
    imenu DrChip.TexStubs.List.Description<tab>Tdes	<Leader>Tdes
    imenu DrChip.TexStubs.List.Enumerate<tab>Tenu	<Leader>Tenu
    imenu DrChip.TexStubs.List.Itemize<tab>Titm	<Leader>Titm
   else
		 sil! unmenu  DrChip.TexStubs
		 sil! iunmenu DrChip.TexStubs
   endif
"   call Dret("s:TexmapsMenu")
  endif
endfun

" ---------------------------------------------------------------------
" Insert mode maps: {{{1
imap <buffer> \Talg <Esc>o\begin{alg} {Algorithm ?}\rm\footnotesize\label{Alg-?}<CR>\end{alg}<Esc>kf?xi
imap <buffer> \Tctr <Esc>o\begin{center}<CR>\end{center}<Esc>O
imap <buffer> \Tdes <Esc>o\begin{description}<CR>\end{description}<Esc>O \item[
imap <buffer> \Tenu <Esc>o\begin{enumerate}<CR>\end{enumerate}<Esc>O \item
imap <buffer> \Teps <Esc>:r $TEXSTUB/eps.tex<CR>/xbox<CR>cw
imap <buffer> \Teqa <Esc>o\begin{eqnarray}<CR>\end{eqnarray}<Esc>O
imap <buffer> \Teqn <Esc>o\begin{equation}<CR>\end{equation}<Esc>O
imap <buffer> \Tfan <Esc>:r $TEXSTUB/fancyhf.tex<CR>4jfL
imap <buffer> \Tfig <Esc>:r $TEXSTUB/figure.tex<CR>/T<CR>
imap <buffer> \Tind <Esc>:r $TEXSTUB/indent.tex<CR>/begin{<CR>o
imap <buffer> \Titm <Esc>o\begin{itemize}<CR>\end{itemize}<Esc>O \item
imap <buffer> \Tmin <Esc>:r $TEXSTUB/minipage.tex<CR>o
imap <buffer> \Ttab <Esc>:r $TEXSTUB/tabular.tex<CR>/Column<CR>

" ---------------------------------------------------------------------
" visual mode maps: {{{1
" \ff: manpage function fix
" \gc: green comment (footnote size, italic, green)
" \gb: green, bold text (normal size, bold, green)
" sf/bf/it/tt : wrap \textsf{around the text}, etc
vmap <buffer> <silent>	<Leader>ff	:<c-u>sil! '<,'>g/^\s*$/d<cr>:sil! '<,'>s/[#_]/\\&/ge<bar>'<,'>s/[<>]/$&$/ge<bar>'<,'>s/$/\\\\/<cr>
vmap <buffer> <silent>  <Leader>gc	:<c-u>B s/^\(\s*\)\(\S.*\)$/\1{\\footnotesize\\textcolor{green}{\\textit{\2}} }/<cr>
vmap <buffer> <silent>  <Leader>gb	:<c-u>B s/^\(\s*\)\(\S.*\)$/\1{\\textcolor{green}{\\textbf{\2}} }/<cr>
vmap <buffer> <silent>  <Leader>sf	:<c-u>B s/^\(\s*\)\(\S.*\)$/\1\\textsf{\2}/<cr>
vmap <buffer> <silent>  <Leader>bf	:<c-u>B s/^\(\s*\)\(\S.*\)$/\1\\textbf{\2}/<cr>
vmap <buffer> <silent>  <Leader>it	:<c-u>B s/^\(\s*\)\(\S.*\)$/\1\\textit{\2}/<cr>
vmap <buffer> <silent>  <Leader>tt	:<c-u>B s/^\(\s*\)\(\S.*\)$/\1\\texttt{\2}/<cr>
vno <silent> <buffer> b`  x:set lz<bar>let texmaps_keepfdm=&fdm<bar>set fdm=manual<cr>i\begin{<esc>pa}<cr>\end{<esc>pa}<esc>:let &fdm=texmaps_keepfdm<bar>set nolz<bar>unlet texmaps_keepfdm<cr>O
vno <silent> <buffer> ctr x:set lz<bar>let texmaps_keepfdm=&fdm<bar>set fdm=manual<cr>O\begin{center}<cr>\end{center}<esc>kp:?\\begin{center}?,/\\end{center}/<<cr>k:?\\begin{center}?+1,/\\end{center}/-1><cr>k:?\\begin{center}?+1,/\\end{center}/-1><cr>:let &fdm=texmaps_keepfdm<bar>set nolz<bar>unlet texmaps_keepfdm<cr>
vno <silent> <buffer> ff	:'<,'>s/#/\\#/g<bar>'<,\>s/[<>]/$&$/g<bar>'<,'>s/$/\\\\/<cr>
vno <silent> <buffer> tbf x:set lz<bar>let texmaps_keepfdm=&fdm<bar>set fdm=manual<cr>i\textbf{<esc>pa}<esc>:let &fdm=texmaps_keepfdm<bar>set nolz<bar>unlet texmaps_keepfdm<cr>
vno <silent> <buffer> tcb x:set lz<bar>let texmaps_keepfdm=&fdm<bar>set fdm=manual<cr>i\textcolor{black}{<esc>pa}<esc>:let &fdm=texmaps_keepfdm<bar>set nolz<bar>unlet texmaps_keepfdm<cr>
vno <silent> <buffer> tcB x:set lz<bar>let texmaps_keepfdm=&fdm<bar>set fdm=manual<cr>i\textcolor{blue}{<esc>pa}<esc>:let &fdm=texmaps_keepfdm<bar>set nolz<bar>unlet texmaps_keepfdm<cr>
vno <silent> <buffer> tcc x:set lz<bar>let texmaps_keepfdm=&fdm<bar>set fdm=manual<cr>i\textcolor{cyan}{<esc>pa}<esc>:let &fdm=texmaps_keepfdm<bar>set nolz<bar>unlet texmaps_keepfdm<cr>
vno <silent> <buffer> tcg x:set lz<bar>let texmaps_keepfdm=&fdm<bar>set fdm=manual<cr>i\textcolor{green}{<esc>pa}<esc>:let &fdm=texmaps_keepfdm<bar>set nolz<bar>unlet texmaps_keepfdm<cr>
vno <silent> <buffer> tck x:set lz<bar>let texmaps_keepfdm=&fdm<bar>set fdm=manual<cr>i\textcolor{khaki4}{<esc>pa}<esc>:let &fdm=texmaps_keepfdm<bar>set nolz<bar>unlet texmaps_keepfdm<cr>
vno <silent> <buffer> tcm x:set lz<bar>let texmaps_keepfdm=&fdm<bar>set fdm=manual<cr>i\textcolor{magenta}{<esc>pa}<esc>:let &fdm=texmaps_keepfdm<bar>set nolz<bar>unlet texmaps_keepfdm<cr>
vno <silent> <buffer> tcr x:set lz<bar>let texmaps_keepfdm=&fdm<bar>set fdm=manual<cr>i\textcolor{red}{<esc>pa}<esc>:let &fdm=texmaps_keepfdm<bar>set nolz<bar>unlet texmaps_keepfdm<cr>
vno <silent> <buffer> tcw x:set lz<bar>let texmaps_keepfdm=&fdm<bar>set fdm=manual<cr>i\textcolor{white}{<esc>pa}<esc>:let &fdm=texmaps_keepfdm<bar>set nolz<bar>unlet texmaps_keepfdm<cr>
vno <silent> <buffer> tcy x:set lz<bar>let texmaps_keepfdm=&fdm<bar>set fdm=manual<cr>i\textcolor{yellow}{<esc>pa}<esc>:let &fdm=texmaps_keepfdm<bar>set nolz<bar>unlet texmaps_keepfdm<cr>
vno <silent> <buffer> tcG x:set lz<bar>let texmaps_keepfdm=&fdm<bar>set fdm=manual<cr>i\textcolor{gray75}{<esc>pa}<esc>:let &fdm=texmaps_keepfdm<bar>set nolz<bar>unlet texmaps_keepfdm<cr>
vno <silent> <buffer> tem x:set lz<bar>let texmaps_keepfdm=&fdm<bar>set fdm=manual<cr>i\textem{<esc>pa}<esc>:let &fdm=texmaps_keepfdm<bar>set nolz<bar>unlet texmaps_keepfdm<cr>
vno <silent> <buffer> tfb x:set lz<bar>let texmaps_keepfdm=&fdm<bar>set fdm=manual<cr>i\textbf{<esc>pa}<esc>:let &fdm=texmaps_keepfdm<bar>set nolz<bar>unlet texmaps_keepfdm<cr>
vno <silent> <buffer> tfi x:set lz<bar>let texmaps_keepfdm=&fdm<bar>set fdm=manual<cr>i\textit{<esc>pa}<esc>:let &fdm=texmaps_keepfdm<bar>set nolz<bar>unlet texmaps_keepfdm<cr>
vno <silent> <buffer> mrm x:set lz<bar>let texmaps_keepfdm=&fdm<bar>set fdm=manual<cr>i\mathrm{<esc>pa}<esc>:let &fdm=texmaps_keepfdm<bar>set nolz<bar>unlet texmaps_keepfdm<cr>
vno <silent> <buffer> mit x:set lz<bar>let texmaps_keepfdm=&fdm<bar>set fdm=manual<cr>i\mathit{<esc>pa}<esc>:let &fdm=texmaps_keepfdm<bar>set nolz<bar>unlet texmaps_keepfdm<cr>
vno <silent> <buffer> mbf x:set lz<bar>let texmaps_keepfdm=&fdm<bar>set fdm=manual<cr>i\mathbf{<esc>pa}<esc>:let &fdm=texmaps_keepfdm<bar>set nolz<bar>unlet texmaps_keepfdm<cr>
vno <silent> <buffer> msf x:set lz<bar>let texmaps_keepfdm=&fdm<bar>set fdm=manual<cr>i\mathsf{<esc>pa}<esc>:let &fdm=texmaps_keepfdm<bar>set nolz<bar>unlet texmaps_keepfdm<cr>
vno <silent> <buffer> mtt x:set lz<bar>let texmaps_keepfdm=&fdm<bar>set fdm=manual<cr>i\mathtt{<esc>pa}<esc>:let &fdm=texmaps_keepfdm<bar>set nolz<bar>unlet texmaps_keepfdm<cr>
vno <silent> <buffer> mcl x:set lz<bar>let texmaps_keepfdm=&fdm<bar>set fdm=manual<cr>i\mathcal{<esc>pa}<esc>:let &fdm=texmaps_keepfdm<bar>set nolz<bar>unlet texmaps_keepfdm<cr>
vno <silent> <buffer> tfs :<c-u>call <SID>TexFromSlide(0)<cr>
vno <silent> <buffer> tos :<c-u>call <SID>TexFromSlide(1)<cr>
vno <silent> <buffer> tit x:set lz<bar>let texmaps_keepfdm=&fdm<bar>set fdm=manual<cr>i\textit{<esc>pa}<esc>:let &fdm=texmaps_keepfdm<bar>set nolz<bar>unlet texmaps_keepfdm<cr>
vno <silent> <buffer> tmd x:set lz<bar>let texmaps_keepfdm=&fdm<bar>set fdm=manual<cr>i\textmd{<esc>pa}<esc>:let &fdm=texmaps_keepfdm<bar>set nolz<bar>unlet texmaps_keepfdm<cr>
vno <silent> <buffer> tsc x:set lz<bar>let texmaps_keepfdm=&fdm<bar>set fdm=manual<cr>i\textsc{<esc>pa}<esc>:let &fdm=texmaps_keepfdm<bar>set nolz<bar>unlet texmaps_keepfdm<cr>
vno <silent> <buffer> tsf x:set lz<bar>let texmaps_keepfdm=&fdm<bar>set fdm=manual<cr>i\textsf{<esc>pa}<esc>:let &fdm=texmaps_keepfdm<bar>set nolz<bar>unlet texmaps_keepfdm<cr>
vno <silent> <buffer> tsf x:set lz<bar>let texmaps_keepfdm=&fdm<bar>set fdm=manual<cr>i\textsf{<esc>pa}<esc>:let &fdm=texmaps_keepfdm<bar>set nolz<bar>unlet texmaps_keepfdm<cr>
vno <silent> <buffer> tsh x:set lz<bar>let texmaps_keepfdm=&fdm<bar>set fdm=manual<cr>i{\huge <esc>pa}<esc>:let &fdm=texmaps_keepfdm<bar>set nolz<bar>unlet texmaps_keepfdm<cr>
vno <silent> <buffer> tsl x:set lz<bar>let texmaps_keepfdm=&fdm<bar>set fdm=manual<cr>i{\large <esc>pa}<esc>:let &fdm=texmaps_keepfdm<bar>set nolz<bar>unlet texmaps_keepfdm<cr>
vno <silent> <buffer> tsL x:set lz<bar>let texmaps_keepfdm=&fdm<bar>set fdm=manual<cr>i{\Large <esc>pa}<esc>:let &fdm=texmaps_keepfdm<bar>set nolz<bar>unlet texmaps_keepfdm<cr>
vno <silent> <buffer> tsl x:set lz<bar>let texmaps_keepfdm=&fdm<bar>set fdm=manual<cr>i\textsl{<esl>pa}<esl>:let &fdm=texmaps_keepfdm<bar>set nolz<bar>unlet texmaps_keepfdm<cr>
vno <silent> <buffer> tsn x:set lz<bar>let texmaps_keepfdm=&fdm<bar>set fdm=manual<cr>i{\normalsize <esc>pa}<esc>:let &fdm=texmaps_keepfdm<bar>set nolz<bar>unlet texmaps_keepfdm<cr>
vno <silent> <buffer> tss x:set lz<bar>let texmaps_keepfdm=&fdm<bar>set fdm=manual<cr>i{\scriptsize <esc>pa}<esc>:let &fdm=texmaps_keepfdm<bar>set nolz<bar>unlet texmaps_keepfdm<cr>
vno <silent> <buffer> tsS x:set lz<bar>let texmaps_keepfdm=&fdm<bar>set fdm=manual<cr>i{\small <esc>pa}<esc>:let &fdm=texmaps_keepfdm<bar>set nolz<bar>unlet texmaps_keepfdm<cr>
vno <silent> <buffer> tst x:set lz<bar>let texmaps_keepfdm=&fdm<bar>set fdm=manual<cr>i{\tiny <esc>pa}<esc>:let &fdm=texmaps_keepfdm<bar>set nolz<bar>unlet texmaps_keepfdm<cr>
vno <silent> <buffer> ttt x:set lz<bar>let texmaps_keepfdm=&fdm<bar>set fdm=manual<cr>i\texttt{<ett>pa}<ett>:let &fdm=texmaps_keepfdm<bar>set nolz<bar>unlet texmaps_keepfdm<cr>
vno <silent> <buffer> tup x:set lz<bar>let texmaps_keepfdm=&fdm<bar>set fdm=manual<cr>i\textup{<ett>pa}<ett>:let &fdm=texmaps_keepfdm<bar>set nolz<bar>unlet texmaps_keepfdm<cr>
vno <silent> <buffer> t$  x:set lz<bar>let texmaps_keepfdm=&fdm<bar>set fdm=manual<cr>i$<esc>pa$<esc>:let &fdm=texmaps_keepfdm<bar>set nolz<bar>unlet texmaps_keepfdm<cr>
vno <silent> <buffer> V`  x:set lz<bar>let texmaps_keepfdm=&fdm<bar>set fdm=manual<cr>i\Verbatim`<esc>pa`<esc>:let &fdm=texmaps_keepfdm<bar>set nolz<bar>unlet texmaps_keepfdm<cr>
vno <silent> <buffer> V@  x:set lz<bar>let texmaps_keepfdm=&fdm<bar>set fdm=manual<cr>i\Verbatim@<esc>pa@<esc>:let &fdm=texmaps_keepfdm<bar>set nolz<bar>unlet texmaps_keepfdm<cr>
vno <silent> <buffer> v`  x:set lz<bar>let texmaps_keepfdm=&fdm<bar>set fdm=manual<cr>i\verb`<esc>pa`<esc>:let &fdm=texmaps_keepfdm<bar>set nolz<bar>unlet texmaps_keepfdm<cr>
vno <silent> <buffer> v@  x:set lz<bar>let texmaps_keepfdm=&fdm<bar>set fdm=manual<cr>i\verb@<esc>pa@<esc>:let &fdm=texmaps_keepfdm<bar>set nolz<bar>unlet texmaps_keepfdm<cr>
vno <silent> <buffer> vg  :B call <SID>TexVerb(0)<cr>
vno <silent> <buffer> vv  :B call <SID>TexVerb(1)<cr>
vno <silent> <buffer> Vv  :B call <SID>TexVerbatim(0)<cr>
vno <silent> <buffer> VV  :B call <SID>TexVerbatim(1)<cr>
nm  <silent> <buffer> <Leader>ov	j[[maO\overlays{#}{%<esc>/\\end{slide}<cr>o}<esc>:'a,.-1g/^\s/s/^/ /<cr>'akf#xi
nm  <silent> <buffer> <Leader>Vv	:call <SID>TexVerbatim(3)<cr>

" ---------------------------------------------------------------------
" Printing commands: {{{1
if has("win32")
  com! Tprv w|exe "silent !yap ".expand("%:r")|redr!
  com! Vlp  w|exe "silent !latex ".expand("%")|exe "silent !yap ".expand("%:r")|redr!
  com! Vprv w|exe "silent !yap ".expand("%:r")|redr!
else
  " Latex() is a function/command in compilers/latex.vim
  com! Tasc            exe "silent !dvi2tty ".expand("%:r")." -o ".expand("%:r").".asc"|exe "vsp ".expand("%:r").".asc"|redr!
  com! Tlgs            exe "sil !dvips ".expand("%:r")."dvi"|exe "!gs ".expand("%:r").".ps"|redr!
  com! Tlgs            exe "sil !dvips ".expand("%:r")."dvi"|exe "!gs ".expand("%:r").".ps"|redr!
  com! Vlp             exe "sil !latex ".expand("%")|exe "sil !xdvi -s 3 ".expand("%:r")."&"|redr!
  com! Tpdf            exe "sil !dvipdf ".expand("%:r").".dvi"|redr!
  com! -count=1 Tprd   exe "sil !dvips ".expand("%:r").".dvi -o ".expand("%:r").".ps"|exe 'silent !lpr -h -\# '.<count>." -Pdione < ".expand("%:r").".ps"|redr!
  com! -count=1 Tprl   exe "sil !dvips ".expand("%:r").".dvi -o ".expand("%:r").".ps"|exe 'silent !lpr -h -\# '.<count>." -PE142color < ".expand("%:r").".ps"|redr!
  com! -count=1 Tprt   exe "sil !dvips ".expand("%:r").".dvi -o ".expand("%:r").".ps"|exe 'silent !lpr -h -\# '.<count>." < ".shellescape(expand("%:r").".ps",1)|redr!
  com! -count=1 Tpc    exe "sil !dvips ".expand("%:r").".dvi -o ".expand("%:r").".ps"|exe 'silent !lpr -h -\# '.<count>." -PHP-Color-Laserjet-4700 < ".expand("%:r").".ps"|redr!
  com! -count=1 Tpbw   exe "sil !dvips ".expand("%:r").".dvi -o ".expand("%:r").".ps"|exe 'silent !lpr -h -\# '.<count>." -PHP-Laserjet-4000 < ".expand("%:r").".ps"|redr!
  com! Tqrd            exe "!lpq -Pdione"
  com! Tqrl            exe "!lpq -PE142color"
  com! Tqrc            exe "!lpq -PS109color"
  com! Tqc             exe "!lpq -PHP-Color-Laserjet-4700"
  com! Tqbw            exe "!lpq -PHP-Laserjet-4000"
  com! Tps             exe "sil !dvips ".expand("%:r")." -o ".expand("%:r").".ps"|redr!
  com! Tprv            exe "sil !xdvi -s 3 ".expand("%:r")."&"|redr!
	com! TVpdf           exe "sil !dvipdf ".expand("%:r").".dvi"|call netrw#BrowseX(expand('%:r').'.pdf',0)
  com! Vprv            exe "sil !xdvi -s 3 ".expand("%:r")."&"|redr!
  com! Vpdf            call netrw#BrowseX(expand('%:r').'.pdf',0)
  com! Vps             call netrw#BrowseX(expand('%:r').'.ps',0)
endif

" ---------------------------------------------------------------------
" s:TexHelp: sets up a special window holding a list of my tex-related {{{1
"          maps, imaps, commands, etc
fun! s:TexHelp()

  " create TexHelp window
  if !exists("s:TexHelpbuf") || !bufexists(s:TexHelpbuf)
   let isfkeep= &isfname
   set isfname-=[
   set isfname-=]
   exe "bo sp ".escape('[Tex Map and Command Help]','')
   set buftype=nofile
   set bufhidden=wipe
   set noswapfile
   set noro
   let &isfname   = isfkeep
   let s:TexHelpbuf = bufnr("%")
  endif

  put ='(I)Maps {{{1'
  put ='* \Talg : (b-e ) algorithm        * \Tfig : (stub) figure'
  put ='  \Tart : (stub) article            \Tgv  : (pgm ) latex+dvips+gv'
  put ='  \Tasm : (stub) asme               \Tiee : (stub) ieee'
  put ='  \Tbgn : (stub) bgn              * \Tind : (stub) indent'
  put ='  \Tbib : (run ) bibtex           * \Titm : (b-e ) itemize'
  put ='  \Tcmd : (stub) stub_Tcmd          \Tlet : (stub) letter'
  put ='* \Tctr : (b-e ) center             \TexHelp : (stub) vimlist'
  put ='* \Tdes : (b-e ) description      * \Tmin : (stub) minipage'
  put ='  \Tend : (stub) end                \Tqud : (stub) quad'
  put ='* \Tenu : (b-e ) enumerate          \Trep : (stub) report'
  put ='* \Teps : (stub) eps                \Tsli : (stub) slide'
  put ='* \Teqa : (b-e ) eqnarray         * \Ttab : (stub) tabular'
  put ='* \Teqn : (b-e ) equation           \Twid : (stub) wide'
  put ='* \Tfan : (stub) fancy headers'
  put =''

  put ='Printer Commands {{{1'
  if has("win32")
   put ='Vlp : latex + yap
   put ='Vprv : yap'
  else
   put ='Tgs  : dvips+gs'
   put ='Tlgs : latex+dvi+gs'
   put ='Tpdf : latex+dvi+ps to pdf'
   put ='Tprb : latex+dvips+lpr to S109Color'
   put ='Tprd : latex+dvips+lpr to dione'
   put ='Tps  : latex+dvips'
   put ='Tprl : latex + dvips + lpr to E142Color'
   put ='Vlp  : latex+dvi'
   put ='Vpdf : preview pdf'
   put ='Vprv : preview'
   put ='Vps  : preview postscript'
  endif
  put =''

  put ='Environments And Abbreviations: {{{1'
  put =' _Short Form  Long Form_'
	put ='   align                  (for multiple eqns aligned on &=, one (#.#)) '
	put ='   arr`       array`'
  put ='   ctr        center'
  put ='   desc`      description`'
  put ='   enum`      enumerate`'
  put ='   eps`       epsf`       (for insertion of an eps figure)'
	put ='   eqnA`                  (multiple eqnarray with one number)'
  put ='   eqn`       equation`'
  put ='   eqna`      eqnarray`'
  put ='   fig`       figure`'
	put ='   flalign'
  put ='   frac`'
	put ='   gat        gather      ( for multiple eqns, multiple (#.#)'
  put ='   i`                     (creates a \item)'
  put ='   item`      itemize`'
  put ='   mat`       matrix`'
  put ='   mini`      minipage`'
	put ='   multc      multicol'
	put ='   multl      multline'
	put ='   split'
  put ='   tab`       tabular`'
  put ='   v`                    \verb``'
	put ='   V`                    \Verbatim``'
  put ='   verb`      verbatim`'
  put =''
  put ='Script Style Support: (imaps) {{{1'
  put ='   bf`                   \textbf{}'
  put ='   it`                   \textit{}'
  put ='   rm`                   \textrm{}'
  put ='   sc`                   \textsc{}'
  put ='   sf`                   \textsf{}'
  put ='   sl`                   \textsl{}'
  put ='   tt`                   \texttt{}'
  put ='   mtt`                  \mathtt{}'
  put ='   mrm`                  \mathrm{}'
  put ='   mbf`                  \mathbf{}'
  put ='   msf`                  \mathsf{}'
  put ='   mtt`                  \mathtt{}'
  put ='   mit`                  \mathit{}'
  put ='   mcal`                 \mathcal{}'
  put =''
  put =' Greek Letters: (imaps) {{{1'
  put ='  _Short-Form Stands-for        Short-Form Stands-for_'
  put ='   ---------- -------------     ---------- ----------'
  put ='   a`         \alpha            v          \nu'
  put ='   b`         \beta             f          \xi'
  put ='   g`         \gamma            p          \pi'
  put ='   d`         \delta            vp         \varpi'
  put ='   e`         \epsilon          r          \rho'
  put ='   ve`        \varepsilon       vr         \varrho'
  put ='   z`         \zeta             s          \sigma'
  put ='   n`         \eta              v          \varsigma'
  put ='   t`         \theta            t          \tau'
  put ='   vt`        \vartheta         u          \upsilon'
  put ='   io`        \iota             h          \phi'
  put ='   k`         \kappa            vh         \varphi'
  put ='   l`         \lambda           x          \chi'
  put ='   m`         \mu               q          \psi'
  put ='   w`         \omega'

  " syntax highlighting
  syn match texmapBar	'---\+'
  syn match texmapInfo  '([^)]\+)'	contains=texmapParen
  syn match texmapTitle	'^.*{{{\d$'	contains=texmapIgnore
  syn match texmapTitle	'_.\{-}_'		contains=texmapIgnore
  syn match texmapIgnore '{{{\d'		contained
	syn match texmapIgnore '_'				contained
  syn match texmapParen	'[()]'			contained

	if !exists("b:did_drchip_texhelp")
   command -nargs=+ HiLink hi def link <args>
   HiLink texmapBar 		Delimiter
   HiLink texmapIgnore	Ignore
   HiLink texmapInfo		String
   HiLink texmapParen	Delimiter
   HiLink texmapTitle	Statement
   let b:did_drchip_texhelp= 1
	 delc HiLink
	endif

  norm! 1Gdd
  setlocal ro
  setlocal fdm=marker
  norm! zM
endfun

" ---------------------------------------------------------------------
" s:TexVerb: a verbatim-like zone that's actually regular LaTeX {{{1
"     style= 0: include gray75 and footnotesize
"     style= 1: just do the verbatim-style conversion only
fun! s:TexVerb(style)
"  call Dfunc("s:TexVerb(style=".a:style.")")
	let keeplz= &lz
	set lz
	if !exists("s:texcmds")
	 " has to be a list, not a dictionary, because the transformations must be applied in the given sequence
   let s:texcmds= [
  \  ['\'  , '\textbackslash '       ], ['<' , '\textless '          ],
  \  ['~'  , '\textasciitilde '      ], ['ª' , '\textordfeminine '   ],
  \  ['∗'  , '\textasteriskcentered '], ['º' , '\textordmasculine '  ],
  \  ['^'  , '\textasciicircum '     ], ['¶' , '\textparagraph '     ],
  \  ['|'  , '\textbar '             ], ['·' , '\textperiodcentered '],
  \  ['¿'  , '\textquestiondown '    ], ['§' , '\textsection '       ],
  \  ['}'  , '\textbraceright '      ], ['“' , '\textquotedblleft '  ],
  \  ['•'  , '\textbullet '          ], ['”' , '\textquotedblright ' ],
  \  ['©'  , '\textcopyright '       ], ['‘' , '\textquoteleft '     ],
  \  ['†'  , '\textdagger '          ], ['’' , '\textquoteright '    ],
  \  ['‡'  , '\textdaggerdbl '       ], ['®' , '\textregistered '    ],
  \  ['…'  , '\textellipsis '        ], ['£' , '\textsterling '      ],
  \  ['—'  , '\textemdash '          ], ['™' , '\texttrademark '     ],
  \  ['–'  , '\textendash '          ], ['{' , '\textbraceleft '     ],
  \  ['¡'  , '\textexclamdown '      ], ['␣' , '\textvisiblespace '  ],
  \  ['>'  , '\textgreater '         ], ['#' , '\#'                  ],
  \  ['_'  , '\_'                    ], ['%' , '\%'                  ],
	\  ['&'  , '\&'                    ], ['$' , '\$']]
"	 call Decho("generated s:texcmds dictionary")
"	 call Decho("s:texcmds=".string(s:texcmds))
  endif

"	call Decho("line#".line(".")."<".getline(".").">  (original)")
	for cnvrt in s:texcmds
	 exe 'sil! s/'.escape(cnvrt[0],'^$\~').'/'.escape(cnvrt[1],'\').'/ge'
"	 call Decho("line#".line(".")."<".getline(".").">  (processed ".cnvrt[0].")")
	endfor
	if a:style == 0
	 sil! s/^.*$/\\textcolor{gray75}{\\textsf{\\footnotesize &}}/e
	endif
	let &lz= keeplz
"  call Dret("s:TexVerb")
endfun

" ---------------------------------------------------------------------
" s:TexVerbatim: for converting \Verbatim`...` to TexVerb style {{{1
"                         -or-  \Verb`...`
"                         -or-  \verb`...`
fun! s:TexVerbatim(style)
"  call Dfunc("s:TexVerbatim(style=".a:style.")")
	if a:style == 3
	 " turn off all indenting
	 let iexpr            = &indentexpr
	 let aikeep           = &ai
	 let cinkeep          = &cin
	 let sikeep           = &si
	 let lzkeep           = &lz
	 set lz indentexpr= noai nocin nosi
	 let stopline         = line(".")
	 call SaveMark("b")
	 norm! g`a
	 while search('\\Verbatim\|\\verb\>','cW',stopline)
		exe "norm! mbi\<cr>\<esc>9l"
		let ykeep    = @@
		norm! vy
		let stopchar = @@
		exe "norm! lf".stopchar."a\<cr>\<esc>k"
		let @@       = ykeep
		call s:TexVerbatim(0)
		norm! k
		j! 3
	 endwhile
	 call RestoreMark("b")
	 let &indentexpr = iexpr
	 let &ai         = aikeep
	 let &cin        = cinkeep
	 let &si         = sikeep
	 let &lz         = lzkeep
"   call Dret("s:TexVerbatim")
	 return

  elseif getline(".") =~ '\\bf\\color{yellow}\\Verbatim'
	 s/\\bf\\color{yellow}\\Verbatim\(.\)\(.\{-}\)\1/\2/
	 let yellow= 1

  elseif getline(".") =~ '\\Verbatim'
	 s/\\Verbatim\(.\)\(.\{-}\)\1/\2/

	elseif getline(".") =~ '\\verb'
	 s/\\verb\(.\)\(.\{-}\)\1/\2/

	elseif getline(".") =~ '\\Verb'
	 s/\\Verb\(.\)\(.\{-}\)\1/\2/
	endif
	if visualmode() == "V" && getline(".") =~ '^\s'
	 norm! 0dw
	 let atat= @@
	 call s:TexVerb(a:style)
	 let @@= atat
	 norm! 0P
	else
	 call s:TexVerb(a:style)
	endif
	if exists("yellow")
	 s/gray75/yellow/
	 s/\\footnotesize/&\\bf /
	endif
"  call Dret("s:TexVerbatim")
endfun

" ---------------------------------------------------------------------
" s:IncDecInit: initialize the increment-decrement dictionary {{{1
"               Supports s:Increment() and s:Decrement()
fun! s:IncDecInit()
"  call Dfunc("s:IncDecInit()")
	" initialize dictionary
	let s:IncDecDict={}

	" initialize lists
	let listnames  = ["sections","sizes","style209s","style2Es","stylemaths","greek","updnarrows","rlarrows","slantarrows","logic","sets"]
	let sections   = ["subparagraph","paragraph","subsubsection","subsection","section","chapter","part"]
	let sizes      = ["tiny","scriptsize","footnotesize","small","normalsize","large","Large","LARGE","huge","Huge"]
	let style209s  = ["rm","em","bf","it","sl","sf","sc","tt"]
	let style2Es   = ["textrm","textbf","textit","textmd","textsc","textsf","textsl","texttt","textup"]
	let stylemaths = ["mathnormal","mathbb","mathbf","mathcal","mathfrak","mathit","mathrm","mathsf","mathtt"]
	let greek      = ["alpha","beta","gamma","delta","epsilon","varepsilon","zeta","eta","theta","vartheta","kappa","lambda","mu","nu","xi","pi","varpi","rho","varrho","sigma","varsigma","tau","upsilon","phi","varphi","chi","psi","omega"]
	let updnarrows = ["downarrow","Downarrow","uparrow","Uparrow","updownarrow","Updownarrow"]
  let rlarrows   = ["rightarrow","Rightarrow","rightarrowtail","hookrighttarrow","leftarrow","Leftarrow","leftarrowtail","hookleftarrow","leftrightarrow","Leftrightarrow"]
	let slantarrows= ["nearrow","nwarrow","searrow","swarrow"]
	let logic      = ["land","lor","wedge","neg","therefore"]
	let sets       = ["varnothing","in","subset","subseteq","supset","supseteq","sqsubset","sqsubseteq","sqsupset","sqsupseteq","cup","bigcup","cap","bigcap","sqcup","bigsqcup","sqcap","bigsqcap"]

	" install lists into s:IncDecDict
	for lst in listnames
	 let indx= 0
	 exe "let lstlen= len(".lst.")"
"	 call Decho("len(".lst.")=".lstlen)
   while indx < lstlen
    let previndx = (indx <= 0)?          lstlen-1 : (indx-1)
    let nextindx = (indx >= lstlen-1)? 0          : (indx+1)
    exe "let item    =".lst."[".indx."]"
    exe "let previtem=".lst."[".previndx."]"
    exe "let nextitem=".lst."[".nextindx."]"
    let s:IncDecDict[item]= [previtem,nextitem]
"    call Decho(lst.": s:IncDecDict[".item."]=[".previtem.",".nextitem."]")
		let indx= indx + 1
   endwhile
	endfor

"  call Dret("s:IncDecInit")
endfun

" ---------------------------------------------------------------------
" s:Increment: modifies behavior of ctrl-x in LaTeX files {{{1
fun! s:Increment()
"  call Dfunc("s:Increment()")
	" if dictionary doesn't exist, create it
	if !exists("s:IncDecDict")
	 call s:IncDecInit()
  endif

	let yreg=@@
	norm! vy
	if has_key(s:IncDecDict,expand("<cword>"))
	 call SaveMark("a")
	 let incword= s:IncDecDict[expand("<cword>")][1]
	 exe "norm! madiwi".incword."\<esc>`a"
	 call RestoreMark("a")
	 norm! F\l
	else
	 " do usual ctrl-a
	 exe "norm! \<c-a>"
	endif

	let @@=yreg
"  call Dret("s:Increment")
endfun

" ---------------------------------------------------------------------
" s:Decrement: modifies behavior of ctrl-x in LaTeX files {{{1
fun! s:Decrement()
"  call Dfunc("s:Decrement()")
	" if dictionary doesn't exist, create it
	if !exists("s:IncDecDict")
	 call s:IncDecInit()
  endif

	let yreg=@@
	norm! vy
	if has_key(s:IncDecDict,expand("<cword>"))
	 call SaveMark("a")
	 let incword= s:IncDecDict[expand("<cword>")][0]
	 exe "norm! madiwi".incword."\<esc>`a"
	 call RestoreMark("a")
	 norm! F\l
	else
	 " do usual ctrl-a
	 exe "norm! \<c-a>"
	endif

	let @@=yreg
"  call Dret("s:Decrement")
endfun

" ---------------------------------------------------------------------
" s:TexSpecial: invokes an external program using the provided word {{{1
"               Assumes that the isk includes a "."
fun! s:TexSpecial()
"	call Dfunc("s:TexSpecial()")

	" get the word under the cursor, including any .suffix
	let iskkeep = &isk
	setl isk+=.
	let word    = expand("<cword>")
	let &isk    = iskkeep
"	call Decho("word<".word.">")

	if word =~ '.eps'
	 " invoke xfig on the associated fig file
	 " convert resulting fig file to an eps file
	 let drawfile= substitute(word,'\.eps$','.fig','')
"	 call Decho("drawfile<".drawfile.">")
	 call system("(xfig -cbg darkblue ".drawfile."; fig2dev -L eps ".drawfile." > ".word.')&')
	endif

"  call Dret("s:TexSpecial")
endfun

" ---------------------------------------------------------------------
" s:TexFromSlide: implements the tfs visual mode mapping {{{1
"                 Surrounds selected text with \fromSlide{}{...}
fun! s:TexFromSlide(style)
"	call Dfunc("s:TexFromSlide(style=".a:style.") ".((visualmode() == 'V')? "visual line" : (visualmode() == 'v')? "visual char" : "visual block"))

  let keep_fdm         = &fdm
  let keep_lz          = &lz
  let keep_ei          = &ei
	set lz ve=all ei=all
	if a:style == 0
	 let style= "fromSlide"
	elseif a:style == 1
	 let style= "onlySlide*"
	endif

	if visualmode() == 'v'
	 " visual character handling
   let g:texindent_stop = 1
   let curline          = line(".")
   norm! gv
   let swp              = SaveWinPosn()
"   call Decho("swp=".swp)
   exe 'norm! gvxi\'.style.'{}{'."\<esc>p"
   call RestoreWinPosn(swp)
   unlet swp
   if line('.') == curline
"    call Decho("same line, moving 13l")
    norm! 13l
   endif
   exe 'norm!  a}'."\<esc>%h"
   unlet g:texindent_stop
   startinsert

	elseif visualmode() == 'V'
	 " visual line handling
"	 call Decho("visual-line mode handling")
"	 call Decho("posn#3: ".string(getpos(".")))
	 let swp = SaveWinPosn()
	 exe "sil! '<,'>s/^\\(\\s*\\)\\(\\S.*\\)$/\\1\\\\".style."{1}{\\2}/"
	 call RestoreWinPosn(swp)
	 norm! f1
"	 call Decho("posn#4: ".string(getpos(".")))

	else
	 " visual block handling
"	 call Decho("visual-block mode handling")
"	 call Decho("posn#5: ".string(getpos(".")))
	 let swp      = SaveWinPosn()
	 let topline  = line("'<")
	 let botline  = line("'>")
	 let leftcol  = virtcol("'<")
	 let rightcol = virtcol("'>") + 1
"	 call Decho("topleft: ".topline.",".leftcol." botright: ".botline.",".rightcol)
	 " pad the lines out to virtcol columns if necessary
	 let padline= topline
	 while padline <= botline
		call setline(padline,printf("%-".rightcol."s",getline(padline)))
		let padline= padline + 1
	 endwhile

"	 call Decho("sil! ".topline.",".botline.'s`\%'.leftcol.'v\(.*\)\%'.rightcol.'v`\\fromSlide{1}{\1}`')
	 exe "sil! ".topline.",".botline.'s`\%'.leftcol.'v\(.*\)\%'.rightcol.'v`\\'.style.'{1}{\1}`'
	 call RestoreWinPosn(swp)
"	 call Decho("posn#6: ".string(getpos(".")))
	 norm! `<f1
  endif

  let &ei  = keep_ei
  let &fdm = keep_fdm
  let &lz  = keep_lz

"  call Dret("s:TexFromSlide")
endfun

" ---------------------------------------------------------------------
" vim:ts=2 fdm=marker
