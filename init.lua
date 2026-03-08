vim.loader.enable()

vim.g.mapleader = vim.keycode("<Space>")

for _, map in ipairs(require("config.mappings")) do
  vim.keymap.set(map.mode or "n", map.keys, map.exec, { desc = map[1] })
end

require("config.options")
require("config.autocmd")
require("config.usercmd")
require("config.lsp")

vim.pack.add({
  "gh:nvim-treesitter/nvim-treesitter",
  "gh:windwp/nvim-ts-autotag",
  "gh:nvim-treesitter/nvim-treesitter-textobjects",
  "gh:nvim-mini/mini.icons",
  "gh:nvim-mini/mini.files",
  "gh:nvim-mini/mini.pick",
  "gh:nvim-mini/mini.extra",
  "gh:echasnovski/mini.diff",
  "gh:mason-org/mason.nvim",
  "gh:saghen/blink.indent",
  { src = "gh:rose-pine/neovim", name = "rose-pine" },
  "gh:savq/melange-nvim",
})
