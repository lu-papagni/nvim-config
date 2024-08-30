local autocmd = vim.api.nvim_create_autocmd
local map = vim.keymap.set

-- Inserire una nuova riga dopo un commento non crea un nuovo commento
-- Andare a capo lo crea
autocmd("FileType", {
  pattern = "*",
  callback = function()
    vim.o.formatoptions = "jcrql"
  end
})

-- Evidenzia brevemente il testo quando viene copiato
autocmd("TextYankPost", {
  desc = "Evidenzia brevemente il testo durante la copia",
  group = vim.api.nvim_create_augroup("my-highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end
})

-- Registra le associazioni tasti per il language server
autocmd("LspAttach", {
  desc = "Funzioni LSP",
  callback = function(event)
    local opts = { buffer = event.buf }

    map("n", "K", function() vim.lsp.buf.hover() end, opts)
    map("n", "gd", function() vim.lsp.buf.definition() end, opts)
    map("n", "gD", function() vim.lsp.buf.declaration() end, opts)
    map("n", "gi", function() vim.lsp.buf.implementation() end, opts)
    map("n", "go", function() vim.lsp.buf.type_definition() end, opts)
    map("n", "gr", function() vim.lsp.buf.references() end, opts)
    map("n", "gs", function() vim.lsp.buf.signature_help() end, opts)
    map("n", "<leader>rn", function() vim.lsp.buf.rename() end, opts)
    map({"n", "x"}, "<leader>cf", function() vim.lsp.buf.format({ async = true }) end, opts)
    map("n", "<leader>ca", function() vim.lsp.buf.code_action() end, opts)
  end
})
