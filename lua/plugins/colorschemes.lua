return {
  {
    "folke/tokyonight.nvim",
    lazy = true,
    opts = {
      transparent = vim.g.colorscheme_use_transparency,
      cache = true,
    }
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = true,
    opts = {
      transparent_background = vim.g.colorscheme_use_transparency,
    }
  },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    lazy = true,
    opts = {}
  },
  {
    "AlexvZyl/nordic.nvim",
    lazy = true,
    opts = {
      transparent = {
        bg = vim.g.colorscheme_use_transparency
      }
    }
  },
  {
    "savq/melange-nvim",
    lazy = true,
    init = function()
      require("utils.colorscheme").subscribe { "melange" }
    end
  }
}
