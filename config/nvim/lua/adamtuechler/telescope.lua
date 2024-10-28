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

local function is_git_repo()
	vim.fn.system("git rev-parse --is-inside-work-tree")

	return vim.v.shell_error == 0
end


local function select_project_files(limit_to_cwd)
	limit_to_cwd = limit_to_cwd or false

	if is_git_repo() then
		require("telescope.builtin").git_files({ use_git_root = not limit_to_cwd })
	else
		require("telescope.builtin").find_files({ hidden = true })
	end
end

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', select_project_files)
vim.keymap.set('n', '<leader>fd', function() select_project_files(true) end)
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<C-f>', builtin.live_grep, {})
