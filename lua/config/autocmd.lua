local autocmd = vim.api.nvim_create_autocmd

-- Inserire una nuova riga dopo un commento non crea un nuovo commento
-- Andare a capo lo crea
autocmd('FileType', {
  pattern = '*',
  callback = function()
    vim.o.formatoptions = 'jcrql'
  end
})

-- Evidenzia brevemente il testo quando viene copiato
autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("my-highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end
})
