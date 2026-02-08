return {
  {
    "zbirenbaum/copilot.lua",
    event = "InsertEnter",
    cmd = "Copilot",
    enabled = false,
    opts = {
      filetypes = {
        gitcommit = false,
      },
      server = {
        type = "binary"
      }
    }
  },
  { 
    "olimorris/codecompanion.nvim",
    enabled = false,
    keys = {
      { "<F9>", "<cmd>CodeCompanionChat Toggle<cr>", desc = "Apre Copilot chat", mode = { "n", "v" } }
    },
    cmd = "CodeCompanion",
    opts = {},
    dependencies = { "nvim-lua/plenary.nvim" }
  }
}
