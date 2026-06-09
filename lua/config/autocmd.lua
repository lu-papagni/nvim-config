local autocmd = vim.api.nvim_create_autocmd
local vimrc_events = vim.api.nvim_create_augroup("vimrc", { clear = true })
local map = vim.keymap.set

if os.getenv("TERM") == "xterm-kitty" then
  autocmd("VimLeave", {
    desc = "Reset Kitty terminal appearance on exit",
    group = vimrc_events,
    callback = function()
      -- vim.system({ "kitten", "@", "set-colors", "--reset", "--all" }, { detach = true })
      vim.system({ "kitten", "@", "set-spacing", "padding=default" }, { detach = true })
    end,
  })
end

autocmd("FileType", {
  desc = "Break comments on new lines",
  pattern = "*",
  group = vimrc_events,
  callback = function()
    vim.opt.formatoptions:remove({ "o" })
  end,
})

autocmd("TextYankPost", {
  desc = "Briefly highlight text when copied",
  group = vimrc_events,
  callback = function()
    vim.highlight.on_yank()
  end,
})

autocmd("VimResized", {
  desc = "Resize splits together with the window",
  group = vimrc_events,
  callback = function()
    if #vim.api.nvim_list_wins() > 1 then
      vim.cmd.tabdo("wincmd =")
    end
  end,
})

autocmd("CmdlineChanged", {
  desc = "Autocomplete command line",
  group = vimrc_events,
  pattern = ":",
  callback = function()
    if #vim.fn.getcmdline() > 1 then
      vim.fn.wildtrigger()
    end
  end,
})

autocmd("FileType", {
  desc = "Enable tree-sitter parser",
  group = vimrc_events,
  pattern = vim
    .iter(vim.fs.find(function(name, _)
      return name:match("^.*%.so$")
    end, {
      limit = math.huge,
      type = "file",
      path = vim.fs.joinpath(vim.fn.stdpath("data"), "site/parser"),
    }) --[[@as IterMod]])
    :map(function(parser)
      return vim.fs.basename(parser)
    end)
    :map(function(parser)
      return (parser:gsub("%.so$", ""))
    end)
    :totable(),
  callback = function(ctx)
    pcall(vim.treesitter.start, ctx.buf)
  end,
})

autocmd("TermRequest", {
  desc = "Update terminal name with current process",
  group = vimrc_events,
  callback = function(ctx)
    local bufname = vim.fn.expand("%")
    local suffix = bufname:match("^term://(.*)")
    local new_name = bufname:gsub(suffix, vim.b.term_title)
    vim.api.nvim_buf_set_name(ctx.buf, new_name)
  end,
})

-- Neovide autocommands
if vim.g.neovide then
  local neovide_events = vim.api.nvim_create_augroup("NeovideEvents", { clear = true })

  autocmd("ColorScheme", {
    desc = "Set the Neovide bar color",
    group = neovide_events,
    callback = function()
      local bg = vim.api.nvim_get_hl(0, { name = "Normal", link = false }).bg
      if bg then
        vim.g.neovide_title_background_color = string.format("#%06x", bg)
      end
    end,
  })

  autocmd("VimEnter", {
    desc = "Set default directory on Neovide startup",
    group = neovide_events,
    once = true,
    callback = function()
      if vim.fn.argc() == 0 then
        vim.api.nvim_set_current_dir(vim.env.HOME)
      end
    end,
  })
end
