require "nvchad.options"

-- add yours here!

vim.opt.clipboard = "" -- Don't copy to system clipboard
vim.opt.cursorlineopt ='both' -- to enable cursorline!

vim.opt.ignorecase = true -- Ignore case when searching
vim.opt.smartcase = true -- Only respect capitals when provided when searching
vim.opt.incsearch = true -- Show search results as you type
vim.opt.hlsearch = true -- Highlight search results

vim.opt.number = true -- Enable line numbers
vim.opt.relativenumber = true -- Enable relative line numbers

vim.opt.swapfile = false
vim.opt.backup = false

vim.opt.tabstop = 4 -- Number of spaces a tab represents
vim.opt.shiftwidth = 4 -- Number of spaces for each indentation
vim.opt.expandtab = true -- Convert tabs to spaces
vim.opt.smartindent = true -- Automatically indent new lines

-- Navigate vim panes better
vim.keymap.set('n', '<c-k>', ':wincmd k<CR>')
vim.keymap.set('n', '<c-j>', ':wincmd j<CR>')
vim.keymap.set('n', '<c-h>', ':wincmd h<CR>')
vim.keymap.set('n', '<c-l>', ':wincmd l<CR>')

vim.opt.wrap = false -- Disable line wrapping
vim.opt.cursorline = true -- Highlight the current line
vim.opt.termguicolors = true -- Enable 24-bit RGB colors

vim.cmd[[
augroup highlight_yank
autocmd!
au TextYankPost * silent! lua vim.highlight.on_yank({higroup="Visual", timeout=300})
augroup END
]]

