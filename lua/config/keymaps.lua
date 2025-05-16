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

-- vim.keymap.set("n", "<leader>e", "<CMD>e .<CR>", { noremap = true, silent = true })

-- ExampleWord
