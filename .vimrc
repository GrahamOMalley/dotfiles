
"*************************************************** VUNDLE Settings ***************************************************
set nocompatible
" get Vundle: $ git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle (required)
Bundle 'gmarik/vundle'

" original repos on github
Bundle 'GrahamOMalley/gom-pyclewn-view'
Bundle 'GrahamOMalley/vim-pudb'
Bundle 'MarcWeber/vim-addon-mw-utils'
Bundle 'Valloric/MatchTagAlways'
Bundle 'Valloric/YouCompleteMe'
Bundle 'benmills/vimux'
Bundle 'dbakker/vim-lint'
Bundle 'ervandew/supertab' 
Bundle 'garbas/vim-snipmate'
Bundle 'majutsushi/tagbar'
Bundle 'scrooloose/syntastic'
Bundle 'sjl/gundo.vim'
Bundle 'tmhedberg/SimpylFold'
Bundle 'tomtom/tlib_vim'
Bundle 'tpope/vim-fugitive'
Bundle 'pitluga/vimux-nose-test'
"Bundle 'vim-scripts/pydoc.vim'
"Bundle 'jalcine/cmake.vim'
"Bundle 'jabapyth/vim-debug'
"Bundle 'godlygeek/tabular'
"Bundle 'tpope/vim-surround' 
"Bundle 'maciakl/vim-neatstatus'
"Bundle 'guns/xterm-color-table.vim'


" vim-scripts repos
"Bundle 'bufexplorer.zip'
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
"set  ttimeoutlen=50
set  undolevels=5000                       "  use many muchos levels of undo
set  wildignore=*.swp,*.bak,*.pyc,*.class
set  wildmenu
set  wildmode=list:longest
"set shellcmdflag=-ic                       " give me my bash alias's! (currently this messes up several things like GDiff and seems to ctrl-z vim
set scrolloff=5

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

" force command-t to open new files in a new tab
let g:CommandTAcceptSelectionMap = '<C-t>'
let g:CommandTAcceptSelectionTabMap = '<CR>'

" don't turn on jedi (python) autocomplete by default (gets set in Python autocmd)
let g:jedi#auto_initialization = 0

" set some TagList properties
set tags+=~/.vim/tags/cpp.ctags
set tags=tags;/
let g:tagbar_left = 1
let g:tagbar_width = 50
let g:tagbar_show_visibility = 1

" Let Syntastic open an error window automatically 
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 0
let g:syntastic_quiet_messages = {'level': 'warnings'}
let g:syntastic_cpp_compiler = 'clang++'
let g:syntastic_cpp_compiler_options = ' -std=c++0x'

" was having some issues with YCM being very slow on cpp files in terminal vim
" over ssh, think this helps?
let g:ycm_allow_changing_updatetime = 0
" general YCM settings
let g:ycm_key_detailed_diagnostics = '<Leader>y'
let g:ycm_confirm_extra_conf = 0
let g:ycm_global_ycm_extra_conf = '/home/gom/.ycm_extra_conf.py'
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1

"Make YCM/Snipmate/Supertab/Syntastic play nice together
let g:ycm_register_as_syntastic_checker = 1
let g:ycm_key_list_select_completion = ['<C-TAB>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-S-TAB>', '<Up>']
let g:ycm_collect_identifiers_from_tags_files = 1
let g:SuperTabDefaultCompletionType = '<C-Tab>'


"*************************************************** GLOBAL KEYMAPS *********************************************
" ************ REMAPS FOR STANDARD THINGS ************

" set difficulty level: Hardcore ;)
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>

"if you remap : to ; you save a lot of keystrokes
nnoremap ; :
nnoremap : ;
"vnoremap ; :
"vnoremap : ;
xnoremap ; :
xnoremap : ;

" TAGLIST
nnoremap <F12> <Esc>:TagbarToggle<CR>

" go to home and end using capitalized directions
nnoremap H ^
nnoremap L $

"improve up/down movement on wrapped lines
nnoremap j gj
nnoremap k gk

" make arrow keys useful again
nnoremap <left>     <esc>:tabp<CR>
nnoremap <right>    <esc>:tabn<CR>

" :ht opens help in new tab
cnoremap <expr> ht getcmdtype() == ':' && empty(getcmdline()) ? 'tab h '     :'ht'

" :tn opens new tab
cnoremap <expr> tn getcmdtype() == ':' && empty(getcmdline()) ? 'tabnew '     :'tn'

" ************ TAKE ME TO YOUR ************

" enable space as custom shortcut map key
let mapleader = " "

"clear search highlight
noremap <silent><Leader>/ :nohls<CR>

" toggles
nnoremap <Leader>w :set wrap!<CR>
nnoremap <Leader>n :set number!<CR>
nnoremap <Leader>p :set paste!<CR>
nnoremap <Leader>u :GundoToggle<CR>
nnoremap <Leader>cr <esc>:set cursorline! <Bar> set cursorcolumn!<CR>

"set <space>f and <space>r to find and replace
nnoremap <Leader>r :%s/\<<C-r><C-w>\>//g<Left><Left>
nnoremap <Leader>f :g/<C-r><C-w><CR>

" fix indenting, don't move cursor
nnoremap <Leader>i mzgg=G`zzz

"call exuberant ctags externally to build tag list for all files in current dir
nnoremap <Leader><F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>

" show available snippets (if exists)
nnoremap <Leader>sp <Esc>:ToggleShowSnips<CR>
nnoremap <Leader>sc <Esc>:SyntasticCheck<CR>

" frequently edited files 
nnoremap <Leader>s :tabnew ~/.vimrc<CR>
nnoremap <Leader>sg :tabnew ~/.vim/bundle/gom-pyclewn-view/plugin/gom-pyclewn-view.vim<CR>
"nnoremap <Leader>sp :tabnew .proj<CR>
nnoremap <Leader>ss :source ~/.vimrc<CR>

" Vimux keymaps
" nnoremap <Leader>v (not sure what to do with this, probably best to set up
" vimux autocmds for unit testing depending on programming language?
nnoremap <Leader>vp :VimuxPromptCommand<CR>
nnoremap <Leader>vi :VimuxInspectRunner<CR>
nnoremap <Leader>vq :VimuxCloseRunner<CR>

" fuGitive keymaps
nnoremap <Leader>g <esc>:Git <CR>
nnoremap <Leader>gc <esc>:Git commit -a<CR>
nnoremap <Leader>gp <esc>:Git push<CR>
nnoremap <Leader>gs :Gstatus<CR><C-W>25+
nnoremap <Leader>gd <esc>:Gdiff<CR>

" something is overwriting my CommandT...
nnoremap <Leader>t <esc>:CommandT<CR>


"*************************************************** FUNCTIONS ***************************************************
"function to look for a template file of the appropriate type
function! LoadTemplate(extension)
    silent! :execute '0r ~/.vim/templates/'. a:extension. '.tpl'
    silent! execute 'source ~/.vim/templates/'.a:extension.'.patterns.tpl'
endfunction

" move around windows a bit easier
function! WinMove(key) 
    let t:curwin = winnr()
    exec "wincmd ".a:key
    if (t:curwin == winnr()) "we havent moved
        if (match(a:key,'[jk]')) "were we going up/down
            wincmd v
        else 
            wincmd s
        endif
        exec "wincmd ".a:key
    endif
endfunction

nnoremap <Leader>h :call WinMove('h')<CR>
nnoremap <Leader>k :call WinMove('k')<CR>
nnoremap <Leader>l :call WinMove('l')<CR>
nnoremap <Leader>j :call WinMove('j')<CR>

map <Leader>wc :wincmd q<cr>
map <Leader>wr <C-W>r

map <Leader>H :wincmd H<cr>
map <Leader>K :wincmd K<cr>
map <Leader>L :wincmd L<cr>
map <Leader>J :wincmd J<cr>




"*************************************************** AUTOCMDS ***************************************************

"********************************************** GLOBAL
autocmd BufNewFile,BufRead *conkyrc set filetype=conkyrc
autocmd BufNewFile * silent! call LoadTemplate('%:e')

" Start Taglist window on file open if any of these types (ignore if debugger view mode on)
autocmd VimEnter,TabEnter *.c,*.cc,*.cpp,*.h,*.cs execute "PyclewnToggleTagbar"

" for editing proto files
autocmd BufRead,BufNewFile *.proto setfiletype proto

augroup Tmux "{{{2
    au!
    autocmd VimEnter,BufNewFile,BufReadPost * call system('tmux rename-window "vim - ' . split(substitute(getcwd(), $HOME, '~', ''), '/')[-1] . '"')
    autocmd VimLeave * call system('tmux rename-window ' . split(substitute(getcwd(), $HOME, '~', ''), '/')[-1])
augroup END

"********************************************** PYTHON
augroup filetype_python
    autocmd!
    autocmd BufRead *.py set smartindent cinwords=if,elif,else,for,while,with,try,except,finally,def,class
    " use pydoc instead of man pages, TODO look into plugins for this
    autocmd BufNewFile,BufRead *.py set keywordprg=pydoc
    "jedi autocomplete
    autocmd BufRead *.py set omnifunc=jedi#complete
    autocmd BufRead *.py let g:jedi#auto_initialization = 1
    autocmd BufRead *.py let g:jedi#popup_on_dot = 0
    autocmd BufRead *.py let g:jedi#goto_command = "<Leader>jg"
    autocmd BufRead *.py let g:jedi#get_definition_command = "<Leader>jd"
    autocmd BufRead *.py let g:jedi#pydoc = "K"
    autocmd BufRead *.py let g:jedi#use_tabs_not_buffers = 1
    autocmd BufRead *.py let g:jedi#rename_command = "<Leader>R"
    autocmd BufRead *.py let g:jedi#related_names_command = "<Leader>n"
    autocmd BufRead *.py let g:jedi#auto_vim_configuration = 0
    "Debugging (with pudb)
    autocmd BufRead,BufNewFile *py nnoremap <F9> :TogglePudbBreakPoint<CR>
    autocmd BufRead,BufNewFile *py inoremap <F9> <ESC>:TogglePudbBreakPoint<CR>a
    autocmd BufRead,BufNewFile *py nnoremap <F2>              :exe "!pudb %"<CR>
    autocmd BufRead,BufNewFile *py nnoremap <F3>              :exe "!pudb % " <left><left>
augroup END

"********************************************** CPP
augroup filetype_cpp
    autocmd!
    autocmd BufRead,BufNewFile *.cpp,*.c,*.h,*.cc let g:SuperTabDefaultCompletionType = "<c-x><c-u>"
    autocmd BufRead,BufNewFile *.cpp,*.c,*.h,*.cc nnoremap <Leader>as         :exe "%!astyle --mode=c --style=ansi"<CR>
    " PyClewn
    autocmd BufRead,BufNewFile *.cpp,*.c,*.h,*.cc let g:pyclewn_args="--gdb=async"
    autocmd BufRead,BufNewFile *.cpp,*.c,*.h,*.cc let g:pyclewn_debug_view_type="cpp"
    autocmd BufRead,BufNewFile *.cpp,*.c,*.h,*.cc let g:pyclewn_locals_on=1
    autocmd BufRead,BufNewFile *.cpp,*.c,*.h,*.cc nnoremap <F2>              :exe "PyclewnDebugToggle"<CR>
    autocmd BufRead,BufNewFile *.cpp,*.c,*.h,*.cc nnoremap <F3>              :exe "Cfoldvar " . line(".")<CR>
    autocmd BufRead,BufNewFile *.cpp,*.c,*.h,*.cc nnoremap <F4>              :exe "CMake"<CR>
    autocmd BufRead,BufNewFile *.cpp,*.c,*.h,*.cc nnoremap <F5>              :exe "Crun"<CR>
    autocmd BufRead,BufNewFile *.cpp,*.c,*.h,*.cc nnoremap <F6>              :exe "PyclewnContinue"<CR>
    autocmd BufRead,BufNewFile *.cpp,*.c,*.h,*.cc nnoremap <F7>              :exe "Cprint " . expand("<cword>") <CR>
    autocmd BufRead,BufNewFile *.cpp,*.c,*.h,*.cc nnoremap <F9>              :exe "PyclewnBreakPointToggle"<CR>
    autocmd BufRead,BufNewFile *.cpp,*.c,*.h,*.cc nnoremap <F10>             :exe "PyclewnNext"<CR>
    autocmd BufRead,BufNewFile *.cpp,*.c,*.h,*.cc nnoremap <F11>             :exe "PyclewnStep"<CR>
    autocmd BufRead,BufNewFile *.cpp,*.c,*.h,*.cc nnoremap <Leader>dl        :exe "PyclewnLocalsToggle"<CR>
    autocmd BufRead,BufNewFile *.cpp,*.c,*.h,*.cc nnoremap <Leader>ds        :exe "Cbt"<CR>
    autocmd BufRead,BufNewFile *.cpp,*.c,*.h,*.cc nnoremap <Leader>df        :exe "Cframe"<CR>
    autocmd BufRead,BufNewFile *.cpp,*.c,*.h,*.cc nnoremap <Leader>dd        :Cdbg 
    autocmd BufRead,BufNewFile *.cpp,*.c,*.h,*.cc vnoremap <Leader>dv        y:Cdbg <C-R>"
    autocmd BufRead,BufNewFile *.cpp,*.c,*.h,*.cc nnoremap <Leader>dw        :exe "Cdbg " . expand("<cword>") <CR>
    autocmd BufRead,BufNewFile *.cpp,*.c,*.h,*.cc nnoremap <Leader>dp        :exe "Cprint " . expand("<cword>") <CR>
    " TODO Cdbg visual selection
augroup END
