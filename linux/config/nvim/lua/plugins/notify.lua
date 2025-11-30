return {
	"rcarriga/nvim-notify",

	opts = {
		stages = "fade_in_slide_out",
		timeout = 3000,
		render = "wrapped-compact",
	},
	init = function()
		vim.notify = require("notify")
	end,
}
