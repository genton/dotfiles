local map = vim.keymap.set

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- ─── Basics ────────────────────────────────────────────────────────────────────
map("n", "<Esc>", "<cmd>nohlsearch<CR>")
map("n", "<leader>w", "<cmd>w<CR>",  { desc = "Save" })
map("n", "<leader>q", "<cmd>q<CR>",  { desc = "Quit" })
map("n", "<leader>Q", "<cmd>qa!<CR>",{ desc = "Quit all" })

-- ─── Navigation ────────────────────────────────────────────────────────────────
-- Keep cursor centered when scrolling / searching
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- Window navigation (handled by vim-tmux-navigator)
-- Mappings removed to allow seamless tmux integration

-- Resize windows
map("n", "<C-Up>",    "<cmd>resize +2<CR>")
map("n", "<C-Down>",  "<cmd>resize -2<CR>")
map("n", "<C-Left>",  "<cmd>vertical resize -2<CR>")
map("n", "<C-Right>", "<cmd>vertical resize +2<CR>")

-- ─── Buffers ───────────────────────────────────────────────────────────────────
map("n", "<S-l>", "<cmd>bnext<CR>",     { desc = "Next buffer" })
map("n", "<S-h>", "<cmd>bprevious<CR>", { desc = "Prev buffer" })
map("n", "<leader>bd", "<cmd>bdelete<CR>", { desc = "Delete buffer" })

-- ─── Move lines in visual mode ─────────────────────────────────────────────────
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- ─── Better paste (don't yank when pasting over selection) ────────────────────
map("x", "<leader>p", [["_dP]], { desc = "Paste without yanking" })

-- ─── System clipboard ──────────────────────────────────────────────────────────
map({ "n", "v" }, "<leader>y", [["+y]],  { desc = "Yank to clipboard" })
map("n",          "<leader>Y", [["+Y]],  { desc = "Yank line to clipboard" })

-- ─── Quickfix ──────────────────────────────────────────────────────────────────
map("n", "<leader>co", "<cmd>copen<CR>",  { desc = "Open quickfix" })
map("n", "<leader>cc", "<cmd>cclose<CR>", { desc = "Close quickfix" })
map("n", "]q", "<cmd>cnext<CR>",          { desc = "Next quickfix" })
map("n", "[q", "<cmd>cprev<CR>",          { desc = "Prev quickfix" })

-- ─── Misc ──────────────────────────────────────────────────────────────────────
-- Join lines without moving cursor
map("n", "J", "mzJ`z")
-- Delete without yanking
map({ "n", "v" }, "<leader>D", [["_d]], { desc = "Delete without yanking" })
-- Better indent (stay in visual mode)
map("v", "<", "<gv")
map("v", ">", ">gv")
-- Select all
map("n", "<C-a>", "gg<S-v>G", { desc = "Select all" })
