return {
	{
		"mason-org/mason-lspconfig.nvim",
		opts = {
			ensure_installed = { "lua_ls", "vimls", "basedpyright", "ts_ls" },
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
							inlayHints = {
								variableTypes = true,
								callArgumentNames = true,
								functionReturnTypes = true,
								genericTypes = true,
							},
						},
					},
				},
			},
		},
	},
}
