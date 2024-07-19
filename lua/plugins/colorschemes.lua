return {
  {
    "LazyVim/LazyVim",
    opts = {
      -- tema attivo
      colorscheme = "tokyonight-moon",
    },
  },
  {
    "sainnhe/gruvbox-material",
    lazy = true,
    init = function()
      vim.g.gruvbox_material_transparent_background = vim.g.using_kitty_term
      vim.g.gruvbox_material_better_performance = true
      vim.g.gruvbox_material_background = "mix"
      vim.g.gruvbox_material_foreground = "mix"
      vim.g.gruvbox_material_enable_bold = true
      vim.g.gruvbox_material_show_eob = false
      vim.g.gruvbox_material_float_style = "bright"
      vim.g.gruvbox_material_diagnostic_text_highlight = true
    end,
  },
  {
    "neanias/everforest-nvim",
    lazy = true,
    config = function()
      require("everforest").setup({
        transparent_background_level = vim.g.using_kitty_term and 2 or 0,
        diagnostic_text_highlight = true,
        show_eob = false,
      })
    end,
  },
  {
    "rebelot/kanagawa.nvim",
    lazy = true,
    opts = {
      transparent = vim.g.using_kitty_term,
      colors = {
        theme = {
          all = {
            ui = {
              bg_gutter = "none",
            },
          },
        },
      },
    },
  },
  {
    "folke/tokyonight.nvim",
    opts = {
      transparent = vim.g.using_kitty_term,
      styles = {
        sidebars = vim.g.using_kitty_term and "transparent",
      },
    },
  },
}
