return {
  "neanias/everforest-nvim",
  lazy = true,
  config = function()
    require("everforest").setup {
      transparent_background_level = os.getenv('TERM') == 'xterm-kitty' and 2 or 0,
      diagnostic_text_highlight = true,
      show_eob = false,
    }
  end
}
