local StatusLine = {}
local _state = {
  buf = -1,
  lsp = {
    name = "",
    nr = 0,
  },
}

local function file_icon_and_name()
  local ok, icons = pcall(require, "mini.icons")
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

local function refresh_lsp(bufnr)
  local lsp = vim.lsp.get_clients({ bufnr = bufnr })
  local name = vim
    .iter(lsp)
    :rev()
    :map(function(c)
      return c.name
    end)
    :next()

  return name, #lsp
end

local function lsp_info()
  local bufnr = vim.fn.bufnr()

  if _state.buf ~= bufnr then
    _state.lsp.name, _state.lsp.nr = refresh_lsp(bufnr)
    _state.buf = bufnr
  end

  local clients = _state.lsp.nr
  local main_lsp = _state.lsp.name
  local parts = {}
  table.insert(parts, string.format("%%#Special#%s%%*", main_lsp))

  if clients > 1 then
    table.insert(parts, "...")
  end

  local out = ""
  if main_lsp and #main_lsp > 0 then
    out = string.format("[%s]", table.concat(parts, ""))
  end

  return out
end

function StatusLine.tostring()
  local file_info = file_icon_and_name() .. " %#WarningMsg#%m%*"
  local language = lsp_info()
  return table.concat({
    "%<",
    file_info,
    "%=",
    vim.diagnostic.status() .. " ",
    language,
    "%12.(%l%#NonText#:%*%L%)",
  })
end

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ctx)
    if ctx.buf == vim.fn.bufnr() then
      _state.lsp.name, _state.lsp.nr = refresh_lsp(ctx.buf)
    end
  end,
  once = true,
})

return StatusLine
