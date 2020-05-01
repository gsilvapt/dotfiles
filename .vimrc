highlight Pmenu ctermfg=15 ctermbg=0 guifg=#ffffff guibg=#000000
call plug#begin()

" Custom Plugs
"" Utils
Plug 'tpope/vim-fugitive'                            " Git Integration
Plug 'airblade/vim-gitgutter'                        " GitGutter (line ±)
Plug 'vim-airline/vim-airline'                       " Vim Airline
Plug 'vim-airline/vim-airline-themes'                " Vim Airline Themes
Plug 'scrooloose/nerdtree'                           " NERDTree plugin
Plug 'mileszs/ack.vim'                               " A better searcher
Plug 'yggdroot/indentline'                           " Line indent characters

"" Autocomplete && Finder && Linter
Plug 'Valloric/YouCompleteMe'
Plug '/usr/local/opt/fzf'
Plug 'w0rp/ale'                                    " Syntax linter

"" Language support
Plug 'fatih/vim-go', {'do': ':GoUpdateBinaries'}
Plug 'nvie/vim-flake8'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'moll/vim-node'
Plug 'ekalinin/Dockerfile.vim'

"" Utils
Plug 'vimwiki/vimwiki'
let g:vimwiki_list = [{'path': '~/vimwiki', 'syntax': 'markdown', 'ext': '.md'}]

" All of your Plugs must be added before the following line
set laststatus=2
call plug#end()            " required

filetype plugin indent on    " required

set encoding=utf-8
set number relativenumber
set nosmd
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

"" Disable Vim's defaults
let g:autoformat_autoindent = 0
let g:autoformat_retab = 0
let g:autoformat_remove_trailing_spaces = 0

" ALE recommended settings
let g:ale_enable = 1
let g:ale_fix_on_save = 1
let g:ale_fixers = {'javascript': ['eslint'], 'python': ['autopep8'], 'java': ['google_java_format']}
let g:ale_sign_error = '●' " Less aggressive than the default '>>'
let g:ale_sign_warning = '.'
let g:ale_lint_on_enter = 0 " Less distracting when opening a new file

" DelimitMate recommended settings
let delimitMate_expand_cr=1

" Pangloss/vim-javascript configs
let g:javascript_plugin_jsdoc = 1

" Colorscheme
syntax on
set background=dark
colorscheme solarized
set t_Co=256

" Solarized config
let g:solarized_contrast = "high"
let g:solarized_visibility = "high"
let g:solarized_bold = 1

" Airline config
let g:airline_theme='solarized'
let g:airline#extensions#tabline#enabled = 1


" Enable Folding
set foldmethod=indent
set foldlevel=99

" Other settings
set hlsearch
set smartcase
set incsearch
set noswapfile
set autoindent
set fileformat=unix
set tabstop=4
set softtabstop=0
set expandtab
set shiftwidth=4
set smarttab

"" Custom mappings
map <C-n> :NERDTreeToggle<CR>
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l
noremap <c-p> :FZF<CR>
map <leader>l :bnext<cr>
map <leader>h :bprevious<cr>
map <leader>tn :tabnew<cr>
map <leader>tc :tabclose<cr>
map <leader>g :Ack
vnoremap <silent> gv :call VisualSelection('gv', '')<CR>

vnoremap $1 <esc>`>a)<esc>`<i(<esc>
vnoremap $2 <esc>`>a]<esc>`<i[<esc>
vnoremap $3 <esc>`>a}<esc>`<i{<esc>
vnoremap $$ <esc>`>a"<esc>`<i"<esc>
vnoremap $q <esc>`>a'<esc>`<i'<esc>
vnoremap $e <esc>`>a"<esc>`<i"<esc>


" => Ack searching and cope displaying
"    requires ack.vim - it's much better than vimgrep/grep
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use the the_silver_searcher if possible (much faster than Ack)
if executable('ag')
    let g:ackprg = 'ag --vimgrep --smart-case'
endif

" When you press gv you Ack after the selected text
vnoremap <silent> gv :call VisualSelection('gv', '')<CR>

" Open Ack and put the cursor in the right position
map <leader>g :Ack

" When you press <leader>r you can search and replace the selected text
vnoremap <silent> <leader>r :call VisualSelection('replace', '')<CR>

set backspace=indent,eol,start

" Python formatting 
let python_highlight_all=1
au BufNewFile,BufRead *.py,*.pyc
            \ set tabstop=4 |
            \ set softtabstop=4 |
            \ set shiftwidth=4 |
            \ set textwidth=119 |
            \ set expandtab |
            \ set autoindent |
            \ set fileformat=unix
" JavaScript formatting
au BufNewFile,BufRead *.js,*.jsx,*.html,*.css
            \ set tabstop=2 |
            \ set softtabstop=2 |
            \ set shiftwidth=2

" Java formatting
au BufNewFile,BufRead *.java
            \ set tabstop=2 |
            \ set softtabstop=2 |
            \ set shiftwidth=2 |
            \ set textwidth=119 |
            \ set expandtab |
            \ set autoindent
