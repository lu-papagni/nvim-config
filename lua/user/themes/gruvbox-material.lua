return {
  'sainnhe/gruvbox-material',
  lazy = false,
  priority = 1000,
  init = function()
    vim.g.gruvbox_material_transparent_background = os.getenv('TERM') == 'xterm-kitty'
    vim.g.gruvbox_material_better_performance = true
    vim.g.gruvbox_material_background = 'mix'
    vim.g.gruvbox_material_foreground = 'mix'
    vim.g.gruvbox_material_enable_bold = true
    vim.g.gruvbox_material_show_eob = false
    vim.g.gruvbox_material_float_style = 'bright'
    vim.g.gruvbox_material_diagnostic_text_highlight = true
  end,
}
