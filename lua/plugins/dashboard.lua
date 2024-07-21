local logo = [[

⠀⠀⠀⠀⠀⠀⣀⣤⣤⣴⣶⣶⣶⣆⠀⠀⠀⠀⠀⠀⠀
⠀⠀⢀⣤⣶⣿⣿⣿⣿⣿⣿⣿⣿⡏⠀⠀⠀⠀⠀⠀⠀
⠀⣴⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀
⠸⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠈⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⣶⢶⣾⣶⣦⠄
⠀⠀⠀⠀⢹⣿⣿⣿⣿⣿⣿⣿⣿⣿⠏⣱⣿⣿⣿⢁⣿
⠀⠀⠀⠀⠀⢻⣿⣿⣿⣿⣿⣿⣿⠁⠸⠟⠐⠟⠁⣾⣿
⠀⠀⠀⠀⣀⣤⣿⣿⣿⣿⡿⢹⠇⠀⢀⣴⣷⣶⣾⡿⠃
⠀⠀⣴⣿⣿⣿⣿⣿⣿⡿⠁⠀⠀⠀⣀⣼⣿⠟⠋⠀⠀
⠀⠀⠻⣿⣿⣿⣿⣿⣿⡟⠀⠀⠀⢚⡿⠋⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠉⠙⢯⣙⣿⠷⠿⣷⡾⠋⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠈⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
  𝕋𝔸𝕂🄴 𝕐𝕆🅄ℝ 𝕋🄸 𝕄𝔼
]]

local spacing = vim.fn.winwidth(0) / 4

return {
  "nvimdev/dashboard-nvim",
  opts = {
    config = {
      header = vim.split(logo, "\n"),
      -- stylua: ignore
      center = {
        { action = 'lua LazyVim.pick()()',                           desc = " Find File" .. string.rep(" ", spacing),       icon = " ", key = "f" },
        { action = "ene | startinsert",                              desc = " New File" .. string.rep(" ", spacing),        icon = " ", key = "n" },
        { action = 'lua LazyVim.pick("oldfiles")()',                 desc = " Recent Files" .. string.rep(" ", spacing),    icon = " ", key = "r" },
        { action = 'lua LazyVim.pick("live_grep")()',                desc = " Find Text" .. string.rep(" ", spacing),       icon = " ", key = "g" },
        { action = 'lua LazyVim.pick.config_files()()',              desc = " Config" .. string.rep(" ", spacing),          icon = " ", key = "c" },
        { action = "LazyExtras",                                     desc = " Lazy Extras" .. string.rep(" ", spacing),     icon = " ", key = "x" },
        { action = "Lazy",                                           desc = " Lazy" .. string.rep(" ", spacing),            icon = "󰒲 ", key = "l" },
        { action = function() vim.api.nvim_input("<cmd>qa<cr>") end, desc = " Quit" .. string.rep(" ", spacing),            icon = " ", key = "q" },
      },
    },
  },
}
