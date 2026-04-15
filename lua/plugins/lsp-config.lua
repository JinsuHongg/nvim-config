return {
	{
		"mason-org/mason-lspconfig.nvim",
		opts = {
			ensure_installed = { "lua_ls", "vimls", "basedpyright", "ruff", "ts_ls" },
		},
	},
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				basedpyright = {
					settings = {
						basedpyright = {
							analysis = { typeCheckingMode = "basic" },
						},
					},
				},
			},
		},
	},
	{
		"mfussenegger/nvim-lint",
		event = "VeryLazy",
		opts = {
			linters_by_ft = {
				python = { "ruff" },
			},
		},
	},
}
