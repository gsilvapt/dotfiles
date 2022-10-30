call plug#begin()

" PLUGINS
"" COLORSCHEME
Plug 'morhetz/gruvbox'

"" UTILS
Plug 'scrooloose/nerdtree' 
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'mileszs/ack.vim'
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Custom language support
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

" golang
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
"let g:go_auto_type_info = 1 " forces 'Press ENTER' too much
let g:go_auto_sameids = 0

" ALL OF YOUR PLUGS MUST BE ADDED BEFORE THE FOLLOWING LINE
set laststatus=2
call plug#end()            " required

" KEY BINDINGS AND REMAPS
" Use tab for trigger completion with characters ahead and navigate.
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
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

" Search selected text in directory
vnoremap <leader>gs :call VisualSelection('gv', '')<CR>
" Open Ack and put the cursor in the right position
map <leader>/ :Rg<CR>
" Quick shortcut to cycle through all buffers.
nnoremap <leader>bn :bnext<CR>
nnoremap <leader>bp :bprevious<CR>

"" Toggle NerdTree
map <C-n> :NERDTreeToggle<CR>

"" File Search
nnoremap <C-p> :Files <CR>

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

set tabstop=4
set softtabstop=4
set shiftwidth=4

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
colorscheme gruvbox
let g:gruvbox_italic=1
let g:gruvbox_contrast_dark="hard"

set termguicolors
set background=dark
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

" Ruby Specific settings
aut BufNewFile,BufRead *.rb 
            \ set softtabstop=2 |
            \ set sw=2 |
            \ set ts=2

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
au FileType markdown,pandoc,md hi Title ctermfg=yellow ctermbg=NONE
au FileType markdown,pandoc,md hi Operator ctermfg=yellow ctermbg=NONE
