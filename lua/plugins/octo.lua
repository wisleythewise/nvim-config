-- octo.nvim: Full GitHub integration in Neovim
-- PRs, Issues, Code Review with inline comments
return {
  "pwntester/octo.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
    "nvim-tree/nvim-web-devicons",
  },
  cmd = { "Octo" },
  keys = {
    -- Main entry points
    { "<leader>go", "<cmd>Octo<cr>", desc = "Octo (GitHub)" },

    -- PR commands
    { "<leader>gpl", "<cmd>Octo pr list<cr>", desc = "List PRs" },
    { "<leader>gpc", "<cmd>Octo pr create<cr>", desc = "Create PR" },
    { "<leader>gpf", "<cmd>Octo pr changes<cr>", desc = "PR changed files" },
    { "<leader>gpd", "<cmd>Octo pr diff<cr>", desc = "PR diff" },
    { "<leader>gpm", "<cmd>Octo pr commits<cr>", desc = "PR commits" },
    { "<leader>gpo", "<cmd>Octo pr checkout<cr>", desc = "Checkout PR" },

    -- Issue commands
    { "<leader>gil", "<cmd>Octo issue list<cr>", desc = "List Issues" },
    { "<leader>gic", "<cmd>Octo issue create<cr>", desc = "Create Issue" },

    -- Review commands
    { "<leader>grs", "<cmd>Octo review start<cr>", desc = "Start review" },
    { "<leader>grr", "<cmd>Octo review resume<cr>", desc = "Resume review" },
    { "<leader>grS", "<cmd>Octo review submit<cr>", desc = "Submit review" },
    { "<leader>grd", "<cmd>Octo review discard<cr>", desc = "Discard review" },

    -- Comments
    { "<leader>gca", "<cmd>Octo comment add<cr>", desc = "Add comment" },
    { "<leader>gcd", "<cmd>Octo comment delete<cr>", desc = "Delete comment" },
  },
  config = function()
    require("octo").setup({
      enable_builtin = true,
      default_remote = { "upstream", "origin" },
      picker = "telescope",
      picker_config = {
        use_emojis = true,
      },
      suppress_missing_scope = {
        projects_v2 = true,
      },
    })

    -- Disable folding in all Octo buffers so diff is fully expanded
    -- Use BufWinEnter (fires after buffer is displayed) and delay to ensure folds are set up
    vim.api.nvim_create_autocmd({ "BufWinEnter", "BufEnter" }, {
      pattern = "*",
      callback = function()
        local bufname = vim.api.nvim_buf_get_name(0)
        local ft = vim.bo.filetype
        -- Match Octo buffers by name pattern or filetype
        if bufname:match("^o//") or bufname:match("^octo://") or ft:match("^octo") then
          -- Set high context for diffs
          vim.opt_local.diffopt:append("context:999")
          vim.opt_local.foldenable = false
          vim.opt_local.foldlevel = 99
          -- Delay zR to run after Octo finishes setting up
          vim.defer_fn(function()
            if vim.api.nvim_buf_is_valid(0) then
              pcall(function() vim.cmd("normal! zR") end)
            end
          end, 100)
        end
      end,
    })
  end,
}
