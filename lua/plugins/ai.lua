return {
  {
    "zbirenbaum/copilot.lua",
    dependencies = { "copilotlsp-nvim/copilot-lsp" },
    enabled = vim.g.git_editor ~= 1,
    event = "VeryLazy",
    cmd = "Copilot",
    init = function()
      vim.g.copilot_nes_debounce = 500
    end,
    opts = {
      nes = {
        enabled = true,
        keymap = {
          accept_and_goto = "<Tab>",
          accept = false,
          dismiss = "<Esc>",
        },
      },
    },
  },
  {
    "olimorris/codecompanion.nvim",
    enabled = false,
    keys = {
      { "<F9>", "<cmd>CodeCompanionChat Toggle<cr>", desc = "Apre Copilot chat", mode = { "n", "v" } },
    },
    cmd = "CodeCompanion",
    opts = {},
    dependencies = { "nvim-lua/plenary.nvim" },
  },
}
