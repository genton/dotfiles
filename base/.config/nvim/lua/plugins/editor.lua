return {
  -- File tree
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    cmd = "Neotree",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    keys = {
      { "<leader>e", "<cmd>Neotree toggle<CR>",  desc = "File tree" },
      { "<leader>o", "<cmd>Neotree focus<CR>",   desc = "Focus file tree" },
    },
    opts = {
      close_if_last_window = true,
      window = { width = 30 },
      filesystem = {
        filtered_items = {
          hide_dotfiles = false,
          hide_gitignored = false,
        },
        follow_current_file = { enabled = true },
      },
    },
  },

  -- Fuzzy finder
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        cond = function() return vim.fn.executable("make") == 1 end,
      },
    },
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<CR>",              desc = "Find files" },
      { "<leader>fg", "<cmd>Telescope live_grep<CR>",               desc = "Live grep" },
      { "<leader>fb", "<cmd>Telescope buffers<CR>",                 desc = "Buffers" },
      { "<leader>fh", "<cmd>Telescope help_tags<CR>",               desc = "Help" },
      { "<leader>fr", "<cmd>Telescope oldfiles<CR>",                desc = "Recent files" },
      { "<leader>fs", "<cmd>Telescope lsp_document_symbols<CR>",    desc = "Symbols" },
      { "<leader>fc", "<cmd>Telescope commands<CR>",                desc = "Commands" },
      { "<leader>/",  "<cmd>Telescope current_buffer_fuzzy_find<CR>", desc = "Buffer search" },
    },
    config = function()
      local telescope = require("telescope")
      local actions = require("telescope.actions")
      telescope.setup({
        defaults = {
          mappings = {
            i = {
              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,
              ["<esc>"] = actions.close,
            },
          },
          file_ignore_patterns = { ".git/", "__pycache__/", "%.pyc", "node_modules/" },
          layout_config = { horizontal = { preview_width = 0.55 } },
          borderchars = {
            prompt = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
            results = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
            preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
          },
        },
      })
      pcall(telescope.load_extension, "fzf")
    end,
  },

  -- Harpoon — quick file marks
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = function()
      local harpoon = require("harpoon")
      return {
        { "<leader>ha", function() harpoon:list():add() end,     desc = "Harpoon add" },
        { "<leader>hh", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, desc = "Harpoon menu" },
        { "<leader>1",  function() harpoon:list():select(1) end, desc = "Harpoon 1" },
        { "<leader>2",  function() harpoon:list():select(2) end, desc = "Harpoon 2" },
        { "<leader>3",  function() harpoon:list():select(3) end, desc = "Harpoon 3" },
        { "<leader>4",  function() harpoon:list():select(4) end, desc = "Harpoon 4" },
      }
    end,
    config = function()
      require("harpoon"):setup()
    end,
  },

  -- Git signs + blame
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      signs = {
        add          = { text = "▎" },
        change       = { text = "▎" },
        delete       = { text = "" },
        topdelete    = { text = "" },
        changedelete = { text = "▎" },
        untracked    = { text = "▎" },
      },
      on_attach = function(buf)
        local gs = package.loaded.gitsigns
        local map = function(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = buf, desc = desc })
        end
        map("n", "]h", gs.next_hunk,               "Next hunk")
        map("n", "[h", gs.prev_hunk,               "Prev hunk")
        map("n", "<leader>gp", gs.preview_hunk,    "Preview hunk")
        map("n", "<leader>gb", gs.blame_line,      "Blame line")
        map("n", "<leader>gR", gs.reset_hunk,      "Reset hunk")
        map("n", "<leader>gs", gs.stage_hunk,      "Stage hunk")
        map("n", "<leader>gS", gs.stage_buffer,    "Stage buffer")
        map("n", "<leader>gu", gs.undo_stage_hunk, "Undo stage hunk")
        map("n", "<leader>gd", gs.diffthis,        "Diff this")
      end,
    },
  },

  -- Git client
  {
    "tpope/vim-fugitive",
    cmd = { "Git", "G" },
    keys = {
      { "<leader>gg", "<cmd>Git<CR>",           desc = "Git status" },
      { "<leader>gl", "<cmd>Git log --oneline<CR>", desc = "Git log" },
    },
  },

  -- Auto pairs
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = { check_ts = true },
  },

  -- Comments
  {
    "numToStr/Comment.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {},
  },

  -- Flash (better f/t/search motions)
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end,   desc = "Flash" },
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash treesitter" },
    },
  },

  -- Toggleterm
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    keys = {
      { "<leader>tt", "<cmd>ToggleTerm direction=horizontal<CR>", desc = "Terminal horizontal" },
      { "<leader>tf", "<cmd>ToggleTerm direction=float<CR>",      desc = "Terminal float" },
      { "<leader>tv", "<cmd>ToggleTerm direction=vertical<CR>",   desc = "Terminal vertical" },
      { "<C-\\>",     "<cmd>ToggleTerm<CR>",                      desc = "Toggle terminal", mode = { "n", "t" } },
    },
    opts = {
      size = function(term)
        if term.direction == "horizontal" then return 15
        elseif term.direction == "vertical" then return math.floor(vim.o.columns * 0.35)
        end
      end,
      open_mapping = nil,
      float_opts = { border = "curved" },
    },
  },
}
