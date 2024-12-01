return {
  "hrsh7th/nvim-cmp",
  version = false,
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "onsails/lspkind.nvim",
  },
  opts = function()
    local cmp = require("cmp")
    local defaults = require("cmp.config.default")()

    vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })

    return {
      completion = {
        completeopt = "menu,menuone,noinsert",
        autocomplete = false,
      },
      snippet = {
        expand = function(args) vim.snippet.expand(args.body) end
      },
      preselect = auto_select and cmp.PreselectMode.Item or cmp.PreselectMode.None,
      mapping = cmp.mapping.preset.insert({
        ["<up>"] = function() end,   -- disabilita le frecce direzionali
        ["<down>"] = function() end,
        ["<C-k>"] = cmp.mapping.select_prev_item(),
        ["<C-j>"] = cmp.mapping.select_next_item(),
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<CR>"] = cmp.mapping.confirm({ select = auto_select }),
        ["<C-y>"] = cmp.mapping.confirm({ select = true }),
        ["<S-CR>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace }),
        ["<C-CR>"] = function(fallback)
          cmp.mapping.abort()
          fallback()
        end,
        ["<Tab>"] = cmp.mapping(function(fallback) -- Parametro successivo
          if vim.snippet.active { direction = 1 } then
            vim.snippet.jump(1)
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback) -- Parametro precedente
          if vim.snippet.active { direction = -1 } then
            vim.snippet.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      }),
      sources = cmp.config.sources({
        { name = "nvim_lsp" },
      }),
      formatting = {
        expandable_indicator = true,
        fields = { "abbr", "kind", "menu" },
        format = require("lspkind").cmp_format {
          mode = "symbol",
          maxwidth = {
            menu = 40,
            abbr = 40
          },
        }
      },
      experimental = {
        ghost_text = {
          hl_group = "CmpGhostText",
        },
      },
      sorting = defaults.sorting,
    }
  end,
}
