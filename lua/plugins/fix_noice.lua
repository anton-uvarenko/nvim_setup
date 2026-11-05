return {
  -- Configure noice.nvim for cmdline UI, disable snacks notifier to avoid conflict
  {
    "folke/snacks.nvim",
    opts = {
      notifier = { enabled = false },
    },
  },
}
