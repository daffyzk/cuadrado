-- work config:

-- colors (i like: retrobox, wildcharm, sorbet, ...)
vim.cmd("colorscheme wildcharm")

-- line num color
vim.api.nvim_set_hl(0, 'LineNr', { fg = '#a94ec2'})
-- #ffbafe
-- transparency
vim.api.nvim_set_hl(0, "Normal", {bg = "none"})
vim.api.nvim_set_hl(0, "NonText", {bg = "none"})

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


