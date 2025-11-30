return {
	"nvim-lualine/lualine.nvim",

	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {
		options = {
			theme = "auto",
		},
		sections = {
			lualine_a = { "mode" },
			lualine_b = {},
			lualine_c = { "filename", { "diagnostics", sources = { "nvim_lsp" } } },
			lualine_x = {},
			lualine_y = { "filetype" },
			lualine_z = { "location" },
		},
	},
}
