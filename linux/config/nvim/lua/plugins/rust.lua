return { {
	"rust-lang/rust.vim",
	config = function(_, opts)
		vim.g.rustfmt_autosave = true
	end,
} }
