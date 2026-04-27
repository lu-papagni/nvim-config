local map = vim.keymap.set

require("mini.icons").setup()

-- mini.files

local files = require("mini.files")

files.setup({
  options = { use_as_default_explorer = true },
  content = {
    prefix = function(entry)
      if entry.fs_type == "directory" then
        return "📁 ", "MiniFilesDirectory"
      end
      return "📄 ", "MiniFilesFile"
    end,
  },
})

require("minifiles-git")

map("n", "<Leader>e", files.open, { desc = "Open mini file explorer" })
map("n", "<Leader>E", function()
  files.open(vim.fn.expand("%"))
end, { desc = "Open mini file explorer in current directory" })

-- mini.pick

local pick = require("mini.pick")

pick.setup({
  mappings = {
    move_down = "<C-j>",
    move_up = "<C-k>",
  },
  source = {
    show = function(buf_id, items, query, opts)
      opts = vim.tbl_deep_extend("force", {
        show_icons = true,
        icons = {
          directory = "📁 ",
          file = "📄 ",
          none = "  ",
        },
      }, opts or {})
      return pick.default_show(buf_id, items, query, opts)
    end,
  },
})

require("mini.extra").setup()

local builtin = pick.builtin
local extra = require("mini.extra").pickers

map("n", "<Leader>/", function()
  extra.buf_lines({ scope = "current" })
end)
map("n", "<Leader>b", builtin.buffers)
map("n", "<Leader>fC", extra.colorschemes)
map("n", "<Leader>fT", function()
  builtin.grep({ pattern = "^\\W+\\b(HACK|TODO|NOTE|BUG|ERROR|FIXME|FIX|INFO)" })
end)
map("n", "<Leader>ff", builtin.files)
map("n", "<Leader>fh", builtin.help)
map("n", "<Leader>fk", extra.keymaps)
map("n", "<Leader>fs", builtin.grep_live)
map("n", "<Leader>ft", function()
  builtin.grep({ pattern = "^\\W+\\bTODO" })
end)
map("n", "<Leader>fu", function()
  builtin.grep({ pattern = vim.fn.expand("<cword>") })
end)

-- mini.diff

local diff = require("mini.diff")

diff.setup({
  view = {
    style = "sign",
    priority = 1,
  },
})

map("n", "<Leader>gd", diff.toggle_overlay, { desc = "Toggle git diff overlay" })
