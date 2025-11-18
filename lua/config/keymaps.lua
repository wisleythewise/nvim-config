-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Leader+r: Substitute word under cursor
vim.keymap.set("n", "<leader>r", ":%s/<C-r><C-w>//gc<Left><Left><Left>", { desc = "Substitute word under cursor" })
