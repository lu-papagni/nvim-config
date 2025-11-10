local StatusLine = {}

local function file_icon_and_name()
  local fname = vim.fn.expand("%:t")
  if fname:len() > 0 then 
    local ok, icons = pcall(require, "mini.icons")
    if ok then
      local icon, hl, _ = icons.get("filetype", vim.bo.filetype)
      return string.format("%%#%s#%s%%* %s", hl, icon, fname)
    end
    return fname
  end
  return "[No Name]"
end

local function tools_info()
  local ft = vim.bo.filetype
  if ft:len() == 0 then return "" end

  local lsp_name = nil
  local copilot_attached = false

  for _, client in pairs(vim.lsp.get_clients { bufnr = 0 }) do
    if client.name:lower() == "copilot" then
      copilot_attached = true
    elseif not lsp_name then
      lsp_name = client.name
    end
  end

  local parts = { ft }
  if lsp_name then
    table.insert(parts, string.format("%%#NonText#@%%#Special#%s%%*", lsp_name))
  end

  local result = string.format("[%s]", table.concat(parts, ""))
  if copilot_attached then
    result = result .. " \u{f4b8}"
  end

  return result
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
    "%<",
    file_icon_and_name(),
    " %#WarningMsg#%m%*",
    string.format("%%5.(%s%%)", diagnostic_count()),
    "%=",
    tools_info(),
    "%12.(%l%#NonText#:%*%L%)",
  }
end

return StatusLine
