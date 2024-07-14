return {
  -- Git related plugins
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',
  'tpope/vim-sleuth',
  {
    'j-hui/fidget.nvim',
    event = { 'VeryLazy' },
    opts = {}
  },
  {
    "fladson/vim-kitty",
    ft = "kitty"
  },
}
