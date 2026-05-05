local StatusLine = {}
local ok, icons = pcall(require, "mini.icons")

local function file_icon_and_name()
  local fname = vim.fn.expand("%:t")
  if fname:len() > 0 then
    if ok then
      local icon, hl, _ = icons.get("filetype", vim.bo.filetype)
      return string.format("%%#%s#%s%%* %s", hl, icon, fname)
    end
    return fname
  end
  return "[No Name]"
end

local function language_info()
  local ft = vim.bo.filetype
  if ft:len() == 0 then
    return ""
  end

  local clients = vim.lsp.get_clients({ bufnr = 0 })
  local lsp_names = vim
    .iter(clients)
    :map(function(c)
      return c.name
    end)
    :totable()

  local parts = { ft }
  if #lsp_names > 0 then
    table.insert(parts, string.format("%%#NonText#@%%#Special#%s%%*", lsp_names[1]))
  end

  return string.format("[%s]", table.concat(parts, ""))
end

local function diagnostic_count()
  local status = {}
  local diags = vim.diagnostic.count(0)
  for id, count in pairs(diags) do
    local severity = vim.diagnostic.severity[id]
    local label = string.format("%%#Diagnostic%s#%s:%d%%*", severity, severity:sub(1, 1), count)
    vim.list_extend(status, { label })
  end
  return table.concat(status, " ")
end

function StatusLine.tostring()
  local file_info = file_icon_and_name()
  local labels = diagnostic_count()
  local padding = 2 + vim.api.nvim_eval_statusline(labels, { highlights = false }).width
  local diagnostics = string.format("%%-%d.(%s%%)", padding, labels)
  local language = language_info()
  return table.concat({
    "%<",
    file_info .. " %#WarningMsg#%m%*",
    "%=",
    diagnostics,
    language,
    "%12.(%l%#NonText#:%*%L%)",
  })
end

return StatusLine
