silent !mkdir -p ~/.vim/backup ~/.vim/swap ~/.vim/undo

set autoindent
set autoread
set backspace=indent,eol,start
set backupdir=.,~/.vim/backup
set complete-=i
set directory=~/.vim/swap//
set display=lastline
set formatoptions=tcqj
set history=10000
set hlsearch
set incsearch
set langnoremap
set laststatus=2
set listchars=tab:>\ ,trail:-,nbsp:+
set mouse=a
set nocompatible
set nrformats=bin,hex
set sessionoptions-=options
set smarttab
set tabpagemax=50
set tags=./tags;,tags
set ttyfast
set undodir=~/.vim/undo
set viminfo+=!
set wildmenu

set hidden
set visualbell
set timeoutlen=60
set cmdheight=2
set statusline=
set statusline+=<%n>        " buffer number
set statusline+=\ %<%f      " filepath
set statusline+=\ %h%w%m%r  " [HELP][Preview][+][RO]
set statusline+=%=          " right align
set statusline+=%c,         " cursor column
set statusline+=%l/%L       " cursor line
set statusline+=\ %P        " percent position

set tabstop=8
set softtabstop=4
set shiftwidth=4
set expandtab
set smartindent

set wildmode=full
set wildignore=

set number
set cursorline
set list
set colorcolumn=80,100

set ignorecase
set smartcase
