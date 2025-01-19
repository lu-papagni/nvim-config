local autocmd = vim.api.nvim_create_autocmd
local map = vim.keymap.set

-- Resetta le impostazioni grafiche di Kitty
autocmd("VimLeave", {
  desc = "Resetta l'aspetto del terminale all'uscita",
  callback = function()
    if os.getenv("TERM") == "xterm-kitty" then
      -- vim.system({ "kitten", "@", "set-colors", "--reset", "--all" }, { detach = true })
      vim.system({ "kitten", "@", "set-spacing", "padding=default" }, { detach = true })
    elseif os.getenv("WIN_HOME") then
      vim.cmd [[set guicursor= | call chansend(v:stderr, "\x1b[ q")]]
    end
  end,
})

-- In Normal Mode, inserire una nuova riga dopo un commento non lo continua
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

    map("n", "K", vim.lsp.buf.hover, opts)
    map("n", "gd", vim.lsp.buf.definition, opts)
    map("n", "gD", vim.lsp.buf.declaration, opts)
    map("n", "gi", vim.lsp.buf.implementation, opts)
    map("n", "go", vim.lsp.buf.type_definition, opts)
    -- map("n", "gr", vim.lsp.buf.references, opts)
    map("n", "gs", vim.lsp.buf.signature_help, opts)
    map("n", "<leader>rn", vim.lsp.buf.rename, opts)
    map({"n", "x"}, "<leader>cf", function() vim.lsp.buf.format({ async = true }) end, opts)
    -- map({"n", "v"}, "<leader>ca", vim.lsp.buf.code_action, opts)
  end
})

-- Imposta la trasparenza per alcuni temi
autocmd("ColorScheme", {
  desc = "Imposta trasparenza per temi",
  pattern = require("utils.colorscheme").get_subscribed(),
  callback = function(_)
    local color = require("utils.colorscheme")
    if vim.g.colorscheme_use_transparency then
      color.fix_transparency({ full = false })
    end
  end
})
