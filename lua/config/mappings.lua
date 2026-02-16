local mappings = {
  {
    "Switch back to Normal Mode in terminal",
    mode = "t",
    keys = "<Esc><Esc>",
    exec = "<C-\\><C-n>",
  },
  {
    "Close current buffer",
    keys = "<Leader>q",
    exec = vim.cmd.bd,
  },
  {
    "Copy in system clipboard",
    mode = { "n", "v" },
    keys = "<A-y>",
    exec = "\"+y"
  },
  {
    "Paste from system clipboard",
    mode = { "n", "v" },
    keys = "<A-p>",
    exec = "\"+p",
  },
  {
    "Scroll downwards centering screen",
    keys = "<C-d>",
    exec = "<C-d>zz",
  },
  {
    "Scroll upwards centering screen",
    keys = "<C-u>",
    exec = "<C-u>zz",
  },
  {
    "Disable directional UP arrow",
    mode = { "n", "v" },
    keys = "<Up>",
    exec = "<Nop>",
  },
  {
    "Disable directional DOWN arrow",
    mode = { "n", "v" },
    keys = "<Down>",
    exec = "<Nop>",
  },
  {
    "Disable directional RIGHT arrow",
    mode = { "n", "v" },
    keys = "<Right>",
    exec = "<Nop>",
  },
  {
    "Disable directional LEFT arrow",
    mode = { "n", "v" },
    keys = "<Left>",
    exec = "<Nop>",
  },
  {
    "Swap alternate files",
    keys = "<Leader><Space>",
    exec = "<C-6>",
  },
  {
    "Swap colorscheme between light and dark variant",
    keys = "<F12>",
    exec = "<Cmd>let &bg = &bg == 'dark' ? 'light' : 'dark'<CR>"
  }
}

if vim.g.neovide then
  local new_opacity = function(step)
    return math.min(1.0, math.max(0, vim.g.neovide_normal_opacity + step))
  end

  vim.list_extend(keymaps, {
    {
      "Put Neovide in fullscreen mode",
      keys = "<F11>",
      exec = function() vim.g.neovide_fullscreen = not vim.g.neovide_fullscreen end,
    },
    {
      "Increase Neovide background opacity",
      mode = { "n", "x", "i", "t" },
      keys = "<C-ScrollWheelUp>",
      exec = function() vim.g.neovide_normal_opacity = new_opacity(0.05) end,
    },
    {
      "Decrease Neovide background opacity",
      mode = { "n", "x", "i", "t" },
      keys = "<C-ScrollWheelDown>",
      exec = function() vim.g.neovide_normal_opacity = new_opacity(-0.05) end,
    }
  })
end

return mappings
