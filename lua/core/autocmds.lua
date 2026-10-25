local augroup = vim.api.nvim_create_augroup("UserCore", { clear = true })

-- 示例：yank 时短暂高亮
vim.api.nvim_create_autocmd("TextYankPost", {
	group = augroup,
	callback = function()
		vim.hl.on_yank({ timeout = 150 })
	end,
})

vim.api.nvim_create_autocmd("BufReadPre", {
	group = augroup,
	callback = function(args)
		local ok, stats = pcall(vim.uv.fs_stat, args.file)
		if ok and stats and stats.size > 1024 * 1024 then
			vim.b[args.buf].large_file = true
			vim.opt_local.swapfile = false
			vim.opt_local.undofile = false
		end
	end,
})
