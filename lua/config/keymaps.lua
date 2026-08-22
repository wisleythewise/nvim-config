-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Force escape to immediately exit insert mode (no delay)
vim.keymap.set("i", "<Esc>", "<Esc>", { noremap = true, nowait = true })

-- Leader+r: Substitute word under cursor
vim.keymap.set("n", "<leader>r", ":%s/<C-r><C-w>//gc<Left><Left><Left>", { desc = "Substitute word under cursor" })

-- LSP hover info
vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover info" })
