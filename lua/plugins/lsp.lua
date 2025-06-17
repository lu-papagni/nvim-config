return {
  {
    "zeioth/garbage-day.nvim",
    cond = vim.g.git_editor ~= 1,
    event = "LspAttach",
    opts = {}
  }
}
