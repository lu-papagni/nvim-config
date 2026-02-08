return {
  "saghen/blink.cmp",
  version = "1.*",
  enabled = vim.g.git_editor ~= 1,
  event = "InsertEnter",
  dependencies = { "fang2hou/blink-copilot" },
  opts = {
    cmdline = { enabled = false },
    completion = {
      menu = { auto_show = false },
      ghost_text = { enabled = true }
    },
    sources = {
      default = { "lsp", "snippets", "copilot" },
      providers = {
        copilot = {
          name = "copilot",
          module = "blink-copilot",
          async = true
        }
      }
    },
    keymap = {
      ["<up>"] = false,
      ["<down>"] = false,
      ["<C-j>"] = { "select_next", "fallback" },
      ["<C-k>"] = { "select_prev", "fallback" },
    }
  }
}
