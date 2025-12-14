return {
  "github/copilot.vim",
  lazy = false,
  config = function()
    -- Disable default Tab mapping so you can define your own
    vim.g.copilot_no_tab_map = true

    -- Enable Copilot for these filetypes
    vim.g.copilot_filetypes = {
      markdown = true,
      text = true,
      rust = true,
      lua = true,
      python = true,
    }

    -- Keymaps for Copilot actions
    vim.keymap.set("i", "<C-g>", 'copilot#Accept("<Tab>")', {
      expr = true,
      replace_keycodes = false,
      silent = true,
      desc = "Accept Copilot suggestion",
    })

    vim.keymap.set("i", "<C-]>", "<Plug>(copilot-next)", {
      desc = "Next Copilot suggestion",
    })

    vim.keymap.set("i", "<C-[>", "<Plug>(copilot-previous)", {
      desc = "Previous Copilot suggestion",
    })

    vim.keymap.set("i", "<C-\\>", "<Plug>(copilot-dismiss)", {
      desc = "Dismiss Copilot suggestion",
    })

    -- Enable/Disable Copilot
    vim.keymap.set("n", "<leader>qj", "<cmd>Copilot enable<CR>", {
      desc = "Enable Copilot",
    })

    vim.keymap.set("n", "<leader>qk", "<cmd>Copilot disable<CR>", {
      desc = "Disable Copilot",
    })
  end,
}
