" Basic configuration ------------------------------------------------- {{{
" Imports settings shared with vim
source ~/dotfiles/common.vim

set list			" show whitespace
set lcs+=space:·		" choose space character
set lcs+=trail:·		" choose trailing space character
"set lcs+=tab:——⇥		" choose tab character
"set lcs+=eol:¬			" choose eol character
" }}}


" Plugin Section ------------------------------------------------------ {{{
call plug#begin("~/.vim/plugged")
" Use :PlugInstall to install plugins after changing list
Plug 'crispgm/nvim-tabline'					" adds tabline
Plug 'EdenEast/nightfox.nvim'					" colorscheme
Plug 'nvim-lualine/lualine.nvim'				" statusline
Plug 'kyazdani42/nvim-web-devicons'				" icons in statusline
Plug 'neoclide/coc.nvim', {'branch': 'release'}			" plugin that interfaces with language server
Plug 'dense-analysis/ale'					" warns of bad code style
Plug 'airblade/vim-gitgutter'					" shows git changes in the gutter
Plug 'kshenoy/vim-signature'					" shows marks in the gutter
Plug 'tpope/vim-fugitive'					" allows git commands in vim
Plug 'preservim/nerdcommenter'					" allows commenting and uncommenting blocks
Plug 'lukas-reineke/indent-blankline.nvim'			" adds indentation guides to all lines
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}	" parser (which allows syntax highlighting)
Plug 'farmergreg/vim-lastplace',				" saves cursor position, folding, and other related things on nvim close
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }		" fuzzy search
call plug#end()
" }}}


" coc.nvim plugin ------------------------------------------------------- {{{
" Go to coc specific settings by using :CocConfig

" Always show the signcolumn, otherwise it would shift the text each time diagnostics appear/become resolved
set signcolumn=yes

" Configure coc.nvim
let g:coc_global_extensions = ['coc-clangd']

" Enable diagnostic messages
augroup coc_lsp
	autocmd!
	autocmd User CocJumpPlaceholderInitialized silent! call CocActionAsync('runCommand', 'editor.action.showReferences')
augroup END

" Set up coc-clangd settings
let g:coc_settings = json_decode(get(g:, 'coc_settings', '{}'))

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

" Rename a variable/field in struct
nmap <leader>r <Plug>(coc-rename)
" }}}


" ale plugin ------------------------------------------------------------ {{{
let g:ale_linters = {
	\ 'c': ['clang', 'gcc'],
\ }
" }}}


" tabline plugin -------------------------------------------------------- {{{
lua <<EOF
require('tabline').setup({
	show_index = true,		-- show tab index
	show_modify = true,		-- show buffer modification indicator
	show_icon = false,		-- show file extension icon
	modify_indicator = '+',		-- modify indicator
	no_name = 'No name',		-- no name buffer name
	brackets = { '', '' },		-- file name brackets surrounding
})
EOF
" leader+t to open new tab.
" gt/gT to navigate tabs.
" leader +x to close current tab.
nnoremap <leader>t :tab split<CR>
nnoremap <leader>x :tabclose<CR>
" }}}


" nvim-treesitter plugin ------------------------------------------------ {{{
" next section is written in lua instead of vimscript
lua <<EOF
require'nvim-treesitter.configs'.setup {
	-- A list of parser names, or "all" (the four listed parsers should always be installed)
	ensure_installed = { "c", "lua", "vim", "help", "bash", "cmake", "cpp",
			     "comment", "dockerfile", "gitcommit", "git_rebase",
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


" fzf plugin ------------------------------------------------------------- {{{
" make control+T in normal mode activate fuzzy file search
nnoremap <silent> <C-t> :FZF<CR>
" }}}


" color schemes ---------------------------------------------------------- {{{
if (has("termguicolors"))
	set termguicolors
endif
syntax enable
colorscheme nordfox
" }}}


" STATUS LINE ------------------------------------------------------------ {{{
lua << END
-- Custom component to display total number of lines
local function line_count()
	return vim.fn.line('$') .. ' lines'
end

require('lualine').setup {
	options = {
		icons_enabled = false,
		theme = 'codedark',
		refresh = {
			statusline = 200,
		}
	},
	sections = {
		lualine_a = {'mode'},
		lualine_b = {'branch', 'diff', 'diagnostics'},
		lualine_c = {'filename'},
		lualine_x = {'encoding', 'fileformat', 'filetype'},
		lualine_y = {'progress', line_count},
		lualine_z = {'location'}
	}
}
END
" }}}

