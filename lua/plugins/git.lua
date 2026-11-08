return {
	{
		"kdheepak/lazygit.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		opts = {},
		keys = {
			{ "<leader>g", "<cmd>LazyGit<cr>", { desc = "Open LazyGit" } },
		},
	},
}
