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

 " autocomplete for brackets, parens, etc.
Plug 'Raimondi/delimitMate'
" wraps args inside parens/brackets
Plug 'git@github.com:FooSoft/vim-argwrap.git'
" automatically insert a linebreak and tab-in after '{' char
" inoremap {<CR> {<CR>} <C-o>O
" syntax highlighting for markdown
Plug 'gabrielelana/vim-markdown'
" fixes focus events from within tmux
Plug 'tmux-plugins/vim-tmux-focus-events'
" asynchronous code linting
" Plug 'w0rp/ale'
" ALE indicators for lightline
Plug 'maximbaz/lightline-ale'
" support vim's modeline in a secure way
Plug 'ciaranm/securemodelines'
" bottom status bar
Plug 'itchyny/lightline.vim'
" elixir 
" Plug 'slashmili/alchemist.vim'
" Plug 'elixir-editors/vim-elixir'
" rust
Plug 'rust-lang/rust.vim'
" autocomplete
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" These settings are here because they were suggested by the coc README.
set updatetime=200
" Give more space for displaying messages.
set cmdheight=2
" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

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
" highlight yanked text
Plug 'machakann/vim-highlightedyank'
" facilitates smart vim split / tmux split navigation
Plug 'christoomey/vim-tmux-navigator'

" preview %s subsitutions as you type them
Plug 'osyo-manga/vim-over'

" language server support
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }

" makes f, F, t and T movements more informative and convenient
Plug 'rhysd/clever-f.vim'

" automatically adjusts 'shiftwidth' and 'expandtab' intelligently based on
" the existing indentation within the file or within the directory tree for
" like files
Plug 'tpope/vim-sleuth'

" The vim-surround plugin allows one to add, change or delete surrounding pairs.
Plug 'tpope/vim-surround'

" Deoplete
" if has('nvim')
"   Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" else
"   Plug 'Shougo/deoplete.nvim'
"   Plug 'roxma/nvim-yarp'
"   Plug 'roxma/vim-hug-neovim-rpc'
" endif
" let g:deoplete#enable_at_startup = 1

" if has('win32') || has('win64')
"   Plug 'tbodt/deoplete-tabnine', { 'do': 'powershell.exe .\install.ps1' }
" else
"   Plug 'tbodt/deoplete-tabnine', { 'do': './install.sh' }
" endif
" End Deoplete

call plug#end()

"""" Plugin settings

" netrw
" close if final buffer is netrw or the quickfix
augroup finalcountdown
 au!
 autocmd WinEnter * if winnr('$') == 1 && getbufvar(winbufnr(winnr()), "&filetype") == "netrw" || &buftype == 'quickfix' |q|endif
 " autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) || &buftype == 'quickfix' | q | endif
 " press hyphen to open netrw in current dir
 nmap - :Lexplore<cr>
 " nmap - :NERDTreeToggle<cr>
augroup END
" automatically kill phantom buffers created by netrw - https://github.com/tpope/vim-vinegar/issues/13
autocmd FileType netrw setl bufhidden=delete
" hide top banner
let g:netrw_banner = 0
" wide list style
let g:netrw_liststyle = 3
" vertical split
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 25

" duration yanked text remains highlighted
let g:highlightedyank_highlight_duration = 300
" clever-f
let g:clever_f_across_no_line = 1
let g:clever_f_fix_key_direction = 1
let g:clever_f_timeout_ms = 3000

" ALE settings
" Don't use the sign column/gutter for ALE
let g:ale_set_signs = 0

" Lint always in Normal Mode
let g:ale_lint_on_text_changed = 'normal'

" Lint when leaving Insert Mode but don't lint when in Insert Mode 
let g:ale_lint_on_insert_leave = 1

" Set ALE's 200ms delay to zero
let g:ale_lint_delay = 0

" Set gorgeous colors for marked lines to sane, readable combinations 
" working with any colorscheme
au VimEnter,BufEnter,ColorScheme *
  \ exec "hi! ALEInfoLine
    \ guifg=".(&background=='light'?'#808000':'#ffff00')."
    \ guibg=".(&background=='light'?'#ffff00':'#555500') |
  \ exec "hi! ALEWarningLine
    \ guifg=".(&background=='light'?'#808000':'#ffff00')."
    \ guibg=".(&background=='light'?'#ffff00':'#555500') |
  \ exec "hi! ALEErrorLine
    \ guifg=".(&background=='light'?'#ff0000':'#ff0000')."
    \ guibg=".(&background=='light'?'#ffcccc':'#550000')

" LSP settings
let g:LanguageClient_autoStart = 1

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
set tabstop=4
set shiftwidth=4
set softtabstop=4
" turns tabs into spaces
set expandtab 

"""" File formats and encodings
set encoding=utf-8
scriptencoding utf-8

"""" Key remappings
" jk is escape
inoremap jk <esc>

nnoremap ,at :-1read ~/projects/dotfiles/snippets/axtest<CR>9jf)hi
nnoremap ,wf :-1read ~/projects/dotfiles/snippets/axtest-wait-for<CR>j<TAB>
nnoremap ,aid :-1read ~/projects/dotfiles/snippets/axtest-accessible-element-by-id<CR>f"li

" ; as :
nnoremap ; :

" For the Argwrap plugin
nnoremap <silent> <leader>a :ArgWrap<CR>

" easier split navigation - instead of ctrl-w and then j, it's just ctrl-j
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" turn off search highlight - vim likes to keep searches highlighted even after the search has been closed sometimes, so this will unhighlight our search for us
nnoremap <leader><space> :nohlsearch<CR>

" Open hotkeys
map <C-p> :Files<CR>
nmap <leader>; :Buffers<CR>

" Quick-save
nmap <leader>w :w<CR>

" Quick replace
nnoremap <leader>r :OverCommandLine<CR> %s/<Paste>

" <leader>s for Rg search
noremap <leader>s :Rg 
let g:fzf_layout = { 'down': '~40%' }
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

"" Autocomplete key remappings
" use <tab> for trigger completion and navigate next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction
inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<C-j>"
inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<C-k>"
" use tab to confirm complete
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<cr>"
" close preview when completion is done
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif
"" End autocomplete key remappings

" make searches always appear in center of page
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz

"""" Autocommand

" Leave paste mode when leaving insert mode
autocmd InsertLeave * set nopaste

"""" Miscellaneous settings
" in popup menu, automatically select the first item in the menu, but do not
" insert it
set completeopt=menu,noinsert
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
" shows last command in bottom right command bar
set showcmd 
" show matching parentheses, bracket, etc, when highlighting over one
set showmatch 
" when file has changed outside vim, automatically update it
set autoread
" prevent vim from trying to analyze too much when files have extremely long single lines
set synmaxcol=500
" No whitespace in vimdiff
if &diff
    " This if-statement is necessary to fix an error: E474: Invalid argument: diffopt+=iwhite
    " https://www.micahsmith.com/blog/2019/11/fixing-vim-invalid-argument-diffopt-iwhite/
    set diffopt-=internal
    set diffopt+=iwhite
endif

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
hi Error ctermfg=203 ctermbg=234 guifg=#F44747 guibg=#1E1E1E
