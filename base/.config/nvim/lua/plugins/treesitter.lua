return {
  -- Parser manager (nvim-treesitter v1.0 — new API, no configs.setup())
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      -- Install parsers (async; safe to call on every startup)
      require("nvim-treesitter").install({
        "python", "rust", "lua", "vim", "vimdoc", "bash", "json", "yaml",
        "toml", "markdown", "markdown_inline", "html", "css",
        "javascript", "typescript", "regex", "sql",
      })

      -- Enable treesitter highlighting per filetype
      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("TreesitterHighlight", { clear = true }),
        callback = function(args)
          pcall(vim.treesitter.start, args.buf)
        end,
      })
    end,
  },

  -- Textobjects (new API: explicit vim.keymap.set calls)
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    lazy = false,
    config = function()
      local sel  = require("nvim-treesitter-textobjects.select")
      local move = require("nvim-treesitter-textobjects.move")
      local swap = require("nvim-treesitter-textobjects.swap")

      require("nvim-treesitter-textobjects").setup({
        select = { lookahead = true },
        move   = { set_jumps = true },
      })

      local map = vim.keymap.set

      -- Select
      map({ "x", "o" }, "af", function() sel.select_textobject("@function.outer", "textobjects") end, { desc = "Outer function" })
      map({ "x", "o" }, "if", function() sel.select_textobject("@function.inner", "textobjects") end, { desc = "Inner function" })
      map({ "x", "o" }, "ac", function() sel.select_textobject("@class.outer",    "textobjects") end, { desc = "Outer class" })
      map({ "x", "o" }, "ic", function() sel.select_textobject("@class.inner",    "textobjects") end, { desc = "Inner class" })
      map({ "x", "o" }, "aa", function() sel.select_textobject("@parameter.outer","textobjects") end, { desc = "Outer param" })
      map({ "x", "o" }, "ia", function() sel.select_textobject("@parameter.inner","textobjects") end, { desc = "Inner param" })

      -- Move
      map({ "n", "x", "o" }, "]f", function() move.goto_next_start("@function.outer",     "textobjects") end, { desc = "Next function start" })
      map({ "n", "x", "o" }, "[f", function() move.goto_previous_start("@function.outer",  "textobjects") end, { desc = "Prev function start" })
      map({ "n", "x", "o" }, "]c", function() move.goto_next_start("@class.outer",         "textobjects") end, { desc = "Next class start" })
      map({ "n", "x", "o" }, "[c", function() move.goto_previous_start("@class.outer",     "textobjects") end, { desc = "Prev class start" })

      -- Swap parameters
      map("n", "<leader>a", function() swap.swap_next("@parameter.inner")     end, { desc = "Swap param next" })
      map("n", "<leader>A", function() swap.swap_previous("@parameter.inner") end, { desc = "Swap param prev" })
    end,
  },
}
