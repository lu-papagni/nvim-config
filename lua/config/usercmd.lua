local usercmd = vim.api.nvim_create_user_command

usercmd("PackClean", function()
  local packages = vim.pack.get()
  local inactive = vim
    .iter(packages)
    :filter(function(p)
      return not p.active
    end)
    :map(function(p)
      return p.spec.name
    end)
    :totable()
  vim.pack.del(inactive)
end, { desc = "Remove inactive plugins" })
