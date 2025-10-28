-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--

-- require("undotree").setup('n', "<leader>uu", )
-- vim.keymap.set("n", "<leader>uu", require("undotree").toggle, { noremap = true, silent = true })
--
-- -- or
-- vim.keymap.set("n", "<leader>uo", require("undotree").open, { noremap = true, silent = true })
-- vim.keymap.set("n", "<leader>uc", require("undotree").close, { noremap = true, silent = true })

vim.opt.swapfile = false

vim.keymap.set(
  "n",
  "<leader>ccs",
  "<CMD>lua require('textcase').current_word('to_snake_case')<CR>",
  { noremap = true, silent = true }
)

vim.keymap.set("n", "<leader>e", "<CMD>Oil<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>E", "<CMD>Oil .<CR>", { noremap = true, silent = true })

vim.keymap.set(
  "n",
  "<leader>by",
  ':lua vim.fn.setreg("+", vim.fn.expand("%:p"))<CR>',
  { noremap = true, silent = true, desc = "copy current file path to clipboard" }
)

-- Workspace errors only
vim.keymap.set("n", "<leader>se", function()
  require("fzf-lua").diagnostics_workspace({
    severity = vim.diagnostic.severity.ERROR,
  })
end, { desc = "Workspace Diagnostics (Errors)" })

-- vim.keymap.set("n", "<leader>e", "<CMD>e .<CR>", { noremap = true, silent = true })

-- ExampleWord

vim.keymap.set("x", "<leader>re", ":Refactor extract ")
vim.keymap.set("x", "<leader>rf", ":Refactor extract_to_file ")

vim.keymap.set("x", "<leader>rv", ":Refactor extract_var ")

vim.keymap.set({ "n", "x" }, "<leader>ri", ":Refactor inline_var")

vim.keymap.set("n", "<leader>rI", ":Refactor inline_func")

vim.keymap.set("n", "<leader>rb", ":Refactor extract_block")
vim.keymap.set("n", "<leader>rbf", ":Refactor extract_block_to_file")
