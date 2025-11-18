-- Disable conceal globally to prevent TreeSitter crashes
vim.o.conceallevel = 0
vim.o.concealcursor = ""

return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "bash",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "vim",
        "vimdoc",
        "yaml",
      })
    end,
    keys = {
      {
        "<leader>tr",
        function()
          local buf = vim.api.nvim_get_current_buf()
          local ft = vim.api.nvim_buf_get_option(buf, "filetype")

          vim.notify("Stopping TreeSitter for " .. ft .. "...", vim.log.levels.INFO)
          pcall(vim.treesitter.stop, buf)

          vim.defer_fn(function()
            if vim.api.nvim_buf_is_valid(buf) then
              vim.notify("Restarting TreeSitter for " .. ft .. "...", vim.log.levels.INFO)
              local ok, err = pcall(vim.treesitter.start, buf)
              if not ok then
                vim.notify("Failed to restart TreeSitter: " .. tostring(err), vim.log.levels.ERROR)
              else
                vim.notify("TreeSitter restarted successfully for " .. ft, vim.log.levels.INFO)
              end
            end
          end, 500)
        end,
        desc = "Restart TreeSitter",
      },
    },
  },
}
