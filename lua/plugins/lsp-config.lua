return {
    {
        "mason-org/mason.nvim",
        config = function()
            require("mason").setup()
        end
    },
    {
        "mason-org/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = {"lua_ls", "vimls", "pyright", "ts_ls"}
            })
        end
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            vim.lsp.config("pyright", {})
            vim.lsp.config("lua_ls", {})
            vim.lsp.config("vimls", {})
            vim.lsp.config("ts_ls", {})
            vim.lsp.enable({ "pyright", "lua_ls", "vimls", "ts_ls" })

            vim.diagnostic.config({
                virtual_text = true,
                signs = true,
                underline = true,
                update_in_insert = false,
                severity_sort = true,
            })

            vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
            vim.keymap.set({'n'}, '<leader>ca', vim.lsp.buf.code_action, {})
        end
    }
}
