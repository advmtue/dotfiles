require("adamtuechler.set")
require("adamtuechler.lazy")
require("adamtuechler.completion")
require("adamtuechler.lsp")
require("adamtuechler.colours")
require("adamtuechler.telescope")

vim.keymap.set('n', '<C-h>', [[:wincmd h<CR>]], { silent = true })
vim.keymap.set('n', '<C-j>', [[:wincmd j<CR>]], { silent = true })
vim.keymap.set('n', '<C-k>', [[:wincmd k<CR>]], { silent = true })
vim.keymap.set('n', '<C-l>', [[:wincmd l<CR>]], { silent = true })

-- Moving text up/down
vim.keymap.set('n', '<A-j>', [[:m .+1<CR>==]], { silent = true })
vim.keymap.set('n', '<A-k>', [[:m .-2<CR>==]], { silent = true })
vim.keymap.set('v', '<A-j>', [[:m '>+1<CR>gv=gv]], { silent = true })
vim.keymap.set('v', '<A-k>', [[:m '<-2<CR>gv=gv]], { silent = true })
