-- bufferline
vim.keymap.set("n", "<leader>bd", ":bp | bd #<CR>", { silent = true })
vim.keymap.set("n", "<leader>dq", function()
	vim.diagnostic.setqflist()
end, { desc = "Diagnostics → quickfix" })
-- neotree
