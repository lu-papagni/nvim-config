return {
  "saghen/blink.indent",
  event = { "BufNewFile", "BufReadPost" },
  opts = {
    static = { enabled = false },
    scope = {
      highlights = { "BlinkIndentScope" },
    }
  }
}
