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

