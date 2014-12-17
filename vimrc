set nocompatible

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
if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
endif
filetype plugin indent on


"--------------------------------------
"               General
"--------------------------------------
set hidden              " allow hidden buffer
set autoread            " auto read file changes from outside
set encoding=utf8       " standard encoding

set nobackup
set nowritebackup
set noswapfile

set incsearch           " search as you type your search.
set ignorecase          " make searches case-insensitive.
set smartcase           " but be smart about case

set backspace=2         " backspace deletes like most programs in insert mode
set laststatus=2        " Always display the status line

" Visual mode pressing * or # searches for the current selection
vnoremap <silent> * :call VisualSelection('f', '')<CR>
vnoremap <silent> # :call VisualSelection('b', '')<CR>

"--------------------------------------
"               Editor
"--------------------------------------
syntax enable           " enable syntax highlighting

colorscheme github      " color scheme
highlight NonText guibg=#060606
highlight Folded  guibg=#0A0A0A guifg=#9090D0

set textwidth=80        " make it obvious where 80 characters is
set colorcolumn=+1      " highlight column after 'textwidth'

" Display extra whitespace
set list listchars=tab:»·,trail:·,nbsp:·

set autoindent          " auto-indent
set smartindent         " be smart about indent

set expandtab           " use spaces instead of tabs
set tabstop=4           " tab spacing
set softtabstop=4       " unify
set shiftwidth=4        " indent/outdent by 4 columns

" Enable spellchecking for Markdown
autocmd FileType markdown setlocal spell

autocmd FileType c setlocal noet sw=4 ts=4 sts=4 cindent cinoptions=(0
autocmd FileType python,java setlocal et sw=4 sts=4


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


"--------------------------------------
"       Source user local config
"--------------------------------------
if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif
