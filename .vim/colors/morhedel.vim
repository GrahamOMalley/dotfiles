" Vim color file
" Maintainer:   connor berry <connorberry@yahoo.com>
" Last Change:  6 July 2007
" URL: www.narwhale.org

let transparency="true"
set background=dark     
hi clear
if exists("syntax_on")
    syntax reset
endif
let g:colors_name="morhedel"

hi   Boolean       ctermfg=Cyan      ctermbg=NONE
hi   Boolean       guifg=Cyan        guibg=Black
hi   Comment       ctermfg=DarkGrey  ctermbg=NONE          cterm=bold         term=bold
hi   Comment       guifg=DarkGrey    guibg=Black           gui=bold           term=bold
hi   Constant      ctermfg=DarkCyan  ctermbg=NONE
hi   Constant      guifg=DarkCyan    guibg=Black
hi   Cursor        ctermfg=Black     ctermbg=white
hi   Cursor        guifg=Black       guibg=white
hi   cursorline    ctermbg=NONE
hi   cursorline    guibg=DarkBlue
hi   Directory     guifg=#44ffff
hi   ErrorMsg      ctermfg=Red       ctermbg=NONE          cterm=bold         term=bold
hi   ErrorMsg      guifg=Red         guibg=Black           gui=bold           term=bold
hi   Folded        ctermfg=DarkCyan  ctermbg=NONE          cterm=underline    term=none
hi   Folded        guifg=DarkCyan    guibg=Black           gui=underline      term=none
hi   Identifier    ctermfg=White     ctermbg=NONE
hi   Identifier    guifg=White       guibg=Black
"hi  IncSearch     guibg=#000000     guifg=#bbcccc
hi   LineNr        term=bold         cterm=bold            ctermfg=DarkCyan   ctermbg=NONE
hi   LineNr        term=bold         gui=bold              guifg=White        guibg=DarkGray
hi   LineNr        term=bold         gui=bold              guifg=White        guibg=DarkGray
hi   NonText       ctermfg=DarkGray  ctermbg=NONE
hi   NonText       guifg=DarkGray    guibg=Black
hi   Normal        ctermfg=White     ctermbg=NONE
hi   Normal        guifg=White       guibg=Black
hi   Number        ctermfg=Cyan      ctermbg=NONE
hi   Number        guifg=Cyan        guibg=Black
hi   PreProc       ctermfg=Grey      ctermbg=NONE          cterm=bold         term=bold
hi   PreProc       guifg=Grey        guibg=Black           gui=bold           term=bold
hi   Scrollbar     ctermfg=DarkCyan  ctermbg=NONE
hi   Scrollbar     guifg=DarkCyan    guibg=Black
hi   Search        term=bold         cterm=bold            ctermfg=231        ctermbg=248     gui=bold       guifg=White     guibg=DarkGray
hi   Special       ctermfg=Grey      ctermbg=NONE
hi   Special       guifg=Grey        guibg=Black
hi   Statement     ctermfg=Cyan      ctermbg=NONE
hi   Statement     guifg=Cyan        guibg=Black
hi   StatusLineNC  term=bold         cterm=bold,underline  ctermfg=Gray       ctermbg=NONE
hi   StatusLineNC  term=bold         gui=bold,underline    guifg=Gray         guibg=Black
hi   StatusLine    term=bold         cterm=bold,underline  ctermfg=White      ctermbg=NONE
hi   StatusLine    term=bold         gui=bold,underline    guifg=White        guibg=Black
hi   String        ctermfg=Cyan      ctermbg=NONE
hi   String        guifg=Cyan        guibg=Black
hi   Title         term=bold         cterm=bold            ctermfg=231        gui=bold        guifg=#ffffff
hi   Todo          term=standout     ctermfg=226           ctermbg=124        guifg=#fff300   guibg=#aa0006
hi   Type          ctermfg=DarkCyan  ctermbg=NONE
hi   Type          guifg=DarkCyan    guibg=Black
hi   VertSplit     ctermfg=White     ctermbg=NONE
hi   VertSplit     guifg=White       guibg=Black
hi   Visual        ctermfg=White     ctermbg=DarkGray      term=none
hi   Visual        guifg=White       guibg=DarkGray        gui=underline      term=none
hi   WarningMsg    ctermfg=Red       ctermbg=NONE
hi   WarningMsg    guifg=Red         guibg=Black
hi   Pmenu         ctermbg=14        ctermfg=DarkGrey      guibg=Magenta
hi   PmenuSel      ctermbg=242       guibg=DarkGrey
hi   PmenuSbar     ctermbg=248       guibg=Grey
hi   PmenuThumb    cterm=reverse     gui=reverse
hi   DiffAdd       term=bold         ctermbg=Cyan           ctermfg=Black
hi   DiffChange    term=bold         ctermbg=NONE
hi   DiffDelete    term=reverse      cterm=bold            ctermbg=9          ctermfg=0 
hi   DiffText      term=reverse      cterm=bold            ctermbg=9          ctermfg=White 
hi   WildMenu      term=standout     ctermfg=0             ctermbg=11         guifg=Black     guibg=Yellow
