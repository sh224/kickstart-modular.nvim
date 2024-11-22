-- Use POSIX compatible shell
if vim.o.shell:match '.*fish$' then
  vim.opt.shell = '/usr/bin/env bash'
end

-- FIXME: Move to another file?
vim.api.nvim_create_autocmd('TermOpen', {
  command = 'startinsert',
})
vim.api.nvim_create_autocmd('TermOpen', {
  command = 'setlocal nonumber norelativenumber',
})

-- Consistent terminal colors
vim.opt.termguicolors = false

-- FIXME
vim.opt.showcmdloc = 'statusline'
--vim.opt.cursorline = true
--vim.api.nvim_set_hl(0, 'CursorLineNr', { ctermfg = 3, ctermbg = 0 })

-- FIXME: Move to theme

vim.cmd 'set cursorline'
vim.cmd 'highlight clear LineNr'
vim.cmd 'highlight LineNr ctermfg=19'
vim.cmd 'highlight clear CursorLine'
vim.cmd 'highlight clear CursorLineNR'
vim.cmd 'highlight CursorLineNR ctermfg=yellow ctermbg=black'
vim.cmd [[
  augroup CLClear
      autocmd! ColorScheme * highlight clear CursorLine
  augroup END
]]

vim.cmd [[
  augroup CLNRSet
      autocmd! ColorScheme * highlight CursorLineNR ctermfg=black ctermbg=yellow
  augroup END
]]

-- Improve smoothness when scrolling
vim.opt.smoothscroll = true

-- Wrap to beginning/end of last/previous line
vim.opt.whichwrap:append '>,<,l,h'

-- Use visual bell instead of beeping
vim.opt.visualbell = true

-- Don't write swap files
vim.opt.swapfile = false

-- Set show matching parenthesis
vim.opt.showmatch = true

-- TODO: Below needed?

--[[
-- indentation
vim.opt.tabstop = 4 -- A tab is four spaces
vim.opt.shiftwidth = 4 -- Number of spaces to use for autoindenting
vim.opt.expandtab = true -- Insert spaces when tab is pressed
vim.opt.autoindent = true -- copy indent from curent line when starting new
vim.opt.copyindent = true -- Copy the previous indentation on autoindenting
vim.opt.smartindent = false -- indentation handled by treesitter
--]]

-- Use multiple of shiftwidth when indenting with '<' and '>'
--vim.opt.shiftround = true

-- TODO: Move to kickstart options.lua?
-- Show hidden chars with :set list
--vim.opt.listchars = 'eol:$,tab:>-,trail:~,extends:>,precedes:<,space:·'
