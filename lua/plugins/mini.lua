return {
  {
    "echasnovski/mini.icons",
    lazy = true,
    config = true,
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
        function()
          require("mini.files").open()
        end,
        desc = "Apri esplora file (CWD)",
      },
      {
        "<leader>E",
        function()
          require("mini.files").open(vim.api.nvim_buf_get_name(0))
        end,
        desc = "Apri esplora file (Buffer Corrente)",
      },
    },
    opts = {
      options = { use_as_default_explorer = true },
    },
    config = function(_, opts)
      require("mini.files").setup(opts)
      require("minifiles-git")
    end,
  },
  {
    "nvim-mini/mini.pick",
    dependencies = "nvim-mini/mini.extra",
    version = false,
    event = "VimEnter",
    opts = {
      mappings = {
        move_down = "<C-j>",
        move_up = "<C-k>",
      },
    },
    config = function(_, opts)
      require("mini.pick").setup(opts)
      require("mini.extra").setup()

      local map = vim.keymap.set
      local builtin = require("mini.pick").builtin
      local extra = require("mini.extra").pickers

      map("n", "<Leader>/", function()
        extra.buf_lines({ scope = "current" })
      end)
      map("n", "<Leader>b", builtin.buffers)
      map("n", "<Leader>fC", extra.colorschemes)
      map("n", "<Leader>fT", function()
        builtin.grep({ pattern = "^\\W+\\b(HACK|TODO|NOTE|BUG|ERROR|FIXME|FIX|INFO)" })
      end)
      map("n", "<Leader>ff", builtin.files)
      map("n", "<Leader>fh", builtin.help)
      map("n", "<Leader>fk", extra.keymaps)
      map("n", "<Leader>fs", builtin.grep_live)
      map("n", "<Leader>ft", function()
        builtin.grep({ pattern = "^\\W+\\bTODO" })
      end)
      map("n", "<Leader>fu", function()
        builtin.grep({ pattern = vim.fn.expand("<cword>") })
      end)
    end,
  },
  {
    "echasnovski/mini.ai",
    version = false,
    enabled = false,
    event = { "BufReadPost", "VeryLazy" },
    opts = {
      custom_textobjects = {
        f = false, -- il default di treesitter funziona meglio
      },
    },
  },
  {
    "echasnovski/mini.diff",
    version = false,
    cond = vim.g.git_editor ~= 1,
    event = { "BufReadPost", "BufNewFile" },
    keys = {
      {
        "<leader>gd",
        function()
          require("mini.diff").toggle_overlay()
        end,
        desc = "Mostra differenze con l'indice della repository",
      },
    },
    opts = {
      view = {
        style = "sign",
        priority = 1,
      },
    },
  },
}
