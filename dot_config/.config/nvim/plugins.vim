call plug#begin('~/.config/nvim/plugged')
Plug 'scrooloose/nerdtree'
Plug 'ryanoasis/vim-devicons'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'pappasam/coc-jedi', { 'do': 'yarn install --frozen-lockfile && yarn build', 'branch': 'main' }
Plug 'cocopon/iceberg.vim'
Plug 'jiangmiao/auto-pairs' 
Plug 'dense-analysis/ale'
Plug 'sheerun/vim-polyglot'
Plug 'luochen1990/rainbow'                                            " Rainbow Parentheses Improved
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'chiel92/vim-autoformat'
Plug 'terryma/vim-multiple-cursors'
Plug 'mattn/emmet-vim'
Plug 'Yggdroot/indentLine'
Plug 'plasticboy/vim-markdown'
Plug 'suan/vim-instant-markdown'
"Plug 'tpope/vim-fugitive'
"Plug 'Yggdroot/indentLine'
"Plug 'scrooloose/syntastic'                                             " syntax checking


call plug#end()

