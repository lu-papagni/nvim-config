-- Tasto leader
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local map = vim.keymap.set

-- QOL word wrap
map('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Apri esplora file laterale nella directory puntata dal buffer che ha focus
map('n', '<leader>e', function()
	vim.cmd.Lexplore(vim.fn.expand('%:p:h'))
end)

-- Chiudi esplora file laterale
map('n', '<leader>E', vim.cmd.Lexplore)

-- Chiudi buffer corrente
map('n', "<leader>q", "<cmd>bd<cr>", { desc = "Chiudi buffer corrente" })

-- Torna in normal mode nel terminale integrato
map('t', '<ESC>', '<C-\\><C-n>', { noremap = true })

if vim.g.neovide then
	map('n', '<F11>', function()
		vim.g.neovide_fullscreen = not vim.g.neovide_fullscreen
	end, { desc = 'Metti Neovide a schermo intero' })
end
