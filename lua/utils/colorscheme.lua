local M = {}

-- Contiene i nomi di temi che hanno richiesto modifiche
local SUBSCRIBED = {}

local HI_GROUPS = {
  "Normal",
  "NormalNC",
  "NonText",
  "EndOfBuffer"
}

function M.fix_transparency(opts)
  local hi_groups = HI_GROUPS

  -- Il gruppo `NormalFloat` controlla lo sfondo dei popup
  if opts.full then
    vim.list_extend(hi_groups, { "NormalFloat" } )
  end

  for _, group in ipairs(hi_groups) do
    vim.api.nvim_set_hl(0, group, { bg = "none" })
  end
end

function M.subscribe(names)
  vim.list_extend(SUBSCRIBED, names)
end

function M.get_subscribed()
  return SUBSCRIBED
end

return M
