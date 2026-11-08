return {
	{
		"ibhagwan/fzf-lua",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		opts = {
			winopts = {
				preview = {
					layout = "vertical", -- 设置为垂直布局
					vertical = "down:50%", -- 预览窗口在下方，占据50%高度
				},
			},
		},
		config = function(_, opts)
			require("fzf-lua").setup(opts)
		end,
		keys = {
			{ "<leader>ff", "<cmd>FzfLua files<cr>", desc = "fzf files" },
			{ "<leader>fb", "<cmd>FzfLua buffers<cr>", desc = "fzf buffers" },
			{ "<leader>fg", "<cmd>FzfLua live_grep<cr>", desc = "fzf grep picker" },
			{ "<leader>fG", "<cmd>FzfLua grep_cword<cr>", desc = "fzf grep_cword picker" },
			{ "<leader>ft", "<cmd>FzfLua tabs<cr>", desc = "fzf tab picker" },
			{ "<leader>fj", "<cmd>FzfLua jumps<cr>", desc = "fzf jumps picker" },
			{ "<leader>fz", "<cmd>FzfLua zoxide<cr>", desc = "fzf zoxide picker" },
			{ "<leader>fo", "<cmd>FzfLua oldfiles<cr>", desc = "fzf oldfiles picker" },
		},
	},
	{
		"stevearc/oil.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		opts = {},
		keys = {
			{ "<leader>fe", "<cmd>Oil<cr>", desc = "Oil file manager" },
		},
	},
	{
		"rmagatti/auto-session",
		dependencies = {
			"ibhagwan/fzf-lua",
		},
		opts = {
			enabled = true,
			auto_save = true,
			auto_restore = true,
			auto_create = false,
			bypass_save_filetypes = { "alpha", "dashboard", "snacks_dashboard" },
		},
		config = function(_, opts)
			require("auto-session").setup(opts)
			require("fzf-lua").register_ui_select()
		end,
		keys = {
			{ "<leader>wr", "<cmd>AutoSession search<cr>", desc = "Search Session" },
			{ "<leader>ws", "<cmd>AutoSession save<cr>", desc = "Save Session" },
			{ "<leader>wa", "<cmd>AutoSession toggle<cr>", desc = "Toggle autosession" },
		},
	},
}
