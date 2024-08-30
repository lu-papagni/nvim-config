return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      enabled = vim.fn.executable("make") == 1 or vim.fn.executable("cmake") == 1,
      build = vim.fn.executable("make") and "make"
        or "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
    },
  },
  cmd = "Telescope",
  keys = {
    { "<leader><space>", "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>", desc = "Cerca tra i nomi dei buffer aperti" },
    { "<leader>;", "<cmd>Telescope command_history<cr>", desc = "Cronologia comandi" },
    { "<leader>:", "<cmd>Telescope commands<cr>", desc = "Cerca ed esegui comando" },
    { "<leader>/", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Cerca nel file corrente" },
    { "<leader>fu", "<cmd>Telescope grep_string<cr>", desc = "Cerca parola sotto il cursore" },
    { "<leader>fs", "<cmd>Telescope live_grep<cr>", desc = "Cerca una stringa nella directory di lavoro" },
    { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Lista dei file recenti" },
    { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Cerca tra i file" },
    { "<leader>fk", "<cmd>Telescope keymaps<cr>", desc = "Cerca tra le keymap con descrizione" },
    { "<leader>fH", "<cmd>Telescope highlights<cr>", desc = "Cerca Highlight Groups" },
  },
  config = function()
    local telescope = require("telescope")

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
      },
      pickers = {
        current_buffer_fuzzy_find = {
          layout_config = {
            preview_width = 0.50,
          },
        },
        highlights = {
          layout_config = {
            preview_width = 0.60,
          },
        },
        command_history = {
          theme = "ivy",
          layout_config = {
            height = 0.35,
          },
        },
        commands = {
          theme = "dropdown",
        },
      },
      extensions = {
        fzf = {
          fuzzy = true,                    -- false will only do exact matching
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "smart_case",
        }
      }
    }

    telescope.load_extension("fzf")
  end
}
