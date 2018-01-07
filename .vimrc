" Include the system settings
:if filereadable( "/etc/vimrc" )
   source /etc/vimrc
:endif

" Installing Vim-Plug if it's not available
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Plugins via Vim-Plug
call plug#begin()
Plug 'morhetz/gruvbox'
Plug 'bitc/vim-bad-whitespace'
Plug 'tpope/vim-fugitive'
Plug 'gregsexton/gitv'
Plug 'szw/vim-maximizer'
Plug 'derekwyatt/vim-fswitch'
Plug 'godlygeek/tabular'
Plug 'majutsushi/tagbar'
call plug#end()

" Color scheme
syntax on
set background=dark
colorscheme gruvbox
"Gruvbox specific
let g:gruvbox_invert_selection=0
:if !has("gui_running")
   set t_Co=256
   let g:gruvbox_italic=0
:endif

" Start editor setup
" Set the filename always visible
set laststatus=2
" Change the status bar
set statusline=
set statusline+=%4*\ %<%F%*            "full path
set statusline+=%2*%m%*                "modified flag
set statusline+=%1*%=%5l%*             "current line
set statusline+=%2*/%L%*               "total lines
set statusline+=%1*%4v\ %*             "virtual column number
"Show line number
set number
set numberwidth=4

"No real tabs
set expandtab
"Case insensitive by default
set ignorecase
"Case inferred by default
set infercase
"Do not wrap line
set nowrap
"When at 3 spaces, and I hit > ... go to 4, not 5
set shiftround
"If there are caps, go case-sensitive
set smartcase
"Auto-indent amount when using cindent,
" >>, << and stuff like that
set shiftwidth=3
"When hitting tab or backspace, how many spaces
"should a tab be (see expandtab)
set softtabstop=3
"Real tabs should be 8, and they will show with
" set list on
set tabstop=8
"Set color column to mark end
highlight ColorColumn ctermbg=gray
set colorcolumn=86

" Don't make noise
set noerrorbells
" Turn on command line completion wild style
set wildmenu
" Ignore these list file extensions
set wildignore=*.dll,*.o,*.obj,*.bak,*.exe,*.pyc,
               \*.jpg,*.gif,*.png
" Turn on wild mode huge list
set wildmode=list:longest

" Load filetype plugins/indent settings
filetype plugin indent on
"Always switch to the current file directory
set autochdir
"Make backspace a more flexible
set backspace=indent,eol,start
"Make backup files
set backup

"Share windows clipboard
set clipboard+=unnamed
"All three file formats
set fileformats=unix,dos,mac

"Line break from the cursor position, deletes space if it's under cursor
nnoremap K :call LineBreak()<CR>
function! LineBreak()
   if getline( "." )[ col( "." ) - 1 ] == ' '
      exec "normal r\<CR>\<ESC>"
   else
      exec "normal i\<CR>\<ESC>"
   endif
endfunction

"Split window navigation
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-h> <C-w>h
map <C-l> <C-w>l

" Key mapping for maximizing current vim window
noremap <C-m> :MaximizerToggle<CR>

"No indent when pasting
"Press  before pasting
nnoremap <leader>p :set invpaste paste?<CR>
set pastetoggle=<leader>p
set showmode

" Automatically diffupdate on write
autocmd BufWritePost * if &diff == 1 | diffupdate | endif

" Search visually selected word
vnoremap n y/<C-R>"<CR>

" Tagbar plugin
noremap <Leader>tb :TagbarToggle<CR>
let g:tagbar_compact = 1
let g:tagbar_autofocus = 1
let g:tagbar_sort = 0
let g:tagbar_left = 1
let g:tagbar_type_tac = {
   \ 'ctagstype' : 'tacc',
   \ 'kinds'     : [
       \ 'd:definition'
   \ ],
   \ 'sort'    : 0
\ }
