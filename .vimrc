" ----------------
" .vimrc
" Adam Tuechler
" ----------------

if has('nvim')
    let s:editor_root=expand("~/.nvim")
"    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
    nmap <BS> <C-W>h
else
    let s:editor_root=expand("~/.vim")
    set nocompatible
endif

filetype off
let &rtp = &rtp . ',' .  s:editor_root . '/bundle/Vundle.vim'

call vundle#rc(s:editor_root . '/bundle/')
call vundle#begin()

" Utilities
Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'bronson/vim-trailing-whitespace'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'danro/rename.vim'
" Language Highlighting
Plugin 'digitaltoad/vim-pug'
" Airline (Status Bar)
Plugin 'bling/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
" Git things
Plugin 'airblade/vim-gitgutter'
Plugin 'tpope/vim-fugitive'
" A bunch of themes
Plugin 'baskerville/bubblegum'
Plugin 'morhetz/gruvbox'
Plugin 'romainl/apprentice'

call vundle#end()
filetype plugin indent on

" Syntax Highlighting
syntax on

" Colour Scheme
"   Uses apprentice as the base, but with a few mods.
"   Mainly removing the background color and replaceing it
"   with the default terminal background.
"    -- (The .Xresources config on desktop)
set background=dark
colorscheme apprentice

" Remove backgrounds
hi Normal ctermbg=NONE
hi LineNr ctermbg=NONE
hi FoldColumn ctermbg=NONE ctermfg=242

" Tab Settings
" :: DEFAULTS
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
autocmd Filetype javascript setlocal ts=4 sw=4 sts=0 noexpandtab    " js
autocmd Filetype html setlocal ts=2 sw=2 expandtab                  " html

" More Options
set nu              " Show line numbers
set hidden          " Don't close hidden buffers
set ignorecase      " Ignore the case when / searching
set smartcase       " Ignore nocase if the search term has capitals in it
set incsearch       " Highlight items in the search as you type
set autoindent      " Auto indent braces
set ruler           " Show the Line + Position of the cursor
set showcmd         " Retains the last command in the bottom of screen
set mouse=a         " Allow mouse use in all edit types
set history=1000    " Heaps of history
set undolevels=1000 " Heaps of undo-ability
set nofoldenable    " Don't fold functions (it looks ugly!)
set nowrap          " Don't wrap text horizontall (Map to new line)
set textwidth=0     " More wrap disabling
set wrapmargin=0    " More wrap disabling
set colorcolumn=80  " Make it obvious where 80 chars is
set scrolloff=4   " 4 Lines of space above/below cursor
set t_Co=256

" Cool-as Button Mapping Configs
" Window-Tab Navigation
map <F7> :tabp<CR>
map <F8> :tabn<CR>

" NERDTree Stuff
nnoremap <F2> :NERDTreeToggle<CR>

" No bitchboi arrow keys
nnoremap <Left> :echoe "HEY YOU, USE H INSTEAD"<CR>
nnoremap <Right> :echoe "HEY YOU, USE L INSTEAD"<CR>
nnoremap <Up> :echoe "HEY YOU, USE K INSTEAD"<CR>
nnoremap <Down> :echoe "HEY YOU, USE J INSTEAD"<CR>

" Various Window Splitting Magic
nnoremap <C-J> <C-W><C-J>
nnoremap <C-H> <C-W><C-H>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
set splitbelow      " Split Down
set splitright      " Split Right

" Fun as Heck Leader Configs
let mapleader = " "
" Buffer-nav
nnoremap <Leader>j :bprev<CR>
nnoremap <Leader>k :bnext<CR>
" Make saving easier
nnoremap <Leader>w :w<CR>

" Vim-Airline Config
set laststatus=2                            " Enable vim-airline
autocmd VimEnter * AirlineTheme term        " Term theme
" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline_powerline_fonts = 0
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline#extensions#branch#enabled = 1

" CtrlP Config
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn|node_modules)$',
  \ 'file': '\v\.(exe|so|dll)$'
  \ }
hi clear Normal
