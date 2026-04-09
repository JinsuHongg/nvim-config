return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile" },
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		opts = {
			ensure_installed = { "python", "lua", "vim", "vimdoc" },
			highlight = { enable = true },
			compilers = { "gcc", "cc" }, -- use gcc, skip tree-sitter CLI
			textobjects = {
				move = {
					enable = true,
					goto_next_start = {
						["]c"] = "@class.outer",
						["]f"] = "@function.outer",
					},
					goto_previous_start = {
						["[c"] = "@class.outer",
						["[f"] = "@function.outer",
					},
				},
			},
		},
	},
}
