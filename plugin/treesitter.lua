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
