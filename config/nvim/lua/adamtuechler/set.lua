vim.g.mapleader = " "
vim.wo.number = true
vim.wo.relativenumber = true
vim.wo.signcolumn = "yes"
vim.wo.wrap = false
vim.o.cmdheight = 1
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.scrolloff = 10
vim.o.fillchars = "vert: ,eob: "
vim.o.guicursor = ""
vim.o.updatetime = 100
vim.o.ignorecase = true
vim.o.smartcase = true
vim.bo.swapfile = false

--[[
vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = { '*.tsx', '*.ts', '*.jsx', '*.js', '*.mjs' },
  command = 'silent! EslintFixAll',
})
--]]

vim.keymap.set('n', '<Leader>t', function() vim.cmd("Ex") end)
