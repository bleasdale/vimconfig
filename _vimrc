"    __   _(_)_ __ ___  _ __ ___
"    \ \ / / | '_ ` _ \| '__/ __|
"  _  \ V /| | | | | | | | | (__
" |_|  \_/ |_|_| |_| |_|_|  \___|
"
" \\            // Nicholas's .vimrc
"  \\          //  Work machine
"   \\  //\\  //   MYVIMRC in ~
"    \\//  \\//
"     \/    \/     Updated 31/05/2021


" LEADER
" this machine has a us keyboard with an awkward \ position
" changed from "," because "," is used to repeat f, F, t, T
let mapleader=" "
let maplocalleader=","
if &compatible
  " Vim defaults to `compatible` when selecting a vimrc with the command-line
  " `-u` argument. Override this.
  set nocompatible
endif
set backspace=2 "backspace deletes like most programs in insert mode
set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=
set belloff=all
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set autoindent
set smartindent
set cindent
set wildmenu
set wildmode=full
set wildignore+=*.swp,*.bak,*.aux,*.log,*.pdf,*.out,*.tmp,*.jpg,*.gif,*.png
set wildignore+=*.ico,*.pdf,*.a,*.o,*.so
set showmatch
set matchtime=3
"set nowrap 
set wrap linebreak nolist
set noswapfile
set nobackup
set undodir=~/vimfiles/undodir
set undofile
set hlsearch
set incsearch
set smartcase
set spell spelllang=en_gb
"set lazyredraw " Make things faster? Useful if heavy macro use.
set encoding=utf-8
scriptencoding utf-8
" Switch buffers without saving
set hidden
set ruler

set guioptions-=r " remove RH scroll bar
set guioptions-=L " remove Lh scroll bar
set guioptions-=T " remove toolbar
if has('python3')
    silent! python3 1
endif

" 'hybrid' line numbering. Relative but current line is absolute
set number relativenumber   
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

" Session management
let g:sessions_dir = '~/vimfiles/sessions'
exec 'nnoremap <Leader>ss :mks! ' . g:sessions_dir . '/*.vim<C-D><BS><BS><BS><BS><BS>'
exec 'nnoremap <Leader>sr :so ' . g:sessions_dir. '/*.vim<C-D><BS><BS><BS><BS><BS>'


" BEGIN VIM-PLUG - automatically does filetype off
"  :PlugInstall "Installs new and updates existing plugins
"  :PlugUpgrade " updates vim-plug
"  :PlugUpdate  " updates existing plugins

"let g:plugs_disabled = []
let g:plugs_disabled = ['YouCompleteMe','vim-rtags']

call plug#begin('~/vimfiles/vim-plug-plugins')
Plug 'morhetz/gruvbox'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/syntastic'
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-abolish'
"Plug 'luochen1990/rainbow' "Open and close bracket pair highlighter
Plug 'itchyny/lightline.vim' "Fancy status bars
Plug 'terryma/vim-multiple-cursors'
Plug 'w0rp/ale'
Plug 'vim-latex/vim-latex'
Plug 'editorconfig/editorconfig-vim'
Plug 'jremmen/vim-ripgrep'
Plug 'vim-utils/vim-man' "Linux, Unix, BSD man pages from Vim
"lug 'lyuts/vim-rtags'
"lug 'Valloric/YouCompleteMe'
Plug 'mbbill/undotree'
Plug 'flazz/vim-colorschemes'
Plug 'altercation/vim-colors-solarized'
Plug 'SirVer/ultisnips'
Plug 'thaerkh/vim-workspace'
Plug 'junegunn/fzf', { 'dir': '~/vimfiles/vim-plug-plugins/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim' " fzf needs fzf and ripgrep to be installed
Plug 'stefandtw/quickfix-reflector.vim' "acts on ripgrep quickfix list and writes changes out to all files
Plug 'dhruvasagar/vim-table-mode'
Plug 'tpope/vim-obsession'
Plug 'dhruvasagar/vim-prosession'
Plug 'rust-lang/rust.vim'
Plug 'rking/ag.vim' " ag.vim requires ag (via choco)
Plug 'justinmk/vim-dirvish' "generates shell script for file ops
Plug 'ryanoasis/vim-devicons'
call plug_disable#commit()
call plug#end()
" END VIM-PLUG

filetype plugin on
filetype plugin indent on
syntax on

let g:tex_flavor='latex'
let g:Tex_CompileRule_pdf = 'xelatex --interaction=nonstopmode --shell-escape $*'
autocmd filetype tex setlocal shiftwidth=2 tabstop=2 "automatically change indent to 2 spaces for latex
let g:Tex_DefaultTargetFormat='pdf'
let g:Tex_MultipleCompileFormats='pdf'
let g:Tex_ViewRule_dvi = 'yap -1'
let g:Tex_ViewRule_pdf = 'SumatraPDF -reuse-instance'
"switch to pdflatex
function SetpdfLaTeX()
    let g:Tex_CompileRule_pdf = 'pdflatex --interaction=nonstopmode -synctex=1 -src-specials $*'
endfunction
noremap <Leader>lp :<C-U>call SetpdfLaTeX()<CR>

"switch to xelatex
function SetXeLaTeX()
    let g:Tex_CompileRule_pdf = 'xelatex --interaction=nonstopmode -synctex=1 -src-specials $*'
endfunction
noremap <Leader>lx :<C-U>call SetXeLaTeX()<CR>

" LIGHTLINE
set laststatus=2
"let g:lightline = { 'colorscheme': 'blue' } " simple setup example
let g:lightline = {
	\ 'colorscheme': 'PaperColor_light',
	\ 'active': {
		\   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ] ]
		\ },
	\ 'component_function': {
		\   'fugitive': 'MyFugitive',
		\   'filename': 'MyFilename'
		\ }
	\ }
	function! MyModified()
		return &ft =~ 'help\|vimfiler' ? '' : &modified ? '+' : &modifiable ? '' : '-'
	endfunction
	function! MyReadonly()
		return &ft !~? 'help\|vimfiler' && &readonly ? 'RO' : ''
	endfunction
	function! MyFilename()
		return ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
		\ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
		\  &ft == 'unite' ? unite#get_status_string() :
		\  &ft == 'vimshell' ? vimshell#get_status_string() :
		\ '' != expand('%:t') ? expand('%:f') : '[No Name]') .
		\ ('' != MyModified() ? ' ' . MyModified() : '')
	endfunction
	function! MyFugitive()
		if &ft !~? 'vimfiler' && exists("*fugitive#head")
			return fugitive#head()
		endif
		return ''
	endfunction
" end Lightline

" flazz/vim-colorschemes : molokai, wombat, underwoater, gruvbox, solarized, 
colorscheme gruvbox
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

" get ripgrep's root directory correct
if executable('rg')
    let g:rg_derive_root='true'
endif


" Luochen Rainbow
let g:rainbow_active = 1
let g:rainbow_load_separately = [
    \ [ '*' , [['(', ')'], ['\[', '\]'], ['{', '}']] ],
    \ [ '*.tex' , [['(', ')'], ['\[', '\]']] ],
    \ [ '*.cpp' , [['(', ')'], ['\[', '\]'], ['{', '}']] ],
    \ [ '*.{html,htm}' , [['(', ')'], ['\[', '\]'], ['{', '}'], ['<\a[^>]*>', '</[^>]*>']] ],
    \ ]

let g:rainbow_guifgs = ['RoyalBlue3', 'DarkOrange3', 'DarkOrchid3', 'FireBrick']
let g:rainbow_ctermfgs = ['lightblue', 'lightgreen', 'yellow', 'red', 'magenta']

"bash
    let g:ycm_semantic_triggers = {
        \ 'tex'  : ['{']
    \}

if has("gui_running")
    "set guifont=:set guifont=Consolas:h12:cANSI:qDRAFT
    set guifont=Lucida_Sans_Typewriter:h12:cANSI:qDRAFT
	"set lines=999 columns=999   " Maximise gvim window
" Remember last screen size
  function! ScreenFilename()
    if has('amiga')
      return "s:.vimsize"
    elseif has('win32')
      return $HOME.'\_vimsize'
    else
      return $HOME.'/.vimsize'
    endif
  endfunction
  function! ScreenRestore()
    " Restore window size (columns and lines) and position
    " from values stored in vimsize file.
    " Must set font first so columns and lines are based on font size.
    let f = ScreenFilename()
    if has("gui_running") && g:screen_size_restore_pos && filereadable(f)
      let vim_instance = (g:screen_size_by_vim_instance==1?(v:servername):'GVIM')
      for line in readfile(f)
        let sizepos = split(line)
        if len(sizepos) == 5 && sizepos[0] == vim_instance
          silent! execute "set columns=".sizepos[1]." lines=".sizepos[2]
          silent! execute "winpos ".sizepos[3]." ".sizepos[4]
          return
        endif
      endfor
    endif
  endfunction

  function! ScreenSave()
    " Save window size and position.
    if has("gui_running") && g:screen_size_restore_pos
      let vim_instance = (g:screen_size_by_vim_instance==1?(v:servername):'GVIM')
      let data = vim_instance . ' ' . &columns . ' ' . &lines . ' ' .
            \ (getwinposx()<0?0:getwinposx()) . ' ' .
            \ (getwinposy()<0?0:getwinposy())
      let f = ScreenFilename()
      if filereadable(f)
        let lines = readfile(f)
        call filter(lines, "v:val !~ '^" . vim_instance . "\\>'")
        call add(lines, data)
      else
        let lines = [data]
      endif
      call writefile(lines, f)
    endif
  endfunction

  if !exists('g:screen_size_restore_pos')
    let g:screen_size_restore_pos = 1
  endif
  if !exists('g:screen_size_by_vim_instance')
    let g:screen_size_by_vim_instance = 1
  endif
  autocmd VimEnter * if g:screen_size_restore_pos == 1 | call ScreenRestore() | endif
  autocmd VimLeavePre * if g:screen_size_restore_pos == 1 | call ScreenSave() | endif
else
	" we are running console Vim
	if exists("+lines")
		set lines=50
	endif
	if exists("+columns")
		set columns=100
	endif
endif " has gui_running

" UltiSnips
let g:UltiSnipsUsePythonVersion = 3
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsEditSplit="vertical"

" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" KEY MAPPINGS
nnoremap <leader>h :wincmd h<CR> " means \h moves the curser to the window to the right
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>
nnoremap <silent> <leader>+ :vertical resize +5<CR>
nnoremap <silent> <leader>- :vertical resize -5<CR>
nnoremap <leader>n :bn<CR> " means \n moves to the next buffer. Current must be saved
nnoremap <leader>p :bp<CR> " previous buffer
nnoremap <silent> <leader>ev :e $MYVIMRC<CR>
nnoremap <silent> <leader>so :w<CR> :so $MYVIMRC<CR>
nnoremap ; :

" NERDTree
" Check if NERDTree is open or active
function! IsNERDTreeOpen()
  return exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) != -1)
endfunction

" Call NERDTreeFind iff NERDTree is active, current window contains a modifiable
" file, and we're not in vimdiff
function! SyncTree()
  if &modifiable && IsNERDTreeOpen() && strlen(expand('%')) > 0 && !&diff
    NERDTreeFind
    wincmd p
  endif
endfunction

" Highlight currently open buffer in NERDTree
autocmd BufRead * call SyncTree()
nnoremap <leader>f :NERDTreeToggle<CR><C-w>l:call SyncTree()<CR<C-w>h
nnoremap <F6> :NERDTreeToggle<CR>
nnoremap <F5> :UndotreeToggle<CR>
nnoremap <silent> <leader>v :NERDTreeFind<CR>
let NERDTreeQuitOnOpen = 1
" automatically close tab if the last window is NerdTree
autocmd bufenter * if (winnr("$") == 1 && exists ("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
" automatically delete the buffer of the file just deleted with NerdTree
let NERDTreeAutoDeleteBuffer = 1

" Run commands that require an interactive shell
nnoremap <leader>r :RunInInteractiveShell<Space>

" un-highlight after a search (:noh)
"noremap <silent> <C-/> :let @/ = ""<CR>
nnoremap <CR> :noh<CR><CR>

" Map TAB to ESC
nnoremap <Tab> <Esc>
vnoremap <Tab> <Esc>gV
onoremap <Tab> <Esc>
cnoremap <Tab> <C-C><Esc>
inoremap <Tab> <Esc>`^
inoremap <Leader><Tab> <Tab>
" autocommands to remap TAB back to ESC if plugins alter the mapping
au VimEnter * map <Tab> <Esc>
au VimEnter * imap <Tab> <Esc>
au VimEnter * vmap <Tab> <Esc>

" tab stuff. The SyncTree causes NerdTree to follow the location of the buffer
noremap <leader>tN :tabnew<CR> :call SyncTree()<CR>
noremap <leader>tc :tabclose<CR> :call SyncTree()<CR>
noremap <leader>tn :tabnext<CR>
noremap <leader>tp :tabprevious<CR>
nnoremap <leader>1 1gt
nnoremap <leader>2 2gt
nnoremap <leader>3 3gt
nnoremap <leader>4 4gt
nnoremap <leader>5 5gt
nnoremap <leader>6 6gt
nnoremap <leader>7 7gt
nnoremap <leader>8 8gt
nnoremap <leader>9 9gt
" visual select then @ to run a macro on the selection https://medium.com/@schtoeffel/you-don-t-need-more-than-one-cursor-in-vim-2c44117d51dbn
source ~/vimfiles/visual-at.vim

"set shellslash
"
" Local config
if filereadable($HOME . "/vimfiles/_vimrc.local")
    source ~/vimfiles/_vimrc.local
endif

