local map = vim.keymap.set
local win_set_config = vim.api.nvim_win_set_config
local win_get_width = vim.api.nvim_win_get_width
local win_get_height = vim.api.nvim_win_get_height

-- Imposta il tasto master
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Apre esplora file
map("n", "<leader>e", vim.cmd.Ex, { desc = "Apri esplora file" })

-- Torna in normal mode nel terminale integrato
map("t", "<ESC><ESC>", "<C-\\><C-n>", { desc = "Torna in normal mode nel terminale integrato", noremap = true })

-- Chiudi buffer corrente
map("n", "<leader>q", vim.cmd.bd, { desc = "Chiudi buffer corrente" })

-- Copia/incolla nel buffer di sistema
map({ "n", "v" }, "<A-y>", "\"+y", { desc = "Copia nel buffer di sistema", noremap = true })
map({ "n", "v" }, "<A-p>", "\"+p", { desc = "Incolla dal buffer di sistema", noremap = true })

-- Disabilita le frecce direzionali
map({ "n", "v", "i" }, "<up>", "<nop>", { noremap = true })
map({ "n", "v", "i" }, "<down>", "<nop>", { noremap = true })
map({ "n", "v", "i" }, "<left>", "<nop>", { noremap = true })
map({ "n", "v", "i" }, "<right>", "<nop>", { noremap = true })

-- Ridimensiona in step
map("n", "<C-w><", function()
  win_set_config(0, { width = math.floor(win_get_width(0) / 1.2) })
end, { desc = "Riduci larghezza della finestra del 20%", noremap = true })

map("n", "<C-w>>", function()
  win_set_config(0, { width = math.floor(win_get_width(0) * 1.2) })
end, { desc = "Aumenta larghezza della finestra del 20%", noremap = true })

map("n", "<C-w>+", function()
  win_set_config(0, { height = math.floor(win_get_height(0) * 1.2) })
end, { desc = "Aumenta altezza della finestra del 20%", noremap = true })

map("n", "<C-w>-", function()
  win_set_config(0, { height = math.floor(win_get_height(0) / 1.2) })
end, { desc = "Riduci altezza della finestra del 20%", noremap = true })

-- Mappe specifiche di Neovide
if vim.g.neovide then
  -- Mette Neovide a schermo intero
	map("n", "<F11>", function()
		vim.g.neovide_fullscreen = not vim.g.neovide_fullscreen
	end, { desc = "Metti Neovide a schermo intero" })
end
