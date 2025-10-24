return {
  {
    "zbirenbaum/copilot.lua",
    event = "InsertEnter",
    cmd = "Copilot",
    opts = {
      filetypes = {
        gitcommit = false,
      }
    }
  },
  { 
    "olimorris/codecompanion.nvim",
    keys = {
      { "<F9>", "<cmd>CodeCompanionChat Toggle<cr>", desc = "Apre Copilot chat", mode = { "n", "v" } }
    },
    cmd = "CodeCompanion",
    opts = {},
    dependencies = { "nvim-lua/plenary.nvim" }
  }
}
