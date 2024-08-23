return {
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    build = ":MasonUpdate",
    opts = {
      ensure_installed = {
        "stylua",
        "shfmt",
      },
    },
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    event = 'VeryLazy',
    opts = {
      ensure_installed = {
        "tsserver", -- JavaScript & TypeScript
        "html",
        "pyright", -- Python
        "clangd",  -- C/C++
      },
      automatic_installation = true,
    }
  },
}
