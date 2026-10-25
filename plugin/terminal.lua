require("core.plugin").plugin({
	{
		repo = "akinsho/toggleterm.nvim",
		deps = {},
		config = function()
			require("toggleterm").setup({
				open_mapping = [[<C-\>]],
				direction = "float",
				size = 20,
				shade_terminals = false,
				start_in_insert = true,
			})
		end,
		keys = {
			{ "<C-\\>", "<cmd>ToggleTerm<cr>", mode = { "n" }, desc = "Toggle Terminal" },
			{ "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", mode = { "n" }, desc = "Float Terminal" },
			{
				"<leader>th",
				"<cmd>ToggleTerm direction=horizontal size=15<cr>",
				mode = { "n" },
				desc = "Horizontal Terminal",
			},
			{
				"<leader>tv",
				"<cmd>ToggleTerm direction=vertical size=60<cr>",
				mode = { "n" },
				desc = "Vertical Terminal",
			},
			{ "<Esc><Esc>", [[<C-\><C-n>]], mode = { "t" }, { desc = "Exit terminal mode" } },
		},
	},
})
