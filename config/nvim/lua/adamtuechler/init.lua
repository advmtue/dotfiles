require("adamtuechler.packer")
require("adamtuechler.set")
require("adamtuechler.lsp")
require("adamtuechler.colours")
require("adamtuechler.telescope")

vim.keymap.set('n', '<C-h>', [[:wincmd h<CR>]], { silent = true })
vim.keymap.set('n', '<C-j>', [[:wincmd j<CR>]], { silent = true })
vim.keymap.set('n', '<C-k>', [[:wincmd k<CR>]], { silent = true })
vim.keymap.set('n', '<C-l>', [[:wincmd l<CR>]], { silent = true })
