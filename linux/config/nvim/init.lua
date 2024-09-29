vim.g.maplocalleader = " "
vim.g.mapleader = " "

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

-- highlights yanked text
vim.cmd([[
    augroup highlight_yank
    autocmd!
        au TextYankPost * silent! lua vim.highlight.on_yank()
    augroup END
]])

-- very common typo remaping
vim.cmd([[command! W write]])
vim.cmd([[command! Q quit]])

-- TODO: do something about sharing platform clipboard with yanking
