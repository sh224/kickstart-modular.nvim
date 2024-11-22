-- Disable arrow keys
vim.keymap.set('n', '<up>', '<nop>')
vim.keymap.set('n', '<down>', '<nop>')
vim.keymap.set('n', '<left>', '<nop>')
vim.keymap.set('n', '<right>', '<nop>')

-- Reload theme
vim.keymap.set('', '<M-u>', require('custom.plugins.tinted-theming').config, { silent = true, desc = 'reload theme' })

-- TODO: Continue with keymaps
