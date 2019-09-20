" Plugins list

call plug#begin('~/.local/share/nvim/plugged')

" UI Related
Plug 'itchyny/lightline.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'fenetikm/falcon'

" Show indent line
Plug 'Yggdroot/indentLine'
let g:indentLine_char_list = ['|', '¦', '┆', '┊']
let g:indentLine_concealcursor = "nv"

" Autocomplete
Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}
Plug 'wellle/tmux-complete.vim'

" Snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" fzf
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Formater
" Plug 'Chiel92/vim-autoformat'
Plug 'sbdchd/neoformat'

" Repeat last action
Plug 'tpope/vim-repeat'

" Show marks
Plug 'kshenoy/vim-signature'

" Show buffers list
Plug 'bling/vim-bufferline'

" Other language highlight
Plug 'sheerun/vim-polyglot'
" Disable Python, markdown highlight (already has semshi, pandoc)
let g:polyglot_disabled = ['python', 'markdown']

" Use iBus with vim
Plug 'kevinhwang91/vim-ibus-sw'
let g:default_input_index = 1

" Use pyenv with vim
Plug 'lambdalisue/vim-pyenv'

" Python syntax highlight
Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}
let g:semshi#mark_selected_nodes = 0

" Connet IPython with vim
Plug 'bfredl/nvim-ipy', {'do': ':UpdateRemotePlugins'}
Plug 'mtikekar/nvim-send-to-term'

" Edit Jupyter with vim
Plug 'goerz/jupytext.vim'
let g:jupytext_fmt = 'py'
let g:jupytext_filetype_map = {'py': 'python'}

" Better code folding
Plug 'tmhedberg/SimpylFold'
Plug 'Konfekt/FastFold'

" Auto pairs
" Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'
Plug 'andymass/vim-matchup'

" Use gcc to comment line
Plug 'tpope/vim-commentary'

" Write note
Plug 'mmai/vim-markdown-wiki'

" Latex
Plug 'lervag/vimtex'
Plug 'matze/vim-tex-fold'

" Use pandoc with vim
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'vim-pandoc/vim-pandoc-after'

" Python text obj
Plug 'jeetsukumaran/vim-pythonsense'

" Better f command"
Plug 'rhysd/clever-f.vim'

" Chrome console with vim
" Plug 'carlosrocha/vim-chrome-devtools', { 'do': 'npm install && npm run build' }

call plug#end()

filetype indent on
filetype plugin on

" Set leader
let mapleader =  ","

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
let g:falcon_background = 0
let g:falcon_inactive = 1
let g:falcon_lightline = 1
colorscheme falcon

" Neoformat
noremap <F3> :Neoformat<CR>

" Semshi mappings
nmap <silent> <leader>rr :Semshi rename<CR>

" vimtex config
let g:tex_flavor  = 'latex'
let g:tex_conceal = ''
let g:vimtex_fold_manual = 1
let g:vimtex_latexmk_continuous = 1
let g:vimtex_compiler_progname = 'nvr'
let g:vimtex_view_method = 'zathura'

" Ultisnips config
let g:UltiSnipsExpandTrigger= "<Plug>(ultisnips_expand)"
let g:UltiSnipsJumpForwardTrigger   = "<c-j>"
let g:UltiSnipsJumpBackwardTrigger  = "<c-k>"
let g:UltiSnipsRemoveSelectModeMappings = 0

" Disable spell check pandoc (Use Vietnamese)
let g:pandoc#spell#enabled = 0
" Enable link concealments
let g:pandoc#syntax#conceal#urls = 1

" Set up Python env for Neovim
" let g:python_host_prog = '/home/datguy/.pyenv/versions/neovim2/bin/python'
" let g:python3_host_prog = '/home/datguy/.pyenv/versions/neovim3/bin/python'
let g:python3_host_prog = '/home/datguy/.pyenv/versions/miniconda3-latest/bin/python'

" Coc.nvim

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
            \ pumvisible() ? "\<C-n>" :
            \ <SID>check_back_space() ? "\<TAB>" :
            \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)

nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    else
        call CocAction('doHover')
    endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
    autocmd!
    " Setup formatexpr specified filetype(s).
    autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
    " Update signature help on jump placeholder
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

" Lightline
let g:lightline = {
            \ 'colorscheme': 'falcon',
            \ 'active': {
            \   'left': [ [ 'mode', 'paste' ],
            \             [ 'cocstatus', 'readonly', 'filename', 'modified' ] ]
            \ },
            \ 'component_function': {
            \   'filetype': 'MyFiletype',
            \   'fileformat': 'MyFileformat',
            \   'cocstatus': 'coc#status'
            \ }
            \ }

let g:lightline.tabline = {
            \   'left': [ ['tabs'] ],
            \   'right': [ ['close'] ]
            \ }


function! MyFiletype()
    return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft') : ''
endfunction

function! MyFileformat()
    return winwidth(0) > 70 ? (&fileformat . ' ' . WebDevIconsGetFileFormatSymbol()) : ''
endfunction
