vim.g.mapleader = " "
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"
vim.opt.wrap = false
vim.opt.cmdheight = 1
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.scrolloff = 10
vim.opt.fillchars = "vert: ,eob: "
vim.opt.guicursor = ""
vim.opt.updatetime = 100
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.swapfile = false
vim.opt.colorcolumn = "100"

--[[
vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = { '*.tsx', '*.ts', '*.jsx', '*.js', '*.mjs' },
  command = 'silent! EslintFixAll',
})
--]]

vim.keymap.set('n', '<Leader>t', function() vim.cmd("Ex") end)
