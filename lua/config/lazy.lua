require("lazy").setup({
  spec = {
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },  -- 1st
    { import = "lazyvim.plugins.extras.ui.mini-animate" }, -- extras 2nd (if any)
    { import = "plugins" },  -- your own plugins last
  },
})
