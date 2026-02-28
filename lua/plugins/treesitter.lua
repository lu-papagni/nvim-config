-- returns memory size in KB
local function get_system_memory()
  local meminfo = io.open("/proc/meminfo", "r")
  assert(meminfo, "Could not read memory stats. Are you on Windows?")
  local line = meminfo:read()
  meminfo:close()
  return tonumber(line:match("%d+"))
end

local function refresh_filetypes()
  -- Enable treesitter only for filetypes supported by installed parsers
  vim.api.nvim_create_autocmd("FileType", {
    pattern = vim
      .iter(require("nvim-treesitter").get_installed())
      :map(vim.treesitter.language.get_filetypes)
      :flatten()
      :totable(),
    group = vim.api.nvim_create_augroup("treesitter_support", { clear = true }),
    callback = function()
      vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      vim.treesitter.start()
    end,
  })
end

return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = ":TSUpdate",
    lazy = false,
    config = function()
      local ensure_installed = {
        "diff",
        "git_config",
        "gitignore",
        "git_rebase",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "toml",
        "vim",
        "vimdoc",
        "comment",
      }

      -- WARNING: gitcommit parser needs a lot of memory to compile
      if get_system_memory() >= 4 * 1024 * 1024 then
        table.insert(ensure_installed, "gitcommit")
      else
        vim.notify("Not enough memory to compile `gitcommit`.", vim.log.levels.WARN)
      end

      vim.api.nvim_create_autocmd("User", {
        pattern = "TSUpdate",
        desc = "Refresh supported filetypes on :TSUpdate",
        callback = refresh_filetypes,
      })

      local treesitter = require("nvim-treesitter")

      treesitter.install(ensure_installed):wait(3e5, function()
        return #treesitter.get_installed() >= #ensure_installed
      end, 1000)

      refresh_filetypes()
    end,
  },
  {
    "windwp/nvim-ts-autotag",
    dependencies = "nvim-treesitter/nvim-treesitter",
    ft = { "html", "xml", "tsx", "ts", "js", "php", "markdown" },
    config = true,
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
            ["]]"] = "@parameter.inner",
          },
          goto_next_end = {
            ["]F"] = "@function.outer",
            ["]C"] = "@class.outer",
          },
          goto_previous_start = {
            ["[f"] = "@function.outer",
            ["[c"] = "@class.outer",
            ["[["] = "@parameter.inner",
          },
          goto_previous_end = {
            ["[F"] = "@function.outer",
            ["[C"] = "@class.outer",
          },
        },
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
    end,
  },
}
