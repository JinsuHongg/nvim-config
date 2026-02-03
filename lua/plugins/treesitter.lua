return{
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      local config = require("nvim-treesitter")
        config.setup({
          auto_install = true,
          highlight = { enable = true },
          indent = { enable = true }
      })
    end
    }
}
