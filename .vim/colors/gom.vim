"--------------------------------------------------------------------
" Name Of File: gom.vim.
" Description: colorscheme, designed against VIM 7.4 GUI and console
" By: Graham O' Malley
" Contact: pissoff@noneofyobidness.com
" Credits: Slightly modified version of dw_cyan (adds console, pmenu)
" Last Change: Saturday, September 30, 2014.
" Installation: Drop this file in your $VIMRUNTIME/colors/ directory.
"--------------------------------------------------------------------

set background=dark
hi clear
if exists("syntax_on")
    syntax reset
endif
let g:colors_name="gom"

"--------------------------------------------------------------------

hi Boolean                                       ctermfg=Cyan
hi Boolean                                       guifg=#00ffff
hi Comment                        ctermbg=NONE   ctermfg=DarkGray   cterm=bold term=bold
hi Comment                        guibg=Black    guifg=DarkGray     gui=bold,italic term=bold
hi Constant                                      ctermfg=Cyan
hi Constant                                      guifg=#00ffff
hi Cursor                         ctermbg=Gray  ctermfg=White
hi Cursor                         guibg=#444444  guifg=#ffffff
hi CursorColumn                   ctermbg=DarkGray
hi CursorColumn                   guibg=#001111
hi CursorLine                     ctermbg=DarkGray
hi CursorLine                     guibg=#001818
hi DiffAdd                        ctermbg=DarkCyan  ctermfg=Cyan
hi DiffAdd                        guibg=#333333  guifg=#00ffff
hi DiffChange                     ctermbg=DarkCyan  ctermfg=Cyan
hi DiffChange                     guibg=#333333  guifg=#00ffff
hi DiffDelete                     ctermbg=DarkCyan  ctermfg=Cyan
hi DiffDelete                     guibg=#333333  guifg=#00ffff
hi DiffText                       ctermbg=DarkCyan  ctermfg=White
hi DiffText                       guibg=#333333  guifg=#ffffff
hi Directory                      ctermbg=Black  ctermfg=Cyan
hi Directory                      guibg=#000000  guifg=#00ffff
hi ErrorMsg                       ctermbg=White  ctermfg=Black
hi ErrorMsg                       guibg=#ffffff  guifg=#000000
hi FoldColumn                     ctermbg=DarkCyan  ctermfg=Red
hi FoldColumn                     guibg=#222222  guifg=#ff0000
hi Folded                         ctermbg=DarkCyan  ctermfg=Red
hi Folded                         guibg=#222222  guifg=#ff0000
hi Function                       ctermbg=Black  ctermfg=Cyan
hi Function                       guibg=#000000  guifg=#00ffff
hi Identifier                     ctermbg=Black  ctermfg=Cyan
hi Identifier                     guibg=#000000  guifg=#00cccc
hi IncSearch       gui=none       ctermbg=Cyan  ctermfg=Black
hi IncSearch       gui=none       guibg=#00bbbb  guifg=#000000
hi LineNr                         ctermbg=Black  ctermfg=DarkCyan
hi LineNr                         guibg=#000000  guifg=#008888
hi MatchParen      gui=none       ctermbg=DarkCyan  ctermfg=Cyan
hi MatchParen      gui=none       guibg=#222222  guifg=#00ffff
hi ModeMsg                        ctermbg=Black  ctermfg=Cyan
hi ModeMsg                        guibg=#000000  guifg=#00ffff
hi MoreMsg                        ctermbg=Black  ctermfg=Cyan
hi MoreMsg                        guibg=#000000  guifg=#00ffff
hi NonText                        ctermbg=Black  ctermfg=White
hi NonText                        guibg=#000000  guifg=#ffffff
hi Normal          gui=none       ctermbg=Black  ctermfg=LightGray
hi Normal          gui=none       guibg=#000000  guifg=#c0c0c0
hi Operator        gui=none                      ctermfg=Gray
hi Operator        gui=none                      guifg=#696969
hi Pmenu                          ctermbg=14     ctermfg=DarkGray      guibg=DarkGray
hi PmenuSbar                      ctermbg=248    guibg=DarkGray
hi PmenuSel                       ctermfg=Cyan      ctermbg=242     guibg=DarkGray guifg=DarkCyan
hi PmenuThumb                                                           cterm=reverse     gui=reverse
hi PreProc         gui=none                      ctermfg=White
hi PreProc         gui=none                      guifg=#ffffff
hi Question                                      ctermfg=Cyan
hi Question                                      guifg=#00ffff
hi Search          gui=none       ctermbg=Cyan  ctermfg=Black
hi Search          gui=none       guibg=#00ffff  guifg=#000000
hi SignColumn                     ctermbg=Black  ctermfg=White
hi SignColumn                     guibg=#111111  guifg=#ffffff
hi Special         gui=none       ctermbg=Black  ctermfg=White
hi Special         gui=none       guibg=#000000  guifg=#ffffff
hi SpecialKey                     ctermbg=Black  ctermfg=Cyan
hi SpecialKey                     guibg=#000000  guifg=#00ffff
hi Statement       gui=bold                      ctermfg=Cyan
hi Statement       gui=bold                      guifg=#00ffff
hi StatusLine      gui=none       ctermbg=Cyan  ctermfg=Black
hi StatusLine      gui=none       guibg=#00ffff  guifg=#000000
hi StatusLineNC    gui=none       ctermbg=Gray  ctermfg=Black
hi StatusLineNC    gui=none       guibg=#444444  guifg=#000000
hi String          gui=none                      ctermfg=Cyan
hi String          gui=none                      guifg=#00bbbb
hi TabLine         gui=none       ctermbg=Gray  ctermfg=Black
hi TabLine         gui=none       guibg=#444444  guifg=#000000
hi TabLineFill     gui=underline  ctermbg=Black  ctermfg=White
hi TabLineFill     gui=underline  guibg=#000000  guifg=#ffffff
hi TabLineSel      gui=none       ctermbg=DarkCyan  ctermfg=Black
hi TabLineSel      gui=none       guibg=#00aaaa  guifg=#000000
hi Title           gui=none                      ctermfg=Cyan
hi Title           gui=none                      guifg=#00ffff
hi Todo            gui=none       ctermbg=Black  ctermfg=Red
hi Todo            gui=none       guibg=#000000  guifg=#ff0000
hi Type            gui=none                      ctermfg=White
hi Type            gui=none                      guifg=#ffffff
hi VertSplit       gui=none       ctermbg=Black  ctermfg=White
hi VertSplit       gui=none       guibg=#000000  guifg=#ffffff
hi Visual                         ctermbg=Cyan  ctermfg=Black
hi Visual                         guibg=#00dddd  guifg=#000000
hi WarningMsg                     ctermbg=Gray  ctermfg=Black
hi WarningMsg                     guibg=#888888  guifg=#000000
hi cDefine                                       ctermfg=Cyan
hi cDefine                                       guifg=#00ffff
hi cInclude                                      ctermfg=White
hi cInclude                                      guifg=#ffffff
"- end of colorscheme -----------------------------------------------  


