""" Startup
" disable compatibility with old terminals to get shiny vim improvements
set nocompatible
" use space as our leader
let mapleader="\<Space>" 

"""" Plugins
" install vim plugged if it doesn't already exist
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

if has('unix') || has('macunix')
    call plug#begin('~/.vim/bundle')
elseif has('win32') || has('win32unix') || has('win64')
    call plug#begin('~/vimfiles/bundle')
endif

" asynchronous code linting
Plug 'w0rp/ale'
" ALE indicators for lightline
Plug 'maximbaz/lightline-ale'
" support vim's modeline in a secure way
Plug 'ciaranm/securemodelines'
" bottom status bar
Plug 'itchyny/lightline.vim'
" elixir 
Plug 'slashmili/alchemist.vim'
Plug 'elixir-editors/vim-elixir'
" completion engine
Plug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install()}}
" color scheme
Plug 'tomasiser/vim-code-dark'
" plugin for git
Plug 'tpope/vim-fugitive'
" adds comment operator - gc/gcc
Plug 'tpope/vim-commentary'
" better syntax highlighting
Plug 'sheerun/vim-polyglot'
" allows vim to identify project roots from known files such as .git
Plug 'airblade/vim-rooter'
" fzf
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" change cursor shape in different modes, improved mouse support, focus
" reporting, paste in any mode
Plug 'wincent/terminus'

call plug#end()

"""" Plugin settings
let g:secure_modelines_allowed_items = [
                \ "textwidth",   "tw",
                \ "softtabstop", "sts",
                \ "tabstop",     "ts",
                \ "shiftwidth",  "sw",
                \ "expandtab",   "et",   "noexpandtab", "noet",
                \ "filetype",    "ft",
                \ "foldmethod",  "fdm",
                \ "readonly",    "ro",   "noreadonly", "noro",
                \ "rightleft",   "rl",   "norightleft", "norl",
                \ "colorcolumn"
                \ ]

" don't show -- INSERT --, pointless as we have lightline 
set noshowmode
" Initialize lightline config
let g:lightline = {}

" Disable lightline's tab bar
let g:lightline.enable = {'tabline': 0}

" Add lightline-ale components to lightline
let g:lightline.component_expand = {
\  'linter_checking': 'lightline#ale#checking',
\  'linter_warnings': 'lightline#ale#warnings',
\  'linter_errors': 'lightline#ale#errors',
\  'linter_ok': 'lightline#ale#ok',
\  'gitbranch': 'fugitive#head'
\ }

" Set colours for the components
let g:lightline.component_type = {
\  'linter_checking': 'left',
\  'linter_warnings': 'warning',
\  'linter_errors': 'error',
\  'linter_ok': 'left'
\ }

" Configure lightline's statusbar
let g:lightline.active = {
\  'left': [[ 'mode', 'paste'], ['gitbranch', 'readonly', 'relativepath', 'modified']],
\  'right': [
\    ['lineinfo'],
\    ['percent'],
\    ['fileformat', 'fileencoding', 'filetype'],
\	   ['linter_checking', 'linter_errors', 'linter_warnings', 'linter_ok']
\  ]
\ }
" let g:lightline = {
"       \ 'colorscheme': 'wombat',
"       \ 'active': {
"       \   'left': [ [ 'mode', 'paste' ],
"       \             [ 'gitbranch', 'readonly', 'relativepath', 'modified' ] ]
"       \ },
"       \ 'component_function': {
"       \   'gitbranch': 'fugitive#head'
"       \ },
"       \ }

" function! LightlineFilename()
"   return expand('%:t') !=# '' ? @% : '[No Name]'
" endfunction

if executable('rg')
	set grepprg=rg\ --no-heading\ --vimgrep
	set grepformat=%f:%l:%c:%m
endif

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
" use 4 spaces to represent tab
set tabstop=2
set softtabstop=2
" number of spaces to use for auto indent
set shiftwidth=2

"""" File formats and encodings
set encoding=utf-8
scriptencoding utf-8

"""" Key remappings
" jk is escape
inoremap jk <esc>

" ; as :
nnoremap ; :

" turn off search highlight - vim likes to keep searches highlighted even after the search has been closed sometimes, so this will unhighlight our search for us
nnoremap <leader><space> :nohlsearch<CR>

" Open hotkeys
map <C-p> :Files<CR>
nmap <leader>; :Buffers<CR>

" Quick-save
nmap <leader>w :w<CR>

" <leader>s for Rg search
noremap <leader>s :Rg
let g:fzf_layout = { 'down': '~20%' }
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

function! s:list_cmd()
  let base = fnamemodify(expand('%'), ':h:.:S')
  return base == '.' ? 'fd --type file --follow' : printf('fd --type file --follow | proximity-sort %s', expand('%'))
endfunction

command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, {'source': s:list_cmd(),
  \                               'options': '--tiebreak=index'}, <bang>0)

"" COC key remappings
" use <tab> for trigger completion and navigate next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
" allow <S-Tab> to navigate coc completions backwards
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" use enter to confirm complete
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<cr>"
" close preview when completion is done
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif
"" End COC key remappings

" make searches always appear in center of page
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz

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
if !has('gui_running')
  set t_Co=256
endif
" render a vertical column at 120 characters
set colorcolumn=120
highlight ColorColumn ctermbg=232

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
colorscheme codedark
