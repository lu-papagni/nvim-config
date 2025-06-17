return {
  {
    "echasnovski/mini.icons",
    lazy = true,
    init = function()
      package.preload["nvim-web-devicons"] = function()
        require("mini.icons").mock_nvim_web_devicons()
        return package.loaded["nvim-web-devicons"]
      end
    end,
  },
  {
    "echasnovski/mini.ai",
    version = false,
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
      vim.api.nvim_create_autocmd("FileType", {
        pattern = {
          "fzf",
          "help",
          "lazy",
          "qf"
        },
        callback = function()
          vim.b.miniindentscope_disable = true
        end,
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
