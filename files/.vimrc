" Use Vim defaults (much better!)
set nocompatible
" allow backspacing over everything in insert mode
set bs=indent,eol,start		

" autoindent on
set ai
set tabstop=4
set shiftwidth=4

set history=250

set backupdir=/var/tmp

set ruler
set number

set ignorecase
set smartcase

set expandtab 
set bg=dark
syntax on
set hlsearch
filetype indent plugin on
filetype plugin on
set modeline
set pastetoggle=<F2>
set showmode

set rtp+=/usr/lib/python2.7/site-packages/powerline/bindings/vim/

" get rid of annoying <esc> timeout
set ttimeoutlen=100
"set noesckeys

" Always show statusline
set laststatus=2

" Use 256 colours (Use this setting only if your terminal supports 256 colours)
set t_Co=256

if has("autocmd")
  augroup fedora
  autocmd!
  autocmd BufNewFile *.spec 0r /usr/share/vim/vimfiles/template.spec
  augroup END
endif

