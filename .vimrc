" custom (g)vim settings

" basics
set nocompatible        " use gVim defaults
set mouse=a             " make sure mouse is used in all cases.
colorscheme desert      " define syntax color scheme
"colorscheme wombat     " define syntax color scheme
"set fileformat=unix     " force unix-style line breaks

" tabs and indenting
set expandtab           " insert spaces instead of tab chars
set tabstop=2           " a n-space tab width
set shiftwidth=2        " allows the use of < and > for VISUAL indenting
set softtabstop=2       " counts n spaces when DELETE or BCKSPCE is used
set autoindent          " auto indents next new line
set nosmartindent       " intelligent indenting -- DEPRECATED by cindent
set nocindent           " set C style indenting off, I don't write C!

" searching
set hlsearch            " highlight all search results
set incsearch           " increment search
set ignorecase          " case-insensitive search
set smartcase           " upper-case sensitive search

" F5 toggles spell checking
:map <F5> :setlocal spell! spelllang=en_us<cr>
:imap <F5> <C-o>:setlocal spell! spelllang=en_us<cr>

set backspace=2         " full backspacing capabilities
set history=100         " 100 lines of command line history
set cmdheight=2         " command line height
set laststatus=2        " occasions to show status line, 2=always.
set ruler               " ruler display in status line
set showmode            " show mode at bottom of screen
set number              " show line numbers
set nobackup            " disable backup files (filename~)
set showmatch           " show matching brackets (),{},[]
set ww=<,>,[,]          " whichwrap -- left/right keys can traverse up/down

" strip ^M linebreaks from dos formatted files
map M :%s/$//g

" syntax highlighting
syntax on               " enable syntax highlighting

" highlight redundant whitespaces and tabs.
"highlight RedundantSpaces ctermbg=red guibg=red
"match RedundantSpaces /\s\+$\| \+\ze\t\|\t/

" gvim settings
"set guioptions-=T" Disable toolbar icons
"set guifont=Monospace\ 8 " backslash spaces (e.g. Bitstream\ Vera\ Sans\ 8)
set guifont=Terminus\ 8 " backslash spaces (e.g. Bitstream\ Vera\ Sans\ 8)
"set lines=36
"set columns=118

" common save shortcuts
inoremap <C-s> <esc>:w<cr>a
nnoremap <C-s> :w<cr>

" enter ex mode with semi-colon
nnoremap ; :
vnoremap ; :

" mutt rules
au BufRead /tmp/mutt-* set tw=72 spell

