return {
	{
		"ibhagwan/fzf-lua",
		lazy = false,
		keys = {
			{ "<C-p>", "<cmd>FzfLua files<cr>", desc = "fzf:Fuzzy find files" },
			{ "<leader>fg", "<cmd>FzfLua live_grep<cr>", desc = "fzf:Live grep" },
		},
	},
}
