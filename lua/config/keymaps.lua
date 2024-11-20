-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

-- Copia/incolla nel buffer di sistema
-- stylua: ignore
map({ "n", "v" }, "<A-y>", "\"+y", { desc = "Copia nel buffer di sistema", noremap = true })
-- stylua: ignore
map({ "n", "v" }, "<A-p>", "\"+p", { desc = "Incolla dal buffer di sistema", noremap = true })

-- Rimappature specifiche di Neovide
if vim.g.neovide then
  -- Mette Neovide a schermo intero
  map("n", "<F11>", function()
    vim.g.neovide_fullscreen = not vim.g.neovide_fullscreen
  end, { desc = "Metti Neovide a schermo intero" })
end
