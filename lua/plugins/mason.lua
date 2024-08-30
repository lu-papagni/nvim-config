return {
  {
    "williamboman/mason.nvim",
    cmd = { "Mason", "MasonInstall" },
    build = ":MasonUpdate",
    opts = {
      -- FIXME: I formatter non vengono installati automaticamente
      ensure_installed = {
        "stylua",
        "shfmt",
      },
    },
  },
}
