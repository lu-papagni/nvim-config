-- Adattato da https://github.com/radleylewis/nvim-lite/tree/youtube_demo

local M = {
  buf = nil,
  win = nil,
  is_open = false,
}

function M.open(opts)
  local opts = opts or {}

  -- If terminal is already open, close it (toggle behavior)
  if M.is_open and vim.api.nvim_win_is_valid(M.win) then
    vim.api.nvim_win_close(M.win, false)
    M.is_open = false
    return
  end

  -- Create buffer if it doesn't exist or is invalid
  if not M.buf or not vim.api.nvim_buf_is_valid(M.buf) then
    M.buf = vim.api.nvim_create_buf(false, true)
    -- Set buffer options for better terminal experience
    vim.api.nvim_buf_set_option(M.buf, "bufhidden", "hide")
  end

  -- Calculate window dimensions
  local width = math.floor(vim.o.columns * (opts.width or 0.8))
  local height = math.floor(vim.o.lines * (opts.height or 0.8))
  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)

  -- Create the floating window
  M.win = vim.api.nvim_open_win(M.buf, true, {
    relative = "editor",
    width = width,
    height = height,
    row = row,
    col = col,
    style = "minimal",
  })

  -- Start terminal if not already running
  local has_terminal = false
  local lines = vim.api.nvim_buf_get_lines(M.buf, 0, -1, false)
  for _, line in ipairs(lines) do
    if line ~= "" then
      has_terminal = true
      break
    end
  end

  if not has_terminal then
    vim.fn.termopen(os.getenv("SHELL"))
  end

  M.is_open = true
  vim.cmd("startinsert")
end

-- Function to explicitly close the terminal
function M.erase()
  if M.is_open and vim.api.nvim_win_is_valid(M.win) then
    vim.api.nvim_win_close(M.win, false)
    M.is_open = false
  end
end

return M
