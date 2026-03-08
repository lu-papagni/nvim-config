local function get_clangd_cmd()
  local cmd = {
    "clangd",
    "--background-index",
    "--clang-tidy",
    "--header-insertion=never",
    "--completion-style=detailed",
    "--fallback-style=llvm",
    "--function-arg-placeholders=false",
  }

  local gcc = vim.fn.exepath("gcc")

  vim.list_extend(cmd, {
    -- Query all avaiable C compilers
    string.format("--query-driver=%s/g*.exe", vim.fn.fnamemodify(gcc, ":h"):gsub("\\", "/")),
  })

  return cmd
end

return {
  cmd = get_clangd_cmd(),
}
