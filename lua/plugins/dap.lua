-- ~/.config/nvim/lua/plugins/dap-python.lua
return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "rcarriga/nvim-dap-ui",
      "mfussenegger/nvim-dap-python",
      "theHamsta/nvim-dap-virtual-text",
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      local dap_python = require("dap-python")

      ----------------------------------------------------------------------
      -- 1) Resolve python from the *current* working directory (.venv first)
      ----------------------------------------------------------------------
      local function get_venv_python()
        local cwd = vim.fn.getcwd()
        local candidates = {
          cwd .. "/.venv/bin/python",
          cwd .. "/venv/bin/python",
        }
        for _, p in ipairs(candidates) do
          if vim.fn.executable(p) == 1 then
            return p
          end
        end
        if vim.env.VIRTUAL_ENV and vim.fn.executable(vim.env.VIRTUAL_ENV .. "/bin/python") == 1 then
          return vim.env.VIRTUAL_ENV .. "/bin/python"
        end
        return "python3"
      end

      ----------------------------------------------------------------------
      -- 2) UI & Virtual Text
      ----------------------------------------------------------------------
      dapui.setup({})
      require("nvim-dap-virtual-text").setup({ commented = true })

      ----------------------------------------------------------------------
      -- 3) Dynamic adapter + configuration (resolved per run)
      --    Using a function adapter makes command resolve at execution time.
      ----------------------------------------------------------------------
      dap.adapters.python = function(cb)
        cb({
          type = "executable",
          command = get_venv_python(),
          args = { "-m", "debugpy.adapter" },
        })
      end

      dap.configurations.python = {
        {
          type = "python",
          request = "launch",
          name = "Debug file",
          program = "${file}",
          pythonPath = function() return get_venv_python() end,
          cwd = "${workspaceFolder}",
          console = "integratedTerminal",
          justMyCode = false,
        },
      }

      ----------------------------------------------------------------------
      -- 4) Keep nvim-dap-python in sync with current venv
      --    We re-run setup on DirChanged so tests use the right interpreter.
      ----------------------------------------------------------------------
      local function refresh_dap_python()
        local py = get_venv_python()
        -- Re-setup to switch interpreter for test helpers
        dap_python.setup(py)
        dap_python.test_runner = "pytest"
      end

      refresh_dap_python()
      vim.api.nvim_create_autocmd("DirChanged", {
        callback = refresh_dap_python,
        desc = "Update dap-python interpreter on directory change",
      })

      ----------------------------------------------------------------------
      -- 5) Signs
      ----------------------------------------------------------------------
      vim.fn.sign_define("DapBreakpoint",         { text = "", texthl = "DiagnosticSignError" })
      vim.fn.sign_define("DapBreakpointRejected", { text = "",  texthl = "DiagnosticSignError" })
      vim.fn.sign_define("DapStopped",            { text = "",  texthl = "DiagnosticSignWarn", linehl = "Visual", numhl = "DiagnosticSignWarn" })

      ----------------------------------------------------------------------
      -- 6) Keymaps (tests call refresh first to avoid stale interpreter)
      ----------------------------------------------------------------------
      local opts = { noremap = true, silent = true }

	vim.keymap.set("n", "<leader>dt", function()
	  dap_python.test_method()
	end, vim.tbl_extend("force", opts, { desc = "Debug: Test Method" }))

	vim.keymap.set("n", "<leader>dT", function()
	  dap_python.test_class()
	end, vim.tbl_extend("force", opts, { desc = "Debug: Test Class" }))

	vim.keymap.set("n", "<leader>db", function()
	  dap.toggle_breakpoint()
	end, vim.tbl_extend("force", opts, { desc = "Debug: Toggle Breakpoint" }))

	vim.keymap.set("n", "<leader>dc", function()
	  dap.continue()
	end, vim.tbl_extend("force", opts, { desc = "Debug: Continue/Start" }))

	vim.keymap.set("n", "<leader>do", function()
	  dap.step_over()
	end, vim.tbl_extend("force", opts, { desc = "Debug: Step Over" }))

	vim.keymap.set("n", "<leader>di", function()
	  dap.step_into()
	end, vim.tbl_extend("force", opts, { desc = "Debug: Step Into" }))

	vim.keymap.set("n", "<leader>dO", function()
	  dap.step_out()
	end, vim.tbl_extend("force", opts, { desc = "Debug: Step Out" }))

	vim.keymap.set("n", "<leader>dq", function()
	  dap.terminate()
	end, vim.tbl_extend("force", opts, { desc = "Debug: Terminate" }))

	vim.keymap.set("n", "<leader>du", function()
	  dapui.toggle()
	end, vim.tbl_extend("force", opts, { desc = "Debug: Toggle UI" }))
    end,
  },
}

