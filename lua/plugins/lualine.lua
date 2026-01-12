return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  opts = function(_, opts)
    -- Clear left side
    opts.sections.lualine_a = {}  -- removes mode
    opts.sections.lualine_b = {}  -- removes branch from left
    opts.sections.lualine_c = {
      { "filename", path = 1 }  -- path=1 shows relative path to cwd
    }
    -- Right side - only branch
    opts.sections.lualine_x = {}
    opts.sections.lualine_y = {}
    opts.sections.lualine_z = { "branch" }  -- branch on right
  end,
}
