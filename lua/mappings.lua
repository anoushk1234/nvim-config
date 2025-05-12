require "nvchad.mappings"

-- add yours here
local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("n", "<leader>ft", "<cmd>FloatermNew<CR>", { desc = "Toggle floating terminal" })
map({ "i", "n" }, "<leader>sw", "<C-w><C-r>", { desc = "Swap two panes." })
map({ "i", "n" }, "<leader>sh", "<C-w>K", { desc = "Swap layout to horizontal." })
map({ "i", "n" }, "<leader>sv", "<C-w>H", { desc = "Swap layout to vertical." })
map({ "i", "n" }, "<leader>lsp", "<cmd>LspRestart<CR>", { desc = "Restart the LSP." })
-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
-- Argument navigation
map("n", ",na", "]a", { desc = "Next argument" })
map("n", ",pa", "[a", { desc = "Previous argument" })

-- Function navigation
map("n", ",nf", "]f", { desc = "Next function" })
map("n", ",pf", "[f", { desc = "Previous function" })

map({ "n", "i" }, ",er", function()
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  local text = 'FD_LOG_ERR(( " (%i-%s)", ));'
  vim.api.nvim_buf_set_text(0, row - 1, col, row - 1, col, { text })

  -- Move cursor to inside the quotes after inserting
  local target_col = col + #'FD_LOG_ERR(( "' -- right after the opening quote
  vim.api.nvim_win_set_cursor(0, { row, target_col })
end, { desc = "Insert FD_LOG_ERR and place cursor" })

map("n", "<leader>ifd", function()
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  local text = {
    "if( FD_UNLIKELY(  ) ){",
    "}",
  }

  -- Insert the block
  vim.api.nvim_buf_set_lines(0, row, row, false, text)

  -- Reindent just the inserted block (row+1 to row+3)
  vim.cmd(string.format("%d,%dnormal ==", row + 1, row + 3))
  -- Move cursor to inside FD_UNLIKELY( | )
  vim.api.nvim_win_set_cursor(0, { row + 1, 19 }) -- Line 1, col after (
end, { desc = "Insert FD_UNLIKELY if-block" })

map("n", "<leader>ifl", function()
  local row = vim.api.nvim_win_get_cursor(0)[1]

  -- Insert lines below the current line
  local text = {
    "if( FD_LIKELY(  ) ){",
    "}",
  }
  vim.api.nvim_buf_set_lines(0, row, row, false, text)

  -- Reindent just the inserted block (row+1 to row+3)
  vim.cmd(string.format("%d,%dnormal ==", row + 1, row + 3))

  -- Move cursor to inside FD_LIKELY(...)
  vim.api.nvim_win_set_cursor(0, { row + 1, 17 })
end, { desc = "Insert FD_LIKELY if-block" })
