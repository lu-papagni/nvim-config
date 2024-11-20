return {
  "neovim/nvim-lspconfig",
  opts = {
    autoformat = false,
    setup = {
      clangd = function(_, opts)
        local cmd = {
          "clangd",
          "--background-index",
          "--clang-tidy",
          "--header-insertion=never",
          "--completion-style=detailed",
          "--function-arg-placeholders",
          "--fallback-style=llvm",
        }

        local gcc = vim.fn.exepath("gcc"):gsub("%.EXE$", ".exe")
        local gpp = vim.fn.exepath("g++"):gsub("%.EXE$", ".exe")

        vim.list_extend(cmd, {
          table.concat({ "--query-driver=", gcc }),
          table.concat({ "--query-driver=", gpp }),
        })

        opts.cmd = cmd
      end,
    },
  },
}
