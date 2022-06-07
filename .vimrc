" ARCTIS-VIM SETUP 2022-05-26

"*********************************************************************
"" Vim-Plug core
"*********************************************************************
let vimplug_exists=expand('~/.vim/autoload/plug.vim')
if has('win32')&&!has('win64')
  let curl_exists=expand('C:\Windows\Sysnative\curl.exe')
else
  let curl_exists=expand('curl')
endif

let g:vim_bootstrap_langs = "c,html,javascript,typescript"
let g:vim_bootstrap_editor = "vim"				" nvim or vim
let g:vim_bootstrap_frams = ""

if !filereadable(vimplug_exists)
  if !executable(curl_exists)
    echoerr "You have to install curl or first install vim-plug yourself!"
    execute "q!"
  endif
  echo "Installing Vim-Plug..."
  echo ""
  silent exec "!"curl_exists" -fLo " . shellescape(vimplug_exists) . " --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  let g:not_finish_vimplug = "yes"

  autocmd VimEnter * PlugInstall
endif

call plug#begin(expand('~/.vim/plugged'))

"*********************************************************************
"" Plug install packages
"*********************************************************************
"" Themes
Plug 'ghifarit53/tokyonight-vim'
Plug 'sainnhe/gruvbox-material'

"" Utils
Plug 'scrooloose/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'sheerun/vim-polyglot'
Plug 'Yggdroot/indentLine'
Plug 'airblade/vim-gitgutter'
Plug 'dense-analysis/ale'
"*********************************************************************
"*********************************************************************

"" Include user's extra bundle
set fillchars+=vert:/
if filereadable(expand("~/.vimrc.local.bundles"))
  source ~/.vimrc.local.bundles
endif

call plug#end()

" Required:
filetype plugin indent on

"*********************************************************************
"" Basic Setup
"*********************************************************************
"" Encoding
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8
set ttyfast

"" Fix backspace indent
set backspace=indent,eol,start

"" Tabs. May be overridden by autocmd rules
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab

"" Map leader to
let mapleader=','

"" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase

set fileformats=unix,dos,mac

set clipboard=unnamedplus

if exists('$SHELL')
  set shell=$SHELL
else
  set shell=/bin/sh
endif

"*********************************************************************
"" Visual Settings 
"*********************************************************************
syntax on
set ruler
set number

if has('termguicolors')
  set termguicolors
endif

"" Theming
set background=dark
let g:gruvbox_material_background='hard'
let g:gruvbox_material_better_performance=1
let g:gruvbox_material_enable_bold=1
let g:gruvbox_material_enable_italic=1
let g:gruvbox_material_transparent_background=0
let g:gruvbox_material_ui_contrast='high'
colorscheme gruvbox-material

"let g:tokyonight_style='storm'
"let g:tokyonight_enable_italic=1
"let g:tokyonight_transparent_background=0
"colorscheme tokyonight

"" Better command line completion
set wildmenu

"" Disable blinking cursor.
set gcr=a:blinkon0
set scrolloff=3

"" Status bar
set laststatus=2

"" Use modeline overrides
set modeline
set modelines=10

set title
set titleold="Terminal"
set titlestring=%F

set statusline=%F%m%r%h%w%=(%{&ff}/%Y)\ (line\ %l\/%L,\ col\ %c)\

"" Mouse support
if has('mouse')
  if &term =~ 'xterm'
    set mouse=a
  else
    set mouse=nvi
  endif
endif

"" IndentLine
let g:indentLine_enabled = 1
let g:indentLine_conceallevel=0
let g:indentLine_char_list = ['|', '¦', '┆', '┊']
let g:indentLine_faster = 1
let g:indentLine_color_gui="#FFFFFF"

if &term =~ '256color'
  set t_ut=
endif

if exists("*fugitive#statusline")
  set statusline+=%{fugitive#statusline()}
endif

"" vim-airline
let g:airline_theme = 'gruvbox_material'
let g:airline_powerline_fonts = 1
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tagbar#enabled = 1
let g:airline_skip_empty_sections = 1

"*********************************************************************
"" Plugin Configs 
"*********************************************************************
"" Abbrevs
"" No one is really happy until you have this shortcuts they 
cnoreabbrev W! w!
cnoreabbrev Q! q!
cnoreabbrev Qall! qall!
cnoreabbrev Wq wq
cnoreabbrev Wa wa
cnoreabbrev wQ wq
cnoreabbrev WQ wq
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Qall qall

"" NERDTree configuration
let g:nerdtree_tabs_focus_on_files=1
let g:NERDTreeChDirMode=2
let g:NERDTreeIgnore=['node_modules','\.rbc$', '\~$', '\.pyc$', '\.db$', '\.sqlite$', '__pycache__']
let g:NERDTreeSortOrder=['^__\.py$', '\/$', '*', '\.swp$', '\.bak$', '\~$']
let g:NERDTreeShowBookmarks=1
let g:NERDTreeMapOpenInTabSilent = '<RightMouse>'
let g:NERDTreeWinSize=50
let NERDTreeShowHidden=1
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.db,*.sqlite,*node_modules/

"" Ale config
let g:ale_lint_on_enter=0
let g:ale_completion_enabled=0
let g:ale_completion_autoimport=0
let g:ale_sign_error='>>'
let g:ale_sign_warning='--'

"*********************************************************************
"" Mappings
"*********************************************************************
"" Split
noremap <leader>h :<C-u>split<CR>
noremap <leader>v :<C-u>vsplit<CR>

"" NERDTree mapping
nnoremap <silent> <leader>p :NERDTreeToggle<CR>

"s" Tabs
"nnoremap <Tab> :gt<CR>
"nnoremap <S-Tab> :gT<CR>
"nnoremap <silent> <S-t> :tabnew<CR>

"" Ease of use 
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>
inoremap {<CR> {<CR>}<ESC>O
inoremap {;<CR> {<CR>};<ESC>O

"" Buffer nav
noremap <leader>q :bp<CR>
noremap <leader>e :bn<CR>
noremap <leader>d :bd<CR>

"" Set working directory
nnoremap <leader>. :lcd %:p:h<CR>

"" Switching windows
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
noremap <C-h> <C-w>h

"" Vmap for maintain visual mode after shifting > and <
vmap < <gv
vmap > >gv

"" Move visual block
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

"" Clean search (Hightlight)
nnoremap <silent> <leader><space> :noh<cr>

"" Search mapping
nnoremap n nzzzv
nnoremap N Nzzzv

"*********************************************************************
"" Commands 
"*********************************************************************
"" remove trailing whitespaces
command! FixWhitespace :%s/\s\+$//e

"*********************************************************************
"" Others 
"*********************************************************************
"" Include user's local vim config
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

if !exists('g:airline_powerline_fonts')
  let g:airline#extensions#tabline#left_sep = ' '
  let g:airline#extensions#tabline#left_alt_sep = '|'
  let g:airline_left_sep          = '▶'
  let g:airline_left_alt_sep      = '»'
  let g:airline_right_sep         = '◀'
  let g:airline_right_alt_sep     = '«'
  let g:airline#extensions#branch#prefix     = '⤴' "➔, ➥, ⎇
  let g:airline#extensions#readonly#symbol   = '⊘'
  let g:airline#extensions#linecolumn#prefix = '¶'
  let g:airline#extensions#paste#symbol      = 'ρ'
  let g:airline_symbols.linenr    = '␊'
  let g:airline_symbols.branch    = '⎇'
  let g:airline_symbols.paste     = 'ρ'
  let g:airline_symbols.paste     = 'Þ'
  let g:airline_symbols.paste     = '∥'
  let g:airline_symbols.whitespace = 'Ξ'
else
  let g:airline#extensions#tabline#left_sep = ''
  let g:airline#extensions#tabline#left_alt_sep = ''

  " powerline symbols
  let g:airline_left_sep = ''
  let g:airline_left_alt_sep = ''
  let g:airline_right_sep = ''
  let g:airline_right_alt_sep = ''
  let g:airline_symbols.branch = ''
  let g:airline_symbols.readonly = ''
  let g:airline_symbols.linenr = ''
endif
