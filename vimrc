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

map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>
