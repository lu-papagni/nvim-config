local map = vim.keymap.set

-- Imposta il tasto master
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Apre esplora file
map('n', '<leader>e', "<cmd>Explore<cr>", { desc = 'Apri esplora file' })

-- Torna in normal mode nel terminale integrato
map('t', '<ESC><ESC>', '<C-\\><C-n>', { desc = 'Torna in normal mode nel terminale integrato', noremap = true })

-- Chiudi buffer corrente
map('n', "<leader>q", "<cmd>bd<cr>", { desc = "Chiudi buffer corrente" })

-- Disabilita le frecce direzionali
map({'n', 'v', 'i'}, "<up>", "<nop>")
map({'n', 'v', 'i'}, "<down>", "<nop>")
map({'n', 'v', 'i'}, "<left>", "<nop>")
map({'n', 'v', 'i'}, "<right>", "<nop>")

-- Ridimensiona in step
map('n', "<C-w><", function() vim.api.nvim_win_set_config(0, { width = math.floor(vim.api.nvim_win_get_width(0) / 1.2) }) end)
map('n', "<C-w>>", function() vim.api.nvim_win_set_config(0, { width = math.floor(vim.api.nvim_win_get_width(0) * 1.2) }) end)
map('n', "<C-w>+", function() vim.api.nvim_win_set_config(0, { height = math.floor(vim.api.nvim_win_get_height(0) * 1.2) }) end)
map('n', "<C-w>-", function() vim.api.nvim_win_set_config(0, { height = math.floor(vim.api.nvim_win_get_height(0) / 1.2) }) end)

-- Mappe specifiche di Neovide
if vim.g.neovide then
  -- Mette Neovide a schermo intero
	map('n', '<F11>', function()
		vim.g.neovide_fullscreen = not vim.g.neovide_fullscreen
	end, { desc = 'Metti Neovide a schermo intero' })
end
