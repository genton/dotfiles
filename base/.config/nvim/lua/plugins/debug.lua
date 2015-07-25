return {
  -- DAP core
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      -- UI
      {
        "rcarriga/nvim-dap-ui",
        dependencies = { "nvim-neotest/nvim-nio" },
        config = function()
          local dap, dapui = require("dap"), require("dapui")
          dapui.setup()
          -- Auto open/close UI on debug events
          dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
          dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
          dap.listeners.before.event_exited["dapui_config"]     = function() dapui.close() end
        end,
      },
      -- Virtual text
      {
        "theHamsta/nvim-dap-virtual-text",
        opts = {},
      },
      -- Python adapter
      {
        "mfussenegger/nvim-dap-python",
        config = function()
          -- Uses the debugpy installed by mason
          local mason_path = vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python"
          require("dap-python").setup(mason_path)
          -- Add test method support
          require("dap-python").test_runner = "pytest"
        end,
      },
    },
    keys = {
      { "<leader>db", function() require("dap").toggle_breakpoint() end,  desc = "Toggle breakpoint" },
      { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input("Condition: ")) end, desc = "Conditional breakpoint" },
      { "<leader>dc", function() require("dap").continue() end,           desc = "Continue" },
      { "<leader>dn", function() require("dap").step_over() end,          desc = "Step over" },
      { "<leader>di", function() require("dap").step_into() end,          desc = "Step into" },
      { "<leader>do", function() require("dap").step_out() end,           desc = "Step out" },
      { "<leader>dr", function() require("dap").repl.open() end,          desc = "REPL" },
      { "<leader>du", function() require("dapui").toggle() end,           desc = "Toggle DAP UI" },
      { "<leader>dt", function() require("dap-python").test_method() end, desc = "Debug test method", ft = "python" },
    },
  },
}
