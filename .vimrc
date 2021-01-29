" Use Vim settings, rather than Vi settings
set nocompatible

" Set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" {{{ Plugins
Plugin 'VundleVim/Vundle.vim'
Plugin 'dense-analysis/ale'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-unimpaired'
Plugin 'tpope/vim-abolish'
Plugin 'jiangmiao/auto-pairs'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'scrooloose/nerdcommenter'
Plugin 'ervandew/supertab'
Plugin 'Yggdroot/indentLine'
Plugin 'ludovicchabant/vim-gutentags'
Plugin 'morhetz/gruvbox'
Plugin 'jeetsukumaran/vim-pythonsense'
" Plugin 'SirVer/ultisnips'
" Plugin 'honza/vim-snippets' " Add snippets
Plugin 'kien/ctrlp.vim'
Plugin 'rhysd/conflict-marker.vim'

call vundle#end()

" }}}
" Other {{{

" leader is comma
let mapleader=","

"  a comment line at the end of a document which gives the settings for
"  vim to use
set modelines=1

set encoding=utf-8

" open vimrc from any vim buffer
nnoremap <Leader>ev :vsplit $MYVIMRC<cr>
nnoremap <Leader>sv :source $MYVIMRC<cr>

" can access your system clipboard
set clipboard=unnamed


" }}}
" Colors {{{

" set t_Co=256
set background=dark
colorscheme gruvbox
syntax on

" overwrite colorscheme
" hi Search       cterm=NONE ctermfg=white     ctermbg=blue
" hi Pmenu        cterm=none ctermfg=0     ctermbg=15
" hi PmenuSel     cterm=none ctermfg=15     ctermbg=12
" hi PmenuSbar    cterm=none ctermfg=none      ctermbg=Green
" hi PmenuThumb   cterm=none ctermfg=DarkGreen ctermbg=DarkGreen
" hi Folded       cterm=none ctermfg=150       ctermbg=233
" hi LineNr       ctermfg=39
" hi MatchParen   cterm=none ctermbg=164       ctermfg=15

" }}}
" Moving {{{

" navigate splits with hjkl
noremap <Leader>h <C-W>h
noremap <Leader>j <C-W>j
noremap <Leader>k <C-W>k
noremap <Leader>l <C-W>l

" Adjust splits to the same size
noremap <Leader>= <C-w>=
" makes jj leave insert mode (like Esc)
inoremap jj <Esc>

" Search mappings: These will make it so that going to the next one in a
"  search will center on the line it's found in.
noremap N Nzz
noremap n nzz

" }}}
" Editing {{{

" Shortcut for replacing throughout file
nnoremap <Leader>s :%s/\<<C-r><C-w>\>//g<Left><Left>
" Shortcut for highlighting word under cursor
nnoremap <leader>* :execute '/' . expand('<cWORD>')<CR>

" Get current directory's path using %%, can be used in commands too
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

" Set shell=/home/gcaria/usr/local/bin/zsh

nmap <leader>w :w<cr>
nmap <leader>q :q<cr>
nmap <leader>x :x<cr>

" Hide files instead of closing them when opening a new file
" and the current buffer has unsaved changes 
" set hidden

" Wrap lines
set wrap
set textwidth=79

" Toggle paste mode automatically
let &t_SI .= "\<Esc>[?2004h"
let &t_EI .= "\<Esc>[?2004l"

inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()

function! XTermPasteBegin()
  set pastetoggle=<Esc>[201~
  set paste
  return ""
endfunction

" Restore cursor position to where it was before
augroup JumpCursorOnEdit
   au!
   autocmd BufReadPost *
            \ if expand("<afile>:p:h") !=? $TEMP |
            \   if line("'\"") > 1 && line("'\"") <= line("$") |
            \     let JumpCursorOnEdit_foo = line("'\"") |
            \     let b:doopenfold = 1 |
            \     if (foldlevel(JumpCursorOnEdit_foo) > foldlevel(JumpCursorOnEdit_foo - 1)) |
            \        let JumpCursorOnEdit_foo = JumpCursorOnEdit_foo - 1 |
            \        let b:doopenfold = 2 |
            \     endif |
            \     exe JumpCursorOnEdit_foo |
            \   endif |
            \ endif
   " Need to postpone using "zv" until after reading the modelines.
   autocmd BufWinEnter *
            \ if exists("b:doopenfold") |
            \   exe "normal zv" |
            \   if(b:doopenfold > 1) |
            \       exe  "+".1 |
            \   endif |
            \   unlet b:doopenfold |
            \ endif
augroup END

" }}}
" User interface {{{

" let vim set the title of the terminal window
set title

" puts number on the left of each line
set number

" turn hybrid line numbers on
set number relativenumber

" can use mouse, doesn't copy line numbers when copying line
set mouse=a

" shows what you are typing as a command
set showcmd

" backspace should work better ?
set backspace=indent,eol,start

" Height of the command bar
set cmdheight=2

" Always display the current cursor position in the lower right corner of the Vim window
set ruler

" prevents some commands to go to first character of line
set nostartofline

 " highlight current line
set cursorline

" only enable cursorline in the active buffer
augroup CursorLine
  autocmd!
  autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  autocmd WinLeave * setlocal nocursorline
augroup END

" visual bell for mistakes
" set visualbell

" Always display the status line, even if only one window is displayed
set laststatus=2

" visual autocomplete for command menu
set wildmenu
set wildmode=longest,list,full

" redraw only when we need to.
set lazyredraw

" fix for 'redrawtime' exceeded syntax highlighting disabled
set redrawtime=10000

set list lcs=trail:·,tab:»·

" map :w to :W
cnoreabbrev <expr> W ((getcmdtype() is# ':' && getcmdline() is# 'W')?('w'):('W'))
cnoreabbrev <expr> Wq ((getcmdtype() is# ':' && getcmdline() is# 'Wq')?('wq'):('Wq'))
cnoreabbrev <expr> Wqa ((getcmdtype() is# ':' && getcmdline() is# 'Wqa')?('wqa'):('Wqa'))

" }}}
" Searching {{{

" when looping through search results, put it in the 
" middle of the screen
nnoremap n nzz
nnoremap N Nzz

" Search down into subdirectories
" Provides tab-completion for all file-related tasks
set path+=**

" Display the match for a search pattern when halfway typing it.
set incsearch

" Ignore case when searching
 set ignorecase

" If our pattern is all lowercase, the search will be case insensitive. 
" as soon as we include an uppercase letter, the search becomes case sensitive.
set smartcase

" turn off search highlight when pressing ,<space>
set hlsearch
nnoremap <leader><space> :nohlsearch<CR>

" increase number of commands stored in history
set history=200

" }}}
" Folding {{{

" enable folding
set foldenable      

" open most folds by default
set foldlevelstart=0 

" 10 nested fold max
set foldnestmax=10  

" fold based on indent level
set foldmethod=marker

" Map space to za for opening and closing folds
nnoremap <Space> za
" }}}
" Indenting {{{ 

" set autoindent

" Enable file type detection
filetype plugin indent on

" set cindent
" set cinkeys-=0#
" set indentkeys-=0#

let g:indentLine_char = '┊'

au BufNewFile,BufRead *.py
    \ set tabstop=4 " Number of spaces a tab counts for
    \ set tabstop=4 " the number of spaces a tab counts for when editing
    \ set softtabstop=4 " Number of spaces used for (auto)indent
    \ set shiftwidth=4 " turns <TAB>s into spaces
    \ set expandtab

" visualize indenting
" set cursorcolumn
" set cursorline

" special number of spaces per tab for c++ files
" autocmd FileType cpp setlocal shiftwidth=2 tabstop=2

" }}}
" {{{ Tabs (windows)
" not really useful because can use gt and gT
map <C-t><up> :tabr<cr>
map <C-t><down> :tabl<cr>
map <C-t><left> :tabp<cr>
map <C-t><right> :tabn<cr>

" abbreviation
ca tn tabnew
ca tc tabclose
" }}}
" {{{ Comments
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
" }}}
" {{{ Tags

set tags=/home/gcaria/neuro-clouds/.git/tags;
set notagrelative

" Open the definition in a new tab
map <A-]> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
" Open the definition in a vertical split
map <C-\> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>

" }}}
" {{{ Plugins settings

" ========== Airline
let g:airline_theme='deus'

" ========== Ale
" let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 1
let g:ale_lint_on_enter = 0
let g:ale_lint_on_save = 1
let g:ale_fix_on_save = 1
let g:ale_linters = {'python': ['flake8', 'pylint']}
let g:ale_fixers = {'python': ['autopep8', 'black', 'isort']}

nmap <silent> <leader>aj :ALENext<cr>
nmap <silent> <leader>ak :ALEPrevious<cr>

" hi ALEWarningSign ctermbg=none ctermfg=220
hi ALEErrorSign   ctermbg=255 ctermfg=196
" hi ALEWarning     ctermbg=220
" hi ALEError       ctermbg=DarkMagenta
" hi SignColumn     ctermbg=none

" =========== UltiSnips
let g:UltiSnipsExpandTrigger="<c-a>"
let g:UltiSnipsJumpForwardTrigger="<c-s>"
let g:UltiSnipsJumpBackwardTrigger="<c-d>"
"
" let g:UltiSnipsSnippetDirectories=['/imports/home/gcaria/.vim/bundle/vim-snippets/UltiSnips','UltiSnips']

" ========== Conflict Marker
" disable the default highlight group
let g:conflict_marker_highlight_group = ''

" Include text after begin and end markers
let g:conflict_marker_begin = '^<<<<<<< .*$'
let g:conflict_marker_end   = '^>>>>>>> .*$'

highlight ConflictMarkerBegin ctermbg=37
highlight ConflictMarkerOurs ctermbg=37
highlight ConflictMarkerTheirs ctermbg=27
highlight ConflictMarkerEnd ctermbg=27
highlight ConflictMarkerCommonAncestorsHunk ctermbg=169

" =========== NerdCommenter 
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1
" Set a language to use its alternate delimiters by default
let g:NERDAltDelims_java = 1
" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1
" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

" ============ Gutentags 

" avoid addinf the tags and tags.lock file to the .gitignore file every single project
let g:gutentags_cache_dir = expand('~/.cache/vim/ctags/')

let g:gutentags_generate_on_new = 1
let g:gutentags_generate_on_missing = 1
let g:gutentags_generate_on_write = 1
let g:gutentags_generate_on_empty_buffer = 0

" let Gutentags generate more info for the tags
let g:gutentags_ctags_extra_args = [
      \ '--tag-relative=yes',
      \ '--fields=+ailmnS',
      \ ]

let g:gutentags_ctags_exclude = [
      \ '*.git', '*.svg', '*.hg',
      \ '*/tests/*',
      \ 'build',
      \ 'dist',
      \ '*sites/*/files/*',
      \ 'bin',
      \ 'docs',
      \ 'example',
      \ '*.zip',
      \ '*.pyc',
      \ '*.tmp',
      \ '*.cache',
      \ 'tags*',
      \ '*.bmp', '*.gif', '*.ico', '*.jpg', '*.png',
      \ '*.rar', '*.zip', '*.tar', '*.tar.gz', '*.tar.xz', '*.tar.bz2',
      \ '*.pdf', '*.doc', '*.docx', '*.ppt', '*.pptx',
      \ ]

" }}}

" vim:foldmethod=marker:foldlevel=0
