return {
  {
    "mg979/vim-visual-multi",
    branch = "master",
    keys = {
      { "<C-n>", mode = { "n", "v" }, desc = "Select next occurrence" },
      { "<C-Up>", mode = { "n", "v" }, desc = "Add cursor up" },
      { "<C-Down>", mode = { "n", "v" }, desc = "Add cursor down" },
    },
    init = function()
      -- Make escape exit VM mode immediately without delay
      vim.g.VM_maps = {
        ["Exit"] = "<Esc>",
      }
      -- Quit VM after leaving insert mode (single escape exits fully)
      vim.g.VM_quit_after_leaving_insert_mode = 1
    end,
  },
}
