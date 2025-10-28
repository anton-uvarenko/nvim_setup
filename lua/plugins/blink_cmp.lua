return {
  "saghen/blink.cmp",
  version = "v1.6.0",
  --
  opts = {
    keymap = {
      preset = "none",

      ["<C-j>"] = { "select_next", "fallback" },
      ["<C-k>"] = { "select_prev", opts = { fallback = false } },
      ["<C-e>"] = { "hide", "fallback" },
      ["<CR>"] = { "accept", "fallback" },
    },

    completion = {
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 200,
      },
    },

    signature = { enabled = true },
  },
}
