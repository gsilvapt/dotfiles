highlight Pmenu ctermfg=15 ctermbg=0 guifg=#ffffff guibg=#000000
call plug#begin()

" PLUGINS
"" COLORSCHEME
Plug 'morhetz/gruvbox'
"" UTILS
Plug 'scrooloose/nerdtree' 
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'mileszs/ack.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'airblade/vim-gitgutter'

"" Custom language support
""" GO
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
au FileType go nmap <leader>gd :GoDef<cr>
au FileType go nmap <leader>rn :GoRename<cr>
au FileType go nnoremap <leader>d :GoDoc<cr>
au FileType go nmap <leader>f :GoFmt<cr>
au FileType go nmap F5 :GoDebugTestFunc
au FileType go nmap F6 :GoDebugStep
au FileType go nmap F7 :GoDebugNext
au FileType go nmap F8 :GoDebugBreakpoint
au FileType go nmap F10 :GoDebugContinue

let g:go_fmt_fail_silently = 0
let g:go_fmt_command = 'goimports'
let g:go_fmt_autosave = 1
let g:go_gopls_enabled = 1
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_operators = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_variable_declarations = 1
let g:go_highlight_variable_assignments = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_diagnostic_errors = 1
let g:go_highlight_diagnostic_warnings = 1
let g:go_auto_sameids = 0
set updatetime=100

" ALL OF YOUR PLUGS MUST BE ADDED BEFORE THE FOLLOWING LINE
set laststatus=2
call plug#end()            " required
filetype plugin indent on    " required

" KEY BINDINGS AND REMAPS
"" Better search
if executable('ag')
    let g:ackprg = 'ag --vimgrep --smart-case'
endif
" When you press gv you Ack after the selected text
vnoremap <silent> gv :call VisualSelection('gv', '')<CR>
" Open Ack and put the cursor in the right position
map <leader>/ :Ack 
"" c-space to trigger completion
inoremap <silent><expr> <c-space> coc#refresh() 
"" Use K to show documentation in preview window.
nnoremap <leader>d :call CocActionAsync('doHover')<cr>
"" Use `[c` and `]c` to navigate diagnostics
nmap <leader>i] <Plug>(coc-diagnostic-next)
nmap <leader>i[ <Plug>(coc-diagnostic-prev)

nmap <leader>gd <Plug>(coc-definition)
nmap <leader>gr <Plug>(coc-references)
nmap <leader>rn <Plug>(coc-rename)

"" Organize imports
nmap <leader>OR :call CocAction('runCommand', 'editor.action.organizeImport')<CR>

"" Toggle NerdTree
map <C-n> :NERDTreeToggle<CR>

"" File Search
nnoremap <C-p> :FZF <CR>

" VIM SETTINGS AND OVERRIDES
syntax on
set t_Co=256
set encoding=utf-8
set number relativenumber

set hlsearch
set incsearch
set linebreak

set noswapfile
set autoindent
set fileformat=unix

set tabstop=2
set softtabstop=2
set shiftwidth=2

set smarttab
set smartindent
set expandtab
"" Disable Vim's defaults
let g:autoformat_autoindent = 0
let g:autoformat_retab = 0
let g:autoformat_remove_trailing_spaces = 0
"" Movement
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l
noremap <Leader>Y "+y

" COLORSCHEME
let g:gruvbox_italic=1
let g:gruvbox_contrast_dark="hard"
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


" base default color changes (gruvbox dark friendly)
hi ErrorMsg ctermbg=234 ctermfg=darkred cterm=NONE
hi Error ctermbg=234 ctermfg=darkred cterm=NONE
hi SpellBad ctermbg=234 ctermfg=darkred cterm=NONE
hi Search ctermbg=236 ctermfg=darkred
hi vimTodo ctermbg=236 ctermfg=darkred
hi Todo ctermbg=236 ctermfg=darkred

" color overrides
au FileType * hi ErrorMsg ctermbg=234 ctermfg=darkred cterm=NONE
au FileType * hi Error ctermbg=234 ctermfg=darkred cterm=NONE
au FileType * hi SpellBad ctermbg=234 ctermfg=darkred cterm=NONE
au FileType * hi Search ctermbg=236 ctermfg=darkred
au FileType * hi vimTodo ctermbg=236 ctermfg=darkred
au FileType * hi Todo ctermbg=236 ctermfg=darkred
au FileType markdown,pandoc hi Title ctermfg=yellow ctermbg=NONE
au FileType markdown,pandoc hi Operator ctermfg=yellow ctermbg=NONE
