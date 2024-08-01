return {
  "nvim-telescope/telescope.nvim",
  keys = {
    { "<leader><leader>", "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>", desc = "Buffers" },
    { "<leader>,", LazyVim.pick("files", { root = false }), desc = "Find Files (cwd)" },
  },
}
