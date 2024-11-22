local M = {}

vim.api.nvim_set_hl(0, 'StatusLine', { ctermfg = 7, ctermbg = 18 })
vim.api.nvim_set_hl(0, 'StatusLineNC', { ctermfg = 7, ctermbg = 18 })
vim.api.nvim_set_hl(0, 'StatusLineBufferNumber', { ctermfg = 8, ctermbg = 18 })
vim.api.nvim_set_hl(0, 'StatusLineBufferNumberActive', { ctermfg = 0, ctermbg = 3 })
vim.api.nvim_set_hl(0, 'StatusLineGit', { ctermfg = 1, ctermbg = 18 })
vim.api.nvim_set_hl(0, 'StatusLineHighlight', { ctermfg = 3, ctermbg = 18 })
vim.api.nvim_set_hl(0, 'StatusLineSeparator', { ctermfg = 8, ctermbg = 18 })

local separator = '%#StatusLineSeparator#' .. '|' .. '%#StatusLine#'

M.buffer_number = function()
  return ' %n '
end

M.filename = function()
  return ' %<%F%m%r%h%w '
end

M.filetype = function()
  return '%y '
end

M.command = function()
  return ' %S '
end

M.git = function()
  -- use fallback because it doesn't set this variable on the initial `BufEnter`
  local signs = vim.b.gitsigns_status_dict or { head = '', added = 0, changed = 0, removed = 0 }
  local has_head = signs.head ~= ''

  if signs.added == nil then
    return '%#StatusLineGit# 󱊆 %#StatusLine# ' .. '[untracked] ' .. separator
  end

  return has_head and '%#StatusLineGit# 󱊆 %#StatusLine# ' .. string.format('+%s ~%s -%s %s', signs.added, signs.changed, signs.removed, separator) or ''
end

M.encoding = function()
  local result = vim.opt.fileencoding:get()

  if result == 'utf-8' and not vim.bo.bomb then
    return ''
  end

  if vim.bo.bomb then
    if result ~= '' then
      result = result .. ' '
    end
    result = result .. '[BOM]'
  end

  if result == '' then
    return ''
  end

  return ' %#StatusLineHighlight#' .. result .. ' ' .. separator
end

M.file_format = function()
  if vim.bo.ff == 'unix' then
    return ''
  end

  return ' %#StatusLineHighlight#' .. '{&ff} ' .. separator
end

M.row_and_column = function()
  local rows = ' %03l/%03L'
  local columns = ' %03v '
  return rows .. columns
end

-- FIXME: Add LSP status
M.get_active = function(self)
  local left = '%#StatusLineBufferNumberActive#' .. self:buffer_number() .. '%#StatusLine#' .. self:filename() .. self:filetype()
  local right = self:command() .. self:git() .. self:encoding() .. self:file_format() .. self:row_and_column()
  return left .. '%=' .. right
end

M.get_inactive = function(self)
  return '%#StatusLineBufferNumber#' .. self:buffer_number() .. '%#StatusLine#' .. self:filename()
end

M.get_explorer = function(self)
  return 'explorer'
end

Statusline = setmetatable(M, {
  __call = function(statusline, mode)
    if mode == 'active' then
      return statusline:get_active()
    end
    if mode == 'inactive' then
      return statusline:get_inactive()
    end
    if mode == 'explorer' then
      return statusline:get_explorer()
    end
  end,
})

-- TODO: replace this using lua
vim.api.nvim_exec2(
  [[
  augroup Statusline
  au!
  au WinEnter,BufEnter * setlocal statusline=%!v:lua.Statusline('active')
  au WinLeave,BufLeave * setlocal statusline=%!v:lua.Statusline('inactive')
  au WinEnter,BufEnter,FileType netrw setlocal statusline=%!v:lua.Statusline('explorer')
  au WinLeave,BufLeave,FileType netrw setlocal statusline=%!v:lua.Statusline('explorer')
  augroup END
]],
  {}
)

-- vim.api.nvim_create_autocmd({ 'WinEnter', 'BufEnter' }, {
--   group = vim.api.nvim_create_augroup('Statusline', { clear = true }),
--   command = 'setlocal statusline=test',
-- })
