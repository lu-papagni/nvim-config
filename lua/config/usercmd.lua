local usercmd = vim.api.nvim_create_user_command

-- FIXME: convertire per `blink.cmp`
usercmd("ToggleAutocomplete", function()
  local ok, cmp = pcall(require, "cmp")

  if ok then
    local current = cmp.get_config().completion.autocomplete

    if current and #current > 0 then
      cmp.setup({ completion = { autocomplete = false } })
      vim.notify("Completamento disabilitato")
    else
      cmp.setup({ completion = { autocomplete = { cmp.TriggerEvent.TextChanged } } })
      vim.notify("Completamento abilitato")
    end
  else
    vim.notify("nvim-cmp non installato", vim.log.levels.ERROR)
  end
end, { desc = "Cambia lo stato del completamento automatico" })
