local usercmd = vim.api.nvim_create_user_command

usercmd("ToggleBackground", function()
  vim.o.background = vim.o.background == 'dark' and 'light' or 'dark'
  vim.cmd.colorscheme(vim.g.colors_name)
end, { desc = 'Modifica il tema da scuro a chiaro e viceversa' })
