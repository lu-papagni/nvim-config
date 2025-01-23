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
    "echasnovski/mini.files",
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
    }
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
}
