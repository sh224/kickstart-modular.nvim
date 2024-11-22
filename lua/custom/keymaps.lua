local defaults = { noremap = true, silent = true }

-- Disable arrow keys
vim.keymap.set('n', '<up>', '<nop>')
vim.keymap.set('n', '<down>', '<nop>')
vim.keymap.set('n', '<left>', '<nop>')
vim.keymap.set('n', '<right>', '<nop>')

-- Reload theme
vim.keymap.set('', '<M-u>', require('custom.plugins.tinted-theming').config, { silent = true, desc = 'reload theme' })

-- Open Lazy
vim.keymap.set('n', '<leader>l', vim.cmd.Lazy, { desc = 'Lazy plugin manager' })

-- Using <leader> + number (1, 2, ... 9) to switch tab
for i = 1, 9, 1 do
  vim.keymap.set('n', '<leader>' .. i, i .. 'gt', { desc = 'which_key_ignore' })
end
vim.keymap.set('n', '<leader>0', ':tablast<cr>', { desc = 'which_key_ignore' })

-- map x to black hole registers
vim.keymap.set('n', 'x', '"_x', {})

-- Ctrl + l to remove highlights and redraw your screen
vim.keymap.set('n', '<C-l>', ':nohlsearch<cr>', defaults)

-- Copy contents of current buffer
vim.keymap.set('n', '<leader>C', ':keepjumps normal! ggyG<cr>', { noremap = true, silent = true, desc = 'Copy contents of current buffer' })

-- Beginning and end of line
vim.keymap.set('n', 'H', '_', defaults)
vim.keymap.set('n', 'L', '$', defaults)

-- FIXME: Continue with keymaps
