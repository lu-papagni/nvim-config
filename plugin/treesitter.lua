local treesitter = require("ts-utils")

local function register_filetypes()
  -- Enable treesitter only for filetypes supported by installed parsers
  vim.api.nvim_create_autocmd("FileType", {
    -- stylua: ignore
    pattern = vim
      .iter(treesitter.get())
      :map(vim.treesitter.language.get_filetypes)
      :flatten()
      :totable(),
    group = vim.api.nvim_create_augroup("treesitter_support", { clear = true }),
    callback = function()
      -- vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      vim.treesitter.start()
    end,
  })
end

local ensure_installed = {
  { lang = { "tsx", "typescript" }, src = "gh:tree-sitter/tree-sitter-typescript" },
  { lang = "bash", src = "gh:tree-sitter/tree-sitter-bash" },
  { lang = "comment", src = "gh:stsewd/tree-sitter-comment" },
  { lang = "gotmpl", src = "gh:ngalaiko/tree-sitter-go-template" },
  { lang = "javascript", src = "gh:tree-sitter/tree-sitter-javascript" },
  { lang = "python", src = "gh:tree-sitter/tree-sitter-python" },
  { lang = "yaml", src = "gh:tree-sitter-grammars/tree-sitter-yaml" },
}

-- WARNING: gitcommit parser needs a lot of memory to compile
if vim.uv.get_available_memory() >= 4 * 2 ^ 30 then
  table.insert(ensure_installed, { lang = "gitcommit", src = "gh:gbprod/tree-sitter-gitcommit" })
else
  vim.notify("Not enough memory to compile `gitcommit`.", vim.log.levels.WARN)
end

vim.schedule(function()
  if vim.fn.executable("tree-sitter") ~= 1 then
    local ok, registry = pcall(require, "mason-registry")
    if not ok then
      vim.notify("tree-sitter-cli not installed: mason is missing", vim.log.levels.WARN)
      return
    end
    if not registry.is_installed("tree-sitter-cli") then
      registry.get_package("tree-sitter-cli"):install()
    end
  end
  treesitter.add(ensure_installed)
  register_filetypes()
end)

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
