local usercmd = vim.api.nvim_create_user_command

usercmd("ToggleBackground", function()
  vim.o.background = vim.o.background == "dark" and "light" or "dark"
  vim.cmd.colorscheme(vim.g.colors_name)
end, { desc = "Modifica il tema da scuro a chiaro e viceversa" })

usercmd("ToggleAutocomplete", function()
  local ok, cmp = pcall(require, "cmp")

  if ok then
    local current = cmp.get_config().completion.autocomplete

    if current and #current > 0 then
      cmp.setup({ completion = { autocomplete = false } })
      vim.notify("Autocomplete disabled")
    else
      cmp.setup({ completion = { autocomplete = { cmp.TriggerEvent.TextChanged } } })
      vim.notify("Autocomplete enabled")
    end
  else
    vim.notify("Completion not installed", vim.log.level.ERROR)
  end
end, { desc = "Cambia lo stato del completamento automatico" })
