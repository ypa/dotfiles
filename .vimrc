" ~/.vimrc
" Vundle configs and pulgins
set nocompatible              " be iMproved, required
filetype off                  " required
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" My plugins

Plugin 'hynek/vim-python-pep8-indent'

Plugin 'scrooloose/nerdtree' "File Tree
Plugin 'jistr/vim-nerdtree-tabs' " Use tabs for nerd tree
let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree
" autocmd vimenter * NERDTree " auto enter NERDTree

Plugin 'kien/ctrlp.vim' " Super Searching with CtrlP

Plugin 'airblade/vim-gitgutter' " Git edits in the gutter
let g:gitgutter_sign_column_always = 1 " show git gutter always

Plugin 'junegunn/goyo.vim' "Distraction free editing

Plugin 'godlygeek/tabular' " Dependency for vim-markdown (below), must come before it.
Plugin 'plasticboy/vim-markdown' "Markdown syntax hightlighting matching rules and mappings
let g:vim_markdown_folding_disabled=1 " disable folding

Plugin 'mattn/webapi-vim' "dependency for gist-vim
Plugin 'mattn/gist-vim' " uploading as Gists to github
let g:gist_detect_filetype = 1 " Detect file type from file name.
" Needed to do : % git config --global github.user ypa
" and had to enter password for the first time. The token gets stored in ~/.gist-vim file. 
" To revoke simply remove the file.

Plugin 'nvie/vim-flake8' "python checking / code-linting - this only check style, for more elaborate checking use syntastic.
Plugin 'scrooloose/syntastic' "python syntax checking


Plugin 'Shougo/neocomplete.vim' "autocomplete
let g:neocomplete#enable_at_startup = 1 " Enable on startup
let g:neocomplete#enable_smart_case = 1 " Use smartcase.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"



" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" end Vundle configs

"==============================================================================

" Remap jk as escape
inoremap jk <esc>
let mapleader=","     " leader is comma

" Color Scheme
if $COLORTERM == 'gnome-terminal'
  set t_Co=256
endif

" Fix color inside tmux not working properly.
if &term =~ '256color'
    " disable Background Color Erase (BCE) so that color schemes
    " render properly when inside 256-color tmux and GNU screen.
    " see also http://snk.tuxfamily.org/log/vim-256color-bce.html
    set t_ut=
endif
" Set colorscheme
colorscheme Tomorrow-Night-Eighties


" Ignore pyc pyo and swp files in file explorer.
let g:netrw_list_hide= '.*\.pyc$,.*\.pyo$,.*\.swp$'

" Split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
set splitbelow
set splitright

" Python indentation
au BufNewFile,BufRead *.py
    \ set tabstop=4 " number of visual spaces per TAB
    \ set softtabstop=4 " number of spaces in tab when edidting
    \ set shiftwidth=4
    \ set expandtab " tabs are spaces
    \ set autoindent
    \ set fileformat=unix

" JS, HTML and CSS indentation
au BufNewFile,BufRead *.js, *.html, *.css
    \ set tabstop=2
    \ set softtabstop=2
    \ set shiftwidth=2

" mark extra whitespace as bad, color it .
highlight BadWhitespace ctermbg=red 
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

"enable syntax highliting
syntax on 
let python_highlight_all=1 


" Other settings
set number " show line numbers
set showcmd " show command in bottom bar
set cursorline " highlight current line
set wildmenu " visual autocomplete for command menu
set showmatch " hightlight matching [{()}]
set encoding=utf-8 " utf encoding
set shell=/bin/bash
set colorcolumn=80 " show vertical rule


" Search 
set nohlsearch
set incsearch    " search as characters are entered
set hlsearch     " highlight meatches
" make searches case-sensitive only if they contain upper-case characters
set ignorecase smartcase
nnoremap <leader><space> :nohlsearch<CR>


" CtrlP
set runtimepath^=~/.vim/bundle/ctrlp.vim " load the plugin
let g:ctrlp_match_window = 'bottom,order:ttb' " order top to bottom
let g:ctrlp_switch_buffer = 0  " open files in new buffers
let g:ctrlp_working_path_mode = 0 "  Search from current directory instead of project root
nnoremap <leader>. :CtrlPTag<cr>  "  running :CtrlPTag will let you search through your tags file and jump to where tags are defined


" Backup files
set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set backupskip=/tmp/*,/private/tmp/*
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set writebackup


" Word wrap without line breaks
:set wrap
:set linebreak
:set nolist  " list disables linebreak


" syntastic settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': [],'passive_filetypes': [] }
nnoremap <C-w>E :SyntasticCheck<CR> :SyntasticToggleMode<CR>


" running python tests
nmap <leader>t :!python % <cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CUSTOM AUTOCMDS copied from
" https://github.com/garybernhardt/dotfiles/blob/master/.vimrc
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup vimrcEx
  " Clear all autocmds in the group
  autocmd!
  autocmd FileType text setlocal textwidth=78
  " Jump to last cursor position unless it's invalid or in an event handler
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  "for ruby, autoindent with two spaces, always expand tabs
  autocmd FileType ruby,haml,eruby,yaml,html,javascript,sass,cucumber set ai sw=2 sts=2 et
  autocmd FileType python set sw=4 sts=4 et

  autocmd! BufRead,BufNewFile *.sass setfiletype sass

  autocmd BufRead *.mkd  set ai formatoptions=tcroqn2 comments=n:&gt;
  autocmd BufRead *.markdown  set ai formatoptions=tcroqn2 comments=n:&gt;

  " Indent p tags
  " autocmd FileType html,eruby if g:html_indent_tags !~ '\\|p\>' | let g:html_indent_tags .= '\|p\|li\|dt\|dd' | endif

  " Don't syntax highlight markdown because it's often wrong
  autocmd! FileType mkd setlocal syn=off

  " Leave the return key alone when in command line windows, since it's used
  " to run commands there.
  autocmd! CmdwinEnter * :unmap <cr>
  autocmd! CmdwinLeave * :call MapCR()

  " *.md is markdown
  autocmd! BufNewFile,BufRead *.md setlocal ft=

  " indent slim two spaces, not four
  autocmd! FileType *.slim set sw=2 sts=2 et
augroup END
