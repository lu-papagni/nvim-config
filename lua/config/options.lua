-- Opzioni generali
vim.o.clipboard = ""

-- Se è aperto nel terminale kitty
vim.g.using_kitty_term = os.getenv("TERM") == "xterm-kitty"

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
  vim.g.neovide_floating_blur_amount_x = 0
  vim.g.neovide_floating_blur_amount_y = 0
end

-- Opzioni specifiche di Windows
if vim.fn.has("win32") == 1 then
  vim.o.shell = "powershell.exe -nologo"
end

-- Rimuovi i bordi interni del terminale
if vim.g.using_kitty_term then
  vim.system({ "kitten", "@", "set-spacing", "padding=0" }, { detach = true })
end
