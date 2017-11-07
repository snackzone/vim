" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

"" Prevents some security exploits having to do with modelines in files.
set modelines=0

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" CTRL+P
set runtimepath^=~/.vim/bundle/ctrlp.vim
let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:5,results:5'
let g:ctrlp_switch_buffer = 'ET' " Jump to open buffer if possible
let g:ctrlp_root_markers = ['package.json', '.git']
let g:ctrlp_custom_ignore = {
 \ 'dir': 'node_modules\|bower_components\|log\|vendor\|public\/system\|tmp\|dist',
 \ }

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

""" general things
set backspace=indent,eol,start
set autoread
set history=1000
set swapfile
set dir=~/tmp
set backupdir=~/tmp//

""" line numbers
set number

""" splits open on bottom and right
set splitbelow
set splitright

""" Indentations
set autoindent
set expandtab
set shiftwidth=2
set softtabstop=2
set tabstop=2

let mapleader = ","

"" Searching / moving
nnoremap / /\v
vnoremap / /\v
set ignorecase
set smartcase
set scrolloff=2
set title
set gdefault
set matchpairs+=<:>
set incsearch
set hlsearch
nnoremap <leader><space> :noh<cr>
nnoremap <tab> %
vnoremap <tab> %

set showmatch  "Weird parentheses highlighting

"" External clipboard register
nnoremap <leader>c "*
vnoremap <leader>c "*

" toggle paste mode
nnoremap <Leader>p :set invpaste<CR>

"" Line-wrapping
set nowrap
set textwidth=79
set formatoptions=qrn1
set colorcolumn=85

"" Tabs
nnoremap <leader><tab> :tabedit<cr>

"" Navigate split panes
nnoremap <C-j> <C-w>j
nnoremap <C-h> <C-w>h
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

"" Buffers
set hidden
nmap <leader>T :enew<cr>
nmap <leader>l :bnext<CR>
nmap <leader>h :bprevious<CR>
nmap <leader>q :bp <BAR> bd #<CR>
nmap <leader>bl :ls<CR>

"" Closes all buffers but the current one
nmap <leader>o :BufOnly<CR>

"" Move vertically across visual lines, not actual lines
nnoremap j gj
nnoremap k gk

" edit file in current low level directory
nnoremap <Leader>e :e <C-R>=expand('%:p:h') . '/'<CR>

" vsp in current low level directory
nnoremap <Leader>v :vsp <C-R>=expand('%:p:h') . '/'<CR>

" sp in current low level directory
nnoremap <Leader>s :sp <C-R>=expand('%:p:h') . '/'<CR>

" enter command without shift
nnoremap ; :

"" Auto-save
au FocusLost * :wa

"" jj (Thanks, Lee!)
inoremap jj <ESC>

"" Vertical split shortcut
nnoremap <leader>w <C-w>v<C-w>l

cnoreabbrev Ack Ack!
nnoremap <leader>a :Ack!<Space>

filetype off
syntax on
filetype plugin indent on
set t_Co=256
set background=dark
colorscheme distinguished
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline_distinguished = 1

""Vim-move
let g:move_key_modifier = 'C'

""Show filename
set statusline=%f ""%f is relative path, %F is absolute

""NERDTree
nnoremap <S-tab> :NERDTreeToggle <Enter>

""Ale
let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_insert_leave = 1
let g:ale_linters = {
      \  'html': [],
      \  'javascript': ['eslint'],
      \  'ruby': ['ruby'],
      \  'eruby': []
      \}

""SyntaxComplete
if has("autocmd") && exists("+omnifunc")
  autocmd Filetype *
     \  if &omnifunc == "" |
     \  setlocal omnifunc=syntaxcomplete#Complete |
     \  endif
endif

" Highlight extra whitespace
highlight ExtraWhitespace ctermbg=2 guibg=darkgreen
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" Markdown Settings
let g:vim_markdown_folding_disabled=1
let g:vim_markdown_fenced_languages = ['js=javascript']

let g:ale_fixers = {'javascript': ['prettier', 'eslint']}
let g:ale_fix_on_save=1

call plug#begin('~/.vim/plugged')
" must use single-quotes in this section

Plug 'mileszs/ack.vim'
Plug 'flazz/vim-colorschemes'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'felixhummel/setcolors.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'kchmck/vim-coffee-script'
Plug 'airblade/vim-gitgutter'
Plug 'matze/vim-move'
Plug 'tpope/vim-fugitive'
Plug 'pangloss/vim-javascript'
Plug 'junegunn/goyo.vim'
Plug 'kien/ctrlp.vim'
Plug 'christoomey/vim-tmux-navigator'

" Asynchronous Linting Engine
Plug 'w0rp/ale'

" Markdown stuff
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'

" Yet Another JavaScript Syntax
Plug 'othree/yajs.vim'

" For ES7 features
Plug 'othree/es.next.syntax.vim'

call plug#end()
