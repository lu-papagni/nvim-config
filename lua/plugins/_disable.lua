return {
  { "rcarriga/nvim-notify", enabled = false },
  { "akinsho/bufferline.nvim", enabled = false },
  { "folke/persistence.nvim", enabled = false },
  { "folke/flash.nvim", enabled = false },
  { "folke/noice.nvim", enabled = false },
  -- LSP keymaps
  {
    "neovim/nvim-lspconfig",
    opts = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      -- disable a keymap
      keys[#keys + 1] = { "<a-p>", false }
    end,
  },
}
