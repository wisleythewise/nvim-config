-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.opt.textwidth = 80
vim.opt.wrap = false

-- Fast escape from insert mode (no delay waiting for escape sequences)
vim.opt.timeoutlen = 300  -- Time to wait for mapped sequence (ms)
vim.opt.ttimeoutlen = 10  -- Time to wait for key code sequence (ms) - makes Esc instant
