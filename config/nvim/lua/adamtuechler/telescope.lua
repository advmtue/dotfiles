-- Fuzzy finder: files and buffers
--
require('telescope').setup({
	defaults = {
		mappings = {
			i = {
				['<C-d>'] = require('telescope.actions').delete_buffer
			}
		},
		layout_strategy = "vertical",
		layout_config = {
			vertical = {
				height = 0.8,
				width = 0.9
			}
		},
		border = true
	},
	pickers = {
		find_files = { hidden = true }
	}
})

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {}, { hidden = true })
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<C-f>', builtin.live_grep, {})
