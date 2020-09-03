" Vundle
set nocompatible
filetype off

call plug#begin('~/.vim/plugged')
Plug 'bronson/vim-trailing-whitespace'
Plug 'godlygeek/tabular'
Plug 'lervag/vimtex'
Plug 'kien/ctrlp.vim'
Plug 'junegunn/vim-plug'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'tpope/vim-fugitive'
Plug 'morhetz/gruvbox'
Plug 'preservim/nerdtree'
Plug 'digitaltoad/vim-pug'
call plug#end()

filetype plugin indent on
syntax on

" Colour Scheme = gruvbox
set background=dark
colorscheme gruvbox
hi Normal ctermbg=NONE
hi todo ctermbg=NONE
hi GruvboxRedSign ctermbg=NONE
hi SignColumn ctermbg=NONE

" Width of an indent (eg. using >>)
autocmd Filetype html setlocal ts=2 sw=2
autocmd Filetype markdown setlocal ts=2 sw=2 wrap
autocmd Filetype yaml,sh setlocal ts=4 sw=4 sts=4 expandtab
autocmd Filetype javascript,typescript setlocal ts=4 sw=4 sts=4 noexpandtab formatoptions+=ro
autocmd Filetype tex setlocal wrap textwidth=80
autocmd Filetype pug setlocal ts=2 sts=-1 sw=2

" Markdown for .md files
autocmd BufNewFile,BufReadPost *.md set filetype=markdown

" Basic Settings
set noswapfile                 " Don't create a swap file
set number                     " Show line numbers
set relativenumber             " Set number as relative to cursor
set hidden                     " Don't close hidden buffers
set ignorecase                 " Ignore the case when / searching
set incsearch                  " Highlight items in the search as you type
set hlsearch                   " highlight matches of a search
set nowrap                     " Don't wrap text horizontally (Map to new line)
set foldmethod=indent          " Fold based on indentation
set foldlevel=99               " Don't start folded
set autoindent                 " Autoindent
set backspace=indent,eol,start " Make backspace work
set linebreak                  " Wrap by word
set laststatus=2               " Enable status bar
set statusline=[%F]%r%=%l:%c%V " Status bar = [{filename}]{permissions}
set conceallevel=2             " Conceal text formatting such as markdown
set splitbelow                 " Split Down
set splitright                 " Split Right
set noea                       " Don't automatically resize windows
set updatetime=50
set cmdheight=2
set signcolumn=number
set colorcolumn=80             " Column #80 highlighed

" Leader utilities
let mapleader = " "          " Use comma as the leader
noremap <leader>H :nohl<cr>  " Clear highlights

" Coc
nmap <leader>gd <Plug>(coc-definition)
nmap <leader>gr <Plug>(coc-references)
nmap <leader>gi <Plug>(coc-implementation)
nmap <leader>rr <Plug>(coc-rename)
nmap <leader>dh <Plug>(coc-diagnostic-prev)
nmap <leader>dl <Plug>(coc-diagnostic-next)

autocmd FileType java nmap <leader>gI :CocCommand java.action.organizeImports<CR>

" Window navigation
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>

" File Tree
nnoremap <leader>t :NERDTreeToggle<CR>
nnoremap <leader>T :NERDTreeFocus<CR>

" Typesetting (latex@vimtex)
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode=0
let g:tex_conceal='abdmg'

" Ctrl P ignore
let g:ctrlp_custom_ignore = {
  \ 'dir':  'node_modules\|DS_Store\|git',
  \ 'file': '\v\.(exe|so|dll|class)$',
  \ }

" Netrw config
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_winsize = 25
let g:netrw_browse_split = 4

" Python run file
autocmd FileType python map <buffer> <F5> :w<CR>:exec '! clear; python3' shellescape(@%, 1)<CR>
