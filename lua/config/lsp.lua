local function get_clangd_cmd()
  local cmd = {
    "clangd",
    "--background-index",
    "--clang-tidy",
    "--header-insertion=never",
    "--completion-style=detailed",
    "--function-arg-placeholders",
    "--fallback-style=llvm",
    "--function-arg-placeholders=false"
  }

  local gcc = vim.fn.exepath("gcc"):gsub("%.EXE$", ".exe")
  local gpp = vim.fn.exepath("g++"):gsub("%.EXE$", ".exe")

  vim.list_extend(cmd, {
    table.concat { "--query-driver=", gcc },
    table.concat { "--query-driver=", gpp }
  })

  return cmd
end

-- Configurazione language server
vim.lsp.config("clangd", { cmd = get_clangd_cmd() })

vim.lsp.config("typescript-language-server", {
  init_options = {
    locale = "it",
    preferences = {
      includeInlayParameterNameHints = "all",
      includeInlayParameterNameHintsWhenArgumentMatchesName = true,
      includeInlayFunctionParameterTypeHints = true,
      includeInlayVariableTypeHints = true,
      includeInlayPropertyDeclarationTypeHints = true,
      includeInlayFunctionLikeReturnTypeHints = true,
      includeInlayEnumMemberValueHints = true,
    }
  }
})

vim.lsp.config("rust-analyzer", {
  settings = {
    ["rust-analyzer"] = {
      completion = {
        callable = { snippets = "add_parentheses" }
      }
    }
  }
})

-- Abilito tutti
vim.lsp.enable {
  "clangd",
  "rust-analyzer",
  "typescript-language-server",
  "pyright"
}

-- Attivazione completamento automatico
--[[ vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspAttach", { clear = true }),
  callback = function(ev)
    vim.lsp.completion.enable(true, ev.data.client_id, ev.buf)
  end,
}) ]]--
