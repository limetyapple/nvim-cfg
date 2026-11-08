return {
	{
		"windwp/nvim-autopairs",
		opts = {},
	},
	{
		"kylechui/nvim-surround",
		opts = {},
	},
	{
		"gbprod/yanky.nvim",
		opts = {
			picker = {
				select = {
					-- 将 action 设为 nil 以使用默认的 put 行为
					action = nil,
				},
				-- 关键：将 picker 后端指定为 fzf
				fzf = {}, -- 部分版本可能需要此字段，或通过其他方式指定
			},
		},
		keys = {
			{ "<leader>p", "<cmd>YankyRingHistory<cr>", desc = "Yank History" },
		},
	},
	{
		"MagicDuck/grug-far.nvim",
		opts = {},
		keys = {
			{ "<leader>rG", "<cmd>GrugFar<cr>", { desc = "Toggle grug-far" } },
			{ "<leader>rg", "<cmd>GrugFarWithin<cr>", { desc = "Toggle grug-far-within" } },
		},
	},
	{
		"numToStr/Comment.nvim",
		opts = {},
	},
	{
		"folke/todo-comments.nvim",
		dependence = { "nvim-lua/plenary.nvim" },
		opts = {},
	},
}
