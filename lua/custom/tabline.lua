local M = {}

vim.api.nvim_set_hl(0, 'TabLineSel', { ctermfg = 'Black', ctermbg = 'Yellow' })
vim.api.nvim_set_hl(0, 'TabLineDim', { ctermfg = 8, ctermbg = 18 })
vim.api.nvim_set_hl(0, 'TabLineSep', { ctermfg = 'Black', ctermbg = 18 })
vim.api.nvim_set_hl(0, 'TabLinePad', { ctermfg = 'Black', ctermbg = 'Black' })

M.title = function(bufnr)
  local file = vim.fn.bufname(bufnr)
  local buftype = vim.fn.getbufvar(bufnr, '&buftype')
  local filetype = vim.fn.getbufvar(bufnr, '&filetype')

  if buftype == 'help' then
    return 'help:' .. vim.fn.fnamemodify(file, ':t:r')
  elseif buftype == 'quickfix' then
    return 'quickfix'
  elseif filetype == 'TelescopePrompt' then
    return 'Telescope'
  elseif filetype == 'git' then
    return 'Git'
  elseif filetype == 'fugitive' then
    return 'Fugitive'
  elseif filetype == 'NvimTree' then
    return 'NvimTree'
  elseif filetype == 'oil' then
    return 'Oil'
  elseif file:sub(file:len() - 2, file:len()) == 'FZF' then
    return 'FZF'
  elseif buftype == 'terminal' then
    local _, mtch = string.match(file, 'term:(.*):(%a+)')
    return mtch ~= nil and mtch or vim.fn.fnamemodify(vim.env.SHELL, ':t')
  elseif file == '' then
    return '[No Name]'
  else
    return vim.fn.pathshorten(vim.fn.fnamemodify(file, ':p:~:t'))
  end
end

M.modified = function(bufnr)
  return vim.fn.getbufvar(bufnr, '&modified') == 1 and '[+]' or ''
end

M.window_count = function(index)
  local nwins = vim.fn.tabpagewinnr(index, '$')
  return nwins > 1 and '(' .. nwins .. ') ' or ''
end

M.tab_start = function(index)
  local is_first = index == 1
  local is_selected = vim.fn.tabpagenr() == index
  local hl_sep = (is_selected and '%#TabLineSel#' or '%#TabLineSep#')
  local hl_index = (is_selected and '%#TabLineSel#' or '%#TabLineDim#')
  return hl_sep .. (is_first and ' ' or ' ') .. hl_index .. index .. ' %#TabLine# '
end

M.tab_end = function(index)
  local is_last = index == vim.fn.tabpagenr '$'
  return ' %#TabLineSep#%#TabLinePad# ' .. (is_last and '%#TabLineSep#' or '')
end

M.cell = function(index)
  local buflist = vim.fn.tabpagebuflist(index)
  local winnr = vim.fn.tabpagewinnr(index)
  local bufnr = buflist[winnr]

  return '%' .. index .. 'T' .. M.tab_start(index) .. M.window_count(index) .. M.title(bufnr) .. M.modified(bufnr) .. M.tab_end(index) .. '%T'
end

M.tabline = function()
  local line = ''
  for i = 1, vim.fn.tabpagenr '$', 1 do
    line = line .. M.cell(i)
  end
  line = line .. '%#TabLineFill#%='
  if vim.fn.tabpagenr '$' > 1 then
    line = line .. '%#TabLineDim#%999X' .. ' '
  end
  return line
end

M.setup = function()
  vim.o.tabline = "%!v:lua.require'custom.tabline'.tabline()"
end

M.setup()

return M
