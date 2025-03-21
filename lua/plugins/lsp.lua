return {
  {
    "neovim/nvim-lspconfig",
    cond = vim.g.git_editor ~= 1,
    dependencies = { "hrsh7th/cmp-nvim-lsp" },
    event = { "BufNewFile", "BufReadPost", "VeryLazy" },
    -- NOTE: uso opzioni custom
    opts = {
      server_settings = {
        rust_analyzer = {
          settings = {
            ["rust-analyzer"] = {
              completion = {
                callable = { snippets = "add_parentheses" }
              }
            }
          }
        },
        clangd = function()
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

          return { cmd = cmd }
        end,
        pyright = {},
        ts_ls = {
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
      },
      override_behavior = {
        ["textDocument/hover"] = vim.lsp.with(
          vim.lsp.handlers.hover,
          {
            border = vim.g.ui_border_style,
            max_width = 80,
            max_height = 15
          }
        )
      },
    },
    config = function(_, opts)
      local lsp = require("lspconfig")

      local capabilities = vim.tbl_deep_extend(
        "force",
        vim.lsp.protocol.make_client_capabilities(),
        require("cmp_nvim_lsp").default_capabilities()
      )

      for name, settings in pairs(opts.server_settings) do
        local server = lsp[name].config_def.default_config.cmd[1]

        -- NOTE: `settings` può essere una funzione o una tabella
        if type(settings) == "function" then settings = settings() end

        if vim.fn.executable(server) == 1 then
          lsp[name].setup(
            vim.tbl_deep_extend(
              "force",
              settings,
              {
                handlers = opts.override_behavior,
                capabilities = capabilities
              }
            )
          )
        end
      end
    end
  },
  {
    "ray-x/lsp_signature.nvim",
    cond = vim.g.git_editor ~= 1,
    event = "VeryLazy",
    opts = {
      doc_lines = 5,
      floating_window = true,
      handler_opts = { border = vim.g.ui_border_style },
      hint_enable = false,
      hint_prefix = "\u{ea92} ",
    }
  }
}
