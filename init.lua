require("config.lazy")

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = false
vim.opt.number = false
vim.g.mapleader = " "

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

vim.keymap.set('n', '<leader>nf', ':Neotree<CR>', { desc = 'Open Neotree' })
vim.keymap.set('n', '<leader>nt', ':ToggleTerm<CR>', { desc = 'Open Terminal' })

vim.keymap.set('n', '<leader>kk', '<C-w>k', { desc = "Move to upper window" })
vim.keymap.set('n', '<leader>jj', '<C-w>j', { desc = "Move to lower window" })
vim.keymap.set('n', '<leader>hh', '<C-w>h', { desc = "Move to left window" })
vim.keymap.set('n', '<leader>ll', '<C-w>l', { desc = "Move to right window" })


vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', { noremap = true, silent = true })
