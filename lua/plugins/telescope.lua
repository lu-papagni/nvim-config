return {
  "nvim-telescope/telescope.nvim",
  branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
  },
  cmd = "Telescope",
  keys = {
    {
      "<leader>,",
      "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>",
      desc = "Buffer Recente",
    },
    { "<leader>:", "<cmd>Telescope command_history<cr>", desc = "Cronologia Comandi" },
    { "<leader>sC", "<cmd>Telescope commands<cr>", desc = "Esegui Comando" },
    { "<leader>/", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Cerca File Corrente" },
    { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "File Recenti" },
    { "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Key Maps" },
  },
  config = function()
    local telescope = require('telescope')

    telescope.setup {
      defaults = {
        mappings = {
          i = {
            ["<C-j>"] = "move_selection_next",
            ["<C-k>"] = "move_selection_previous",
            ["<C-p>"] = false,
            ["<C-n>"] = false,
            ["<up>"] = false,
            ["<down>"] = false,
          }
        },
        results_title = "Risultati",
      },
      pickers = {
        current_buffer_fuzzy_find = {
          prompt_title = "Cerca File Corrente",
          layout_config = {
            preview_width = 0.50,
          },
        },
        oldfiles = {
          prompt_title = "File Recenti",
        },
        command_history = {
          prompt_title = "Cronologia Comandi",
          theme = "ivy",
          layout_config = {
            height = 0.35,
          },
        },
        buffers = {
          prompt_title = "Buffer Recenti",
        },
        commands = {
          prompt_title = "Esegui Comando",
          theme = "ivy",
          layout_config = {
            height = 0.35,
          },
        },
        keymaps = {
          prompt_title = "Associazioni Tasti",
        },
      },
      extensions = {
        fzf = {
          fuzzy = true,                    -- false will only do exact matching
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
        }
      }
    }

    telescope.load_extension('fzf')
  end
}
