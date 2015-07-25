return {
  -- Mason: LSP installer
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    keys = { { "<leader>lm", "<cmd>Mason<CR>", desc = "Mason" } },
    build = ":MasonUpdate",
    opts = {
      ui = { border = "rounded" },
      ensure_installed = {
        "pyright",
        "ruff",
        "rust-analyzer",
        "codelldb",
        "debugpy",
      },
    },
    config = function(_, opts)
      require("mason").setup(opts)
      -- Auto-install tools listed in ensure_installed
      local mr = require("mason-registry")
      mr.refresh(function()
        for _, tool in ipairs(opts.ensure_installed) do
          local p = mr.get_package(tool)
          if not p:is_installed() then
            p:install()
          end
        end
      end)
    end,
  },

  -- Mason <-> lspconfig bridge
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      ensure_installed = { "pyright" },
      automatic_installation = true,
    },
  },

  -- LSP configuration
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- Diagnostic signs
      local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
      end

      vim.diagnostic.config({
        virtual_text = { prefix = "●" },
        update_in_insert = false,
        severity_sort = true,
        float = { border = "rounded", source = "always" },
      })

      -- Keymaps applied on LSP attach
      local on_attach = function(_, buf)
        local map = function(keys, func, desc)
          vim.keymap.set("n", keys, func, { buffer = buf, desc = desc })
        end
        local tb = require("telescope.builtin")

        map("gd",         tb.lsp_definitions,          "Go to definition")
        map("gD",         vim.lsp.buf.declaration,     "Go to declaration")
        map("gr",         tb.lsp_references,           "References")
        map("gi",         tb.lsp_implementations,      "Implementations")
        map("gt",         tb.lsp_type_definitions,     "Type definition")
        map("K",          vim.lsp.buf.hover,           "Hover docs")
        map("<C-s>",      vim.lsp.buf.signature_help,  "Signature help")
        map("<leader>lr", vim.lsp.buf.rename,          "Rename")
        map("<leader>la", vim.lsp.buf.code_action,     "Code action")
        map("<leader>ld", tb.diagnostics,              "Diagnostics")
        map("<leader>lf", function() vim.lsp.buf.format({ async = true }) end, "Format")
        map("]d",         vim.diagnostic.goto_next,    "Next diagnostic")
        map("[d",         vim.diagnostic.goto_prev,    "Prev diagnostic")
        map("<leader>le", vim.diagnostic.open_float,   "Show diagnostic")
      end

      -- Pyright (type checking, go-to-def, hover)
      lspconfig.pyright.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
          python = {
            analysis = {
              typeCheckingMode = "basic",
              autoImportCompletions = true,
              useLibraryCodeForTypes = true,
            },
          },
        },
      })

      -- Ruff (linting — disable hover/format to avoid conflict with pyright/conform)
      lspconfig.ruff.setup({
        capabilities = capabilities,
        on_attach = function(client, buf)
          client.server_capabilities.hoverProvider = false
          on_attach(client, buf)
        end,
      })
    end,
  },
}
