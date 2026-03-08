return {
  "windwp/nvim-autopairs",
  event = "InsertEnter",
  opts = {
    disable_filetype = {
      "TelescopePrompt",
      "spectre_panel",
      "minifiles",
      "txt",
    },
    enable_bracket_in_quote = false,
  },
}
