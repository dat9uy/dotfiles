" Plugins list

call plug#begin('~/.local/share/nvim/plugged')

" UI Related
Plug 'itchyny/lightline.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'ayu-theme/ayu-vim'

" Show indent line
Plug 'Yggdroot/indentLine'
let g:indentLine_concealcursor = "nv"

" Autocomplete
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'tbodt/deoplete-tabnine', { 'do': './install.sh' }
Plug 'deoplete-plugins/deoplete-jedi'
Plug 'beeender/Comrade'
let g:deoplete#enable_at_startup = 1

" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

" Jupyter vim
Plug 'jupyter-vim/jupyter-vim'

" Type unicode math
Plug 'arthurxavierx/vim-unicoder'

nnoremap <buffer> <silent> <C-\> :JupyterSendCell<CR>
nnoremap <buffer> <silent> <localleader>c :JupyterConnect<CR>

" Formater
Plug 'psf/black', { 'tag': '19.10b0' }
let g:black_linelength = 79

Plug 'sbdchd/neoformat'

noremap <F3> :Black<CR>
noremap <F4> :Neoformat<CR>

" Markdown table
Plug 'dhruvasagar/vim-table-mode'

" View csv
Plug 'chrisbra/csv.vim'

" Repeat last action
Plug 'tpope/vim-repeat'

" Multiple cursor
Plug 'mg979/vim-visual-multi', {'branch': 'master'}

" Show marks
Plug 'kshenoy/vim-signature'

" File tree
Plug 'preservim/nerdtree'

map <silent> <F2> :NERDTreeToggle<CR>

" Show buffers list
Plug 'bling/vim-bufferline'

" Other language highlight
Plug 'sheerun/vim-polyglot'
" Disable markdown highlight (already has, pandoc)
" let g:polyglot_disabled = ['markdown']

" Use iBus with vim
Plug 'kevinhwang91/vim-ibus-sw'
let g:default_input_index = 1

" Better code folding
Plug 'tmhedberg/SimpylFold'
Plug 'Konfekt/FastFold'

" Auto pairs
Plug 'tmsvg/pear-tree'
Plug 'tpope/vim-surround'
Plug 'andymass/vim-matchup'
Plug 'luochen1990/rainbow'
let g:rainbow_active = 1

" Use gcc to comment line
Plug 'tpope/vim-commentary'

" Python text obj
Plug 'jeetsukumaran/vim-pythonsense'

" Go anywhere"
Plug 'justinmk/vim-sneak'
let g:sneak#label = 1

call plug#end()

filetype indent on
filetype plugin on

" Set leader
let mapleader = ","
let maplocalleader = "\\"

" UI configuration
syntax on 
set hidden
set mouse=a
set noshowmode
set nolazyredraw
set guioptions-=e  " Don't use GUI tabline

" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Use ESC to exit terminal mode
tnoremap <Esc> <C-\><C-n>

" Turn off backup
set nobackup
set noswapfile
set nowritebackup

" Fold comments in Python
autocmd FileType python setlocal foldmethod=expr foldexpr=getline(v:lnum)=~'^\s*#'

" Search configuration
set ignorecase                    " ignore case when searching
set smartcase                     " turn on smartcase

" True Color Support
set termguicolors

" Number line
set number
set relativenumber

" Tab and Indent configuration
set expandtab
set tabstop=4
set shiftwidth=4

" Colorscheme
" let g:vim_monokai_tasty_italic = 1
let ayucolor="dark" 
colorscheme ayu

" Set up Python env for Neovim
" let g:python_host_prog = '/home/datguy/.pyenv/versions/neovim2/bin/python'
" let g:python3_host_prog = '/home/datguy/.pyenv/versions/neovim3/bin/python'
let g:python3_host_prog = '/home/datguy/miniconda3/envs/vim-jupyter/bin/python'

" Lightline
let g:lightline = {
      \ 'colorscheme': 'ayu',
      \ }
