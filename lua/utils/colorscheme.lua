local M = {}

-- Contiene i nomi di temi che hanno richiesto modifiche
local SUBSCRIBED = {}

-- ID dei gruppi di cui fare l'override
local HI_GROUPS = {
  "Normal",
  "NormalNC",
  "NonText",
  "EndOfBuffer"
}

local SERVICES = {
  fix_transparency = function(opts)
    local hi_groups = vim.deepcopy(HI_GROUPS)

    -- Il gruppo `NormalFloat` controlla lo sfondo dei popup
    if opts.full then
      vim.list_extend(hi_groups, { "NormalFloat" } )
    end

    for _, group in ipairs(hi_groups) do
      vim.api.nvim_set_hl(0, group, { bg = "none" })
    end
  end
}

function M.apply(theme)
  for service, opts in pairs(SUBSCRIBED[theme]) do
    if opts then
      local ok, err = pcall(SERVICES[service], opts)

      if not ok then
        vim.notify("Errore durante il servizio " .. service .. " per il tema " .. theme)
      end
    end
  end
end

local function fix_transparency(opts)
  local hi_groups = vim.deepcopy(HI_GROUPS)

  -- Il gruppo `NormalFloat` controlla lo sfondo dei popup
  if opts.full then
    vim.list_extend(hi_groups, { "NormalFloat" } )
  end

  for _, group in ipairs(hi_groups) do
    vim.api.nvim_set_hl(0, group, { bg = "none" })
  end
end

function M.subscribe(theme_spec)
  SUBSCRIBED = vim.tbl_extend("force", SUBSCRIBED, theme_spec)
end

function M.get_subscribed()
  return vim.deepcopy(SUBSCRIBED)
end

return M
