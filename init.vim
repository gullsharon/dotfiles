" basic configuration ------------------------------------------------- {{{
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
set wildmode=longest,list	" get bash-like tab completions
set cc=80			" set an 80 column border for good coding style
filetype plugin indent on	" allow auto-indenting depending on file type
syntax on			" syntax highlighting
set mouse=a			" enable mouse click
set clipboard+=unnamedplus	" using system clipboard
filetype on
filetype plugin on
" set cursorline		" highlight current cursorline
set ttyfast			" Speed up scrolling in Vim
set scrolloff=10		" keeps a few lines visible after and before current line
set showcmd			" shows the partial command you are typing while typing it
set history=1000		" keeps undo history
set updatetime=200		" faster updating
set guicursor=			" fixes bug where commands insert random `q` character
set list			" show whitespace
set lcs+=space:·		" choose space character
set lcs+=trail:·		" choose trailing space character
"set lcs+=tab:——⇥		" choose tab character
"set lcs+=eol:¬			" choose eol character

" open new split panes to right and below
set splitright
set splitbelow

" custom colorcolumn for git commits
autocmd FileType gitcommit set colorcolumn=50,72

" change Home button behavior to first jump to first non-whitespace character,
" and only when pressed again, go to the start of the line
nnoremap <expr> <Home> col('.') == match(getline('.'), '\S') + 1 ? '0' : '^'
inoremap <expr> <Home> col('.') == match(getline('.'), '\S') + 1 ? "\<C-O>0" : "\<C-O>^"
" }}}


" Plugin Section ------------------------------------------------------ {{{
call plug#begin("~/.vim/plugged")
" Use :PlugInstall to install plugins after changing list
Plug 'EdenEast/nightfox.nvim'					" colorscheme
Plug 'nvim-lualine/lualine.nvim'				" statusline
Plug 'kyazdani42/nvim-web-devicons'				" icons in statusline
Plug 'neoclide/coc.nvim', {'branch': 'release'}			" plugin that interfaces with language server
Plug 'airblade/vim-gitgutter'					" shows git changes in the gutter
Plug 'kshenoy/vim-signature'					" shows marks in the gutter
Plug 'tpope/vim-fugitive'					" allows git commands in vim
Plug 'preservim/nerdcommenter'					" allows commenting and uncommenting blocks
Plug 'lukas-reineke/indent-blankline.nvim'			" adds indentation guides to all lines
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}	" parser (which allows syntax highlighting)
Plug 'farmergreg/vim-lastplace'					" saves cursor position, folding, and other related things on nvim close
call plug#end()
" }}}


" coc.nvim plugin ------------------------------------------------------- {{{
" Always show the signcolumn, otherwise it would shift the text each time diagnostics appear/become resolved
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate
inoremap <silent><expr> <TAB>
	\ coc#pum#visible() ? coc#pum#next(1) :
	\ CheckBackspace() ? "\<Tab>" :
	\ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
	\: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion
if has('nvim')
	inoremap <silent><expr> <c-space> coc#refresh()
else
	inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
	if CocAction('hasProvider', 'hover')
	call CocActionAsync('doHover')
	else
	call feedkeys('K', 'in')
	endif
endfunction

" Highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')
" }}}


" nvim-treesitter plugin ------------------------------------------------ {{{
" next section is written in lua instead of vimscript
lua <<EOF
require'nvim-treesitter.configs'.setup {
	-- A list of parser names, or "all" (the four listed parsers should always be installed)
	ensure_installed = { "c", "lua", "vim", "help", "bash", "cmake", "cpp",
			     "dockerfile", "gitcommit", "git_rebase",
			     "gitattributes", "make", "markdown",
			     "markdown_inline", "python", "regex", },

	-- Install parsers synchronously (only applied to `ensure_installed`)
	sync_install = false,

	-- Automatically install missing parsers when entering buffer
	-- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
	auto_install = false,

	highlight = {
		-- `false` will disable the whole extension
		enable = true,

		-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
		-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
		-- Using this option may slow down your editor, and you may see some duplicate highlights.
		-- Instead of true it can also be a list of languages
		additional_vim_regex_highlighting = false,
	},
}
EOF

" code folding
set foldmethod=syntax
set foldexpr=nvim_treesitter#foldexpr()
set nofoldenable				" Disable folding at startup.
" }}}


" nerdcommenter  plugin -------------------------------------------------- {{{
" basic usage: <leader>c<space> toggles comment/no-comment

" Create default mappings
let g:NERDCreateDefaultMappings = 1

" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

" Set a language to use its alternate delimiters by default
let g:NERDAltDelims_java = 1

" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1
" }}}


" color schemes --------------------------------------------------------- {{{
if (has("termguicolors"))
	set termguicolors
endif
syntax enable
colorscheme nordfox
" }}}


" STATUS LINE ------------------------------------------------------------ {{{
lua << END
require('lualine').setup {
	options = {
		icons_enabled = false,
		theme = 'codedark',
		refresh = {
			statusline = 200,
		}
	}
}
END
" }}}

