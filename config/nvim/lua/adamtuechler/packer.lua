vim.cmd.packadd('packer.nvim')

require('packer').startup(function(use)
	use 'wbthomason/packer.nvim'
	use "ellisonleao/gruvbox.nvim"
	use 'airblade/vim-gitgutter'
	use 'jose-elias-alvarez/typescript.nvim'
	use 'terrastruct/d2-vim'

	use({
		"kylechui/nvim-surround",
		tag = "*", -- Use for stability; omit to use `main` branch for the latest features
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end
	})

	use {
		'nvim-telescope/telescope.nvim', tag = '0.1.3',
		requires = { {'nvim-lua/plenary.nvim'} }
	}

	-- LSP
	use {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
		'hrsh7th/nvim-cmp',
		'hrsh7th/cmp-nvim-lsp',
		'hrsh7th/cmp-buffer',
		'hrsh7th/cmp-path',
		'hrsh7th/cmp-vsnip',
		'hrsh7th/vim-vsnip',
		'hrsh7th/vim-vsnip-integ',
		'hrsh7th/cmp-nvim-lsp-signature-help',
	}
end)
