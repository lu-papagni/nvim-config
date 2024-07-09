return {
  "williamboman/mason-lspconfig.nvim",
  event = 'VeryLazy',
  opts = {
    ensure_installed = {
      "tsserver", -- JavaScript & TypeScript
      "html",
      "lua_ls",
      "pyright", -- Python
      "clangd",  -- C/C++
    },
    automatic_installation = true,
  }
}
