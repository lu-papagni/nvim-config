return {
  -- Theme inspired by Atom
  'rebelot/kanagawa.nvim',
  lazy = true,
  opts = {
    transparent = os.getenv('TERM') == 'xterm-kitty',
    colors = {
      theme = {
        all = {
          ui = {
            bg_gutter = 'none'
          }
        }
      }
    }
  }
}
