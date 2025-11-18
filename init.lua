-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.undofile = false

-- Use OSC52 for clipboard only when running inside Docker
local function is_docker()
  local f = io.open("/.dockerenv", "r")
  if f then
    f:close()
    return true
  end
  return false
end

if is_docker() then
  -- Use a wrapper script to access host clipboard via nsenter
  vim.g.clipboard = {
    name = "docker-host",
    copy = {
      ["+"] = {"sh", "-c", 'cat > /workspace/.nvim-clipboard'},
      ["*"] = {"sh", "-c", 'cat > /workspace/.nvim-clipboard'},
    },
    paste = {
      ["+"] = {"sh", "-c", 'cat /workspace/.nvim-clipboard 2>/dev/null || echo ""'},
      ["*"] = {"sh", "-c", 'cat /workspace/.nvim-clipboard 2>/dev/null || echo ""'},
    },
    cache_enabled = 0,
  }

  -- Ensure we always use the + register for yanking
  vim.opt.clipboard = "unnamedplus"
end

