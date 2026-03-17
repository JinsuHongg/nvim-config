return {
  {
    "olimorris/onedarkpro.nvim",
    priority = 1000,
    opts = {
      options = {
        cursorline = true,
        transparency = false,
      },
      styles = {
        types = "italic",      -- Classes/Types (Yellow + Italic)
        methods = "bold",     -- Function calls (Blue + Bold)
        variables = "NONE",   -- Variables (White)
        parameters = "italic" -- Function args (Red + Italic)
      },
      -- Force specific One Dark Pro colors if you find them too dull
      colors = {
        mocha = {
          blue = "#61afef",   -- Classic One Dark Blue
          yellow = "#e5c07b", -- Classic One Dark Yellow
          purple = "#c678dd", -- Classic One Dark Purple
        },
      },
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "onedark",
    },
  },
}
