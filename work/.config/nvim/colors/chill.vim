" Name:         Chill
" Description:  this theme is only for chill people that praise the lord
" Author:       Daffy Hellman <daffy@fatsolutions.xyz>
" Maintainer:   Daffy Hellman <daffy@fatsolutions.xyz>
" Website:      https://daffy.tech
" License:      fat fuck licence to fuck
" Last Updated: Thu Feb 20 2025

 Clear highlights

highlight clear
if exists("syntax_on")
    syntax reset
endif

let g:colors_name = "chill"

hi Normal       guifg=#ffbafe guibg=none
hi NonText      guibg=none
hi LineNr       guifg=#a94ec2
hi CursorLine   guibg=#ffa3d1
hi Visual       guibg=#ffffbb
hi Comment      guifg=#d689c0 gui=italic
hi String       guifg=#00cc8b
hi Function     guifg=#ff33b4
hi Keyword      guifg=#dd00ff
hi Number       guifg=#ff87d9
hi Identifier   guifg=#00c9ab "ff00ae
hi Statement    guifg=#ff0080
hi Operator     guifg=#ffa3d1
hi Special      guifg=#ffa3d1
hi PreProc      guifg=#ffa3d1
hi Type         guifg=#00ff00 "ff3884
hi Constant     guifg=#ffa3d1 guibg=#610030

hi MatchParen   guifg=#ffa3d1 guibg=#610030

" Treesitter memes ???
"
"hi TSParameter  guifg=#00c9ab gui=italic
"hi TSField      guifg=#123123
"hi TSNamespace  guifg=#123123


" stuff I copied from some theme I like on nvim idk

"hi! link CursorColumn CursorLine
"hi! link StatusLineTerm StatusLine
"hi! link StatusLineTermNC StatusLineNC
"hi! link VisualNOS Visual
"hi! link Tag Special
"hi! link lCursor Cursor
"hi! link MessageWindow PMenu
"hi! link PopupNotification Todo
"hi! link CurSearch Search
"
"hi Normal ctermfg=gray ctermbg=Black cterm=NONE
"hi ColorColumn ctermfg=Black ctermbg=gray cterm=NONE
"hi Comment ctermfg=gray ctermbg=NONE cterm=bold
"hi CursorLine ctermfg=NONE ctermbg=NONE cterm=underline
"hi CursorLineNr ctermfg=Yellow ctermbg=NONE cterm=NONE
"hi Error ctermfg=Red ctermbg=Black cterm=reverse
"hi ErrorMsg ctermfg=Black ctermbg=Red cterm=NONE
"hi FoldColumn ctermfg=gray ctermbg=NONE cterm=NONE
"hi Folded ctermfg=gray ctermbg=NONE cterm=NONE
"hi LineNr ctermfg=gray ctermbg=NONE cterm=NONE
"hi MatchParen ctermfg=gray ctermbg=NONE cterm=bold,underline
"hi NonText ctermfg=gray ctermbg=NONE cterm=NONE
"hi Pmenu ctermfg=DarkGray ctermbg=White cterm=NONE
"hi PmenuSbar ctermfg=NONE ctermbg=DarkGray cterm=NONE
"hi PmenuSel ctermfg=Black ctermbg=Blue cterm=NONE
"hi PmenuThumb ctermfg=NONE ctermbg=Blue cterm=NONE
"hi PmenuKind ctermfg=Red ctermbg=White cterm=NONE
"hi PmenuKindSel ctermfg=Red ctermbg=Blue cterm=NONE
"hi PmenuExtra ctermfg=DarkGray ctermbg=White cterm=NONE
"hi PmenuExtraSel ctermfg=DarkGray ctermbg=Blue cterm=NONE
"hi SignColumn ctermfg=gray ctermbg=NONE cterm=NONE
"hi SpecialKey ctermfg=gray ctermbg=NONE cterm=NONE
"hi StatusLine ctermfg=gray ctermbg=Black cterm=bold,reverse
"hi StatusLineNC ctermfg=gray ctermbg=Black cterm=reverse
"hi TabLine ctermfg=Black ctermbg=gray cterm=NONE
"hi TabLineFill ctermfg=Black ctermbg=gray cterm=NONE
"hi TabLineSel ctermfg=gray ctermbg=Black cterm=NONE
"hi ToolbarButton ctermfg=Black ctermbg=gray cterm=bold
"hi ToolbarLine ctermfg=NONE ctermbg=NONE cterm=NONE
"hi VertSplit ctermfg=Black ctermbg=gray cterm=NONE
"hi Visual ctermfg=Black ctermbg=Blue cterm=NONE
"hi WildMenu ctermfg=Blue ctermbg=DarkGray cterm=bold
"hi EndOfBuffer ctermfg=NONE ctermbg=NONE cterm=NONE
"hi Conceal ctermfg=Blue ctermbg=NONE cterm=NONE
"hi Cursor ctermfg=Black ctermbg=White cterm=NONE
"hi DiffAdd ctermfg=Green ctermbg=Black cterm=reverse
"hi DiffChange ctermfg=Cyan ctermbg=Black cterm=reverse
"hi DiffDelete ctermfg=Red ctermbg=Black cterm=reverse
"hi DiffText ctermfg=Yellow ctermbg=Black cterm=reverse
"hi Directory ctermfg=Green ctermbg=NONE cterm=bold
"hi IncSearch ctermfg=Magenta ctermbg=Black cterm=reverse
"hi ModeMsg ctermfg=Yellow ctermbg=NONE cterm=bold
"hi MoreMsg ctermfg=Yellow ctermbg=NONE cterm=bold
"hi Question ctermfg=Magenta ctermbg=NONE cterm=bold
"hi Search ctermfg=DarkGreen ctermbg=Black cterm=reverse
"hi QuickFixLine ctermfg=Cyan ctermbg=Black cterm=reverse
"hi SpellBad ctermfg=Red ctermbg=NONE cterm=underline
"hi SpellCap ctermfg=Blue ctermbg=NONE cterm=underline
"hi SpellLocal ctermfg=Cyan ctermbg=NONE cterm=underline
"hi SpellRare ctermfg=Magenta ctermbg=NONE cterm=underline
"hi Title ctermfg=Green ctermbg=NONE cterm=bold
"hi WarningMsg ctermfg=Red ctermbg=NONE cterm=bold
"hi Boolean ctermfg=Magenta ctermbg=NONE cterm=NONE
"hi Character ctermfg=Magenta ctermbg=NONE cterm=NONE
"hi Conditional ctermfg=Red ctermbg=NONE cterm=NONE
"hi Constant ctermfg=Magenta ctermbg=NONE cterm=NONE
"hi Define ctermfg=Cyan ctermbg=NONE cterm=NONE
"hi Debug ctermfg=Red ctermbg=NONE cterm=NONE
"hi Delimiter ctermfg=Magenta ctermbg=NONE cterm=NONE
"hi Error ctermfg=Red ctermbg=Black cterm=bold,reverse
"hi Exception ctermfg=Red ctermbg=NONE cterm=NONE
"hi Float ctermfg=Magenta ctermbg=NONE cterm=NONE
"hi Function ctermfg=Green ctermbg=NONE cterm=bold
"hi Identifier ctermfg=Blue ctermbg=NONE cterm=NONE
"hi Ignore ctermfg=fg ctermbg=NONE cterm=NONE
"hi Include ctermfg=Cyan ctermbg=NONE cterm=NONE
"hi Keyword ctermfg=Red ctermbg=NONE cterm=NONE
"hi Label ctermfg=Red ctermbg=NONE cterm=NONE
"hi Macro ctermfg=Cyan ctermbg=NONE cterm=NONE
"hi Number ctermfg=Magenta ctermbg=NONE cterm=NONE
"hi Operator ctermfg=Cyan ctermbg=NONE cterm=NONE
"hi PreCondit ctermfg=Cyan ctermbg=NONE cterm=NONE
"hi PreProc ctermfg=Cyan ctermbg=NONE cterm=NONE
"hi Repeat ctermfg=Red ctermbg=NONE cterm=NONE
"hi SpecialChar ctermfg=Red ctermbg=NONE cterm=NONE
"hi SpecialComment ctermfg=Red ctermbg=NONE cterm=NONE
"hi Statement ctermfg=Red ctermbg=NONE cterm=NONE
"hi StorageClass ctermfg=Magenta ctermbg=NONE cterm=NONE
"hi Special ctermfg=Magenta ctermbg=NONE cterm=NONE
"hi String ctermfg=Green ctermbg=NONE cterm=NONE
"hi Structure ctermfg=Cyan ctermbg=NONE cterm=NONE
"hi Todo ctermfg=fg ctermbg=Black cterm=bold
"hi Type ctermfg=Yellow ctermbg=NONE cterm=NONE
"hi Typedef ctermfg=Yellow ctermbg=NONE cterm=NONE
"hi Underlined ctermfg=Blue ctermbg=NONE cterm=underline
"hi CursorIM ctermfg=Black ctermbg=White cterm=NONE

" Color: neutralred              #cc241d        160            DarkRed
" Color: neutralgreen            #98971a        100            DarkGreen
" Color: neutralyellow           #d79921        172            DarkYellow
" Color: neutralblue             #458588        66             DarkBlue
" Color: neutralpurple           #b16286        132            DarkMagenta
" Color: neutralaqua             #689d6a        71             DarkCyan
" Color: neutralorange           #d65d0e        166            LightRed
" Background: dark
" Color: bg0                     #1c1c1c        234            Black
" Color: bg1                     #3c3836        237            DarkGray
" Color: bg2                     #504945        239            DarkGray
" Color: bg3                     #303030        236
" Color: bg4                     #7c6f64        243
" Color: bg5                     #000000        16             DarkGray
" Color: bg6                     #121212        233            DarkGray
" Color: fg0                     #fbf1c7        230            White
" Color: fg1                     #ebdbb2        187            White
" Color: fg2                     #d5c4a1        187
" Color: fg3                     #bdae93        144
" Color: fg4                     #a89984        102            gray
" Color: grey                    #928374        102            DarkGray
" Color: red                     #fb4934        203            Red
" Color: green                   #b8bb26        142            Green
" Color: yellow                  #fabd2f        214            Yellow
" Color: blue                    #83a598        109            Blue
" Color: purple                  #d3869b        175            Magenta
" Color: aqua                    #8ec07c        107            Cyan
" Color: orange                  #fe8019        208            Magenta
" Term colors: bg0  neutralred neutralgreen neutralyellow neutralblue neutralpurple neutralaqua fg4
" Term colors: grey red        green        yellow        blue        purple        aqua        fg1
" Background: light
" Color: bg0                     #fbf1c7        230            White
" Color: bg1                     #ebdbb2        187            Grey
" Color: bg2                     #e5d4b1        188            Grey
" Color: bg3                     #bdae93        144
" Color: bg4                     #a89984        137
" Color: bg5                     #ebe1b7        229            Grey
" Color: bg6                     #ffffd7        231            Grey
" Color: fg0                     #282828        235            DarkGray
" Color: fg1                     #3c3836        237            Black
" Color: fg2                     #503836        237
" Color: fg3                     #665c54        59
" Color: fg4                     #7c6f64        243            Black
" Color: grey                    #928374        102            DarkGray
" Color: red                     #9d0006        124            Red
" Color: green                   #79740e        64             Green
" Color: yellow                  #b57614        172            Yellow
" Color: blue                    #076678        23             Blue
" Color: purple                  #8f3f71        126            Magenta
" Color: aqua                    #427b58        29             Cyan
" Color: orange                  #ff5f00        202            Magenta
" Term colors: fg1  neutralred neutralgreen neutralyellow neutralblue neutralpurple neutralaqua fg4
" Term colors: grey red        green        yellow        blue        purple        aqua        bg0
" Background: any
" vim: et ts=8 sw=2 sts=2
