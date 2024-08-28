return {
  {
    "neovim/nvim-lspconfig",
    lazy = true,
    dependencies = { "hrsh7th/cmp-nvim-lsp" },
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    event = { "BufReadPre", "VeryLazy" },
    opts = function()
      local cmp_lsp = require("cmp_nvim_lsp")
      local capabilities = vim.tbl_deep_extend(
        "force",
        {},
        vim.lsp.protocol.make_client_capabilities(),
        cmp_lsp.default_capabilities()
      )

      return {
        ensure_installed = {
          "tsserver", -- JavaScript & TypeScript
          "html",
          "pyright", -- Python
          "clangd",  -- C/C++
        },
        handlers = {
          function(server)
            require("lspconfig")[server].setup {
              capabilities = require("cmp_nvim_lsp").default_capabilities()
            }
          end,
          ["tsserver"] = function()
            require("lspconfig")["tsserver"].setup {
              capabilities = capabilities,
              init_options = {
                preferences = {
                  tsserincludeInlayParameterNameHints = 'all',
                  includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                  includeInlayFunctionParameterTypeHints = true,
                  includeInlayVariableTypeHints = true,
                  includeInlayPropertyDeclarationTypeHints = true,
                  includeInlayFunctionLikeReturnTypeHints = true,
                  includeInlayEnumMemberValueHints = true,
                }
              }
            }
          end
        }
      }
    end
  }
}
