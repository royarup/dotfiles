" Include the system settings
:if filereadable( "/etc/vimrc" )
   source /etc/vimrc
:endif

" Include Arista-specific settings
:if filereadable( $VIM . "/vimfiles/arista.vim" )
   source $VIM/vimfiles/arista.vim
:endif

"Setting the syntax highlighting
syntax on
set background=dark
colorscheme gruvbox
"Gruvbox specific
let g:gruvbox_invert_selection=0
:if !has("gui_running")
   set t_Co=256
   let g:gruvbox_italic=0
:endif

"Set the filename always visible
set laststatus=2
"Change the status bar
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

"Don't make noise
set noerrorbells
"Turn on command line completion wild style
set wildmenu
"Ignore these list file extensions
set wildignore=*.dll,*.o,*.obj,*.bak,*.exe,*.pyc,
               \*.jpg,*.gif,*.png
"Turn on wild mode huge list
set wildmode=list:longest

"Load filetype plugins/indent settings
filetype plugin indent on
"Always switch to the current file directory
set autochdir
"Make backspace a more flexible
set backspace=indent,eol,start
"Make backup files
set backup
"Where to put backup and swap files
if !empty( $A4_CHROOT )
   set backupdir=/tmp/.vim/backup
   set directory=/tmp/.vim/swap
else
   set backupdir=~/.vim/backup
   set directory=~/.vim/swap
endif
"Share windows clipboard
set clipboard+=unnamed
"All three file formats
set fileformats=unix,dos,mac


"Disable arrow keys
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

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
noremap <C-m> :call MaximizeToggle()<CR>
function! MaximizeToggle()
  if exists("s:maximize_session")
    exec "source " . s:maximize_session
    call delete(s:maximize_session)
    unlet s:maximize_session
    let &hidden=s:maximize_hidden_save
    unlet s:maximize_hidden_save
  else
    let s:maximize_hidden_save = &hidden
    let s:maximize_session = tempname()
    set hidden
    exec "mksession! " . s:maximize_session
    only
  endif
endfunction

"No indent when pasting
"Press \p before pasting
nnoremap <leader>p :set invpaste paste?<CR>
set pastetoggle=<leader>p
set showmode

"Highlight current line and column
"Toggle with \c
:hi CursorLine   cterm=NONE ctermbg=gray ctermfg=white
:hi CursorColumn cterm=NONE ctermbg=gray ctermfg=white
:nnoremap <Leader>c :set cursorline! cursorcolumn!<CR>

"Insert a comment blocks
command InsDebug :normal A<CR><CR>#<<<ARUP: DEBUG<CR>import Tac<CR>Tac.pdb()<CR>#<<<ARUP: END DEBUG<CR><ESC>
command InsComment :normal A<CR><CR>#<<<ARUP: COMMENT<CR>#<<<ARUP: END COMMENT<CR><ESC>

"Plugins customization
"

"Set ctags
if !empty( $A4_CHROOT )
   set tags=/src/tags
endif

"Setting the fold color for AGid
let AGid_Hi_Fold = 'cterm=bold ctermbg=black ctermfg=white'

"Custom setting for python_fn
"Remapping go to start of block
map ]b :PBoB<CR>
vmap ]b :<C-U>PBOB<CR>m'gv``

"Remapping jump to previous class
map  ]P   :call PythonDec( "class", -1 )<CR>
vmap ]P   :call PythonDec( "class", -1 )<CR>

"Rempping jump to next class
map  ]N   :call PythonDec( "class", 1 )<CR>
vmap ]N   :call PythonDec( "class", 1 )<CR>

"Rempping jump to previous function
map  ]p   :call PythonDec( "function", -1 )<CR>
vmap ]p   :call PythonDec( "function", -1 )<CR>

"Rempping jump to next function
map  ]n   :call PythonDec( "function", 1 )<CR>
vmap ]n   :call PythonDec( "function", 1 )<CR>

