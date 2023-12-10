" This file is for configurations that are shared between vim and neovim.

" Basic configuration ------------------------------------------------- {{{
set nocompatible		" disable compatibility to old-time vi
set showmatch			" show matching
set ignorecase			" case insensitive search
set smartcase			" case sensitive search if includes capital
set mouse=v			" middle-click paste with
set hlsearch			" highlight search
set incsearch			" incremental search
set tabstop=8			" number of columns occupied by a tab
set softtabstop=8		" see multiple spaces as tabstops so <BS> does the right thing
" set expandtab			" converts tabs to white space
set shiftwidth=8		" width for autoindents
set autoindent			" indent a new line the same amount as the line just typed
set number			" add line numbers
set wildmenu			" show completion suggestions
set wildmode=longest,list	" get bash-like tab completions
set cc=80			" set an 80 column border for good coding style
filetype plugin indent on	" allow auto-indenting depending on file type
syntax on			" syntax highlighting
set clipboard+=unnamedplus	" using system clipboard
set clipboard+=unnamed		" for middle-mouse pasting
filetype on
filetype plugin on
" set cursorline		" highlight current cursorline
set ttyfast			" Speed up scrolling in Vim
set scrolloff=10		" keeps a few lines visible after and before current line
set showcmd			" shows the partial command you are typing while typing it
set history=1000		" keeps undo history
set updatetime=300		" faster updating
set guicursor=			" fixes bug where commands insert random `q` character
set cino=(0,0,0,0),(0,0,0),(0,0,0),(0)	" sets indendation of function definitions and calls
" open new split panes to right and below
set splitright
set splitbelow

" use spaces instead of tabs, only in python files
autocmd FileType python setlocal expandtab

" custom colorcolumn for git commits
autocmd FileType gitcommit set colorcolumn=50,72

" change Home button behavior to first jump to first non-whitespace character,
" and only when pressed again, go to the start of the line
nnoremap <expr> <Home> col('.') == match(getline('.'), '\S') + 1 ? '0' : '^'
inoremap <expr> <Home> col('.') == match(getline('.'), '\S') + 1 ? "\<C-O>0" : "\<C-O>^"

" Show Trailing Whitespaces
highlight ExtraWhitespace ctermbg=Brown guibg=Cyan
match ExtraWhitespace /\s\+$/

" use shift + up/down to move current line
nnoremap <S-Up> :m-2<CR>
nnoremap <S-Down> :m+<CR>
inoremap <S-Up> <Esc>:m-2<CR>gi
inoremap <S-Down> <Esc>:m+<CR>gi
" }}}

" Load local vim configurations
source ~/.vimrc_local

