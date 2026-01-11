return {
  "voldikss/vim-floaterm",
  keys = {
    { "<A-t>", "<cmd>FloatermToggle<cr>", desc = "Toggle terminal" },
    { "<A-t>", "<cmd>FloatermToggle<cr>", mode = "t", desc = "Toggle terminal" },
    { "<A-n>", "<cmd>FloatermNew<cr>", desc = "New terminal" },
    { "<A-]>", "<cmd>FloatermNext<cr>", desc = "Next terminal" },
    { "<A-[>", "<cmd>FloatermPrev<cr>", desc = "Previous terminal" },
  },
  cmd = { "FloatermNew", "FloatermToggle" },
  init = function()
    vim.g.floaterm_width = 0.8
    vim.g.floaterm_height = 0.8
    vim.g.floaterm_title = "Terminal ($1/$2)"
    vim.g.floaterm_borderchars = "─│─│╭╮╯╰"
  end,
}
