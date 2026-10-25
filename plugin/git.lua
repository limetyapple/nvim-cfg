require("core.plugin").plugin({
	{
		repo = "kdheepak/lazygit.nvim",
		deps = {
			"nvim-lua/plenary.nvim",
		},
		config = function() end,
		keys = {
			{ "<leader>g", "<cmd>LazyGit<cr>", { desc = "Open LazyGit" } },
		},
	},
})
