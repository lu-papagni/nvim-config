return {
  "mason-org/mason.nvim",
  lazy = false,
  config = function()
    require("mason-registry").update()
    require("mason").setup()

    local ensure_installed = { "tree-sitter-cli" }
    local registry = require("mason-registry")
    vim.iter(ensure_installed)
      :filter(function(id) return not registry.is_installed(id) end)
      :each(function(pkg) registry.get_package(pkg):install() end)
  end
}
