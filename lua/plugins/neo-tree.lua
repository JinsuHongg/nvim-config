return {
	"nvim-neo-tree/neo-tree.nvim",
	keys = {
		{ "<C-n>", "<cmd>Neotree toggle<cr>", desc = "neotree:Toggle Neo-tree" },
		{ "<leader>e", "<cmd>Neotree focus<cr>", desc = "neotree:Focus Neo-tree" },
	},
	opts = {
		filesystem = {
			window = {
				width = 30, -- fixed width (important)
			},
		},
		window = {
			position = "left",
		},
	},
}
