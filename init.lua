vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
vim.g.mapleader = " "

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
  },

  { import = "plugins" },
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = {
    "lua/*.lua",
    "lua/configs/*.lua",
    "lua/plugins/*.lua",
  },
  callback = function(args)
  local file = vim.fn.fnamemodify(args.file, ":.")
  if file:match("lua/plugins/") then
    vim.cmd("Lazy reload")
  else
    vim.cmd("luafile " .. file)
    vim.notify("Reloaded " .. file, vim.log.levels.INFO)
  end
end,
})


require "options"
require "nvchad.autocmds"

vim.schedule(function()
  require "mappings"
end)
-- for borland
-- vim.api.nvim_set_hl(0, "Normal", { fg = "#FFFFFF", bg = "#0000AA" })
-- vim.api.nvim_set_hl(0, "StatusLine", { fg = "#000000", bg = "#C0C0C0" })
-- vim.api.nvim_set_hl(0, "StatusLineNC", { fg = "#000000", bg = "#C0C0C0" })
-- vim.api.nvim_set_hl(0, "LineNr", { fg = "#C0C0C0", bg = "#0000AA" })
-- vim.api.nvim_set_hl(0, "CursorLine", { bg = "#000088" })
-- vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#FFFF00", bg = "#000088", bold = true })
-- vim.api.nvim_set_hl(0, "Comment", { fg = "#00FF00", italic = true })
-- vim.api.nvim_set_hl(0, "String", { fg = "#FF0000" })
-- vim.api.nvim_set_hl(0, "Number", { fg = "#00FFFF" })
-- vim.api.nvim_set_hl(0, "Keyword", { fg = "#FFFF00", bold = true })
-- -- vim.api.nvim_set_hl(0, "Function", { fg = "#FFFFFF" })
-- vim.api.nvim_set_hl(0, "Type", { fg = "#00FFFF" })
-- vim.api.nvim_set_hl(0, "Constant", { fg = "#00FFFF" })
-- vim.api.nvim_set_hl(0, "Identifier", { fg = "#FFFFFF" })
-- vim.api.nvim_set_hl(0, "Statement", { fg = "#FFFF00" })
-- vim.api.nvim_set_hl(0, "PreProc", { fg = "#FFFF00" })
-- vim.api.nvim_set_hl(0, "Special", { fg = "#FFFF00" })
-- vim.api.nvim_set_hl(0, "Underlined", { fg = "#FFFFFF", underline = true })
-- vim.api.nvim_set_hl(0, "Visual", { bg = "#AAAA00", fg = "#000000" })
-- -- Highlight fields and methods (like `.nvim_set_hl`)
-- vim.api.nvim_set_hl(0, "Field",         { fg = "#FFFF00" })  -- bright yellow
-- vim.api.nvim_set_hl(0, "@field",        { fg = "#FFFF00" })  -- treesitter
-- vim.api.nvim_set_hl(0, "@property",     { fg = "#FFFF00" })  -- common for Lua/C
-- -- vim.api.nvim_set_hl(0, "@method",       { fg = "#00FFFF" })  -- method calls
-- -- vim.api.nvim_set_hl(0, "@function.call",{ fg = "#00FFFF" })  -- method calls
-- -- Apply to all preprocessor-style lines
-- vim.api.nvim_set_hl(0, "PreProc", { fg = "#000000", bg = "#00FFFF", bold = true })
--
-- -- Apply to Treesitter include groups
-- vim.api.nvim_set_hl(0, "@include", { fg = "#000000", bg = "#00FFFF", bold = true })
-- vim.api.nvim_set_hl(0, "@preproc", { fg = "#000000", bg = "#00FFFF", bold = true })
--
-- -- Highlight header strings too, in case they are treated as Constant/String
-- vim.api.nvim_set_hl(0, "Constant", { fg = "#000000", bg = "#00FFFF" })
-- vim.api.nvim_set_hl(0, "String", { fg = "#000000", bg = "#00FFFF" })
-- vim.api.nvim_set_hl(0, "@string", { fg = "#000000", bg = "#00FFFF" })
-- vim.api.nvim_set_hl(0, "Include", { fg = "#000000", bg = "#00FFFF", bold = true })
-- -- Set visible function color
-- vim.api.nvim_set_hl(0, "Function", { fg = "#00FFFF" })         -- Bright cyan
-- vim.api.nvim_set_hl(0, "@function", { fg = "#00FFFF" })
-- vim.api.nvim_set_hl(0, "@function.call", { fg = "#00FFFF" })
-- vim.api.nvim_set_hl(0, "@method", { fg = "#00FFFF" })           -- For method calls

