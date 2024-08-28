return {
  "folke/todo-comments.nvim",
  cmd = { "TodoTrouble", "TodoTelescope" },
  event = "BufReadPost",
  opts = {},
  -- stylua: ignore
  keys = {
    { "]t", function() require("todo-comments").jump_next() end, desc = "Promemoria Successivo" },
    { "[t", function() require("todo-comments").jump_prev() end, desc = "Promemoria Precedente" },
    { "<leader>dt", "<cmd>Trouble todo toggle<cr>", desc = "Todo (Trouble)" },
    { "<leader>dT", "<cmd>Trouble todo toggle filter = {tag = {TODO,FIX,FIXME}}<cr>", desc = "Todo/Fix/Fixme (Trouble)" },
    { "<leader>ft", "<cmd>TodoTelescope keywords=TODO<cr>", desc = "Trova i promemoria Todo" },
    { "<leader>fT", "<cmd>TodoTelescope<cr>", desc = "Trova tutti i tipi di promemoria" },
  },
}
