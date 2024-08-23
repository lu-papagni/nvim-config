return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPost", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
  },
  config = function()
    local lspconfig = require("lspconfig")
    local cmp_lsp = require("cmp_nvim_lsp").default_capabilities()

    local function on_attach(client, bufnr)
      local opts = {
        noremap = true,
        silent = true,
        buffer = bufnr
      }

      -- Keybinds
      opts.desc = "Go to declaration"
      vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

      opts.desc = "Show documentation under cursor"
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)

      opts.desc = "Code actions"
      vim.keymap.set({ 'n', 'v' }, "<leader>ca", vim.lsp.buf.code_action, opts)

      opts.desc = "Smart rename"
      vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

      -- Suggerimenti contestuali
      if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
        vim.keymap.set('n', '<leader>th', function()
          vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
        end)
      end
    end

    lspconfig.html.setup {
      capabilities = cmp_lsp,
      on_attach = on_attach
    }

    lspconfig.clangd.setup {
      capabilities = cmp_lsp,
      on_attach = on_attach
    }

    lspconfig.pyright.setup {
      capabilities = cmp_lsp,
      on_attach = on_attach
    }

    lspconfig.tsserver.setup {
      capabilities = cmp_lsp,
      on_attach = on_attach,
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
