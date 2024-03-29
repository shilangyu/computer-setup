require("init_lazy") -- download lazy.nvim

require("lazy").setup("plugins") -- make the lua/plugins/ a module declaring plugins

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.termguicolors = true
vim.opt.scrolloff = 10
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.linebreak = true
vim.opt.mouse = "a"
vim.opt.undofile = true

vim.g.rustfmt_autosave = true

-- TODO: make :W and :Q remapped to :w and :q (common typo)
-- TODO: do something about sharing platform clipboard with yanking
