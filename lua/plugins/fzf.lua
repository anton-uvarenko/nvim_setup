return {
  "ibhagwan/fzf-lua",
  opts = {
    winopts = {
      preview = {
        layout = "vertical",
      },
    },
    files = {
      fd_opts = [[--color=never --type f --hidden --follow --exclude .git]],
      rg_opts = [[--color=never --files --hidden --follow -g "!.git"]],
    },
    grep = {
      rg_opts = table.concat({
        "--hidden",
        "--column",
        "--line-number",
        "--no-heading",
        "--color=always",
        "--smart-case",
        "--max-columns=4096",
        "-g '!.git'",
        "-e",
      }, " "),
    },
  },
}
