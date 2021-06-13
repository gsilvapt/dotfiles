highlight Pmenu ctermfg=15 ctermbg=0 guifg=#ffffff guibg=#000000
call plug#begin()

" PLUGINS
"" COLORSCHEME
Plug 'morhetz/gruvbox'
"" UTILS
Plug 'scrooloose/nerdtree' 
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'airblade/vim-gitgutter'

" ALL OF YOUR PLUGS MUST BE ADDED BEFORE THE FOLLOWING LINE
set laststatus=2
call plug#end()            " required
filetype plugin indent on    " required

" KEY BINDINGS AND REMAPS
"" c-space to trigger completion
inoremap <silent><expr> <c-space> coc#refresh() 
"" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>
"" Use `[c` and `]c` to navigate diagnostics
nmap <leader>i] <Plug>(coc-diagnostic-next)
nmap <leader>i[ <Plug>(coc-diagnostic-prev)

nmap <leader>gd <Plug>(coc-definition)
nmap <leader>gr <Plug>(coc-references)
nmap <leader>rn <Plug>(coc-rename)

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
"" Organize imports
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

"" Toggle NerdTree
map <C-n> :NERDTreeToggle<CR>

"" File Search
nnoremap <C-p> :GFiles<CR>

" VIM SETTINGS AND OVERRIDES
syntax on
set t_Co=256
set encoding=utf-8
set number relativenumber
set nosmd
set foldmethod=indent
set foldlevel=99
set hlsearch
set smartcase
set incsearch
set noswapfile
set autoindent
set fileformat=unix
set tabstop=4
set softtabstop=4
set shiftwidth=4
set smarttab
"" Disable Vim's defaults
let g:autoformat_autoindent = 0
let g:autoformat_retab = 0
let g:autoformat_remove_trailing_spaces = 0
"" Movement
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" COLORSCHEME
let g:gruvbox_italic=1
set termguicolors
colorscheme gruvbox
set backspace=indent,eol,start
set colorcolumn=120

" Python formatting 
let python_highlight_all=1
au BufNewFile,BufRead *.py,*.pyc
            \ set textwidth=119 |
            \ set expandtab |
            \ set autoindent |
            \ set fileformat=unix
" JavaScript and YAML formatting
au BufNewFile,BufRead *.yaml, *.yml, *.js,*.ts,*.jsx,*.html,*.css
            \ set tabstop=2 |
            \ set softtabstop=2 |
            \ set shiftwidth=2

