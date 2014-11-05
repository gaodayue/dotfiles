"--------------------------------------
"               Vundle
"--------------------------------------
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'altercation/vim-colors-solarized'
Plugin 'Lokaltog/vim-powerline'
Plugin 'kien/ctrlp.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-commentary'
"Plugin 'Valloric/YouCompleteMe'

call vundle#end()
filetype plugin indent on


"--------------------------------------
"              Key Map
"--------------------------------------
" Use <Space> for (search) and Ctrl-<Space> for (backwards search)                      
map <space> /
map <c-space> ?

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Allow saving of files when forgot to start vim using sudo
cmap w!! %!sudo tee > /dev/null %

" set a map leader
let mapleader = ","
let g:mapleader = ","

" Fast saving
nmap <leader>w :w!<cr>
" Close the current buffer                                          
map <leader>bd :bd<cr>
" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>


"--------------------------------------
"               Plugin
"--------------------------------------
" => Powerline
set t_Co=256
set laststatus=2

" => Nerd Tree
" -------------------------------------
map <leader>nn :NERDTreeToggle<cr>
map <leader>nb :NERDTreeFromBookmark
map <leader>nf :NERDTreeFind<cr>
let NERDTreeIgnore=['.o$[[file]]', '.class[[file]]', '.pyc[[file]]']
" -------------------------------------

" => Ctrl-P
" -------------------------------------
" let g:ctrlp_working_path_mode = 0
let g:ctrlp_map = '<leader>f'
let g:ctrlp_cmd = 'CtrlPBuffer'
let g:ctrlp_max_height = 20
let g:ctrlp_custom_ignore = 'node_modules\|^\.DS_Store\|^\.git\|^\.coffee'
" -------------------------------------

" => ctags & cscope
" -------------------------------------
" look for tags first in `pwd`, and work up the tree towards the root if not found
set tags=./tags;/

" cscope
if has("cscope")
    " use both cscope and ctag for 'ctrl-]', ':ta', and 'vim -t'
    set cscopetag
    " check ctags for definition of a symbol before checking cscope, set to 0
    " if you want the reverse search order.
    set csto=1
    " add any cscope database in current directory
    if filereadable("cscope.out")
        cs add cscope.out
    elseif $CSCOPE_DB != ""
        cs add $CSCOPE_DB
    endif
    " show msg when any other cscope db added
    set cscopeverbose

    " The following maps all invoke one of the following cscope search types:
    "
    "   's'   symbol: find all references to the token under cursor
    "   'g'   global: find global definition(s) of the token under cursor
    "   'c'   calls:  find all calls to the function name under cursor
    "   't'   text:   find all instances of the text under cursor
    "   'e'   egrep:  egrep search for the word under cursor
    "   'f'   file:   open the filename under cursor
    "   'i'   includes: find files that include the filename under cursor
    "   'd'   called: find functions that function under cursor calls
    "
    nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
    nmap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
    nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>

    " Using 'CTRL-spacebar' to open results in horizontal split
    nmap <C-@>s :scs find s <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@>g :scs find g <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@>c :scs find c <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@>t :scs find t <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@>e :scs find e <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@>f :scs find f <C-R>=expand("<cfile>")<CR><CR>
    nmap <C-@>i :scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
    nmap <C-@>d :scs find d <C-R>=expand("<cword>")<CR><CR>

    set timeoutlen=1000
endif

" YouCompleteMe
"let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
"nnoremap <leader>jd :YcmCompleter GoTo<CR>

" -------------------------------------


"--------------------------------------
"               General
"--------------------------------------
set hidden              " allow hidden buffer
set autoread            " auto read file changes from outside
set encoding=utf8       " standard encoding

set nobackup
set nowritebackup
set noswapfile

set hlsearch            " highlight searched phrases.
set incsearch           " highlight as you type your search.
set ignorecase          " make searches case-insensitive.
set smartcase           " but be smart about case
" Visual mode pressing * or # searches for the current selection
vnoremap <silent> * :call VisualSelection('f', '')<CR>                                    
vnoremap <silent> # :call VisualSelection('b', '')<CR>

syntax enable           " enable syntax highlighting
set background=dark
colorscheme solarized   " set colorscheme

set autoindent          " auto-indent
set smartindent         " be smart about indent

set expandtab           " use spaces instead of tabs
set tabstop=4           " tab spacing
set softtabstop=4       " unify
set shiftwidth=4        " indent/outdent by 4 columns

autocmd FileType c setlocal noet sw=4 ts=4 sts=4 cindent cinoptions=(0
autocmd FileType python setlocal et sw=4 sts=4


"--------------------------------------
"               Function
"--------------------------------------
" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \ exe "normal! g`\"" |
     \ endif

" Remember info about open buffers on close
set viminfo^=%

" view changes to the buffer
function! s:DiffWithSaved()
  let filetype=&ft
  diffthis
  vnew | r # | normal! 1Gdd
  diffthis
  exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction
com! DiffSaved call s:DiffWithSaved()
