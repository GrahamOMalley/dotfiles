
"*************************************************** VUNDLE Settings ***************************************************
set nocompatible
" get Vundle: $ git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle (required)
Bundle 'gmarik/vundle'

" original repos on github
Bundle 'Rip-Rip/clang_complete'
Bundle 'davidhalter/jedi-vim'
Bundle 'ervandew/supertab'
Bundle 'guns/xterm-color-table.vim'
Bundle 'msanders/snipmate.vim'
Bundle 'scrooloose/nerdcommenter'
Bundle 'scrooloose/syntastic'
Bundle 'sjl/gundo.vim'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-surround' 

" vim-scripts repos
Bundle 'bufexplorer.zip'
Bundle 'taglist.vim'

" non github repos
Bundle 'git://git.wincent.com/command-t.git'

filetype plugin indent on

"*************************************************** Generic Settings ***************************************************

set  ai
set  backspace=indent,eol,start
set  expandtab
set  hidden                                "  do not unload buffers
set  history=5000                          "  remember more commands and search history
set  hlsearch
set  ignorecase
set  incsearch
set  linebreak                                                                                
set  nobackup
set  nofoldenable
set  noswapfile
set  number
set  popt+=syntax:y                        "  Syntax when printing
set  pumheight=15                          "  smaller completion window
set  shiftwidth=4
set  shortmess=a
set  shortmess=atI
set  showcmd                               "  Show us the command we're typing in bottom right of screen
set  showfulltag                           "  Show full tags when doing search completion
set  showmatch                             "  Highlight matching parens
set  smartcase
set  softtabstop=4
set  tabstop=4
set  undolevels=5000                       "  use many muchos levels of undo
set  wildignore=*.swp,*.bak,*.pyc,*.class
set  wildmenu
set  wildmode=list:longest

"syntax highlighting and colourscheme
syntax on
colorscheme morhedel

" STATUS LINE
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\[HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]
set laststatus=2

" try to act like 256 color term
if (&term == 'xterm' || &term =~? '^screen')
    set t_Co=256
endif

"********************************************** PLUGIN VARS

" don't turn on jedi (python) autocomplete by default (gets set in Python autocmd)
let g:jedi#auto_initialization = 0

" set some TagList properties
set tags+=~/.vim/tags/cpp.ctags
set tags=tags;/
let Tlist_WinWidth = 50
let Tlist_Inc_Winwidth = 300
let Tlist_Exit_OnlyWindow = 1 

" Supertab should try to use User completion
let g:SuperTabDefaultCompletionType = "context"

" show clang errors in quickfix window
let g:clang_complete_copen = 1
"*************************************************** GLOBAL KEYMAPS *********************************************

" set difficulty level: Hardcore ;)
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>

"if you remap : to ; you save a lot of keystrokes doing :w :q etc
nnoremap ; :
nnoremap : ;
vnoremap ; :
vnoremap : ;

" enable comma as custom shortcut map key
let mapleader = ","

"set ,r to do a global search/replace on word under cursor
nnoremap <Leader>r :%s/\<<C-r><C-w>\>//g<Left><Left>

" TAGLIST
nnoremap <F12> <Esc>:Tlist<CR>

" CTAGS
"call exuberant ctags externally to build tag list for all files in current dir
nnoremap <Leader><F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>
"nnoremap <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
nnoremap <C-\> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>

"nnoremap ctrl-j to the jump key binding
nnoremap <c-j> /<+.\{-1,}+><cr>c/+>/e<cr>
inoremap <c-j> <ESC>/<+.\{-1,}+><cr>c/+>/e<cr>

" FREQUENTLY EDITED FILES
nnoremap <Leader>v :tabnew ~/.vimrc<CR>
nnoremap <Leader>vt :tabnew ~/.vim/.myvimtips<CR>
nnoremap <Leader>vs :source ~/.vimrc<CR>
nnoremap <Leader>vc :tabnew .clang_complete<CR>

" toggle wrap
nnoremap <leader>w :set wrap!<CR>

" go to home and end using capitalized directions
nnoremap H ^
nnoremap L $

"improve up/down movement on wrapped lines
nnoremap j gj
nnoremap k gk

"clear search highlight
noremap <silent><Leader>/ :nohls<CR>

" make arrow keys useful again
nnoremap <up>       <esc>:bp<CR>
nnoremap <down>     <esc>:bn<CR>
nnoremap <left>     <esc>:tabp<CR>
nnoremap <right>    <esc>:tabn<CR>

" :ht opens help in new tab
cnoremap <expr> ht getcmdtype() == ':' && empty(getcmdline()) ? 'tab h '     :'ht'

" fix indenting, don't move cursor
nnoremap <leader>i mzgg=G`zzz

" fuGitive keymaps
nnoremap <leader>g <esc>:Git 
nnoremap <leader>gc <esc>:Git commit -a
nnoremap <leader>gp <esc>:Git push -u origin master --force
nnoremap <leader>gs :Gstatus<CR><C-W>25+
"*************************************************** AUTOCMDS ***************************************************

"********************************************** GLOBAL
autocmd BufNewFile,BufRead *conkyrc set filetype=conkyrc

"function to look for a template file of the appropriate type
function! LoadTemplate(extension)
    silent! :execute '0r ~/.vim/templates/'. a:extension. '.tpl'
    silent! execute 'source ~/.vim/templates/'.a:extension.'.patterns.tpl'
endfunction

autocmd BufNewFile * silent! call LoadTemplate('%:e')


"func to load in the patterns for the filetype in the buffer
function! LoadPatterns(extension)
    silent! :execute 'source ~/.vim/templates/'.a:extension.'.patterns.tpl'
endfunction

:autocmd BufRead * silent! call LoadPatterns('%:e')

"********************************************** PYTHON
augroup filetype_python
    autocmd!
    autocmd BufRead *.py nnoremap <F5> :pyfile %<CR>
    autocmd BufRead *.py set smartindent cinwords=if,elif,else,for,while,with,try,except,finally,def,class
    "jedi autocomplete
    autocmd BufRead *.py let g:jedi#auto_initialization = 1
    autocmd BufRead *.py let g:jedi#goto_command = "<leader>g"
    autocmd BufRead *.py let g:jedi#get_definition_command = "<leader>d"
    autocmd BufRead *.py let g:jedi#pydoc = "K"
    autocmd BufRead *.py let g:jedi#use_tabs_not_buffers = 1
    autocmd BufRead *.py let g:jedi#rename_command = "<leader>R"
    autocmd BufRead *.py let g:jedi#related_names_command = "<leader>n"
    "TODO PyClewn Debugging
augroup END

"********************************************** CPP
augroup filetype_cpp
    autocmd!
    autocmd BufRead,BufNewFile *.cpp,*.c,*.h,*.cc nnoremap <F4> :exe "!make"<CR>
    " PyClewn
    autocmd BufRead,BufNewFile *.cpp,*.c,*.h,*.cc nnoremap <F2> :exe "Pyclewn"<CR> 
    autocmd BufRead,BufNewFile *.cpp,*.c,*.h,*.cc nnoremap <F5> :exe "Crun"<CR>
    autocmd BufRead,BufNewFile *.cpp,*.c,*.h,*.cc nnoremap <F6> :exe "Ccontinue"<CR>
    autocmd BufRead,BufNewFile *.cpp,*.c,*.h,*.cc nnoremap <F7> :exe "Cfile "
    autocmd BufRead,BufNewFile *.cpp,*.c,*.h,*.cc nnoremap <F8> :exe "Cprint " . expand("<cword>") <CR>
    autocmd BufRead,BufNewFile *.cpp,*.c,*.h,*.cc nnoremap <F9> :exe "Cbreak " . expand("%:p") . ":" . line(".")<CR>
    autocmd BufRead,BufNewFile *.cpp,*.c,*.h,*.cc nnoremap <F10> :exe "Cnext "<CR>
    autocmd BufRead,BufNewFile *.cpp,*.c,*.h,*.cc let g:SuperTabDefaultCompletionType = "<c-x><c-u>"
augroup END

"*************************************************** FUNCTIONS ***************************************************

" dump the output of some command (:map) into a new tab
function! TabMessage(cmd)
    redir => message
    silent execute a:cmd
    redir END
    tabnew
    silent put=message
    set nomodified
endfunction
command! -nargs=+ -complete=command TabMessage call TabMessage(<q-args>)
