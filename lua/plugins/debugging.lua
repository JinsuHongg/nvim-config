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

    require("dapui").setup({
			layouts = {
				{
					-- The left sidebar (scopes, breakpoints, etc.)
					elements = {
						{ id = "scopes", size = 0.25 },
						{ id = "breakpoints", size = 0.25 },
						{ id = "stacks", size = 0.25 },
						{ id = "watches", size = 0.25 },
					},
					position = "left",
					size = 40, -- Width of the left sidebar
				},
				{
					-- The bottom tray (REPL and console)
					elements = {
						{ id = "repl", size = 0.5 },
						{ id = "console", size = 0.5 },
					},
					position = "bottom",
					size = 15, -- Lowered to 15 so it fits on most screens
				},
			},
		})		
    require("dap-python").setup("python")
    require("dap-python").test_runner = "pytest"
    for _, config in pairs(require("dap").configurations.python or {}) do
        config.console = "internalConsole"
    end
    require('dap').defaults.fallback.focus_terminal = false

		dap.defaults.fallback.terminal_win_cmd = "botright 15split new"
    
    -- Track whether session stopped due to exception
		local stopped_on_exception = false
		-- Variable to store our window layout snapshot
		local window_layout = ""

		dap.listeners.after.event_stopped["dapui_config"] = function(session, body)
			if body and body.reason == "exception" then
				stopped_on_exception = true
			end
		end

		dap.listeners.before.event_initialized["dapui_config"] = function()
			stopped_on_exception = false  -- reset on new session
			-- 1. Take a snapshot of window sizes before opening DAP UI
			window_layout = vim.fn.winrestcmd() 
			dapui.open()
		end

		dap.listeners.after.event_terminated["dapui_config"] = function()
			if not stopped_on_exception then
				dapui.close()
				-- 2. Restore the window sizes after closing DAP UI
				vim.schedule(function()
					if window_layout ~= "" then vim.cmd(window_layout) end
				end)
			end
		end

		dap.listeners.after.event_exited["dapui_config"] = function(_, body)
			if body and body.exitCode ~= 0 then return end  -- non-zero exit, keep open
			if not stopped_on_exception then
				dapui.close()
				-- 2. Restore the window sizes after closing DAP UI
				vim.schedule(function()
					if window_layout ~= "" then vim.cmd(window_layout) end
				end)
			end
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
