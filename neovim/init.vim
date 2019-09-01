call plug#begin('~/.config/nvim/plugged')

" Startup for VIM
Plug 'mhinz/vim-startify'

" NerdTree and GIT status of files/folders in NerdTree
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'

" Linting
Plug 'w0rp/ale'

" Formatting
Plug 'sbdchd/neoformat'

" TypeScript
Plug 'HerringtonDarkholme/yats.vim'
Plug 'mhartington/nvim-typescript', {'for': ['typescript', 'tsx'], 'do': './install.sh' }

" GO Lang
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

" GraphQL
Plug 'jparise/vim-graphql'

" Styling
Plug 'dikiaap/minimalist'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Autocomplete
Plug 'Shougo/deoplete.nvim'
Plug 'zchee/deoplete-go', { 'do': 'make'}
Plug 'Shougo/denite.nvim'

call plug#end()

" -------------------------------------------------------------------------------
" ------------------------------ General Setup ---------------------------
" -------------------------------------------------------------------------------

" Fat fingers
:command WQ wq
:command Wq wq
:command W w
:command Q q
" -------------------------------------------------------------------------------
" ------------------------------ Start NerdTree Setup ---------------------------
" -------------------------------------------------------------------------------

let g:NERDTreeMouseMode=3
let NERDTreeShowHidden=1

" Startup.. 
autocmd VimEnter * NERDTree | wincmd p | call SyncTree() " -- File
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | wincmd p | endif " -- No File
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | call SyncTree() | ene | endif " -- Directory

map nt :NERDTreeToggle<CR>

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

" Highlight currently open buffer in NERDTree, used when switching file
autocmd BufEnter * call SyncTree()
" Close NERDTree when no file is open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" ----------------------------------------------------------------------------
" ------------------------------- End NERDTree Setup -------------------------
" ----------------------------------------------------------------------------
set mouse=a
set number
set noswapfile
set ttyfast
set clipboard=unnamed

" Enable file type detection and do language-dependent indenting.
filetype plugin indent off
filetype plugin indent on

" Ignore case of searches
set ignorecase
" Highlight dynamically as pattern is typed
set incsearch

" Colours and syntax
syntax on
colorscheme minimalist
set number

"GO Setup - https://hackernoon.com/my-neovim-setup-for-go-7f7b6e805876
set noexpandtab
set shiftwidth=2
set softtabstop=2
filetype plugin indent on

let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1
let g:go_highlight_interfaces = 1

let g:go_auto_sameids = 1
let g:go_fmt_command = "goimports"

let g:neoformat_enabled_javascript = ['prettier']
let g:neoformat_enabled_css = ['prettier']
let g:neoformat_enabled_html = ['prettier']
let g:neoformat_enabled_yaml = ['prettier']
let g:neoformat_run_all_formatters = 1
let g:neoformat_only_msg_on_error = 1
autocmd BufWritePre *.js Neoformat
autocmd BufWritePre *.html Neoformat
autocmd BufWritePre *.css Neoformat
autocmd BufWritePre *.yml Neoformat

" Error and warning signs.
let g:ale_sign_error = '⤫'
let g:ale_sign_warning = '⚠'

let g:deoplete#enable_at_startup = 1

if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
let g:deoplete#enable_at_startup = 1
