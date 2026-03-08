local autocmd = vim.api.nvim_create_autocmd
local vimrc_events = vim.api.nvim_create_augroup("vimrc", { clear = true })
local map = vim.keymap.set

-- Resetta le impostazioni grafiche di Kitty
if os.getenv("TERM") == "xterm-kitty" then
  autocmd("VimLeave", {
    desc = "Resetta l'aspetto del terminale all'uscita",
    group = vimrc_events,
    callback = function()
      -- vim.system({ "kitten", "@", "set-colors", "--reset", "--all" }, { detach = true })
      vim.system({ "kitten", "@", "set-spacing", "padding=default" }, { detach = true })
    end,
  })
end

-- In Normal Mode, inserire una nuova riga dopo un commento non lo continua
autocmd("FileType", {
  pattern = "*",
  group = vimrc_events,
  callback = function()
    vim.opt.formatoptions:remove({ "o" })
  end,
})

-- Evidenzia brevemente il testo quando viene copiato
autocmd("TextYankPost", {
  desc = "Evidenzia brevemente il testo durante la copia",
  group = vimrc_events,
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Ridimensiona gli split con la finestra
autocmd("VimResized", {
  desc = "Ridimensiona gli split insieme alla finestra",
  group = vimrc_events,
  callback = function()
    if #vim.api.nvim_list_wins() > 1 then
      vim.cmd.tabdo("wincmd =")
    end
  end,
})

autocmd("CmdlineChanged", {
  desc = "Autocomplete command line",
  group = vimrc_events,
  pattern = ":",
  callback = function()
    if #vim.fn.getcmdline() > 1 then
      vim.fn.wildtrigger()
    end
  end,
})

-- Autocomandi solo per Neovide
if vim.g.neovide then
  local neovide_events = vim.api.nvim_create_augroup("NeovideEvents", { clear = true })

  -- Cambia il colore della barra
  autocmd("ColorScheme", {
    desc = "Imposta il colore della barra di Neovide",
    group = neovide_events,
    callback = function()
      local bg = vim.api.nvim_get_hl(0, { name = "Normal", link = false }).bg
      if bg then
        vim.g.neovide_title_background_color = string.format("#%06x", bg)
      end
    end,
  })

  -- Directory di default
  autocmd("VimEnter", {
    desc = "Imposta la directory di default all'avvio di Neovide",
    group = neovide_events,
    once = true,
    callback = function()
      if vim.fn.argc() == 0 then
        vim.api.nvim_set_current_dir(vim.env.HOME)
      end
    end,
  })
end
