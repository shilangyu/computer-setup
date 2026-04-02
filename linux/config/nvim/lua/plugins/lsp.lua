return {
	{
		"https://github.com/neovim/nvim-lspconfig",
		init = function()
			vim.lsp.enable({ "lua_ls", "terraformls", "fish_lsp", "gopls", "tinymist" })
		end,
	},
}
