require("core.plugin").plugin({
	{
		repo = "windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup()
		end,
	},
	{
		repo = "kylechui/nvim-surround",
		config = function()
			require("nvim-surround").setup()
		end,
		-- usage :h nvim-surround.usage.
	},
	{
		repo = "gbprod/yanky.nvim",
		config = function()
			require("yanky").setup({
				picker = {
					select = {
						-- 将 action 设为 nil 以使用默认的 put 行为
						action = nil,
					},
					-- 关键：将 picker 后端指定为 fzf
					fzf = {}, -- 部分版本可能需要此字段，或通过其他方式指定
				},
			})
		end,
		keys = {
			{ "<leader>p", "<cmd>YankyRingHistory<cr>", desc = "Yank History" },
		},
	},
	{
		repo = "MagicDuck/grug-far.nvim",
		config = function()
			require("grug-far").setup()
		end,
		keys = {
			{ "<leader>rG", "<cmd>GrugFar<cr>", { desc = "Toggle grug-far" } },
			{ "<leader>rg", "<cmd>GrugFarWithin<cr>", { desc = "Toggle grug-far-within" } },
		},
	},
	{
		repo = "numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	},
	{
		repo = "folke/todo-comments.nvim",
		deps = { "nvim-lua/plenary.nvim" },
		config = function()
			require("todo-comments").setup()
		end,
	},
})
