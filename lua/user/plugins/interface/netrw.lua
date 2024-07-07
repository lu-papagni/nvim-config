return {
  'prichrd/netrw.nvim',
  opts = {
    use_devicons = true,
  },
  init = function()
    vim.g.netrw_banner = 0
    vim.g.netrw_liststyle = 3 -- vista ad albero
    vim.g.netrw_mousemaps = 0
    vim.g.netrw_sizestyle = 'H'
    vim.g.netrw_preview = 1
    vim.g.netrw_winsize = 25
    vim.g.netrw_sort_by = 'name'
  end
}
