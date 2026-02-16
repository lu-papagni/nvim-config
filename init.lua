vim.g.mapleader = vim.keycode("<Space>")

for _, map in ipairs(require("config.mappings")) do
  vim.keymap.set(map.mode or "n", map.keys, map.exec, { desc = map[1] })
end

require("config.options")
require("config.autocmd")
require("config.usercmd")
require("config.lsp")
require("config.lazy")
