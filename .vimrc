set nocompatible
filetype off

call plug#begin('~/.vim/plugged')
Plug 'junegunn/vim-plug'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'morhetz/gruvbox'
Plug 'tpope/vim-fugitive'
Plug 'bronson/vim-trailing-whitespace'
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'airblade/vim-gitgutter'
Plug 'jlanzarotta/bufexplorer'
Plug 'tpope/vim-eunuch'
Plug 'godlygeek/tabular'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Langs
Plug 'lervag/vimtex'
Plug 'hashivim/vim-terraform'
Plug 'vim-python/python-syntax'
call plug#end()

filetype plugin indent on
syntax on

" Colour Scheme = gruvbox
set background=dark
colorscheme gruvbox
hi Normal ctermbg=NONE           " Remove background colour and use the terminal default.
hi todo ctermbg=NONE             " Remove high-contrast background on TODO keyword.
hi GruvboxRedSign ctermbg=NONE   " Remove the background on the red sign in the gutter.
hi GruvboxGreenSign ctermbg=NONE " Remove the background on the red sign in the gutter.
hi GruvboxAquaSign ctermbg=NONE  " Remove the background on the red sign in the gutter.
hi SignColumn ctermbg=NONE       " Remove the background of the signcolumn gutter.
hi ColorColumn ctermbg=234       "
hi VertSplit ctermbg=234         " Colour of vertical split columns
hi NonText ctermfg=233           " Colour of '~' text on non-file lines

" Width of an indent (eg. using >>)
" HTML
autocmd Filetype html setlocal ts=2 sw=0 sts=2
" Markdown
autocmd Filetype markdown setlocal ts=2 sw=2
" Yaml, Bash Scripts
autocmd Filetype yaml,sh setlocal ts=4 sw=4 sts=4 expandtab
" JavaScript, TypeScript
autocmd Filetype javascript,typescript setlocal ts=2 sw=2 sts=2 noexpandtab formatoptions+=ro
" LaTex/Tex
autocmd Filetype tex setlocal wrap textwidth=80
" Pug
autocmd Filetype pug setlocal ts=2 sts=-1 sw=2
" CSharp
autocmd Filetype cs setlocal ts=4 sw=0 sts=4 expandtab
" SCSS, CSS
autocmd Filetype scss,css setlocal ts=2 sw=0 sts=2 expandtab

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
" set statusline=[%F]%r%=%l:%c%V " Status bar = [{filename}]{permissions}
set conceallevel=2             " Conceal text formatting such as markdown
set splitbelow                 " Split Down
set splitright                 " Split Right
set noea                       " Don't automatically resize windows
set updatetime=50
set cmdheight=2                " Extra space for cmd output
set signcolumn=yes             " Distinct sign column
" set colorcolumn=110          " Column #110 highlighed
set fillchars+=vert:\          " No character in vert column spacers
set mouse=a                    " Enable mouse
set ttymouse=xterm2            " Fix for laggy mouse highlighting

" Leader utilities
let mapleader = " "            " Use space as the leader
noremap <leader>H :nohl<cr>    " Clear highlights

" Coc
nmap <leader>gd <Plug>(coc-definition)
nmap <leader>gr <Plug>(coc-references)
nmap <leader>gi <Plug>(coc-implementation)
nmap <leader>rr <Plug>(coc-rename)
nmap <leader>dh <Plug>(coc-diagnostic-prev)
nmap <leader>dl <Plug>(coc-diagnostic-next)

" Coc Extensions
let g:coc_global_extensions = [
	\ 'coc-angular',
	\ 'coc-css',
	\ 'coc-omnisharp',
	\ 'coc-tsserver',
	\ 'coc-prettier',
	\ 'coc-json',
	\ 'coc-pyright'
	\ ]

" Window navigation
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>

" File Tree
nnoremap <leader>t :NERDTreeToggle<CR>
nnoremap <leader>T :NERDTreeFocus<CR>

" Ripgrep
nnoremap <C-p> :Files<CR>
nnoremap <C-f> :Rg! 

" Python syntax highlighting
let g:python_highlight_all = 1

" NERDTREE Git status
let g:NERDTreeGitStatusIndicatorMapCustom = {
                \ 'Modified'  :'✹',
                \ 'Staged'    :'✚',
                \ 'Untracked' :'✭',
                \ 'Renamed'   :'➜',
                \ 'Unmerged'  :'═',
                \ 'Deleted'   :'✖',
                \ 'Dirty'     :'✗',
                \ 'Ignored'   :'☒',
                \ 'Clean'     :'✔︎',
                \ 'Unknown'   :'?',
                \ }

" Typesetting (latex@vimtex)
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode=0
let g:tex_conceal='abdmg'

" Airline
let g:airline_symbols_ascii = 1

" GitGutter
let g:gitgutter_map_keys = 0

" Terraform auto formatting
autocmd FileType tf,terraform autocmd BufWritePre <buffer> :TerraformFmt

" Close vim if NERDTree is the last and only buffer
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
