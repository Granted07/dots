vim.g.mapleader = " "
vim.g.maplocalleader = " "

local o = vim.opt
o.shiftwidth = 2   -- indent size for >>, <<, auto-indent
o.softtabstop = 2  -- Tab key inserts 2 spaces
o.tabstop = 2      -- how a literal tab is displayed
o.expandtab = true -- use spaces instead of tab charactersi
o.number = true
o.relativenumber = true   -- makes 5j / 12k easy to count
o.cursorline = true
o.scrolloff = 8
o.signcolumn = "yes"
o.clipboard = "unnamedplus"
o.ignorecase = true
o.smartcase = true
o.undofile = true
o.splitright = true
o.splitbelow = true
o.updatetime = 250
o.timeoutlen = 400
o.termguicolors = true
o.wrap = false

-- keymaps
local map = vim.keymap.set
map("n", "<Esc>", "<cmd>nohlsearch<cr>")
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")
map("v", "J", ":m '>+1<cr>gv=gv")   -- move selected lines
map("v", "K", ":m '<-2<cr>gv=gv")
map("v", "<", "<gv")                -- keep selection when indenting
map("v", ">", ">gv")
map("n", "<C-h>", "<C-w>h")         -- window navigation
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")
map("n", "<leader>w", "<cmd>w<cr>")
map("n", "<leader>q", "<cmd>q<cr>")
