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

""" disable folding
let g:vim_markdown_folding_disabled=1

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
set incsearch
set showmatch  "Weird parentheses highlighting
set matchpairs+=<:>
set hlsearch
nnoremap <leader><space> :noh<cr>
nnoremap <tab> %
vnoremap <tab> %

"" External clipboard register
nnoremap <leader>c "*
vnoremap <leader>c "*

"" Line-wrapping
set nowrap
set textwidth=79
set formatoptions=qrn1
set colorcolumn=85

"" Training-wheels
" nnoremap <up> <nop>
" nnoremap <down> <nop>
" nnoremap <left> <nop>
" nnoremap <right> <nop>
" inoremap <up> <nop>
" inoremap <down> <nop>
" inoremap <left> <nop>
" inoremap <right> <nop>
nnoremap j gj
nnoremap k gk

" edit file in current low level directory
nnoremap <Leader>e :e <C-R>=expand('%:p:h') . '/'<CR>

" vsp in current low level directory
nnoremap <Leader>v :vsp <C-R>=expand('%:p:h') . '/'<CR>

" sp in current low level directory
nnoremap <Leader>s :sp <C-R>=expand('%:p:h') . '/'<CR>
nnoremap ; :

"" Auto-save
au FocusLost * :wa

"" jj (Thanks, Lee!)
inoremap jj <ESC>

"" Vertical split shortcut
nnoremap <leader>w <C-w>v<C-w>l

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

""Pathogen stuff
execute pathogen#infect()
filetype off
syntax on
filetype plugin indent on
colorscheme distinguished
let g:airline#extensions#tabline#enabled = 1
let g:airline_distinguished = 1

""Vim-move
let g:move_key_modifier = 'C'

""Show filename
set statusline=%f ""%f is relative path, %F is absolute

""Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_js_checkers = ["js"]
let g:syntastic_javascript_checkers = ['eslint']

" disable html_tidy errors
let g:syntastic_html_tidy_quiet_messages = { "level" : "warnings" }

" disable syntastic on the statusline
let g:statline_syntastic = 0

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
