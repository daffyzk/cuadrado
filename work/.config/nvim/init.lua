-- random settings

vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")
vim.wo.number = true
vim.wo.relativenumber = true
vim.g.mapleader = " "

-- lazy package manager

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
    {"nvim-telescope/telescope.nvim", tag = "0.1.5", dependencies = {"nvim-lua/plenary.nvim"}},
    {"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"},
    {"nvim-neo-tree/neo-tree.nvim", branch = "v3.x", 
        dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim"
        }
    },
    {"neovim/nvim-lspconfig"}
}

local opts = {}

require("lazy").setup(plugins,opts)

-- telescope

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<C-p>", builtin.find_files, {})
vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})

-- treesitter 

local config = require("nvim-treesitter.configs")

config.setup({
    ensure_installed = {
        "lua", "rust", "go", "javascript", "typescript", "python"
    },
    highlight = { enable = true },
    indent = { enable = true },
})

-- neo-tree (hell yeah)

vim.keymap.set("n", "<C-n>", ":Neotree filesystem reveal right<CR>", {})

-- LSP memes

local handlers = {
    ["textDocument/publishDiagnostics"] = vim.lsp.with(
        vim.lsp.diagnostic.on_publish_diagnostics, {
            signs = false,
        }
    ),
    ["textDocument/hover"] = vim.lsp.with(
        vim.lsp.handlers.hover,
        { border = "single"}
    ),
    ["textDocument/signatureHelp"] = vim.lsp.with(
        vim.lsp.handlers.signature_help,
        { border = "single"}
    )
  }

local on_attach = function(client, bufnr)
    -- vim.keymap.set('n', '[d', function() vim.diagnostic.goto_prev vim.diagnostic.open_float end)
    -- vim.keymap.set('n', ']d', function() vim.diagnostic.goto_next vim.diagnostic.open_float end)
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
    vim.keymap.set('n', '<space>q', vim.diagnostic.setqflist)
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action)
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    -- -- vim.keymap.set('n', '', vim.diagnostic.open_float)
    -- client.server_capabilities.semanticTokensProvider = nil
end  

local config = {
    on_attach = on_attach,
    handlers = handlers,
}

-- work config:

-- colors (i like: retrobox, wildcharm, sorbet, ...)
vim.cmd("colorscheme chill")

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


