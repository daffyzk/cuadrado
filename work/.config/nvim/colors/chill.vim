" Clear highlights

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

" Treesitter memes

hi TSParameter  guifg=#00c9ab gui=italic
hi TSField      guifg=#123123
hi TSNamespace  guifg=#123123

