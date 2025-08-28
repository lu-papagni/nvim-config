local StatusLine = {}

local function language_info()
  local lang = vim.bo.filetype
  if lang:len() == 0 then return "" end
  local _, lsp = next(vim.lsp.get_clients { bufnr = 0 })
  if lsp then lang = string.format("%s%%#NonText#@%%#Special#%s%%*", lang, lsp.name) end
  return string.format("[%s]", lang)
end

local function diagnostic_count()
  local status = {}
  local diags = vim.diagnostic.count(0)
  for i, count in ipairs(diags) do
    if count > 0 then
      local severity = vim.diagnostic.severity[i]
      table.insert(status, string.format("%%#Diagnostic%s#%s:%d%%*", severity, severity:sub(1,1), count))
    end
  end
  return table.concat(status, " ")
end

function StatusLine.tostring()
  return table.concat {
    "%<%f %#WarningMsg#%m%*",
    string.format("%%5.(%s%%)", diagnostic_count()),
    "%=",
    language_info(),
    "%9.(%l%#NonText#:%*%L%)",
  }
end

return StatusLine
