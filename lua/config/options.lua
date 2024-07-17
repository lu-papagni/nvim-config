-- Opzioni specifiche di neovide
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

-- Se è aperto nel terminale kitty
if os.getenv("TERM") == "xterm-kitty" then
  vim.g.using_kitty_term = true

  -- Colori da usare come sfondo di kitty
  vim.g.kitty_background_variants = {
    ["gruvbox-material"] = { dark = "#282828", light = "#f9f5d7" },
    ["onedark"] = { dark = "#282c34", light = "#ffffff" },
    ["kanagawa"] = { dark = "#1f1f28", light = "#f2ecbc" },
    ["everforest"] = { dark = "#272e33", light = "#fffbef" },
    ["tokyonight-moon"] = { dark = "#212336", light = "#E1E2E7" },
    ["tokyonight-day"] = { dark = "#212336", light = "#E1E2E7" },
  }
else
  vim.g.using_kitty_term = false
end

-- Opzioni specifiche di Windows
if vim.fn.has("win32") == 1 then
  vim.o.shell = "powershell.exe -nologo"
end
