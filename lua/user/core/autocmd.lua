local create_autocmd = vim.api.nvim_create_autocmd

create_autocmd('FileType', {
  pattern = { '*' },
  callback = function()
    -- vim.cmd("set formatoptions-=o")
    vim.o.formatoptions = 'jcrql'
  end
})

-- Evidenzia brevemente il testo quando copio
create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("my-highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end
})

create_autocmd('ColorScheme', {
  pattern = '*',
  callback = function()
    if vim.g.using_kitty_term then
      local new_bg = vim.o.background_variants[vim.g.colors_name][vim.o.background]
      vim.system({ 'kitten', '@', 'set-colors', 'background=' .. new_bg })
    end

    vim.api.nvim_set_hl(0, "TSPunctBracket", { link = "Grey" })
  end
})

-- Funzioni speciali di kitty
if vim.g.using_kitty_term then
  vim.system({ 'kitten', '@', 'set-spacing', 'padding=0' }, { detach = true })

  create_autocmd("VimLeave", {
    callback = function()
      vim.system({ 'kitten', '@', 'set-colors', '--reset', '--all' }, { detach = true })
      vim.system({ 'kitten', '@', 'set-spacing', 'padding=default' }, { detach = true })
    end
  })
end
