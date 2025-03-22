vim.o.background = "light"

-- vim.cmd("colorscheme catppuccin")
-- vim.cmd("colorscheme gruvbox")
vim.cmd("colorscheme onedark")

-- Remove background colour and use the terminal default.
vim.api.nvim_set_hl(0, "Normal", { ctermbg = "none" })
vim.api.nvim_set_hl(0, "EndOfBuffer", { ctermbg = "none" })

-- Remove high-contrast background on TODO keyword.
vim.api.nvim_set_hl(0, "todo", { ctermbg = "none" })

-- Remove the background on the red sign in the gutter.
vim.api.nvim_set_hl(0, "GruvboxRedSign", { ctermbg = "none" })

-- Remove the background on the red sign in the gutter.
vim.api.nvim_set_hl(0, "GruvboxGreenSign", { ctermbg = "none" })

-- Remove the background on the red sign in the gutter.
vim.api.nvim_set_hl(0, "GruvboxAquaSign", { ctermbg = "none" })

-- Remove the background of the signcolumn gutter.
vim.api.nvim_set_hl(0, "SignColumn", { ctermbg = "none" })

-- Line width bar
-- vim.api.nvim_set_hl(0, "ColorColumn", { ctermbg = 234, bg = "#212530" }) -- dark
vim.api.nvim_set_hl(0, "ColorColumn", { ctermbg = 234, bg = "#DFDFDF" }) -- light

-- Colour of vertical split columns
vim.api.nvim_set_hl(0, "VertSplit", { ctermbg = 234 })

-- Colour of '~' text on non-file lines
vim.api.nvim_set_hl(0, "NonText", { ctermfg = 233 })

-- Colour of '~' text on non-file lines
vim.api.nvim_set_hl(0, "LspReferenceText", { link = 'VISUAL' })

-- Colour of '~' text on non-file lines
vim.api.nvim_set_hl(0, "LspReferenceRead", { link = 'VISUAL' })

-- Colour of '~' text on non-file lines
vim.api.nvim_set_hl(0, "LspReferenceWrite", { link = 'VISUAL' })
