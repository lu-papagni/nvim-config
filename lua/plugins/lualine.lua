return {
  "nvim-lualine/lualine.nvim",
  opts = {
    options = {
      component_separators = { left = "", right = "" },
      section_separators = { left = "", right = "" },
      ignore_focus = {
        "dapui_watches",
        "dapui_breakpoints",
        "dapui_scopes",
        "dapui_console",
        "dapui_stacks",
        "dap-repl",
      },
      disabled_filetypes = {
        "netrw",
        "trouble",
        "alpha",
      },
    },
    sections = {
      lualine_a = {
        {
          "mode",
          icons_enabled = true,
          icon = "",
        },
      },
      lualine_y = { "progress" },
      lualine_z = {
        {
          "location",
          icons_enabled = true,
          icon = { "󰵉", align = "right" },
        },
      },
    },
  },
}
