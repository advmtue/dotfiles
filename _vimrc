set nocompatible
filetype off

" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"

set rtp+=~/.vim/bundle/Vundle.vim

" Everyone loves vundle :)
call vundle#begin(path)
	
" Might aswell get Vundle to handle itself
Plugin 'gmarik/Vundle.vim'

" Base-16 Theme
Plugin 'chriskempson/base16-vim'
" Codeschool Colour Theme
Plugin '29decibel/codeschool-vim-theme'
	
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
colorscheme codeschool
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
set viminfo+=n$VIM/_viminfo
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

set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let eq = ''
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      let cmd = '""' . $VIMRUNTIME . '\diff"'
      let eq = '"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction
