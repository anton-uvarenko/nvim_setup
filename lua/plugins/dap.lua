return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "leoluz/nvim-dap-go",
    "nvim-neotest/nvim-nio",
  },

  config = function()
    local dap, dapui = require("dap"), require("dapui")

    require("dapui").setup()
    -- require("dap-go").setup()

    dap.listeners.before.attach.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
      dapui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
      dapui.close()
    end

    vim.keymap.set("n", "<Leader>dt", dapui.toggle, { desc = "toggle ui" })
    vim.keymap.set("n", "<Leader>db", dap.toggle_breakpoint, { desc = "breakpoint" })
    vim.keymap.set("n", "<Leader>dB", dap.clear_breakpoints, { desc = "clear breakpoints" })
    vim.keymap.set("n", "<F1>", dap.step_into, { desc = "step into" })
    vim.keymap.set("n", "<F2>", dap.step_over, { desc = "step over" })
    vim.keymap.set("n", "<F3>", dap.step_out, { desc = "step out" })
    vim.keymap.set("n", "<F4>", dap.run_to_cursor, { desc = "run to cursor" })
    vim.keymap.set("n", "<Leader>dc", dap.continue, { desc = "continue" })
    vim.keymap.set("n", "<Leader>ds", dap.close, { desc = "stop" })
    vim.keymap.set("n", "<Leader>dr", ":lua require('dapui').open({reset = true})<CR>", { desc = "reset" })

    vim.fn.sign_define(
      "DapBreakpoint",
      { text = "⏺", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
    )
  end,
}
