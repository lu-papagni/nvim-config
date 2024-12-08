return {
  "lewis6991/gitsigns.nvim",
  keys = {
    {
      "]h",
      function() require("gitsigns").nav_hunk("next") end,
      desc = "Naviga alla prossima sezione"
    },
    {
      "[h",
      function() require("gitsigns").nav_hunk("prev") end,
      desc = "Naviga alla precedente sezione"
    },
    {
      "<leader>gs",
      function() require("gitsigns").stage_hunk() end,
      desc = "Aggiungi sezione alla revisione"
    },
    {
      "<leader>gr",
      function() require("gitsigns").reset_hunk() end,
      desc = "Rimuovi sezione dalla revisione"
    },
    {
      "<leader>gt",
      function() require("gitsigns").toggle_deleted() end,
      desc = "Alterna visualizzazione linee eliminate"
    },
    {
      "<leader>gb",
      function() require("gitsigns").toggle_current_line_blame() end,
      desc = "Alterna visualizzazione linee eliminate"
    },
    {
      "<leader>gd",
      function() require("gitsigns").diffthis() end,
      desc = "Mostra differenze con l'indice della repository"
    },
  },
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    current_line_blame_formatter = table.concat(
      {
        " \u{f113} <author>",
        "\u{f274} <author_time:%R>",
        "\u{f449} <summary> "
      },
      " \u{e621} "
    )
  }
}
