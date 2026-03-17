return {
	-- Just tell mason-lspconfig which servers to install
	{
		"williamboman/mason-lspconfig.nvim",
		opts = {
			ensure_installed = { "lua_ls", "vimls", "basedpyright", "ts_ls" },
		},
	},

	-- Only override basedpyright settings, everything else LazyVim handles
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
