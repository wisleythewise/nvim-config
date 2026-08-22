return {
  "ThePrimeagen/99",
  keys = {
    { "<leader>9v", mode = "v", desc = "99: Visual prompt (replace selection)" },
    { "<leader>9s", desc = "99: Search project" },
    { "<leader>9b", desc = "99: Vibe (background generation)" },
    { "<leader>9x", desc = "99: Stop all requests" },
    { "<leader>9o", desc = "99: Open last result" },
    { "<leader>9l", desc = "99: View logs" },
  },
  config = function()
    local _99 = require("99")
    local Providers = require("99.providers")

          -- For logging that is to a file if you wish to trace through requests
          -- for reporting bugs, i would not rely on this, but instead the provided
          -- logging mechanisms within 99.  This is for more debugging purposes
          local cwd = vim.uv.cwd()
          local basename = vim.fs.basename(cwd)
    _99.setup({
      provider = Providers.ClaudeCodeProvider,
      logger = {
        level = _99.WARN,
        path = "/tmp/" .. basename .. ".99.debug",
        print_on_error = true,
      },

              --- WARNING: if you change cwd then this is likely broken
              --- ill likely fix this in a later change
              ---
              --- md_files is a list of files to look for and auto add based on the location
              --- of the originating request.  That means if you are at /foo/bar/baz.lua
              --- the system will automagically look for:
              --- /foo/bar/AGENT.md
              --- /foo/AGENT.md
              --- assuming that /foo is project root (based on cwd)
      md_files = {
        "AGENT.md",
      },
    })

    -- visual mode only: takes the current selection, prompts you, and
    -- replaces the selection with the result
    vim.keymap.set("v", "<leader>9v", function()
      _99.visual()
    end)

    -- search across the project with a prompt, results land in the quickfix list
    vim.keymap.set("n", "<leader>9s", function()
      _99.search()
    end)

    -- vibe: agentic generation in the background (replaces old fill_in_function)
    vim.keymap.set("n", "<leader>9b", function()
      _99.vibe()
    end)

    -- cancel any in-flight requests
    vim.keymap.set("n", "<leader>9x", function()
      _99.stop_all_requests()
    end)

    -- open the last result (qfix for search/vibe, tutorial window for tutorial)
    vim.keymap.set("n", "<leader>9o", function()
      _99.open()
    end)

    -- view the most recent logs
    vim.keymap.set("n", "<leader>9l", function()
      _99.view_logs()
    end)
  end,
}
