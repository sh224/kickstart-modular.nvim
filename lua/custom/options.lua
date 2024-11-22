-- Use POSIX compatible shell
if vim.o.shell:match '.*fish$' then
  vim.opt.shell = '/usr/bin/env bash'
end

-- Start terminal in insert mode
vim.api.nvim_create_autocmd('TermOpen', {
  command = 'startinsert',
})

-- Disable line numbers for terminal
vim.api.nvim_create_autocmd('TermOpen', {
  command = 'setlocal nonumber norelativenumber',
})

-- Consistent terminal colors
vim.opt.termguicolors = false

-- Don't show command
vim.opt.showcmd = false

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

-- Indentation
vim.opt.tabstop = 8 -- Always 8 (see :h tabstop)
vim.opt.softtabstop = 4 -- What you expect
vim.opt.shiftwidth = 4 -- Number of spaces to use for autoindenting
vim.opt.expandtab = true -- Insert spaces when tab is pressed
vim.opt.autoindent = true -- copy indent from curent line when starting new
vim.opt.copyindent = true -- Copy the previous indentation on autoindenting
vim.opt.smartindent = true -- indentation handled by treesitter
vim.opt.shiftround = true -- Use multiple of shiftwidth when indenting with '<' and '>'
