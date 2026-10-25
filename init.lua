require("core.options")
require("core.keymaps")
require("core.autocmds")

-- vim.api.nvim_create_autocmd("VimEnter", {
-- 	once = true,
-- 	callback = function()
-- 			vim.schedule(function()
-- 		require("core.plugin").flush()
-- 		end)
-- 	end,
-- })
