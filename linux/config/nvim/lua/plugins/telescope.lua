return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release --target install",
			},
		},
		keys = {
			{ "<leader>ff", require("telescope.builtin").find_files, desc = "Telescope find files" },
			{ "<leader>fg", require("telescope.builtin").live_grep, desc = "Telescope live grep" },
			{ "<leader>fb", require("telescope.builtin").buffers, desc = "Telescope buffers" },
			{ "<leader>fh", require("telescope.builtin").help_tags, desc = "Telescope help tags" },
		},
		config = function()
			local telescope = require("telescope")
			local actions = require("telescope.actions")

			telescope.setup({
				defaults = {
					mappings = {
						i = {
							["<esc>"] = actions.close,
							["<C-j>"] = actions.move_selection_next,
							["<C-k>"] = actions.move_selection_previous,
							["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
						},
					},
				},
				pickers = {},
				extensions = {},
			})

			telescope.load_extension("fzf")
		end,
	},
}
