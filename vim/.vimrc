" === Basic Config === "
set nu
set relativenumber
syntax on
inoremap jk <Esc>
set timeoutlen=150
let mapleader = " "

" === Plugins === "
call plug#begin()
Plug 'junegunn/vim-easy-align'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'easymotion/vim-easymotion'
Plug 'wakatime/vim-wakatime'
" Plug 'dracula/vim', { 'as': 'dracula' }
" Plug 'sainnhe/everforest'
Plug 'ayu-theme/ayu-vim' " or other package manager
call plug#end()

" === Keymaps === "
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)
map <Leader> <Plug>(easymotion-prefix)
nmap s <Plug>(easymotion-bd-f)
" inoremap <C-h> <Left>
" inoremap <C-l> <Right>
" inoremap <C-j> <Down>
" inoremap <C-k> <Up>

" === Others === "
" set background=dark
set termguicolors     " enable true colors support
" let ayucolor="light"  " for light version of theme
let ayucolor="dark" " for mirage version of theme
" let ayucolor="dark"   " for dark version of theme
colorscheme ayu
" map <C-U> <C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y>
" map <C-D> <C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E>
" 原仓库ayu-theme/ayu-vim 在文件/path/to/.vim/plugged/ayu-vim/colors/ayu.vim
" 的第275行有 let &background = s:style，我这使用mirage这个版本的ayu时会报错
" 所以如果想使用的话看情况进行注释
" hi Normal guibg=NONE ctermbg=NONE
