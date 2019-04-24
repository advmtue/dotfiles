" Vundle
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()
Plugin 'VundleVim/Vundle.vim'            " Self-management
Plugin 'bronson/vim-trailing-whitespace' " Highlight trailing whitespace
Plugin 'godlygeek/tabular'               " Tabularize
Plugin 'pangloss/vim-javascript'         " Javascript highlighting
Plugin 'lervag/vimtex'                   " TeX support
call vundle#end()

syntax on
filetype plugin indent on

" Colour Scheme
set background=dark
colorscheme delek
hi Comment ctermfg=darkgray
hi LineNr ctermbg=NONE ctermfg=darkgray
hi Folded ctermbg=NONE
hi MatchParen ctermbg=darkblue ctermfg=darkgray cterm=bold
hi StatusLine cterm=bold ctermfg=0 ctermbg=white
hi StatusLineNC ctermbg=NONE

" Width of an indent (eg. using >>)
autocmd Filetype html setlocal ts=2 sw=2
autocmd Filetype markdown setlocal ts=2 sw=2 wrap
autocmd Filetype yaml setlocal ts=4 sw=4 sts=4 expandtab

" Markdown for .md files
autocmd BufNewFile,BufReadPost *.md set filetype=markdown

" - Basic Settings
set noswapfile                 " Don't create a swap file
set number                     " Show line numbers
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
set statusline+=[%F]%r         " Status bar = [{filename}]{permissions}
set conceallevel=2             " Conceal text formatting such as markdown
set splitbelow                 " Split Down
set splitright                 " Split Right

" NetRW Config (:Vex)
let g:netrw_banner = 0       " Remove Banner
let g:netrw_winsize = 18     " Width
let g:netrw_browse_split = 2 " Open in previous window
let g:netrw_liststyle = 3    " Open in tree mode

" Window split navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-H> <C-W><C-H>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>

" Leader utilities
let mapleader = ","             " Use comma as the leader
noremap <Leader>j :bprev<cr>    " Leader-j previous buffer
noremap <Leader>k :bnext<cr>    " Leader-k next buffer
noremap <Leader>l :ls<cr>	" Leader-l shows buffer listing
nnoremap <leader>h :nohl<cr>    " Clear highlights

" Typesetting (latex@vimtex)
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode=0
let g:tex_conceal='abdmg'
