--[[ Aspetto ]]--
vim.g.ui_border_style = "rounded"    -- Stile dei bordi dell'interfaccia. Vedi :h nvim_open_win()

--[[ Comportamento ]]--
vim.wo.number = true          -- Attiva numeri di riga
vim.wo.relativenumber = true  -- Numeri di riga relativi al cursore
vim.o.hlsearch = false        -- Non evidenziare i risultati dopo la ricerca
vim.o.breakindent = true      -- Mantieni indentazione
vim.o.undofile = true         -- Annulla operazione anche dopo la riapertura di Vim
vim.o.tabstop = 2             -- Dimensione del tab = 2 spazi
vim.o.shiftwidth = 2          -- Dimensione del tab = 2 spazi
vim.o.expandtab = true        -- Converti TAB in spazi
vim.o.wrap = false            -- Disabilita a capo automatico
vim.o.scrolloff = 9           -- Numero di righe da mostrare sempre intorno al cursore
vim.o.termguicolors = true    -- Supporto per truecolor nel terminale
vim.o.ignorecase = true       -- I comandi sono case insensitive
vim.o.smartcase = true        -- Disabilita `ignorecase` quando si digita una lettera maiuscola
vim.o.splitright = true       -- Gli split verticali compaiono a destra della finestra attiva
vim.o.splitbelow = true       -- Gli split orizzontali compaiono sotto la finestra attiva

--[[ netrw - Esplora File ]]--
vim.g.netrw_winsize = 30      -- Larghezza finestre secondarie in %
vim.g.netrw_preview = 1       -- Anteprima verticale
vim.g.netrw_keepdir = 1       -- Sincronizza la directory di lavoro durante la navigazione (1 = off, 0 = off)

--[[ Neovide ]]--
if vim.g.neovide then
  vim.o.guifont = "JetBrainsMono Nerd Font,Consolas:h11"
  vim.g.neovide_refresh_rate = 60
  vim.g.neovide_refresh_rate_idle = 5
  vim.g.neovide_remember_window_size = true
  vim.g.neovide_cursor_animation_length = 0.10
  vim.g.neovide_cursor_trail_size = 0.5
  vim.g.neovide_cursor_animate_command_line = false
  vim.g.neovide_transparency = 0.95
  vim.g.neovide_floating_shadow = false
end

--[[ Windows ]]--
if vim.fn.has("win32") == 1 then
  local shell = "cmd.exe"
  local options = "-nologo"

  -- Prova a usare PowerShell 7
  if vim.fn.executable("pwsh") == 1 then
    shell = "pwsh.exe"
  elseif vim.fn.excutable("powershell") then
    shell = "powershell.exe"
  end

  vim.o.shell = table.concat({ shell, options }, " ")
end

--[[ WSL ]]--
if vim.fn.has("wsl") == 1 then
  local function paste()
    return {
      vim.fn.split(vim.fn.getreg(""), "\n"),
      vim.fn.getregtype(""),
    }
  end

  vim.g.clipboard = {
    name = "OSC 52",
    copy = {
      ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
      ["*"] = require("vim.ui.clipboard.osc52").copy("*"),
    },
    paste = {
      ["+"] = paste,
      ["*"] = paste,
    },
  }
end

--[[ Kitty Terminal ]]-- 
if os.getenv("TERM") == "xterm-kitty" then
  vim.schedule(function()
    vim.system(
      { "kitten", "@", "set-spacing", "padding=0" },
      { detach = true }
    )
  end)
end
