" Vundle
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()
Plugin 'VundleVim/Vundle.vim'            " Self-management
Plugin 'bronson/vim-trailing-whitespace' " Highlight trailing whitespace
Plugin 'godlygeek/tabular'               " Tabularize
Plugin 'lervag/vimtex'                   " TeX support
Plugin 'owickstrom/vim-colors-paramount' " Paramount colorscheme
Plugin 'kien/ctrlp.vim'                  " Fuzzy finding
Plugin 'prettier/vim-prettier'           " TypeScript/JavaScript linting
Plugin 'dense-analysis/ale'              " Code Quality
call vundle#end()

filetype plugin indent on
syntax on

" Colour Scheme = paramount
set background=dark
colorscheme paramount
" Set background colour to terminal default
hi Normal ctermbg=NONE
hi Constant ctermfg=darkred

" Width of an indent (eg. using >>)
autocmd Filetype html setlocal ts=2 sw=2
autocmd Filetype markdown setlocal ts=2 sw=2 wrap
autocmd Filetype yaml,sh setlocal ts=4 sw=4 sts=4 expandtab
autocmd Filetype tex setlocal wrap

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

" Window split navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-H> <C-W><C-H>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>

" Leader utilities
let mapleader = ","          " Use comma as the leader
noremap <Leader>j :bprev<cr> " Leader-j previous buffer
noremap <Leader>k :bnext<cr> " Leader-k next buffer
noremap <leader>h :nohl<cr>  " Clear highlights

" Typesetting (latex@vimtex)
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode=0
let g:tex_conceal='abdmg'

" Ctrl P ignore
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git'

" Netrw config
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_winsize = 24
