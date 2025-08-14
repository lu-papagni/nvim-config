local map = vim.keymap.set

local function resize_win(dim, ratio)
  assert(
    dim == "width" or dim == "height",
    string.format("'%s' non è una dimensione di finestra valida", dim)
  )

  local size = {
    width = vim.api.nvim_win_get_width(0),
    height = vim.api.nvim_win_get_height(0),
  }
  local factor = 1 + math.abs(ratio)

  if ratio < 0 then factor = 1/factor end
  new_size = math.floor(size[dim] * factor)  -- NOTE: window-id = 0 indica la finestra corrente
  vim.api.nvim_win_set_config(0, { [dim] = new_size })
end

-- Imposta il tasto master
vim.g.mapleader = vim.keycode("<space>")

-- Torna in normal mode nel terminale integrato
map("t", "<ESC><ESC>", "<C-\\><C-n>", { desc = "Torna in normal mode nel terminale integrato" })

-- Chiudi buffer corrente
map("n", "<leader>q", vim.cmd.bd, { desc = "Chiudi buffer corrente" })

-- Copia/incolla nel buffer di sistema
map({ "n", "v" }, "<A-y>", "\"+y", { desc = "Copia nel buffer di sistema" })
map({ "n", "v" }, "<A-p>", "\"+p", { desc = "Incolla dal buffer di sistema" })

-- Scorri con cursore centrato
map("n", "<C-d>", "<C-d>zz", { desc = "Scorri verso il basso con cursore centrato" })
map("n", "<C-u>", "<C-u>zz", { desc = "Scorri verso l'alto con cursore centrato" })

-- Disabilita le frecce direzionali
map({ "n", "v" }, "<up>", "<nop>", { desc = "Disabilita le frecce direzionali" })
map({ "n", "v" }, "<down>", "<nop>", { desc = "Disabilita le frecce direzionali" })
map({ "n", "v" }, "<left>", "<nop>", { desc = "Disabilita le frecce direzionali" })
map({ "n", "v" }, "<right>", "<nop>", { desc = "Disabilita le frecce direzionali" })

-- Ridimensiona in step
map("n", "<C-w><", function() resize_win("width", -0.2) end,
    { desc = "Riduci larghezza della finestra del 20%" })

map("n", "<C-w>>", function() resize_win("width", 0.2) end,
    { desc = "Aumenta larghezza della finestra del 20%" })

map("n", "<C-w>+", function() resize_win("height", 0.2) end,
    { desc = "Aumenta altezza della finestra del 20%" })

map("n", "<C-w>-", function() resize_win("height", -0.2) end,
    { desc = "Riduci altezza della finestra del 20%" })

-- Scambia velocemente i due buffer più recenti
map("n", "<leader><space>", "<C-^>", { desc = "Scambia velocemente i due buffer più recenti" })

-- Rimappature specifiche di Neovide
if vim.g.neovide then
	map("n", "<F11>",
      function() vim.g.neovide_fullscreen = not vim.g.neovide_fullscreen end,
      { desc = "Metti Neovide a schermo intero" })

  local function new_opacity(step)
    return math.min(1.0, math.max(0, vim.g.neovide_normal_opacity + step))
  end

  map({ "n", "x", "i", "t" }, "<C-ScrollWheelUp>",
      function() vim.g.neovide_normal_opacity = new_opacity(0.05) end,
      { desc = "Aumenta opacità della finestra di Neovide" })

  map({ "n", "x", "i", "t" }, "<C-ScrollWheelDown>",
      function() vim.g.neovide_normal_opacity = new_opacity(-0.05) end,
      { desc = "Riduci opacità della finestra di Neovide" })
end
