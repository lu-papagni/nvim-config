---@class ThemeSettings
--- Insieme di impostazioni per l'applicazione di un tema
local DEFAULT_SETTINGS = {
  foreground = nil, ---@type string|nil
  background = nil, ---@type string|nil
  transparent = true, ---@type boolean
  force_transparency = false, ---@type boolean
  mode = 'dark', ---@type 'light'|'dark'
}

---@class ThemeSettings
local SETTINGS = {}

local Colorscheme = {}

--- Modifica gli highlight groups relativi a TreeSitter
---@param theme string|nil Nome del tema
local function edit_text_objects(theme)
  if theme == "gruvbox-material" then
    vim.api.nvim_set_hl(0, "TSPunctBracket", { link = "Grey" })
  end
end

--- Rende il tema trasparente
Colorscheme.toggle_transparency = function()
  local theme = Colorscheme.current
  local transparent = SETTINGS[theme].transparent
  local force = SETTINGS[theme].force_transparency

  if not transparent and force then
    local highlightGroups = {
      "Normal",
      "NormalFloat",
      "NormalNC",
      "NonText",
      "EndOfBuffer",
    }
    for _, group in ipairs(highlightGroups) do
      vim.api.nvim_set_hl(0, group, { bg = "none" })
    end
  end

  SETTINGS[theme].transparent = not transparent

  vim.cmd.colorscheme(theme)
  edit_text_objects(theme)
end

Colorscheme.toggle_mode = function()
  local mode = vim.o.background

  vim.o.background = mode == 'dark' and 'light' or 'dark'
end

--- Applica il tema scelto a nvim
Colorscheme.setup = function(opts)
  for theme, settings in pairs(opts) do
    SETTINGS[theme] = {}
    SETTINGS[theme].mode = settings.mode or DEFAULT_SETTINGS.mode
    SETTINGS[theme].transparent = settings.transparent or DEFAULT_SETTINGS.transparent
    SETTINGS[theme].force_transparency = settings.force_transparency or DEFAULT_SETTINGS.force_transparency
    SETTINGS[theme].background = settings.background
    SETTINGS[theme].foreground = settings.foreground
  end
end

Colorscheme.before = function(theme)
  Colorscheme.current = theme

  if theme == "gruvbox-material" then
    vim.g.gruvbox_material_transparent_background = SETTINGS[theme].transparent
    vim.g.gruvbox_material_better_performance = 1
    vim.g.gruvbox_material_background = SETTINGS[theme].background or 'mix'
    vim.g.gruvbox_material_foreground = SETTINGS[theme].foreground or 'mix'
    vim.g.gruvbox_material_enable_bold = 1
    vim.g.gruvbox_material_show_eob = 0
    vim.g.gruvbox_material_float_style = 'bright'
    vim.g.gruvbox_material_diagnostic_text_highlight = 1
  end
end

---Applica le impostazioni rispetto allo schema colori corrente
Colorscheme.after = function()
  local theme = Colorscheme.current
  local want_transparency = DEFAULT_SETTINGS.transparent
  local mode = DEFAULT_SETTINGS.mode

  if SETTINGS[theme] then
    want_transparency = SETTINGS[theme].transparent
    mode = SETTINGS[theme].mode
  end

  vim.o.background = mode

  -- BUG:La trasparenza non si attiva sempre
  if want_transparency then
    Colorscheme.toggle_transparency()
  end

  edit_text_objects(theme)
end

return Colorscheme
