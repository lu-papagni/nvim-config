-- In Normal Mode, inserire una nuova riga dopo un commento non lo continua
vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function()
    vim.o.formatoptions = "jcrql"
  end,
})

-- Reset impostazioni grafiche di kitty
vim.api.nvim_create_autocmd("VimLeave", {
  callback = function()
    if vim.g.using_kitty_term then
      vim.system({ "kitten", "@", "set-spacing", "padding=default" }, { detach = true })
    end
  end,
})
