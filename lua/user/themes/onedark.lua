return {
  -- Theme inspired by Atom
  'navarasu/onedark.nvim',
  lazy = true,
  opts = {
    style = 'warm',
    transparent = os.getenv('TERM') == 'xterm-kitty',
  }
}
