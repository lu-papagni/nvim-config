local user_command = vim.api.nvim_create_user_command

-- Cambia il tema da scuro a chiaro e viceversa
user_command("ThemeToggleDarkmode", function()
  vim.o.background = vim.o.background == 'dark' and 'light' or 'dark'
  vim.cmd.colorscheme(vim.g.colors_name)
end, {})

-- Disabilita il formatter
user_command("ConformDisable", function(args)
  if args.bang then
    -- FormatDisable! will disable formatting just for this buffer
    vim.b.disable_autoformat = true
  else
    vim.g.disable_autoformat = true
  end
end, {
  desc = "Disable autoformat-on-save",
  bang = true,
})

-- Abilita il formatter
user_command("ConformEnable", function()
  vim.b.disable_autoformat = false
  vim.g.disable_autoformat = false
end, {
  desc = "Re-enable autoformat-on-save",
})
