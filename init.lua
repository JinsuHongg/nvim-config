local scratch = "/tmp/" .. vim.env.USER
vim.env.XDG_DATA_HOME = scratch .. "/.local/share"
vim.env.XDG_CACHE_HOME = scratch .. "/.cache"
vim.env.XDG_STATE_HOME = scratch .. "/.local/state"

-- 1. Disable all automatic clipboard detection
-- vim.opt.clipboard = ""
--
-- -- 2. Define a "Write-Only" OSC 52 Provider
-- local function osc52_copy(lines, _)
-- 	-- Join the lines and encode to Base64
-- 	local text = table.concat(lines, "\n")
-- 	local b64 = vim.base64.encode(text)
-- 	-- Manually send the OSC 52 string to the terminal's stderr
-- 	-- \27]52;c; is the start, \7 is the terminator
-- 	local osc = string.format("\27]52;c;%s\7", b64)
-- 	io.stderr:write(osc)
-- end
--
-- -- 3. Use internal registers for Paste to avoid the ^@ / 41 leaks
-- local function osc52_paste()
-- 	return {
-- 		vim.fn.split(vim.fn.getreg('"'), "\n"),
-- 		vim.fn.getregtype('"'),
-- 	}
-- end
--
-- vim.g.clipboard = {
-- 	name = "ghostty-fix",
-- 	copy = { ["+"] = osc52_copy, ["*"] = osc52_copy },
-- 	paste = { ["+"] = osc52_paste, ["*"] = osc52_paste },
-- }
--
-- vim.opt.clipboard = "unnamedplus"
vim.opt.undofile = false

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end

vim.opt.rtp:prepend(lazypath)

-- Load your custom options and plugins
require("vim-options")
require("config.lazy")
