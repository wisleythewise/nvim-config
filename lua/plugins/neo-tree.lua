return {
  -- Enable neo-tree file explorer with automatic import updates on file move/rename
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    cmd = "Neotree",
    keys = {
      { "<leader>e", "<cmd>Neotree toggle<cr>", desc = "Toggle Neo-tree" },
      { "<leader>fe", "<cmd>Neotree toggle<cr>", desc = "Toggle Neo-tree" },
    },
    config = function()
      -- Set up event handlers for file operations
      local function on_move(data)
        local snacks_ok, snacks = pcall(require, "snacks")
        if snacks_ok and snacks.rename then
          snacks.rename.on_rename_file(data.source, data.destination)
        end
      end

      require("neo-tree").setup({
        close_if_last_window = false,
        filesystem = {
          follow_current_file = {
            enabled = true,
          },
          use_libuv_file_watcher = true,
        },
        event_handlers = {
          {
            event = "file_moved",
            handler = on_move,
          },
          {
            event = "file_renamed",
            handler = on_move,
          },
        },
      })
    end,
  },
}
