-- random settings

vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
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
    {"nvim-telescope/telescope.nvim", 
        tag = "0.1.5", 
        dependencies = {
            "nvim-lua/plenary.nvim"
        }
    },                                  -- fuzzy-find and live-grep files
    {"nvim-treesitter/nvim-treesitter", 
        build = ":TSUpdate"},           -- syntax highlighting
    {"nvim-neo-tree/neo-tree.nvim", 
        branch = "v3.x", 
        dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim"
        }
    },                                  -- cool side bar for files
    {'akinsho/toggleterm.nvim', 
        version = "*", 
        config = true
    },                                  -- terminal
    {"neovim/nvim-lspconfig"},
    {"hrsh7th/nvim-cmp"},               -- autocomplete
    {"hrsh7th/cmp-buffer"},
    {"hrsh7th/cmp-path"},
    {"hrsh7th/cmp-nvim-lua"},
    {"hrsh7th/cmp-nvim-lsp"},
    {"noir-lang/noir-nvim"},            -- noir lsp
    {"tpope/vim-fugitive"},             -- git goodness 
    {"askfiy/visual_studio_code"},      -- vscode theme
}

local opts = {}

-- lazy package manager
require("lazy").setup(plugins,opts)
local treesitter = require("nvim-treesitter.configs")
local cmp = require("cmp")

cmp.setup({
    mapping = cmp.mapping.preset.insert({
        ["C-d"] = cmp.mapping.scroll_docs(-4), 
        ["C-f"] = cmp.mapping.scroll_docs(4),
        ["C-Space"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<C-y>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Insert,
            select = true
        }),
    }),
    snippet = {
        expand = function(args)
            vim.snippet.expand(args.body)
            vim.snippet.expand()
        end,
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    sources = {
        { name = "nvim_lua" },
        { name = "nvim_lsp" },
        { name = "path" },
        { name = "buffer", keyboard_length = 5 },
    },
})

-- cmp.setup.cmdline(":", {
--     mapping = cmp.mapping.preset.cmdline(),
--     sources = cmp.config.sources({
--         {name = "path" }
--     }, {
--         {name = "cmdline"}
--        }),
--     matching = { disallow_symbol_nonprefix_matching = false }
-- })

treesitter.setup({
    ensure_installed = {
        "lua", "rust", "go", "javascript", "typescript", "python"
    },
    highlight = { enable = true },
    indent = { enable = true },
})

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


local function lsp_jump_in_tab(method)
  -- get current buffer and cursor position
  local current_buf = vim.api.nvim_get_current_buf()
  local cursor = vim.api.nvim_win_get_cursor(0)

  -- perform LSP request ( could be definition or declaration )
  local result = vim.lsp.buf_request_sync(current_buf, method, {
    textDocument = { uri = vim.uri_from_bufnr(current_buf) },
    position = { line = cursor[1] - 1, character = cursor[2] },
  }, 1000)

  -- get target file from LSP response
  local target_file = nil
  for _, client_results in pairs(result or {}) do
    if client_results.result and client_results.result[1] then
      local uri = client_results.result[1].targetUri or client_results.result[1].uri
      target_file = vim.uri_to_fname(uri)
      break
    end
  end

  if not target_file then
    print("No " .. method:match("([^/]+)$") .. " found")
    return
  end

  target_file = vim.fn.expand(target_file):gsub("^~", vim.fn.getenv("HOME"))

  -- check if file is already open in a tab
  for _, tab in ipairs(vim.api.nvim_list_tabpages()) do
    for _, win in ipairs(vim.api.nvim_tabpage_list_wins(tab)) do
      local buf = vim.api.nvim_win_get_buf(win)
      local bufname = vim.api.nvim_buf_get_name(buf)
      if bufname == target_file then -- if open focus on the tab
        vim.api.nvim_set_current_tabpage(tab)
        vim.lsp.buf[method:match("([^/]+)$")]()
        return
      end
    end
  end

  -- if not open create new tab
  vim.cmd("tab split")
  vim.lsp.buf[method:match("([^/]+)$")]()
end

-- SHORTCUTS -- shortcuts -- SHORTCUTS -- shortcuts -- SHORTCUTS -- 

-- to move in tabs on the default layer
vim.keymap.set('n', '<Leader>j', vim.cmd.tabfirst)
vim.keymap.set('n', '<Leader>k', vim.cmd.tabnext) 
vim.keymap.set('n', '<Leader>l', vim.cmd.tabprev) 
vim.keymap.set('n', '<Leader>;', vim.cmd.tablast) 
vim.keymap.set('n', '<Leader>n', function () return ':tabnew ' end, { expr = true })

-- telescope
local telescope = require("telescope")
local telescope_btn = require("telescope.builtin")

telescope.setup{
    defaults = {
        file_ignore_patterns = {
            "node_modules/.*",
            "target/.*",
            "fonts/.*",
            "dist/.*",
            "%.git/.*",
            "%.gitlab/.*",
            "%.cache/",
            "%.next",
            "%.d.ts",
            "yarn.lock",
            "Cargo.lock",
            "%.tsbuildinfo",
        }
    }
}

vim.keymap.set("n", "<C-p>", telescope_btn.find_files, {})
vim.keymap.set("n", "<C-b>", telescope_btn.buffers, {})
vim.keymap.set("n", "<leader>fg", telescope_btn.live_grep, {})

-- neo-tree
vim.keymap.set("n", "<C-n>", ":Neotree filesystem reveal right<CR>", {})

-- toggle terminal
vim.keymap.set('n', '<leader>t', '<cmd>ToggleTerm direction=float<cr>', { noremap = true, silent = true })

-- find and replace (a.k.a. rename)
vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename)

-- diagnostics and code actions
local on_attach = function(client, bufnr)
    -- vim.keymap.set('n', '[d', function() vim.diagnostic.goto_prev vim.diagnostic.open_float end)
    -- vim.keymap.set('n', ']d', function() vim.diagnostic.goto_next vim.diagnostic.open_float end)
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
    vim.keymap.set('n', '<space>q', vim.diagnostic.setqflist)
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action)
    vim.keymap.set('n', 'gD', function() 
        lsp_jump_in_tab("textDocument/declaration") 
    end, bufopts)
    vim.keymap.set('n', 'gd', function() 
        lsp_jump_in_tab("textDocument/definition") 
    end, bufopts)
    -- -- vim.keymap.set('n', '', vim.diagnostic.open_float)
    -- client.server_capabilities.semanticTokensProvider = nil
end  

local config = {
    on_attach = on_attach,
    handlers = handlers,
}

-- my forced 4 tab spacing breaks ts formatting so here's a fix
vim.api.nvim_create_autocmd("FileType", {
    pattern = "typescript",
    callback = function()
        vim.opt_local.tabstop = 2
        vim.opt_local.softtabstop = 2
        vim.opt_local.shiftwidth = 2
        vim.opt_local.expandtab = true
    end,
})

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

-- alba plugin

local function pad_to_width(text, width, side)
  local pad = width - string.len(text)
  if pad <= 0 then return text end
  if side == 'left' then
    return string.rep(' ', pad) .. text
  else
    return text .. string.rep(' ', pad)
  end
end

local function create_float_win(lines, filter_fn)
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  local width = math.min(80, vim.o.columns - 4)
  local height = math.min(#lines, vim.o.lines - 4)
  local win = vim.api.nvim_open_win(buf, true, {
    relative = 'editor',
    width = width,
    height = height,
    col = math.floor((vim.o.columns - width) / 2),
    row = math.floor((vim.o.lines - height) / 2),
    border = { '┌', '─', '┐', '│', '┘', '─', '└', '│' },
    style = 'minimal',
  })
  vim.api.nvim_win_set_option(win, 'winhl', 'Normal:Normal,FloatBorder:LineNr')
  vim.api.nvim_win_set_option(win, 'wrap', false)
  vim.api.nvim_buf_set_keymap(buf, 'n', '<Esc>', ':q<CR>', { noremap = true, silent = true })
  vim.api.nvim_buf_set_keymap(buf, 'n', 'q', ':q<CR>', { noremap = true, silent = true })
  vim.api.nvim_buf_set_keymap(buf, 'n', '<CR>', '', {
    noremap = true,
    silent = true,
    callback = function() filter_fn(win, buf, '\n') end,
  })
  vim.api.nvim_buf_set_keymap(buf, 'n', 'p', '', {
    noremap = true,
    silent = true,
    callback = function() filter_fn(win, buf, 'p') end,
  })
  vim.api.nvim_buf_set_keymap(buf, 'n', 't', '', {
    noremap = true,
    silent = true,
    callback = function() filter_fn(win, buf, 't') end,
  })
  vim.api.nvim_buf_set_keymap(buf, 'n', 's', '', {
    noremap = true,
    silent = true,
    callback = function() filter_fn(win, buf, 's') end,
  })
  vim.api.nvim_buf_set_keymap(buf, 'n', 'd', '', {
    noremap = true,
    silent = true,
    callback = function() filter_fn(win, buf, 'd') end,
  })
  return win, buf
end

local function filter_list(win, buf, key)
  local result = vim.api.nvim_win_get_cursor(win)[1]
  local filename = vim.split(vim.api.nvim_buf_get_lines(buf, result - 1, result, false)[1], '%s+')[-1]
  
  if key == '\n' then
    vim.cmd('buffer ' .. filename)
    vim.api.nvim_win_close(win, true)
  elseif key == 'p' then
    vim.cmd('buffer ' .. filename)
  elseif key == 't' then
    vim.cmd('tabnew ' .. filename)
    vim.api.nvim_win_close(win, true)
  elseif key == 's' then
    vim.cmd('vsplit ' .. filename)
    vim.api.nvim_win_close(win, true)
  elseif key == 'd' then
    vim.cmd('bdelete ' .. filename)
    local lines = vim.api.nvim_buf_line_count(buf)
    if lines == 1 then
      vim.api.nvim_win_close(win, true)
      return
    end
    vim.api.nvim_buf_set_lines(buf, result - 1, result, false, {})
  end
end

local function list_buffers()
  local buffers = vim.fn.getbufinfo({ buflisted = 1, bufloaded = 1 })
  local lista = {}
  
  for _, buf in ipairs(buffers) do
    local bufnr = pad_to_width(tostring(buf.bufnr), 3, 'right')
    local line = pad_to_width(tostring(buf.lnum), 4, 'left')
    local lines = pad_to_width(tostring(buf.linecount), 4, 'right')
    local fname = buf.name
    local short = pad_to_width(vim.fn.fnamemodify(fname, ':t'), 25, 'right')
    local text = string.format('%s  %s/%s   %s %s', bufnr, line, lines, short, fname)
    table.insert(lista, text)
  end
  
  create_float_win(lista, filter_list)
end

local function filter_marks(win, buf, key)
  local result = vim.api.nvim_win_get_cursor(win)[1]
  local line = vim.api.nvim_buf_get_lines(buf, result - 1, result, false)[1]
  local mark = vim.split(line, '%s+')[1]
  local filename = vim.split(line, '%s+')[-1]
  
  if key:match('[A-Z]') then
    vim.cmd('normal! `' .. key)
    vim.api.nvim_win_close(win, true)
  elseif key == '\n' then
    vim.cmd('normal! `' .. mark)
    vim.api.nvim_win_close(win, true)
  elseif key == 'p' then
    vim.cmd('normal! `' .. mark)
  elseif key == 't' then
    vim.cmd('tabnew ' .. filename)
    vim.cmd('normal! `' .. mark)
    vim.api.nvim_win_close(win, true)
  elseif key == 's' then
    vim.cmd('vsplit ' .. filename)
    vim.cmd('normal! `' .. mark)
    vim.api.nvim_win_close(win, true)
  elseif key == 'd' then
    vim.cmd('delmarks ' .. mark)
    local lines = vim.api.nvim_buf_line_count(buf)
    if lines == 1 then
      vim.api.nvim_win_close(win, true)
      return
    end
    vim.api.nvim_buf_set_lines(buf, result - 1, result, false, {})
  end
end

local function list_marks()
  local marks = vim.fn.getmarklist()
  local lista = {}
  
  for _, mark in ipairs(marks) do
    if mark.mark:match('[0-9]') then goto continue end
    local letter = mark.mark:sub(-1)
    local line = pad_to_width(tostring(mark.pos[1]), 5, 'left')
    local fname = mark.file
    local short = pad_to_width(vim.fn.fnamemodify(fname, ':t'), 25, 'right')
    local text = string.format('%s    %s    %s%s', letter, line, short, fname)
    table.insert(lista, text)
    ::continue::
  end
  
  if #lista == 0 then
    vim.api.nvim_echo({ { 'global marks not set', 'WarningMsg' } }, false, {})
    return
  end
  
  create_float_win(lista, filter_marks)
end

vim.keymap.set('n', '<space>l', list_buffers, { silent = true })
vim.keymap.set('n', '<space>m', list_marks, { silent = true })

