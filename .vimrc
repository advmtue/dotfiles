" Editor root is the same regardless of the vim version/fork
let s:editor_root=expand("~/.config/vim")

" Vundle
filetype off
set rtp+=~/.config/vim/bundle/Vundle.vim

call vundle#begin()
Plugin 'VundleVim/Vundle.vim'            " Package Management
Plugin 'bronson/vim-trailing-whitespace' " Trailing whitespace helper
Plugin 'tmhedberg/SimpylFold'            " Function Folding
Plugin 'godlygeek/tabular'               " Since Smart Tabs hates

Plugin 'moll/vim-node'                   " Node highlighting
Plugin 'leafgarland/typescript-vim'
Plugin 'mxw/vim-jsx'                     " JSX Syntax
Plugin 'shmup/vim-sql-syntax'            " SQL Syntax
Plugin 'lervag/vimtex'                   " TeX support
call vundle#end()

syntax on
filetype plugin indent on

" Colour Scheme
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
autocmd Filetype typescript setlocal ts=4 sw=4 sts=4 expandtab
autocmd Filetype json setlocal ts=4 sw=4 sts=4 expandtab

" Markdown for .md files
autocmd BufNewFile,BufReadPost *.md set filetype=markdown

" - Basic Settings
set noswapfile                 " Meh #MadLAdZ
set number                         " Show line numbers
set hidden                     " Don't close hidden buffers
set ignorecase                 " Ignore the case when / searching
set incsearch                  " Highlight items in the search as you type
set hlsearch " highlight matches of a search
set ruler                      " Show the Line + Position of the cursor
set showcmd                    " Retains the last command in the bottom of screen
set nowrap                     " Don't wrap text horizontall (Map to new line)
set scrolloff=4                " 4 Lines of space above/below cursor
set foldmethod=indent          " Fold based on indentation
set foldlevel=99 " Don't start folded
set autoindent                 " Autoindent
set backspace=indent,eol,start " Make backspace work
set linebreak                  " Wrap by word
set laststatus=2
set statusline+=[%F]%r

" Function folding with spacebar
nnoremap <space> za

" NetRW Config
nnoremap <F2> :Vex<CR>
let g:netrw_banner = 0       " Remove Banner
let g:netrw_winsize = 18     " Width
let g:netrw_browse_split = 2 " Open in previous window
let g:netrw_liststyle = 3    " Open in tree mode

" F9 To Run Scripts
autocmd FileType python nnoremap <buffer> <F9> :exec '!python' shellescape(@%, 1)<cr>
autocmd FileType javascript nnoremap <buffer> <F9> :exec '!node' shellescape(@%, 1)<cr>

" Various Window Splitting Magic
nnoremap <C-J> <C-W><C-J>
nnoremap <C-H> <C-W><C-H>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
set splitbelow " Split Down
set splitright " Split Right

" Leader maps
let mapleader = ","             " Use comma as the leader
noremap <Leader>j :bprev<cr>    " Leader-j previous buffer
noremap <Leader>k :bnext<cr>    " Leader-k next buffer
noremap <Leader>q :bw<cr>       " Leader-q close buffer
noremap <Leader>w :w<cr>        " Leader-w saves buffer
nnoremap <leader>h :nohl<cr>    " Clear highlights
