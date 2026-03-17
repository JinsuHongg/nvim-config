return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"nvim-neotest/nvim-nio",
		"rcarriga/nvim-dap-ui",
		"mfussenegger/nvim-dap-python",
	},
	-- Tell LazyVim's existing DAP keymaps not to conflict
	keys = {
		{
			"<F5>",
			function()
				require("dap").continue()
			end,
		},
		{
			"<F10>",
			function()
				require("dap").step_over()
			end,
		},
		{
			"<F11>",
			function()
				require("dap").step_into()
			end,
		},
		{
			"<F12>",
			function()
				require("dap").step_out()
			end,
		},
		{
			"<Leader>b",
			function()
				require("dap").toggle_breakpoint()
			end,
		},
		{
			"<Leader>du",
			function()
				require("dapui").toggle()
			end,
		},
		{
			"<Leader>B",
			function()
				require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
			end,
		},
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")

		require("dapui").setup({
			layouts = {
				{
					elements = {
						{ id = "scopes", size = 0.25 },
						{ id = "breakpoints", size = 0.25 },
						{ id = "stacks", size = 0.25 },
						{ id = "watches", size = 0.25 },
					},
					position = "left",
					size = 40,
				},
				{
					elements = {
						{ id = "repl", size = 0.5 },
						{ id = "console", size = 0.5 },
					},
					position = "bottom",
					size = 15,
				},
			},
		})

		require("dap-python").setup("python")
		require("dap-python").test_runner = "pytest"
		for _, config in pairs(dap.configurations.python or {}) do
			config.console = "internalConsole"
		end
		dap.defaults.fallback.focus_terminal = false
		dap.defaults.fallback.terminal_win_cmd = "botright 15split new"

		-- Window layout restore + exception-aware auto-close
		local stopped_on_exception = false
		local window_layout = ""

		dap.listeners.after.event_stopped["dapui_config"] = function(_, body)
			if body and body.reason == "exception" then
				stopped_on_exception = true
			end
		end
		dap.listeners.before.event_initialized["dapui_config"] = function()
			stopped_on_exception = false
			window_layout = vim.fn.winrestcmd()
			dapui.open()
		end

		local function close_and_restore()
			if not stopped_on_exception then
				dapui.close()
				vim.schedule(function()
					if window_layout ~= "" then
						vim.cmd(window_layout)
					end
				end)
			end
		end

		dap.listeners.after.event_terminated["dapui_config"] = close_and_restore
		dap.listeners.after.event_exited["dapui_config"] = function(_, body)
			if body and body.exitCode ~= 0 then
				return
			end
			close_and_restore()
		end

		vim.api.nvim_create_autocmd("FileType", {
			pattern = "dap-repl",
			callback = function()
				require("dap.ext.autocompl").attach()
				vim.opt_local.completeopt = "menuone,noinsert,noselect"
			end,
		})

		-- Signs
		local signs = {
			DapBreakpoint = { text = "🔴" },
			DapBreakpointCondition = { text = "🟡" },
			DapLogPoint = { text = "🟢" },
			DapStopped = { text = "➡️", linehl = "Visual" },
		}
		for name, opts in pairs(signs) do
			vim.fn.sign_define(
				name,
				vim.tbl_extend("keep", opts, {
					texthl = name,
					linehl = opts.linehl or "",
					numhl = "",
				})
			)
		end
	end,
}
