" ----------------
" .vimrc
" Adam Tuechler
" ----------------

if has('nvim')
    let s:editor_root=expand("~/.nvim")
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
    nmap <BS> <C-W>h
else
    let s:editor_root=expand("~/.vim")
    set nocompatible
endif

filetype off
let &rtp = &rtp . ',' .  s:editor_root . '/bundle/Vundle.vim'

call vundle#rc(s:editor_root . '/bundle/')
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'bronson/vim-trailing-whitespace'
" Airline (Status Bar)
Plugin 'bling/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'digitaltoad/vim-pug'
" Git things
Plugin 'airblade/vim-gitgutter'
Plugin 'tpope/vim-fugitive'
" A bunch of themes
Plugin 'baskerville/bubblegum'
Plugin 'morhetz/gruvbox'

call vundle#end()
filetype plugin indent on

" Syntax Highlighting
:syntax on

" Colour Scheme
:set background=dark
:colorscheme bubblegum-256-dark
:let g:gruvbox_contrast = 'hard'

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

" Vim-Airline Config
set laststatus=2                            " Enable vim-airline
autocmd VimEnter * AirlineTheme bubblegum   " Bubblegum theme
" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline_powerline_fonts = 0
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline#extensions#branch#enabled = 1
