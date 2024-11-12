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
          "ts_ls",
          "jedi_language_server",
          "clangd",
        },
        handlers = {
          function(server)
            if server ~= "jdtls" then
              require("lspconfig")[server].setup { capabilities = capabilities }
            end
          end,
          ["ts_ls"] = function()
            require("lspconfig").ts_ls.setup {
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
          ["clangd"] = function()
            local cmd = {
              "clangd",
              "--background-index",
              "--clang-tidy",
              "--header-insertion=iwyu",
              "--completion-style=detailed",
              "--function-arg-placeholders",
              "--fallback-style=llvm",
            }

            local gcc = vim.fn.exepath("gcc"):gsub("%.EXE$", ".exe")
            local gpp = vim.fn.exepath("g++"):gsub("%.EXE$", ".exe")

            vim.list_extend(cmd, {
              table.concat { "--query-driver=", gcc },
              table.concat { "--query-driver=", gpp }
            })

            require("lspconfig").clangd.setup {
              capabilities = capabilities,
              cmd = cmd,
              init_options = {
                usePlaceholders = true,
                completeUnimported = true,
                clangdFileStatus = true,
              },
            }
          end
        }
      }
    end
  },
}
