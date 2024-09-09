return {
  "jiaoshijie/undotree",
  dependencies = "nvim-lua/plenary.nvim",
  config = function()
    require("undotree").setup({
      keymaps = {
        ["j"] = "move_next",
        ["k"] = "move_prev",
        ["gj"] = "move2parent",
        ["J"] = "move_change_next",
        ["K"] = "move_change_prev",
        ["<cr>"] = "action_enter",
        ["p"] = "enter_diffbuf",
        ["q"] = "quit",
      },
    })
    vim.keymap.set("n", "<leader>uu", require("undotree").toggle, { noremap = true, silent = true })
  end,
}
