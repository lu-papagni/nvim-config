return {
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      {
        "neovim/nvim-lspconfig",
        lazy = true,
        dependencies = { "hrsh7th/cmp-nvim-lsp" },
      },
    },
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
          "tsserver",
          "pyright",
          "clangd",
        },
        handlers = {
          function(server)
            require("lspconfig")[server].setup {
              capabilities = capabilities
            }
          end,
          ["tsserver"] = function()
            require("lspconfig")["tsserver"].setup {
              capabilities = capabilities,
              init_options = {
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
            }
          end,
        }
      }
    end
  },
}
