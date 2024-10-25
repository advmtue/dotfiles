-- Language server management
require('mason').setup()
require('mason-lspconfig').setup({
	ensure_installed = {
		'lua_ls',
		'terraformls',
		'tflint',
		"gopls",
	}
})

local capabilities = require('cmp_nvim_lsp').default_capabilities()

require('lspconfig').lua_ls.setup({
	settings = { Lua = { diagnostics = { globals = { 'vim' } } } },
	capabilities = capabilities
})

require('lspconfig').terraformls.setup({ capabilities = capabilities })
require('lspconfig').tflint.setup({ capabilities = capabilities })
require('lspconfig').gopls.setup({ capabilities = capabilities })

vim.api.nvim_create_autocmd('LspAttach', {
	group = vim.api.nvim_create_augroup('UserLspConfig', {}),
	callback = function(ev)
		-- Enable completion triggered by <c-x><c-o>
		vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

		local opts = { buffer = ev.buf }

		-- Hover highlight
		vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)

		-- vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)

		-- Go to definition
		vim.keymap.set('n', '<leader>gd', vim.lsp.buf.definition, opts)

		-- Go to implementation
		vim.keymap.set('n', '<leader>gi', vim.lsp.buf.implementation, opts)

		-- Find references
		vim.keymap.set('n', '<leader>gr', vim.lsp.buf.references, opts)

		-- Rename
		vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)

		-- Code actions
		vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)

		-- Format
		vim.keymap.set('n', '<leader>fm', function() vim.lsp.buf.format { async = true } end, opts)

		local client = vim.lsp.get_client_by_id(ev.data.client_id)

		if client.server_capabilities.documentHighlightProvider then
			vim.api.nvim_create_augroup("lsp_document_highlight", { clear = true })

			vim.api.nvim_clear_autocmds { buffer = ev.bufnr, group = "lsp_document_highlight" }

			-- Highlight when cursor holds on a position
			vim.api.nvim_create_autocmd("CursorHold", {
				callback = vim.lsp.buf.document_highlight,
				buffer = ev.bufnr,
				group = "lsp_document_highlight",
				desc = "Highlight in document",
			})

			-- Clear LSP highlights when cursor moves
			vim.api.nvim_create_autocmd("CursorMoved", {
				callback = vim.lsp.buf.clear_references,
				buffer = ev.bufnr,
				group = "lsp_document_highlight",
				desc = "Clear All the References",
			})
		end

		if client.supports_method('textDocument/formatting') then
			-- Format the current buffer on save
			vim.api.nvim_create_autocmd('BufWritePre', {
				buffer = ev.buf,
				callback = function()
					vim.lsp.buf.format({ bufnr = ev.buf, id = client.id })
				end,
			})
		end
	end,
})
