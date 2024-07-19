vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function()
    vim.o.formatoptions = "jcrql"
  end,
})

vim.api.nvim_create_autocmd("UIEnter", {
  callback = function()
    if vim.g.using_kitty_term then
      vim.system({ "kitten", "@", "set-spacing", "padding=0" }, { detach = true })
    end
  end,
})

vim.api.nvim_create_autocmd("VimLeave", {
  callback = function()
    if vim.g.using_kitty_term then
      vim.system({ "kitten", "@", "set-colors", "--reset", "--all" }, { detach = true })
      vim.system({ "kitten", "@", "set-spacing", "padding=default" }, { detach = true })
    end
  end,
})

vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = function()
    local colors, bg = vim.g.colors_name, vim.o.background
    local bg_modes = vim.g.custom_background_variants[colors]

    if bg_modes and vim.g.using_kitty_term then
      local new_bg = bg_modes[bg]
      vim.system({ "kitten", "@", "set-colors", "background=" .. new_bg }, { detach = true })
    end

    vim.api.nvim_set_hl(0, "TSPunctBracket", { link = "Grey" })
  end,
})
