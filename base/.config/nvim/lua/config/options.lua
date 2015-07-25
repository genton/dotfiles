local opt = vim.opt

-- Line numbers
opt.number = true
opt.relativenumber = true

-- Indentation (Python: 4 spaces)
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.smartindent = true

-- Display
opt.wrap = false
opt.cursorline = true
opt.colorcolumn = "88"       -- ruff/black default line length
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.signcolumn = "yes"
opt.showmode = false          -- lualine handles this
opt.termguicolors = true
opt.pumheight = 10

-- Files
opt.swapfile = false
opt.backup = false
opt.undofile = true
opt.undodir = vim.fn.expand("~/.vim/undodir")
opt.fileencoding = "utf-8"

-- Search
opt.hlsearch = true
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true

-- Splits
opt.splitbelow = true
opt.splitright = true

-- Performance
opt.updatetime = 50
opt.timeoutlen = 300

-- Clipboard
opt.clipboard = "unnamedplus"

-- Mouse
opt.mouse = "a"

-- Completion
opt.completeopt = { "menuone", "noselect" }

-- Folds
opt.foldenable = false        -- open all folds on start
