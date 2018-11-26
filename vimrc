"""" Startup
" disable compatibility with old terminals to get shiny vim improvements
set nocompatible

"""" Backup
set backupcopy=yes
set backupdir=~/.vim/backup
silent !mkdir -p ~/.vim/backup > /dev/null 2>&1
set directory=~/.vim/tmp
silent !mkdir -p ~/.vim/tmp> /dev/null 2>&1

"""" Backspacing
" allow backspaces to delete new lines, etc. makes backspace perform how most other programs do
set backspace=eol,start,indent 
" allow vim to wrap to next line when the end of the line has been reached
set whichwrap+=<,>,h,l 

"""" Code formatting
" do not wrap long lines - let them be displayed in very long horizontal lines
set nowrap
set nojoinspaces

"""" File formats and encodings
set encoding=utf-8
scriptencoding utf-8

"""" Key remappings
" use , as our leader
let mapleader="," 
" jk is escape
inoremap jk <esc>
" turn off search highlight - vim likes to keep searches highlighted even after the search has been closed sometimes, so this will unhighlight our search for us
nnoremap <leader><space> :nohlsearch<CR>

"""" Miscellaneous settings
" minimal automatic indenting for any file type
set autoindent 
" shows line numbers relative to your current line number
set relativenumber 
" show current line number in left-pane
set number 
set numberwidth=6
" show line and column in bottom right hand corner
set ruler 
" enable syntax processing
syntax on 
" turns tabs into spaces
set expandtab 
" shows last command in bottom right command bar
set showcmd 
" show matching parentheses, bracket, etc, when highlighting over one
set showmatch 
" when file has changed outside vim, automatically update it
set autoread
" enable the ability to read modelines from files
set modeline
" prevent vim from trying to analyze too much when files have extremely long single lines
set synmaxcol=500
" No whitespace in vimdiff
set diffopt+=iwhite 

"""" Search settings
" search as characters are entered, rather than when search is completed
set incsearch 
" highlight search matches
set hlsearch 
" ignore case by default when searching
set ignorecase 
" in conjunction with the above, only return smartcased items. e.g., if we search for 'The', we don't want lowercase 'the'
set smartcase 
" hide buffers rather than destroying them when editing new files
set hidden 

"""" Mouse settings
" enable usage of the mouse
set mouse=a 
" hide mouse cursor when characters are typed
set mousehide 

"""" UI settings
" always show status bar
set laststatus=2
" number of lines to show below your cursor while scrolling to new page
set scrolloff=2
" and the same, but horizontally
set sidescrolloff=2
" briefly show matching brace when one is added
set showmatch
" open new buffers below rather than above
set splitbelow
" enable 256 colors in terminal
set t_Co=256

set title
" make things FASTER
set ttyfast
" enable wild menu, which gives a command line completion menu
set wildmenu
set wildmode=longest:full,full
set wildignore=.hg,.svn,*~,*.png,*.jpg,*.gif,*.settings,Thumbs.db,*.min.js,*.swp,publish/*,intermediate/*,*.o,*.hi,Zend,vendor
set nolist
set listchars=nbsp:¬,extends:»,precedes:«,trail:•
"""" Colors
set background=dark
if exists('+termguicolors')
    set termguicolors
elseif exists('+guicolors')
    set guicolors
endif
