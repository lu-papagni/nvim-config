local M = {}

-- Contiene i nomi di temi che hanno richiesto modifiche
local _subscribed = {}

-- ID dei gruppi di cui fare l'override
local _hi_groups = {
  "Normal",
  "NormalNC",
  "NonText",
  "EndOfBuffer"
}

local _services = {
  fix_transparency = function(opts)
    local hi_groups = vim.deepcopy(_hi_groups)

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
  for service, opts in pairs(_subscribed[theme]) do
    if opts then
      local ok, err = pcall(_services[service], opts)

      if not ok then
        vim.notify("Errore durante il servizio " .. service .. " per il tema " .. theme)
      end
    end
  end
end

local function fix_transparency(opts)
  local hi_groups = vim.deepcopy(_hi_groups)

  -- Il gruppo `NormalFloat` controlla lo sfondo dei popup
  if opts.full then
    vim.list_extend(hi_groups, { "NormalFloat" } )
  end

  for _, group in ipairs(hi_groups) do
    vim.api.nvim_set_hl(0, group, { bg = "none" })
  end
end

function M.subscribe(theme_spec)
  _subscribed = vim.tbl_extend("force", _subscribed, theme_spec)
end

function M.get_subscribed()
  return vim.deepcopy(_subscribed)
end

return M
