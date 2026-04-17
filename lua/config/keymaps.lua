-- bufferline
vim.keymap.set("n", "<leader>bd", ":bp | bd #<CR>", { silent = true, desc = "Delete buffer" })
vim.keymap.set("n", "<leader>dq", function()
	vim.diagnostic.setqflist()
end, { desc = "Diagnostics → quickfix list" })
-- neotree
-- vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { desc = "Exit terminal mode" })
vim.keymap.set("t", "<C-space>", [[<C-\><C-n>]], { desc = "Exit terminal mode" })
vim.keymap.set("n", "<leader>fk", function()
	require("fzf-lua").keymaps()
end, { desc = "find keymaps" })
