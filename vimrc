set nocompatible
filetype off

" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
if has('unix')
    set t_Co=256
endif

set rtp+=~/.vim/bundle/Vundle.vim
set viminfo+=n~/.vim/viminfo

" Everyone loves vundle :)
call vundle#begin()
	
" Might aswell get Vundle to handle itself
Plugin 'gmarik/Vundle.vim'

" Base-16 Theme
Plugin 'chriskempson/base16-vim'
" Codeschool Colour Theme
Plugin '29decibel/codeschool-vim-theme'
Plugin 'morhetz/gruvbox'
	
" NERDTree & commenter
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter'
	
" JADE highlighter
Plugin 'digitaltoad/vim-jade'
	
" Nodejs plugin, not really sure of the benefits
Plugin 'moll/vim-node'
	
" Javascript syntax
Plugin 'pangloss/vim-javascript'

" Surround
Plugin 'tpope/vim-surround'

" Ctrp - File Finding
Plugin 'kien/ctrlp.vim'

" End Vundle Things
call vundle#end()
filetype plugin indent on

" Colourscheme and Font
colorscheme gruvbox
set background=dark
set guifont=Consolas:h8

" Remove Toolbar and Left-Scrollbar
set guioptions-=L
set guioptions-=T

" Blah
set nu
set hidden
set ignorecase
set incsearch
set incsearch
set smartcase
set showmatch
set autoindent
set ruler
set vb
set noerrorbells
set showcmd
set mouse=a
set history=1000
set undolevels=1000
set nofoldenable
:set nowrap
set textwidth=0
set wrapmargin=0

" NERDTree Close
cd ~/ 
map <F2> :NERDTreeToggle<CR>
map <C-o> :NERDTree %<CR>

map <F3> :mksession! ~/.vim/sessions/vim_session <cr> " Quick write session with F2
map <F4> :source ~/.vim/sessions/vim_session <cr>     " And load session with F3

au GUIEnter * simalt ~x
set backupdir=$VIM/vimtmp,.
set directory=$VIM/vimtmp,.

map <F8> :tabn<CR>
map <F7> :tabp<CR>
map <C-h> :nohl<CR>

