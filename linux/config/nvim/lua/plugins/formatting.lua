return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			tex = { "latexindent" },
			bib = { "latexindent" },
			markdown = { "denofmt" },
			json = { "denofmt" },
			scala = { "scalafmt" },
			c = { "clangfmt" },
			cpp = { "clangfmt" },
			zig = { "zigfmt" },
			go = { "gofmt" },
			swift = { "swiftfmt" },
			dart = { "dartfmt" },
		},
		format_on_save = { timeout_ms = 500, lsp_fallback = true },
		formatters = {
			denofmt = {
				command = "deno",
				args = { "fmt", "--prose-wrap", "preserve", "$FILENAME" },
				stdin = false,
			},
			scalafmt = {
				command = "scalafmt",
				args = { "--stdin", "--stdout" },
			},
			clangfmt = {
				command = "clang-format",
				args = { "--style=Chromium" },
			},
			zigfmt = {
				command = "zig",
				args = { "fmt", "--stdin" },
			},
			swiftfmt = {
				command = "swift-format",
			},
			dartfmt = {
				command = "dart",
				args = { "format" },
			},
		},
	},
}
