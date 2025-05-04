local map = vim.keymap.set

local function resize_win(increase, dim, factor)
  local get_dim = {
    width = vim.api.nvim_win_get_width,
    height = vim.api.nvim_win_get_height
  }

  local new_size = get_dim[dim](0)

  if increase then
    new_size = new_size * factor
  else
    new_size = new_size / factor
  end

  new_size = math.floor(new_size)

  vim.api.nvim_win_set_config(0, { [dim] = new_size })
end

-- Imposta il tasto master
vim.g.mapleader = " "

-- Torna in normal mode nel terminale integrato
map("t", "<ESC><ESC>", "<C-\\><C-n>", { desc = "Torna in normal mode nel terminale integrato", noremap = true })

-- Chiudi buffer corrente
map("n", "<leader>q", vim.cmd.bd, { desc = "Chiudi buffer corrente" })

-- Copia/incolla nel buffer di sistema
map({ "n", "v" }, "<A-y>", "\"+y", { desc = "Copia nel buffer di sistema", noremap = true })
map({ "n", "v" }, "<A-p>", "\"+p", { desc = "Incolla dal buffer di sistema", noremap = true })

-- Disabilita le frecce direzionali
map({ "n", "v" }, "<up>", "<nop>", { noremap = true })
map({ "n", "v" }, "<down>", "<nop>", { noremap = true })
map({ "n", "v" }, "<left>", "<nop>", { noremap = true })
map({ "n", "v" }, "<right>", "<nop>", { noremap = true })

-- Ridimensiona in step
map("n", "<C-w><", function() resize_win(false, "width", 1.2) end, { desc = "Riduci larghezza della finestra del 20%", noremap = true })
map("n", "<C-w>>", function() resize_win(true, "width", 1.2) end, { desc = "Aumenta larghezza della finestra del 20%", noremap = true })
map("n", "<C-w>+", function() resize_win(true, "height", 1.2) end, { desc = "Aumenta altezza della finestra del 20%", noremap = true })
map("n", "<C-w>-", function() resize_win(false, "height", 1.2) end, { desc = "Riduci altezza della finestra del 20%", noremap = true })

-- Mappe specifiche di Neovide
if vim.g.neovide then
  -- Mette Neovide a schermo intero
	map("n", "<F11>", function() vim.g.neovide_fullscreen = not vim.g.neovide_fullscreen end, { desc = "Metti Neovide a schermo intero" })
end
