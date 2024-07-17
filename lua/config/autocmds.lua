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
    if vim.g.using_kitty_term then
      local colors, bg = vim.g.colors_name, vim.o.background

      if vim.g.kitty_background_variants[colors] then
        local new_bg = vim.g.kitty_background_variants[colors][bg]
        vim.system({ "kitten", "@", "set-colors", "background=" .. new_bg }, { detach = true })
      end
    end

    vim.api.nvim_set_hl(0, "TSPunctBracket", { link = "Grey" })
  end,
})
