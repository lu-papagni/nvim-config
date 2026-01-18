return {
  {
    "echasnovski/mini.icons",
    lazy = true,
    config = true
  },
  { 
    "echasnovski/mini.files",
    cond = vim.g.git_editor ~= 1,
    dependencies = "echasnovski/mini.icons",
    version = false,
    lazy = false,
    keys = {
      {
        "<leader>e",
        function() require("mini.files").open() end,
        desc = "Apri esplora file (CWD)"
      },
      {
        "<leader>E",
        function() require("mini.files").open(vim.api.nvim_buf_get_name(0)) end,
        desc = "Apri esplora file (Buffer Corrente)"
      },
    },
    opts = {
      options = { use_as_default_explorer = true },
    },
    config = function(_, opts)
      require("mini.files").setup(opts)
      require("minifiles-git")
    end
  },
  {
    "echasnovski/mini.ai",
    version = false,
    enabled = false,
    event = { "BufReadPost", "VeryLazy" },
    opts = {
      custom_textobjects = {
        f = false     -- il default di treesitter funziona meglio
      }
    }
  },
  {
    "echasnovski/mini.indentscope",
    version = false,
    init = function()
      -- Disabilita in specifici file e nel terminale integrato
      vim.api.nvim_create_autocmd("FileType", {
        pattern = {
          "fzf",
          "help",
          "lazy",
          "qf",
          "codecompanion"
        },
        callback = function()
          vim.b.miniindentscope_disable = true
        end,
      })

      vim.api.nvim_create_autocmd("TermOpen", {
        callback = function()
          vim.b.miniindentscope_disable = true
        end
      })
    end,
    event = { "BufNewFile", "BufReadPost" },
    opts = {
      draw = {
        -- Stessa funzione di `mini.indentscope.gen_animation.none`
        -- Copiata per evitare di caricare il plugin
        animation = function() return 0 end
      },
      options = { try_as_border = true },
      symbol = "│"
    }
  },
  {
    "echasnovski/mini.diff",
    version = false,
    cond = vim.g.git_editor ~= 1,
    event = { "BufReadPost", "BufNewFile" },
    keys = {
      {
        "<leader>gd",
        function() require("mini.diff").toggle_overlay() end,
        desc = "Mostra differenze con l'indice della repository"
      }
    },
    opts = {
      view = {
        style = "sign",
        priority = 1
      }
    }
  }
}
