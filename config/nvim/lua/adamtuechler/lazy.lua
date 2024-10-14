-- Ensure that lazy.nvim is installed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"

	local out = vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"--branch=stable",
		lazyrepo,
		lazypath
	})

	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})

		vim.fn.getchar()

		os.exit(1)
	end
end

vim.opt.rtp:prepend(lazypath)

-- Manage packages
require("lazy").setup({
	spec = {
		-- Colour scheme options. Better to keep these handy
		"ellisonleao/gruvbox.nvim",
		{
			"navarasu/onedark.nvim",
			opts = { style = "deep" }
		},
		{
			"catppuccin/nvim",
			name = "catppuccin",
			opts = {
				flavour = "auto",
				background = { light = "latte", dark = "mocha" }
			}
		},

		"airblade/vim-gitgutter",
		"kylechui/nvim-surround",

		-- File finder
		{
			'nvim-telescope/telescope.nvim',
			tag = '0.1.8',
			dependencies = { {'nvim-lua/plenary.nvim'} }
		},

		-- Syntax highlighting
		{
			"nvim-treesitter/nvim-treesitter",
			build = ":TSUpdate",
			config = function ()
				local configs = require("nvim-treesitter.configs")

				configs.setup({
					ensure_installed = {
						"c", "c_sharp", "lua",
						"html", "javascript",
						"go", "gomod", "gosum",
						"json", "query",
						"terraform", "typescript",
						"vim", "vimdoc",
					},
					sync_install = false,
					highlight = { enable = true },
					indent = { enable = true },
				})
			end
		},

		-- Status line
		{
			"nvim-lualine/lualine.nvim",
			opts = {
				options = {
					icons_enabled = false,
					theme = 'onelight',
					section_separators = '',
					component_separators = ''
				}
			}
		},

		-- LSP
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",

		-- Code completion
		'hrsh7th/nvim-cmp',

		-- Code completion...
		-- ... source: neovim lsp
		'hrsh7th/cmp-nvim-lsp',
		-- ... source: words in buffers
		'hrsh7th/cmp-buffer',
		-- ... source: neovim lua
		'hrsh7th/cmp-nvim-lua',
		-- ... source: filesystem paths
		'hrsh7th/cmp-path',
		-- ... source: from snippets (vsnip)
		'hrsh7th/cmp-vsnip',
		-- ... helper: highlight current parameter in function signature 
		'hrsh7th/cmp-nvim-lsp-signature-help',

		-- Code snippets (like vscode)
		'hrsh7th/vim-vsnip',
		'hrsh7th/vim-vsnip-integ',
	},

	-- colorscheme that will be used when installing plugins.
	install = { colorscheme = { "habamax" } },

	-- automatically check for plugin updates
	checker = { enabled = true },
})
