" -- This thing
"   Honestly have no idea what it is
if has('nvim')
    let s:editor_root=expand("~/.nvim")
    nmap <BS> <C-W>h
else
    let s:editor_root=expand("~/.vim")
    set nocompatible
endif

" -- Vundle
filetype off
let &rtp = &rtp . ',' .  s:editor_root . '/bundle/Vundle.vim'
call vundle#rc(s:editor_root . '/bundle/')
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'             " Package Management
Plugin 'scrooloose/nerdtree'              " NERDTree filesystem explorer
Plugin 'scrooloose/nerdcommenter'         " Commenting
Plugin 'tpope/vim-surround'               " Surround
Plugin 'bronson/vim-trailing-whitespace'  " Trailing whitespace helper
Plugin 'ctrlpvim/ctrlp.vim'               " Ctrl-P
Plugin 'danro/rename.vim'                 " Rename active file

Plugin 'digitaltoad/vim-pug'              " Pug (Jade) highlighting
Plugin 'moll/vim-node'                    " Node highlighting

Plugin 'bling/vim-airline'                " Airline (Status bar)
Plugin 'vim-airline/vim-airline-themes'   " Airline themes pack

Plugin 'airblade/vim-gitgutter'           " Git gutter
Plugin 'tpope/vim-fugitive'               " Fugitive

Plugin 'baskerville/bubblegum'
Plugin 'morhetz/gruvbox'
Plugin 'romainl/apprentice'

call vundle#end()
filetype plugin indent on

" Syntax Highlighting
syntax on

" -- Colour Scheme
"   Uses apprentice as the base, but with a few mods.
"   Mainly removing the background color and replacing it
"   with the default terminal background.
set background=dark
colorscheme apprentice
hi Normal ctermbg=NONE                    " Remove Backgrounds
hi LineNr ctermbg=NONE
hi FoldColumn ctermbg=NONE ctermfg=242

" -- General Settings
" Tabs = 2 spaces
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
autocmd Filetype javascript setlocal ts=4 sw=4 sts=4 " Jscript gets 4w tab

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
"set colorcolumn=80  " Make it obvious where 80 chars is
set scrolloff=4     " 4 Lines of space above/below cursor
set lazyredraw      " Don't redraw during automated tasks
set t_Co=256        " 256 Colors

" -- Maps and Remaps
nnoremap <F2> :NERDTreeToggle<CR>       " NERDTree

" No bitchboi arrow keys
nnoremap <Left> :echoe "HEY YOU, USE H INSTEAD"<CR>
nnoremap <Right> :echoe "HEY YOU, USE L INSTEAD"<CR>
nnoremap <Up> :echoe "HEY YOU, USE K INSTEAD"<CR>
nnoremap <Down> :echoe "HEY YOU, USE J INSTEAD"<CR>

" Various Window Splitting Magic
nnoremap \ <C-W>v
nnoremap - <C-W>n
nnoremap <C-J> <C-W><C-J>
nnoremap <C-H> <C-W><C-H>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
set splitbelow      " Split Down
set splitright      " Split Right

" Leader maps
let mapleader = " "             " Use space as the leader
nnoremap <Leader>j :bprev<CR>   " Leader-j previous buffer
nnoremap <Leader>k :bnext<CR>   " Leader-k next buffer
nnoremap <Leader>w :w<CR>       " Leader-w save
nnoremap <Leader>q :bw<CR>      " Leader-q close buffer

" -- Airline
set laststatus=2                            " Enable vim-airline
autocmd VimEnter * AirlineTheme term        " Term theme
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline_powerline_fonts = 1
" let g:airline_left_sep = ''
" let g:airline_right_sep = ''
"let g:airline#extensions#branch#enabled = 1

" -- Ctrl-P
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.git|\.hg|\.svn|node_modules)$',
  \ 'file': '\v\.(exe|so|dll)$'
  \ }
