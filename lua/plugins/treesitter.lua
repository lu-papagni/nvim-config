return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = ":TSUpdate",
    lazy = false,
    config = function()
      local ensure_installed = {
        "diff",
        "gitcommit",
        "git_config",
        "gitignore",
        "git_rebase",
        "json",
        "jsonc",
        "lua",
        "markdown",
        "markdown_inline",
        "toml",
        "vim",
        "vimdoc",
        "comment",
      }
      require("nvim-treesitter").install(ensure_installed)
      vim.api.nvim_create_autocmd("FileType", {
        -- Abilita solo per le estensioni supportate dai parser
        -- NOTE: prima di usare un nuovo parser bisognerà installarlo con
        -- `:TSInstall` e riavviare neovim.
        pattern = vim.iter(require("nvim-treesitter").get_installed())
          :map(function(l) return vim.treesitter.language.get_filetypes(l) end)
          :flatten()
          :totable(),
        group = vim.api.nvim_create_augroup("my-treesitter", { clear = true }),
        -- WARNING: non usare mai `callback = vim.treesitter.start`
        -- altrimenti ci saranno errori nell'apertura dei file.
        callback = function() vim.treesitter.start() end
      })
    end,
  },
  {
    "windwp/nvim-ts-autotag",
    dependencies = "nvim-treesitter/nvim-treesitter",
    ft = { "html", "xml", "tsx", "ts", "js", "php", "markdown" },
    config = true
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    dependencies = "nvim-treesitter/nvim-treesitter",
    event = { "BufNewFile", "BufReadPre", "VeryLazy" },
    config = function()
      local textobjects = {
        select = {
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["ac"] = "@conditional.outer",
          ["ic"] = "@conditional.inner",
          ["al"] = "@loop.outer",
          ["il"] = "@loop.inner",
          ["ie"] = "@assignment.rhs",
          ["iE"] = "@assignment.lhs",
          ["aa"] = "@parameter.outer",
          ["ia"] = "@parameter.inner",
        },
        move = {
          goto_next_start = {
            ["]f"] = "@function.outer",
            ["]c"] = "@class.outer",
            ["]]"] = "@parameter.inner"
          },
          goto_next_end = {
            ["]F"] = "@function.outer",
            ["]C"] = "@class.outer",
          },
          goto_previous_start = {
            ["[f"] = "@function.outer",
            ["[c"] = "@class.outer",
            ["[["] = "@parameter.inner"
          },
          goto_previous_end = {
            ["[F"] = "@function.outer",
            ["[C"] = "@class.outer",
          },
        }
      }

      for mapping, obj in pairs(textobjects.select) do
        vim.keymap.set({ "x", "o" }, mapping, function()
          require("nvim-treesitter-textobjects.select").select_textobject(obj, "textobjects")
        end)
      end

      for method, mappings in pairs(textobjects.move) do
        for mapping, obj in pairs(mappings) do
          vim.keymap.set({ "n", "x", "o" }, mapping, function()
            require("nvim-treesitter-textobjects.move")[method](obj, "textobjects")
          end)
        end
      end
    end
  },
}
