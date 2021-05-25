Patch for Latex-suite allowing Forward search with SumatraPDF for Windows.
Also details the setup instruction to use backward search.
Date: 2009/02/20
Authors: 
	Julien Cornebise (julien@corne.biz) 
	Manuel Pegourie-Gonnard (mpg@elzevir.fr)

REQUIRES:

1. Latex-suite and GVim (tested with Gvim 7.2). Please use the latest
	SVN version of Latex-suite, as the official package is outdated
	(http://vim-latex.svn.sourceforge.net/viewvc/vim-latex/).

2. SumatraPDF version beta 0.9.3 at least (tested with beta 0.9.3).
	(available at http://blog.kowalczyk.info/software/sumatrapdf/index.html)

3. Python with "Python for Windows" extension
	(available at http://www.python.org/download/windows/ and 
	http://starship.python.net/crew/mhammond/win32/, respectively)
	(tested with Python 2.6 and Build 212, respectively)

INSTALL:

1. Add SumatraPDF folder to your PATH environment variable.

2. Copy fwdsumatra.py in ftplugin/latex-suite

3. Apply patch to compiler.vim, by copying fwdsumatra.diff in 
	latex-suite folder and running
	patch -p0 -c -b compiler.vim fwdsumatra.diff
	(Note: the "patch" utility is avaiable for example in Cygwin)

3. Set-up pdflatex to use synctex, by adding 
	let g:Tex_CompileRule_pdf = 'pdflatex --synctex=-1 -src-specials -interaction=nonstopmode $*'
	in your .vimrc or vimfiles/ftplugin/tex.vim (create it if needed).
	Note: requires a recent version of pdflatex, see SyncTeX homepage
	(http://itexmac.sourceforge.net/SyncTeX.html).

5. Set-up latex-suite to use SumatraPDF for viewing by adding the line
	let g:Tex_ViewRule_pdf = 'SumatraPDF -inverse-search "gvim -c \":RemoteOpen +\%l \%f\""'
	in your .vimrc or vimfiles/ftplugin/tex.vim (create it if needed).
	NOTE: this also sets up the Backward search in SumatraPDF (to be precise,
	the argument would only need to be called once and for all, as SumatraPDF
	remembers the setting).

RUN:

1. Open a TeX-file

2. Set the target as PDF, either with "TTarget" in the buffer, or by having
	prealably added the line
	let g:Tex_DefaultTargetFormat= 'pdf'
	in your .vimrc or vimfiles/ftplugin/tex.vim (create it if needed). 

3. Compile by pressing \ll . 

4. Press \ls to jump to the current line of the .tex file in the PDF file.

5. Enjoy !

REMARK: 

1. Does not work with the beamer class, due to incompatibility between
	beamer and most synchronization technologies, including SyncTeX (see
	http://itexmac.sourceforge.net/SyncTeX.html for details).

2. Usual disclaimer, if the world explodes because you run this patch, not
	our fault.

LICENSE:

	This program is free software. It comes without any warranty, to
	the extent permitted by applicable law. You can redistribute it
	and/or modify it under the terms of the Do What The Fuck You Want
	To Public License, Version 2, as published by Sam Hocevar. See
	http://sam.zoy.org/wtfpl/COPYING for more details.
