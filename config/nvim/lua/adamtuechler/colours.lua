vim.o.background = "dark"
vim.cmd("colorscheme gruvbox")

vim.api.nvim_set_hl(0, "Normal",{ ctermbg = NONE })             -- Remove background colour and use the terminal default.
vim.api.nvim_set_hl(0, "todo",{ ctermbg = NONE })               -- Remove high-contrast background on TODO keyword.
vim.api.nvim_set_hl(0, "GruvboxRedSign",{ ctermbg = NONE })     -- Remove the background on the red sign in the gutter.
vim.api.nvim_set_hl(0, "GruvboxGreenSign",{ ctermbg = NONE })   -- Remove the background on the red sign in the gutter.
vim.api.nvim_set_hl(0, "GruvboxAquaSign",{ ctermbg = NONE })    -- Remove the background on the red sign in the gutter.
vim.api.nvim_set_hl(0, "SignColumn",{ ctermbg = NONE })         -- Remove the background of the signcolumn gutter.
vim.api.nvim_set_hl(0, "ColorColumn",{ ctermbg = 234 })         -- 
vim.api.nvim_set_hl(0, "VertSplit",{ ctermbg = 234 })           -- Colour of vertical split columns
vim.api.nvim_set_hl(0, "NonText",{ ctermfg = 233 })             -- Colour of '~' text on non-file lines

vim.api.nvim_set_hl(0, "LspReferenceText",{ link = 'VISUAL' })             -- Colour of '~' text on non-file lines
vim.api.nvim_set_hl(0, "LspReferenceRead",{ link = 'VISUAL' })             -- Colour of '~' text on non-file lines
vim.api.nvim_set_hl(0, "LspReferenceWrite",{ link = 'VISUAL' })             -- Colour of '~' text on non-file lines
