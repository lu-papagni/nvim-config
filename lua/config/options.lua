-- Comportamento
vim.wo.number = true          -- Attiva numeri di riga
vim.wo.relativenumber = true  -- Numeri di riga relativi al cursore
vim.o.hlsearch = false        -- Non evidenziare i risultati dopo la ricerca
vim.o.breakindent = true      -- Mantieni indentazione
vim.o.undofile = true         -- Annulla un'operazione anche dopo la riapertura di Vim
vim.o.tabstop = 2             -- Dimensione del tab = 2 spazi
vim.o.shiftwidth = 2          -- Dimensione del tab = 2 spazi
vim.o.expandtab = true        -- Converti TAB in spazi
vim.o.wrap = false            -- Disabilita a capo automatico
vim.o.scrolloff = 9           -- Righe da mostrare sempre intorno al cursore
vim.o.termguicolors = true    -- Supporto per truecolor nel terminale
vim.o.ignorecase = true       -- I comandi sono case insensitive
vim.o.smartcase = true        -- Disabilita `ignorecase` quando si digita una lettera maiuscola

-- Esplora file
vim.g.netrw_winsize = 30      -- Larghezza dell'esplora file laterale in %
vim.g.netrw_keepdir = 0       -- Sincronizza la directory di lavoro durante la navigazione
vim.g.netrw_liststyle = 1     -- Lista dettagliata
vim.g.netrw_sort_by = 'exten' -- Ordina per estensione, prima le directory

-- Se è aperto in Neovide
if vim.g.neovide then
  vim.o.guifont = 'JetBrainsMono Nerd Font,Consolas:h11'
  vim.g.neovide_refresh_rate = 60
  vim.g.neovide_refresh_rate_idle = 5
  vim.g.neovide_remember_window_size = true
  vim.g.neovide_cursor_animation_length = 0.10
  vim.g.neovide_cursor_trail_size = 0.5
  vim.g.neovide_cursor_animate_command_line = false
  vim.g.neovide_transparency = 0.95
  vim.g.neovide_floating_shadow = false
end

-- Windows
if vim.fn.has('win32') == 1 then
  vim.o.shell = 'powershell.exe -nologo'
end
