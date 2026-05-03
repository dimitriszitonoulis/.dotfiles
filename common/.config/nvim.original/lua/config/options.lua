-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Disable autoformatting on save
vim.g.autoformat = false

-- lua/config/options.lua → sets vim.opt and vim.g values early.
-- lua/config/autocmds.lua → runs after plugins and options are loaded.
-- If some plugin checks vim.g.autoformat only at startup, my change here might be too late.
-- In LazyVim’s case, conform.nvim respects it even if set here, because it checks per buffer when formatting, not only on startup.
-- But if another plugin were to read it only once during init, it could miss the setting.

---- Enable autoformat for certain files
-- vim.api.nvim_create_autocmd({ "FileType" }, {
--   pattern = {
--     "lua",
--     "python",
--   },
--   callback = function()
--     vim.b.autoformat = true
--   end,
-- })

---- Disable autoformat for certain files
-- vim.api.nvim_create_autocmd({ "FileType" }, {
--   pattern = {
--     "lua",
--     "c",
--     "cpp",
--     "h",
--     "hpp",
--     "python",
--   },
--   callback = function()
--     vim.b.autoformat = false
--   end,
-- })
