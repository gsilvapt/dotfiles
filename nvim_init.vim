highlight Pmenu ctermfg=15 ctermbg=0 guifg=#ffffff guibg=#000000
call plug#begin()

" PLUGINS
"" UTILS
Plug 'vim-airline/vim-airline'                       " Vim Airline
Plug 'vim-airline/vim-airline-themes'                " Vim Airline Themes
Plug 'scrooloose/nerdtree'                           " NERDTree plugin
Plug 'mileszs/ack.vim'                               " A better searcher
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif
Plug 'yggdroot/indentline'                           " Line indent characters
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

"" AIRLINE CONFIG
let g:airline_theme='onedark'
let g:airline#extensions#tabline#enabled = 1

"" INDENTLINE CONFIG
let g:indentLine_first_char = '|'
let g:indentLine_char = '¦'
let g:indentLine_color_term = 240
let g:indentLine_setConceal = 2
" default ''.
" n for Normal mode
" v for Visual mode
" i for Insert mode
" c for Command line editing, for 'incsearch'
let g:indentLine_concealcursor = "nc"

"" AUTOCOMPLETE && FINDER && LINTER
Plug 'neoclide/coc.nvim', {'branch': 'release'}
""" Saner defaults for better UX
set updatetime=300
""" c-space to trigger completion
inoremap <silent><expr> <c-space> coc#refresh()
""" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

"" Use `[c` and `]c` to navigate diagnostics
nmap <leader>[c <Plug>(coc-diagnostic-prev)
nmap <leader>]c <Plug>(coc-diagnostic-next)

"" Remap keys for gotos
nmap <leader>gd <Plug>(coc-definition)
nmap <leader>gy <Plug>(coc-type-definition)
nmap <leader>gi <Plug>(coc-implementation)
nmap <leader>gr <Plug>(coc-references)
"
" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
" Organize imports
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')
" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

"" LANGUAGE SUPPORT (CUSTOM, IN CASE COC SUCKS FOR A GIVEN LANGUAGE
Plug 'rust-lang/rust.vim'

"" UTILS
Plug 'vimwiki/vimwiki'
let g:vimwiki_list = [{'path': '~/vimwiki', 'syntax': 'markdown', 'ext': '.md'}]

" ALL OF YOUR PLUGS MUST BE ADDED BEFORE THE FOLLOWING LINE
set laststatus=2
call plug#end()            " required
filetype plugin indent on    " required

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

"" Custom mappings
map <C-n> :NERDTreeToggle<CR>
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l
noremap <c-p> :FZF<CR>
map <leader>bn :bnext<cr>
map <leader>bp :bprevious<cr>

" => Ack searching and cope displaying
"    requires ack.vim - it's much better than vimgrep/grep
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" When you press gv you Ack after the selected text
vnoremap <silent> gv :call VisualSelection('gv', '')<CR>

" Open Ack and put the cursor in the right position
command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, {'options': '--delimiter : --nth 4..'}, <bang>0)
map <leader>/ :Ack 

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

