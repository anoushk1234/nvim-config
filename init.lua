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
