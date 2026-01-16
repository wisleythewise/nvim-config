-- gh-dash: GitHub dashboard in floating terminal
-- Usage: <leader>gd to open gh-dash (like LazyGit but for GitHub PRs/Issues)
return {
  "voldikss/vim-floaterm",
  keys = {
    {
      "<leader>gd",
      "<cmd>FloatermNew --name=gh-dash --title=gh-dash --width=0.9 --height=0.9 --autoclose=2 gh dash<cr>",
      desc = "GitHub Dashboard (gh-dash)",
    },
  },
}
