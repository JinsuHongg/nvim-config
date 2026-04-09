local ok, osc52 = pcall(require, "vim.ui.clipboard.osc52")

if ok then
	vim.g.clipboard = {
		name = "osc52",
		copy = {
			["+"] = function(lines, regtype)
				pcall(osc52.copy("+"), lines, regtype)
			end,
			["*"] = function(lines, regtype)
				pcall(osc52.copy("*"), lines, regtype)
			end,
		},
		paste = {
			["+"] = function()
				return { vim.fn.getreg('"') }
			end,
			["*"] = function()
				return { vim.fn.getreg('"') }
			end,
		},
	}
end
