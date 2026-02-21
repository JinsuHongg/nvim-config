return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		require("neo-tree").setup({
			filesystem = {
				filtered_items = {
					visible = true,
					hide_dotfiles = false,
					hide_gitignored = false,
				},
				window = {
					mappings = {
						["Y"] = function(state)
							-- Get the node
							local node = state.tree:get_node()
							local path = node.path
							-- Copy to system clipboard
							vim.fn.setreg("+", path)
							vim.notify("Copied path: " .. path)
						end,
					},
				},
			},
		})
		vim.keymap.set("n", "<C-n>", ":Neotree filesystem reveal left<CR>", {})
	end,
}
