-- work config:

-- colors (i like: retrobox, wildcharm, sorbet, ...)
-- my own colorscheme: chill
vim.cmd("colorscheme visual_studio_code")
-- fixing issue with vscode theme and transparency
vim.cmd("hi TabLine guifg=LightMagenta guibg=none")
vim.cmd("hi TabLineSel guifg=LightGreen guibg=none")
vim.cmd("hi TabLineFill guibg=none")
-- transparency
vim.cmd("hi Normal guibg=none")
vim.cmd("hi NonText guibg=none")
-- lsp langs

require'lspconfig'.cairo_ls.setup(config)
require'lspconfig'.ts_ls.setup(config)
require'lspconfig'.rust_analyzer.setup(config)
-- require'lspconfig'.gopls.setup(config)

-- comment strings on cairo

vim.api.nvim_create_autocmd({"FileType"}, {
  pattern = {"cairo"}, 
  callback = function()
    vim.bo.commentstring = "// %s" 
  end,
})


