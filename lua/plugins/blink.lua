return {
  "saghen/blink.cmp",
  version = "1.*",
  enabled = vim.g.git_editor ~= 1,
  event = "InsertEnter",
  opts = {
    cmdline = { enabled = false },
    completion = {
      menu = { auto_show = false },
      ghost_text = { enabled = true }
    },
    sources = {
      default = { "lsp", "snippets" }
    },
    keymap = {
      ["<up>"] = false,
      ["<down>"] = false,
      ["<C-j>"] = { "select_next", "fallback" },
      ["<C-k>"] = { "select_prev", "fallback" },
    }
  }
}
