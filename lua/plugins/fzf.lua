return {
  "ibhagwan/fzf-lua",
  cmd = "FzfLua",
  keys = {
    {
      "<leader><space>",
      function() require("fzf-lua").buffers { sort_lastused = true } end,
      desc = "Cerca tra i nomi dei buffer aperti"
    },
    {
      "<leader>;",
      function() require("fzf-lua").command_history() end,
      desc = "Cronologia comandi"
    },
    {
      "<leader>:",
      function() require("fzf-lua").commands() end,
      desc = "Cerca ed esegui comando"
    },
    {
      "<leader>/",
      function() require("fzf-lua").grep_curbuf() end,
      desc = "Cerca nel file corrente"
    },
    {
      "<leader>fu",
      function() require("fzf-lua").grep_cword() end,
      desc = "Cerca parola sotto il cursore"
    },
    {
      "<leader>fs",
      function() require("fzf-lua").live_grep() end,
      desc = "Cerca una stringa nella directory di lavoro"
    },
    {
      "<leader>fr",
      function() require("fzf-lua").oldfiles() end,
      desc = "Lista dei file recenti"
    },
    {
      "<leader>ff",
      function() require("fzf-lua").files() end,
      desc = "Cerca tra i file"
    },
    {
      "<leader>fk",
      function() require("fzf-lua").keymaps() end,
      desc = "Cerca tra le associazioni tasti"
    },
    {
      "<leader>fH",
      function() require("fzf-lua").highlights() end,
      desc = "Cerca Highlight Groups"
    },
    {
      "<leader>ca",
      function() require("fzf-lua").lsp_code_actions() end,
      desc = "Azioni consigliate LSP"
    },
    {
      "gr",
      function() require("fzf-lua").lsp_references() end,
      desc = "Riferimenti simbolo LSP"
    },
  },
  opts = {
    winopts = {
      border = "single",
      preview = { default = "bat" }
    },
    oldfiles = {
      previewer = false,
      winopts = {
        width = 0.5
      }
    },
    buffers = {
      previewer = false,
      winopts = {
        width = 0.5
      }
    }
  }
}
