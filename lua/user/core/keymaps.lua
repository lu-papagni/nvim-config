-- Tasto leader
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local map = vim.keymap.set

-- QOL word wrap
map('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Diagnostica
map('n', '[d', vim.diagnostic.goto_prev, { desc = 'Vai a prec. messaggio di diagnostica' })
map('n', ']d', vim.diagnostic.goto_next, { desc = 'Vai a succ. messaggio di diagnostica' })
map('n', '<leader>dm', vim.diagnostic.open_float, { desc = 'Apri menu diagnostica' })
map('n', '<leader>dl', vim.diagnostic.setloclist, { desc = 'Apri lista diagnostica' })

-- Apri esplora file laterale nella directory del buffer che ha focus
map('n', '<leader>e', function()
	vim.cmd.Lexplore(vim.fn.expand('%:p:h'))
end)

map('n', '<leader>E', vim.cmd.Lexplore)

-- Chiudi buffer corrente
map('n', "<leader>q", "<cmd>bd<cr>", { desc = "Chiudi buffer corrente" })
