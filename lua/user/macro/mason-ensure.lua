local M = {}

local IS_UNIX = vim.fn.has('linux') or vim.fn.has('macos')
local MASON_PATH = vim.fn.stdpath('data') .. '/mason'

---Fornisce il percorso di un modulo mason
---@param module string
---@return string
local function get_module_path(module)
  local mod_path = MASON_PATH .. '/bin/' .. module
  local ext = '.cmd'

  if not IS_UNIX then
    -- rendi il percorso compatibile con Windows
    mod_path = (mod_path .. ext):gsub('/', '\\')
  end

  return mod_path
end

---Controlla che siano installati i moduli elencati
---@param modules string[]
M.ensure = function(modules)
  if modules and #modules > 0 then
    local cmd = "MasonInstall"
    local file_exists = vim.fn.filereadable

    for _, modname in ipairs(modules) do
      local path = get_module_path(modname)
      if file_exists(path) == 0
      then
        cmd = cmd .. ' ' .. modname
      end
    end

    if not cmd == "MasonInstall" then
      vim.cmd(cmd)
    end
  end
end

return M
