return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      transparent = os.getenv("TERM") == "xterm-kitty",
      cache = true,
    },
    config = function()
      vim.cmd.colorscheme("tokyonight")
    end,
  },
}
