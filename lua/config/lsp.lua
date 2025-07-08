local function get_clangd_cmd()
  local cmd = {
    "clangd",
    "--background-index",
    "--clang-tidy",
    "--header-insertion=never",
    "--completion-style=detailed",
    "--fallback-style=llvm",
    "--function-arg-placeholders=false"
  }

  local gcc = vim.fn.exepath("gcc")

  vim.list_extend(cmd, {
    -- Uso tutti i compilatori disponibili
    string.format("--query-driver=%s/g*.exe", vim.fn.fnamemodify(gcc, ":h"):gsub("\\", "/"))
  })

  return cmd
end

if vim.g.git_editor ~= 1 then
  vim.api.nvim_create_autocmd(
    { "BufReadPre", "BufNewFile", "UIEnter" },
    {
      desc = "Configura LSP al momento giusto",
      once = true,
      callback = function()
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
          "basedpyright"
        }
      end
    }
  )
end
