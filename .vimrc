call plug#begin()

" PLUGINS
"" COLORSCHEME
Plug 'morhetz/gruvbox'
Plug 'dracula/vim', { 'as': 'dracula' }

"" UTILS
Plug 'scrooloose/nerdtree' 
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'dense-analysis/ale'

" Custom language support
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

set omnifunc=ale#completion#OmniFunc
let g:ale_completion_enabled = 1
let g:ale_completion_autoimport = 1
let g:ale_lint_on_text_changed='never'
let g:ale_set_loclist = 0
let g:ale_set_quickfix = 1
let g:ale_linters = {
\    'go': ['gopls'],
\    'python': ['pylsp'],
\    'sh': ['shellcheck'],
\}

let g:ale_fixers = {
\    'go': ['gopls'],
\    'python': ['ruff'],
\    'sh': ['shellcheck'],
\    '*': ['remove_trailing_lines', 'trim_whitespace'],
\}

let g:ale_python_pyls_executable = 'pylsp'
if executable('pyls')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'pyls',
        \ 'cmd': {server_info->['pyls']},
        \ 'whitelist': ['python'],
        \ })
endif


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

nmap <leader>i] <Plug>(ale_previous_wrap)
nmap <leader>i[ <Plug>(ale_next_wrap)
nmap K <Plug>(ale_hover)
nmap <leader>gd <Plug>(ale_go_to_definition)
nmap <leader>gr <Plug>(ale_find_references)
nmap <leader>rn <Plug>(ale_rename)

"" Organize imports
nmap <leader>OR :call CocAction('runCommand', 'editor.action.organizeImport')<CR>

" Search selected text in directory
vnoremap <leader>ss :call VisualSelection('gv', '')<CR>
" Open Ack and put the cursor in the right position
map <leader>/ :Rg <CR>
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
let g:gruvbox_bold=1
let g:gruvbox_italic=1
let g:gruvbox_contrast_dark="hard"
let g:gruvbox_contrast_light="hard"
autocmd vimenter * hi Normal guibg=NONE ctermbg=NONE

if (has("termguicolors"))
    set termguicolors
endif
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
au BufNewFile,BufRead *.yml, *.js,*.ts,*.jsx,*.html,*.css
            \ set tabstop=2 |
            \ set softtabstop=2 |
            \ set shiftwidth=2 

" Override gohtml filetype automatically to HTML
au BufRead,BufNewFile *.gohtml 
            \ set filetype=html

" vim-pandoc stuff
let g:python3_host_prog="~/.pyenv/shims/python3"
