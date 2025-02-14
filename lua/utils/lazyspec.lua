local M = {}

-- Genera una LazySpec a partire da un layout custom che prevede moduli opzionali
function M.use_optionals(spec)
  local PLUGIN_PATH = vim.fn.stdpath("config") .. "/lua/plugins/"
  local new_spec = {
    -- Importare `plugins` è obbligatorio per il plugin manager
    { import = "plugins" }
  }

  for _, s in ipairs(spec) do
    if s.enabled == nil or s.enabled then
      local avaiable = s.optional and vim.uv.fs_stat(PLUGIN_PATH .. s.mod)
      -- Aggiungo il modulo se non è opzionale oppure
      -- è opzionale ed esiste su disco
      if not s.optional or avaiable then
        table.insert(new_spec, { import = "plugins." .. s.mod })
      end
    end
  end

  return new_spec
end

return M
