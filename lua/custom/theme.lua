-- Line number theme

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
