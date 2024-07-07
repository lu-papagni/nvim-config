local create_autocmd = vim.api.nvim_create_autocmd

create_autocmd('FileType', {
  pattern = { '*' },
  callback = function()
    -- vim.cmd("set formatoptions-=o")
    vim.o.formatoptions = 'jcrql'
  end
})

-- Evidenzia brevemente il testo quando copio
create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("my-highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end
})

-- Rende le parentesi grigie
create_autocmd('ColorScheme', {
  pattern = '*',
  callback = function()
    vim.api.nvim_set_hl(0, "TSPunctBracket", { link = "Grey" })
  end
})

-- Funzioni speciali di kitty
if os.getenv('TERM') == 'xterm-kitty' then
  local function set_kitty_bg(dark_bg, light_bg)
    local bg = vim.o.background

    if bg == 'dark' then
      if dark_bg then
        vim.system({ 'kitten', '@', 'set-colors', 'background=' .. dark_bg })
      else
        print('ERRORE: Il tema non ha la modalità scura.')
      end
    else
      if bg == 'light' then
        if light_bg then
          vim.system({ 'kitten', '@', 'set-colors', 'background=' .. light_bg })
        else
          print('ERRORE: Il tema non ha la modalità chiara.')
        end
      end
    end
  end

  vim.system({ 'kitten', '@', 'set-spacing', 'padding=0' }, { detach = true })

  create_autocmd("VimLeave", {
    callback = function()
      vim.system({ 'kitten', '@', 'set-colors', '--reset', '--all' }, { detach = true })
      vim.system({ 'kitten', '@', 'set-spacing', 'padding=default' }, { detach = true })
    end
  })

  create_autocmd('ColorScheme', {
    pattern = 'kanagawa',
    callback = function()
      set_kitty_bg('#1f1f28', '#f2ecbc')
    end
  })

  create_autocmd('ColorScheme', {
    pattern = 'everforest',
    callback = function()
      set_kitty_bg('#272e33', '#fffbef')
    end
  })

  create_autocmd('ColorScheme', {
    pattern = 'gruvbox-material',
    callback = function()
      set_kitty_bg('#282828', '#f9f5d7')
    end
  })

  create_autocmd('ColorScheme', {
    pattern = 'onedark',
    callback = function()
      set_kitty_bg('#282c34', nil)
    end
  })
end
