-- TODO:
-- - there is no autoindenting. If i write `fn asd() {\n` the cursor is on the start of the line. This should be set up using tree-sitter semantic information. This seems to be a bug, it is enabled in the tree sitter config
-- - setup LSP
--   - completions (blink.cmp?)
--   - keybinds
-- - setup file tree
-- - setup LLM completion
-- - lualine is used, yet the status bar is still there showing duplicate info
-- - pairing of { " ' ( etc stopped working?
-- - extend selection according to structural information from treesitter
-- - use LSP formatting instead of custom formatters?
-- - use LSP commenting instead of custom plugin? Or in the least this information should be provided by tree-sitter, maybe it is already so?
-- - theme is not switching automatically (this happened after I moved the auto-theme to theme.lua)

-- this needs to be setup before initializing lazy.nvim
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require("init_lazy") -- download lazy.nvim
require("lazy").setup("plugins") -- make the lua/plugins/ a module declaring plugins

vim.opt.number = true -- show line numbers
vim.opt.relativenumber = true -- make line numbers relative
vim.opt.termguicolors = true -- enable 24-bit RGB color support

vim.opt.scrolloff = 10 -- keep a distance of 10 lines between the cursor and borders
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true -- turn tab into spaces
vim.opt.linebreak = true

vim.opt.mouse = "a"

vim.opt.undofile = true -- create a global undo file (you can undo even after reopening the file)

vim.opt.ignorecase = true -- case insensitive searches
vim.opt.smartcase = true -- if a capital is present, do case sensitive search
vim.opt.incsearch = true -- show search matches as you type

-- highlights yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- very common typo remaping
vim.api.nvim_create_user_command("W", "w", { nargs = 0 })
vim.api.nvim_create_user_command("Q", "q", { nargs = 0 })
-- no WQ remapping: use ZZ in normal mode instead

-- ; is the new :
vim.keymap.set("n", ";", ":", {})

-- on C-d/C-u, recenter
vim.keymap.set("n", "<C-d>", "<C-d>zz", {})
vim.keymap.set("n", "<C-u>", "<C-u>zz", {})

-- paste on text without copying the deleted text
vim.keymap.set("v", "<leader>p", '"_dP', {})

-- move block of code up and down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", {})
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", {})

-- search and replace selection
vim.keymap.set("n", "<leader>sc", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("v", "<leader>sc", [[y:%s/\<<C-r><C-r>"\>/<C-r><C-r>"/gI<Left><Left><Left>]])

-- copy to clipboard with leader y
vim.keymap.set("n", "<leader>y", '"+y', {})
vim.keymap.set("v", "<leader>y", '"+y', {})
vim.keymap.set("n", "<leader>Y", '"+Y', {})
vim.keymap.set("v", "<leader>Y", '"+Y', {})

-- make package names in plugins/*.lua clickable URLs
local group = vim.api.nvim_create_augroup("LinkablePackage", { clear = true })
local ns = vim.api.nvim_create_namespace("linkable_package")

vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
	pattern = "*/plugins/*.lua",
	group = group,
	callback = function(opts)
		-- schedule this to run after the buffer is fully loaded to ensure Treesitter is ready
		vim.schedule(function()
			-- check if Treesitter is available
			local ok, parsers = pcall(require, "nvim-treesitter.parsers")
			if not ok or not parsers.has_parser("lua") then
				vim.notify("Treesitter Lua parser not found. Cannot make clickable links.", vim.log.levels.WARN)
				return
			end

			-- get the parser for the current buffer
			local parser = vim.treesitter.get_parser(opts.buf, "lua")
			local tree = parser:parse()[1]
			local root = tree:root()

			-- extract literal string contents (so without surrounding ", ' , [[)
			local query = vim.treesitter.query.parse("lua", "(string_content) @str")

			for _, node, _ in query:iter_captures(root, opts.buf) do
				local text = vim.treesitter.get_node_text(node, opts.buf)
				if string.match(text, "^[^/]+/[^/]+$") then
					local row1, col1, row2, col2 = node:range()
					vim.api.nvim_buf_set_extmark(
						opts.buf,
						ns,
						row1,
						col1,
						{ end_row = row2, end_col = col2, url = "https://github.com/" .. text }
					)
				end
			end
		end)
	end,
})
