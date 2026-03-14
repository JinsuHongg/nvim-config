return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"nvim-neotest/nvim-nio",
		"rcarriga/nvim-dap-ui",
		"mfussenegger/nvim-dap-python",
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")

		require("dapui").setup()
		require("dap-python").setup("uv")
    require("dap-python").test_runner = "pytest"
    require('dap').defaults.fallback.focus_terminal = false
		-- Horizontal split height (lines)
    dap.defaults.fallback.terminal_win_cmd = "botright 25split"  -- 15 lines

    -- Open UI on session start
    dap.listeners.before.event_initialized["dapui_config"] = function()
      dapui.open()
    end

    -- Close UI only if session ended normally
    dap.listeners.after.event_terminated["dapui_config"] = function(session)
      if not session then return end  -- safety
      -- Check if the session stopped due to an exception
      if session.exception_info then
        -- keep UI open
        return
      end
      dapui.close()
    end

    dap.listeners.after.event_exited["dapui_config"] = function(session)
      if not session then return end
      if session.exception_info then
        return
      end
      dapui.close()
    end

    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'dap-repl',
      callback = function()
        require('dap.ext.autocompl').attach()
        vim.opt_local.completeopt = 'menuone,noinsert,noselect'
      end,
    })

		vim.fn.sign_define("DapBreakpoint", {
			text = "🔴",
			texthl = "DapBreakpoint",
			linehl = "",
			numhl = "",
		})

		vim.fn.sign_define("DapBreakpointCondition", {
			text = "🟡",
			texthl = "DapBreakpointCondition",
			linehl = "",
			numhl = "",
		})

		vim.fn.sign_define("DapLogPoint", {
			text = "🟢",
			texthl = "DapLogPoint",
			linehl = "",
			numhl = "",
		})

		vim.fn.sign_define("DapStopped", {
			text = "➡️",
			texthl = "DapStopped",
			linehl = "Visual",
			numhl = "",
		})

		vim.keymap.set("n", "<F5>", dap.continue)
		vim.keymap.set("n", "<F10>", dap.step_over)
		vim.keymap.set("n", "<F11>", dap.step_into)
		vim.keymap.set("n", "<F12>", dap.step_out)
		vim.keymap.set("n", "<Leader>b", dap.toggle_breakpoint)
    vim.keymap.set("n", "<Leader>du", dapui.toggle)
		vim.keymap.set("n", "<Leader>B", function()
			dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
		end)
	end,
}
