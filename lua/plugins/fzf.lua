return {
  "ibhagwan/fzf-lua",
  cmd = "FzfLua",
  keys = {
    {
      "<leader><space>",
      function() require("fzf-lua").buffers() end,
      desc = "Cerca tra i nomi dei buffer aperti"
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
      function() require("fzf-lua").lsp_code_actions { silent = true } end,
      desc = "Azioni consigliate LSP"
    },
    {
      "gr",
      function() require("fzf-lua").lsp_references() end,
      desc = "Riferimenti simbolo LSP"
    },
    {
      "<space>fC",
      function() require("fzf-lua").colorschemes() end,
      desc = "Cerca temi con anteprima"
    },
    {
      "<leader>fh",
      function() require("fzf-lua").helptags() end,
      desc = "Cerca nel manuale di Neovim"
    },
    {
      "<leader>dm",
      function() require("fzf-lua").diagnostics_workspace() end,
      desc = "Mostra messaggi di diagnostica"
    },
    {
      -- INFO: sostituisce `todo-comments`
      "<leader>ft",
      function()
        require("fzf-lua").grep {
          search = [[\bTODO:]],
          no_esc = true,
          multiline = true
        }
      end,
      desc = "Trova i commenti di promemoria (TODO)"
    },
    {
      -- INFO: sostituisce `todo-comments`
      "<leader>fT",
      function()
        require("fzf-lua").grep {
          search = [[\b(HACK|TODO|NOTE|BUG|ERROR|FIXME|FIX|INFO):]],
          no_esc = true,
          multiline = true
        }
      end,
      desc = "Trova tutti i commenti di promemoria"
    }
  },
  opts = {
    defaults = { file_icons = "mini" },
    previewers = {
      bat = { theme = "base16" }
    },
    winopts = {
      preview = { default = "bat" }
    },
    oldfiles = {
      previewer = false,
      winopts = {
        width = 0.5
      }
    },
    lsp = {
      code_actions = {
        previewer = false,
        winopts = {
          width = 0.5
        }
      }
    },
    diagnostics = {
      winopts = {
        preview = { layout = "vertical" }
      }
    },
    buffers = {
      previewer = false,
      winopts = {
        width = 0.5,
        height = 0.4
      }
    },
    keymap = {
      fzf = {
        -- Invia tutti i risultati alla quickfix list
        ["ctrl-q"] = "select-all+accept",
      }
    }
  }
}
