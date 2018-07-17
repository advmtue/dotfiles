" Set editor root depending on the version of vim
if has('nvim')
    let s:editor_root=expand("~/.config/nvim")
    nmap <BS> <C-W>h
else
    let s:editor_root=expand("~/.config/vim")
    set nocompatible
endif

" - V U N D L E
filetype off
let &rtp = &rtp . ',' .  s:editor_root . '/bundle/Vundle.vim'
call vundle#rc(s:editor_root . '/bundle/')

call vundle#begin()
Plugin 'VundleVim/Vundle.vim'               " Package Management
Plugin 'scrooloose/nerdtree'                " NERDTree filesystem explorer
Plugin 'bronson/vim-trailing-whitespace'    " Trailing whitespace helper
Plugin 'ctrlpvim/ctrlp.vim'                 " Ctrl-P
Plugin 'danro/rename.vim'                   " Rename active file
Plugin 'digitaltoad/vim-pug'                " Pug (Jade) highlighting
Plugin 'moll/vim-node'                      " Node highlighting
Plugin 'mxw/vim-jsx'                        " JSX Syntax
Plugin 'lervag/vimtex'                      " TeX support
Plugin 'itchyny/lightline.vim'              " LightLine (Status bar)
Plugin 'airblade/vim-gitgutter'             " Git gutter
Plugin 'romainl/apprentice'                 " ColorScheme
Plugin 'mhinz/vim-startify'                 " Start Screen
Plugin 'w0rp/ale'                           " Linting
Plugin 'tmhedberg/SimpylFold'               " Function Folding

" Things I really need to learn how to use
Plugin 'scrooloose/nerdcommenter'           " Commenting
Plugin 'tpope/vim-surround'                 " Surround
call vundle#end()

" - Colour Scheme
"   Uses apprentice as the base, but with a few mods.
"
"   Mainly removing the background color and replacing it
"    with the default terminal background.
syntax on
filetype plugin indent on
colorscheme apprentice
hi Normal ctermbg=NONE
hi LineNr ctermbg=NONE
hi FoldColumn ctermbg=NONE ctermfg=242
hi Visual ctermbg=NONE

" - TAB/SPACE Settings I should NEVER MESS WITH AGAIN
"   17-07-18 - I changed this shit again and fucked things lmao
"
set tabstop=4
"   How many spaces a tab appears to be
set shiftwidth=4
"   Width of an indent (eg. using >>)
set softtabstop=-1
"   What distance does backspacing over spaces go?
"    -1 makes it =shiftwidth
set expandtab
"   Expand tabs into spaces
set smarttab
"   Backspace removes a shiftwidth of spaces

" - FileType based tab settings
autocmd Filetype html setlocal ts=2 sw=2

" - Basic Settings
set nobackup            " Meh #MadLAdZ
set noswapfile          " Meh #MadLAdZ
set nu                  " Show line numbers
set hidden              " Don't close hidden buffers
set ignorecase          " Ignore the case when / searching
set smartcase           " Ignore nocase if the search term has capitals in it
set incsearch           " Highlight items in the search as you type
set autoindent          " Auto indent braces
set ruler               " Show the Line + Position of the cursor
set showcmd             " Retains the last command in the bottom of screen
set mouse=a             " Allow mouse use in all edit types
set history=1000        " Heaps of history
set undolevels=1000     " Heaps of undo-ability
set nowrap              " Don't wrap text horizontall (Map to new line)
set textwidth=0         " More wrap disabling
set wrapmargin=0        " More wrap disabling
set scrolloff=4         " 4 Lines of space above/below cursor
set lazyredraw          " Don't redraw during automated tasks
set t_Co=256            " 256 Colors
set foldmethod=indent
set foldlevel=99

" - Cemetery of past settings
"set nofoldenable       " Don't fold functions (it looks ugly!)
"set colorcolumn=80     " Make it obvious where 80 chars is

" - Maps and Remaps
nnoremap <F2> :NERDTreeToggle<CR>
nnoremap <space> za

" - F9 To Run Python Script
autocmd FileType python nnoremap <buffer> <F9> :exec '!python' shellescape(@%, 1)<cr>
autocmd FileType javascript nnoremap <buffer> <F9> :exec '!node' shellescape(@%, 1)<cr>

" - No bitchboi arrow keys
nnoremap <Left> :echoe "HEY YOU, USE H INSTEAD"<CR>
nnoremap <Right> :echoe "HEY YOU, USE L INSTEAD"<CR>
nnoremap <Up> :echoe "HEY YOU, USE K INSTEAD"<CR>
nnoremap <Down> :echoe "HEY YOU, USE J INSTEAD"<CR>

" - Various Window Splitting Magic
nnoremap \ <C-W>v
nnoremap - <C-W>n
nnoremap <C-J> <C-W><C-J>
nnoremap <C-H> <C-W><C-H>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
set splitbelow    " Split Down
set splitright    " Split Right

" - Leader maps
let mapleader = ","             " Use comma as the leader
noremap <Leader>j :bprev<cr>    " Leader-j previous buffer
noremap <Leader>k :bnext<cr>    " Leader-k next buffer
noremap <Leader>q :bw<cr>       " Leader-q close buffer
noremap <Leader>w :w<cr>        " Leader-w saves buffer

" - Status Bar
set laststatus=2                                    " Enable Status Bar
" autocmd VimEnter * AirlineTheme term              " Term theme
" let g:airline#extensions#tabline#enabled = 1
" let g:airline#extensions#tabline#fnamemod = ':t'
" let g:airline_powerline_fonts = 1
" let g:airline_left_sep = ''
" let g:airline_right_sep = ''
" let g:airline#extensions#branch#enabled = 1

" Hide the -- INSERT -- line since it's not needed
set noshowmode

" - Ctrl-P
let g:ctrlp_custom_ignore = {
            \ 'dir':  '\v[\/](\.git|\.hg|\.svn|node_modules)$',
            \ 'file': '\v\.(exe|so|dll)$'
            \ }

" - Startify Nonsense
let g:startify_custom_header = [
            \ '                               ___     ',
            \ '      ___        ___          /__/\    ',
            \ '     /__/\      /  /\        |  |::\   ',
            \ '     \  \:\    /  /:/        |  |:|:\  ',
            \ '      \  \:\  /__/::\      __|__|:|\:\ ',
            \ '  ___  \__\:\ \__\/\:\__  /__/::::| \:\',
            \ ' /__/\ |  |:|    \  \:\/\ \  \:\~~\__\/',
            \ ' \  \:\|  |:|     \__\::/  \  \:\      ',
            \ '  \  \:\__|:|     /__/:/    \  \:\     ',
            \ '   \__\::::/      \__\/      \  \:\    ',
            \ '       ~~~~                   \__\/',
            \ ]
let g:startify_files_number=5
highlight StartifyBracket ctermfg=7
highlight StartifyNumber ctermfg=7
highlight StartifyPath ctermfg=7
highlight StartifySlash ctermfg=7
highlight StartifyFile ctermfg=15
highlight StartifySection ctermfg=1
highlight StartifyHeader ctermfg=10

" - Ale
let g:ale_sign_column_always = 1
nnoremap <F7> :ALENext<CR>
nnoremap <F8> :ALEPrevious<CR>
