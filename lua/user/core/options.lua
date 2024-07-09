-- Se è aperto in neovide
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

-- Se è aperto nel terminale kitty
if os.getenv('TERM') == 'xterm-kitty' then
  vim.g.using_kitty_term = true

  -- Colori da usare come sfondo di kitty
  vim.o.background_variants = {
    ['gruvbox-material'] = { dark = '#282828', light = '#f9f5d7' },
    ['onedark'] = { dark = '#282c34', light = '#ffffff' },
    ['kanagawa'] = { dark = '#1f1f28', light = '#f2ecbc' },
    ['everforest'] = { dark = '#272e33', light = '#fffbef' },
  }
else
  vim.g.using_kitty_term = false
end

-- Opzioni specifiche di Windows
if vim.fn.has('win32') then
  vim.o.shell = 'powershell.exe -nologo'
end

vim.opt.hlsearch = false -- Non evidenziare le parole durante la ricerca

vim.wo.number = true
vim.wo.relativenumber = true

vim.opt.mouse = 'a'               -- Attiva il mouse

vim.opt.clipboard = 'unnamedplus' -- La clipboard è sincronizzata con il sistema

vim.opt.breakindent = true        -- Le righe che escono dal bordo vengono mandate a capo e indentate

vim.opt.undofile = true           -- Salva cronologia annulla operazione

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.wo.signcolumn = 'yes' -- Attiva colonna dei numeri

vim.opt.completeopt = 'menuone,noselect'

vim.opt.termguicolors = true -- Supporto truecolor

vim.opt.showmode = false     -- Disabilita la visualizzazione della modalità

vim.opt.ruler = false        -- Disabilita la barra delle informazioni (ruler)

vim.opt.laststatus = 0       -- Imposta laststatus su 0

-- 4 spazi di tabulazione
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.wrap = false  -- Disabilita wrapping

vim.opt.scrolloff = 9 -- Numero minimo di linee sopra/sotto al cursore

vim.g.c_syntax_for_h = true
