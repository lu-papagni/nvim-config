-- Generale
vim.o.undofile = true
vim.opt.path:append("**")
vim.opt.wildignore:append { "*.o", "*.class", "*.jar", "*.obj", "*.tmp" }

-- UI
vim.wo.number = true
vim.wo.relativenumber = true
vim.o.termguicolors = true
vim.o.scrolloff = 9
vim.o.wrap = false
vim.o.cursorline = true
vim.o.cursorlineopt = "line"
vim.o.statusline = "%{%v:lua.require'statusline'.tostring()%}"

-- Ricerca
vim.o.hlsearch = false
vim.o.ignorecase = true
vim.o.smartcase = true

-- Formattazione
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.o.breakindent = true

-- Finestre
vim.o.splitright = true
vim.o.splitbelow = true

-- Folding
vim.o.foldmethod = "expr"
vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.o.foldlevelstart = 6
vim.o.foldnestmax = 4

-- Diagnostica
vim.diagnostic.config {
  virtual_text = {
    severity = {
      min = vim.diagnostic.severity.INFO,
      max = vim.diagnostic.severity.WARN
    },
    current_line = true
  },
  virtual_lines = {
    severity = {
      min = vim.diagnostic.severity.ERROR
    },
    current_line = true
  }
}

-- Aspetto
vim.o.winborder = "rounded"   -- Stile dei bordi dell'interfaccia. Vedi `vim.o.winborder`

-- netrw
vim.g.netrw_winsize = 30      -- Larghezza finestre secondarie in %
vim.g.netrw_preview = 1       -- Anteprima verticale
vim.g.netrw_keepdir = 1       -- Sincronizza la directory di lavoro durante la navigazione

-- Neovide
if vim.g.neovide then
  vim.g.neovide_refresh_rate = 60
  vim.g.neovide_refresh_rate_idle = 5
  vim.g.neovide_remember_window_size = true
  vim.g.neovide_cursor_animation_length = 0
  vim.g.neovide_cursor_trail_size = 0.5
  vim.g.neovide_cursor_animate_command_line = false
  vim.g.neovide_normal_opacity = 0.95
  vim.g.neovide_floating_shadow = false
  vim.g.neovide_hide_mouse_when_typing = true
end

-- Solo su Windows
if vim.fn.has("win32") == 1 then
  -- Prova a usare PowerShell 7
  vim.o.shell = (vim.fn.executable("pwsh") == 1 and "pwsh" or "powershell") .. ".exe"
  vim.o.shellcmdflag = table.concat(
    {
      "-NoLogo",
      "-ExecutionPolicy",
      "RemoteSigned",
      "-Command",
      "[Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;",
      "$PSStyle.Formatting.Error='';",
      "$PSStyle.Formatting.ErrorAccent='';",
      "$PSStyle.Formatting.Warning='';",
      "$PSStyle.OutputRendering='PlainText';"
    },
    " "
  )
  vim.o.shellredir = "2>&1 | Out-File -Encoding utf8 %s; exit $LastExitCode"
  vim.o.shellpipe = "2>&1 | Out-File -Encoding utf8 %s; exit $LastExitCode"
  vim.o.shellquote = ""
  vim.o.shellxquote = ""
end

-- Solo su WSL
if vim.fn.has("wsl") == 1 then
  local function wsl_paste()
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
      ["+"] = wsl_paste,
      ["*"] = wsl_paste,
    },
  }
end

-- Kitty Terminal 
if os.getenv("TERM") == "xterm-kitty" then
  vim.schedule(function()
    vim.system(
      { "kitten", "@", "set-spacing", "padding=0" },
      { detach = true }
    )
  end)
end
