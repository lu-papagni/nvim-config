return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    close_if_last_window = true,
    filesystem = {
      hijack_netrw_behavior = "open_current",
      filtered_items = {
        hide_dotfiles = false,
      },
    },
    event_handlers = {
      {
        event = "file_open_requested",
        handler = function()
          vim.cmd("Neotree close")
        end,
      },
    },
  },
}
