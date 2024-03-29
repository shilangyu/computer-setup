return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		opts = {
			auto_install = true,
			ensure_installed = {
				"c",
				"cpp",
				"css",
				"go",
				"html",
				"java",
				"javascript",
				"json",
				"markdown",
				"lua",
				"python",
				"query",
				"rust",
				"yaml",
				"scala",
				"svelte",
				"tsx",
				"typescript",
				"vim",
				"vimdoc",
			},
			highlight = { enable = true },
			indent = { enable = true },
			-- TODO: find out if incremental_selection is interesting
		},
		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)
		end,
	},
}
