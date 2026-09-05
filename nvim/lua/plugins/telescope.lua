require('telescope').setup({})

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>f', builtin.find_files, { desc = 'Find files' })
vim.keymap.set('n', '<leader>a', builtin.live_grep, { desc = 'Grep in project' })
vim.keymap.set('n', '<leader>b', builtin.buffers, { desc = 'Find buffers' })
vim.keymap.set('n', '<leader>hh', builtin.help_tags, { desc = 'Help tags' })
