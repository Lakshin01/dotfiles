set number
syntax enable

" set colorscheme

set background=dark
colorscheme elflord

hi Normal guibg=NONE ctermbg=NONE

call plug#begin()

if empty(glob('~/.vim/autoload/plug.vim'))
	silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

Plug 'junegunn/goyo.vim'
Plug 'plasticboy/vim-markdown'
Plug 'vim-pandoc/vim-pandoc'
Plug 'https://gitlab.com/rwxrob/vim-pandoc-syntax-simple'
"Plug 'vim-pandoc/vim-pandoc-syntax'

call plug#end()

"vimrc alias ha
noremap \src :source ~/.vimrc<cr>

" Disables all Arrow Keys in normal mode, use imap to remove them in insert
" mode

"map <up> <nop>
"map <down> <nop>
"map <left> <nop>
"map <right> <nop>
"rwxRob's suggestion
noremap <up> :echoerr "Umm, use k instead"<CR> 
noremap <down> :echoerr "Umm, use j instead"<CR>
noremap <left> :echoerr "Umm, use h instead"<CR>
noremap <right> :echoerr "Umm, use l instead"<CR>
inoremap <up> <nop>
inoremap <down> <nop>                                                                         
inoremap <left> <nop>                                                                         
inoremap <right> <nop>   

" inspired from a youtube video - vim without plugins
set nocompatible " Makes vim more more VIm and not VI centric i guess

syntax enable
filetype plugin indent on

set path+=**    
" ** searches recursively into directories
set wildmenu " Display all! matching files while tab completion

" TAG JUMPING - LIKE A KEYWORD SEARCH eg it searches for its definition
"command! MakeTags !ctags -R .   " TO much node module codes have million tags
"so ignore
"
set path+=**




















