return {
  "folke/noice.nvim",
  opts = {
    routes = {
      {
        filter = { find = "Validate documents" },
        opts = { skip = true },
      },
      {
        filter = { find = "Publish Diagnostics" },
        opts = { skip = true },
      },
    },
  },
}
