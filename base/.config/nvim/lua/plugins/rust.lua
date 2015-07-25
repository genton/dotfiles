return {
  {
    "mrcjkb/rustaceanvim",
    version = "^5",
    lazy = false,
    ft = { "rust" },
    config = function()
      vim.g.rustaceanvim = {
        dap = {
          -- The configuration will be handled by rustaceanvim itself
        },
        server = {
          on_attach = function(client, bufnr)
            local map = function(keys, func, desc)
              vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
            end

            -- Use RustLsp specific commands
            map("<leader>la", function() vim.cmd.RustLsp("codeAction") end, "Code Action")
            map("<leader>dr", function() vim.cmd.RustLsp("debuggables") end, "Rust Debuggables")
            map("<leader>lr", function() vim.cmd.RustLsp("rename") end, "Rename")
            map("K", function() vim.cmd.RustLsp("hover") end, "Hover")
          end,
          default_settings = {
            ["rust-analyzer"] = {
              cargo = { allFeatures = true },
              checkOnSave = { command = "clippy" },
              procMacro = { enable = true },
            },
          },
        },
      }
    end,
  },
}
