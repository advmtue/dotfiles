-- File and buffer switching and searching
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
local utils = require('telescope.utils')
vim.keymap.set('n', '<leader>ff', function()
	builtin.find_files({ find_command = { "rg", "--ignore", "--hidden", "--glob=!.git/", "--files" } })
end)
vim.keymap.set('n', '<leader>fd', function() builtin.find_files({ cwd = utils.buffer_dir() }) end)
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<C-f>', builtin.live_grep, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
