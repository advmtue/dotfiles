require('mason').setup()
require('mason-lspconfig').setup({
	ensure_installed = { 'lua_ls', 'eslint', 'tsserver' }
})

local cmp = require('cmp')
require('cmp').setup({
	snippet = {
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
      end,
    },
	sources = cmp.config.sources({
		{ name = 'nvim_lsp' },
		{ name = 'path' },
		{ name = 'buffer', keyword_length = 3 },
		{ name = 'nvim_lsp_signature_help' },
		{ name = 'vsnip' }
	}),
	mapping = cmp.mapping.preset.insert({
		['<C-Space>'] = cmp.mapping.complete(),
		['<CR>'] = cmp.mapping.confirm({ select = true }),
	}),
})

local capabilities = require('cmp_nvim_lsp').default_capabilities()

require('lspconfig').lua_ls.setup({
	settings = { Lua = { diagnostics = { globals = { 'vim' } } } },
	capabilities = capabilities
})

require('lspconfig').eslint.setup({
	capabilities = capabilities
})

require('typescript').setup({});

vim.api.nvim_create_autocmd('LspAttach', {
	group = vim.api.nvim_create_augroup('UserLspConfig', {}),
	callback = function(ev)
		-- Enable completion triggered by <c-x><c-o>
		vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

		local opts = { buffer = ev.buf }

		vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
		-- vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)

		vim.keymap.set('n', '<leader>gd', vim.lsp.buf.definition, opts)
		vim.keymap.set('n', '<leader>gi', vim.lsp.buf.implementation, opts)
		vim.keymap.set('n', '<leader>gr', vim.lsp.buf.references, opts)
		vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
		vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)

		vim.keymap.set('n', '<space>f', function()
			vim.lsp.buf.format { async = true }
		end, opts)

		local client = vim.lsp.get_client_by_id(ev.data.client_id)

		if client.server_capabilities.documentHighlightProvider then
			vim.api.nvim_create_augroup("lsp_document_highlight", { clear = true })
			vim.api.nvim_clear_autocmds { buffer = ev.bufnr, group = "lsp_document_highlight" }
			vim.api.nvim_create_autocmd("CursorHold", {
				callback = vim.lsp.buf.document_highlight,
				buffer = ev.bufnr,
				group = "lsp_document_highlight",
				desc = "Document Highlight",
			})
			vim.api.nvim_create_autocmd("CursorMoved", {
				callback = vim.lsp.buf.clear_references,
				buffer = ev.bufnr,
				group = "lsp_document_highlight",
				desc = "Clear All the References",
			})
		end
	end,
})
