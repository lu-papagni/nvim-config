local ensure_installed = {
  "emmylua_ls",
  "basedpyright",
  "typescript-language-server",
  "stylua",
}

require("mason").setup()
local registry = require("mason-registry")

registry.refresh(function()
  -- stylua: ignore
  vim.iter(ensure_installed)
    :filter(function(pkg) return not registry.is_installed(pkg) end)
    :map(registry.get_package)
    :each(function(pkg) pkg:install() end)
end)
