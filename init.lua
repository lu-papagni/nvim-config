vim.loader.enable()

vim.g.mapleader = vim.keycode("<Space>")

for _, map in ipairs(require("config.mappings")) do
  vim.keymap.set(map.mode or "n", map.keys, map.exec, { desc = map[1] })
end

require("config.options")
require("config.autocmd")
require("config.usercmd")

vim.pack.add({
  "https://github.com/neovim/nvim-lspconfig",
  "https://github.com/windwp/nvim-ts-autotag",
  "https://github.com/nvim-treesitter/nvim-treesitter-textobjects",
  "https://github.com/nvim-mini/mini.icons",
  "https://github.com/nvim-mini/mini.files",
  "https://github.com/nvim-mini/mini.pick",
  "https://github.com/nvim-mini/mini.extra",
  "https://github.com/echasnovski/mini.diff",
  "https://github.com/mason-org/mason.nvim",
  "https://github.com/saghen/blink.indent",
  { src = "https://github.com/rose-pine/neovim", name = "rose-pine" },
  "https://github.com/savq/melange-nvim",
})
