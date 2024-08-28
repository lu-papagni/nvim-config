return {
  {
    "williamboman/mason.nvim",
    cmd = { "Mason", "MasonInstall" },
    build = ":MasonUpdate",
    opts = {
      ensure_installed = {
        "stylua",
        "shfmt",
      },
    },
  },
}
