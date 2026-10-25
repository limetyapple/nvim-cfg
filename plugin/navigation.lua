require("core.plugin").plugin({
	{
		repo = "ibhagwan/fzf-lua",
		deps = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("fzf-lua").setup()
			require("fzf-lua").register_ui_select()
		end,
		keys = {
			{ "<leader>ff", "<cmd>FzfLua files<cr>", desc = "fzf files" },
			{ "<leader>fb", "<cmd>FzfLua buffers<cr>", desc = "fzf buffers" },
			{ "<leader>fg", "<cmd>FzfLua live_grep<cr>", { desc = "fzf grep picker" } },
			{ "<leader>fG", "<cmd>FzfLua grep_cword<cr>", { desc = "fzf grep_cword picker" } },
			{ "<leader>ft", "<cmd>FzfLua tabs<cr>", { desc = "fzf tab picker" } },
			{ "<leader>fj", "<cmd>FzfLua jumps<cr>", { desc = "fzf jumps picker" } },
			{ "<leader>fz", "<cmd>FzfLua zoxide<cr>", { desc = "fzf zoxide picker" } },
			{ "<leader>fo", "<cmd>FzfLua oldfiles<cr>", { desc = "fzf oldfiles picker" } },
		},
	},
	{
		repo = "stevearc/oil.nvim",
		deps = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("oil").setup()
		end,
		keys = {
			{ "<leader>fe", "<cmd>Oil<cr>", { silent = true, desc = "Oil file manager" } },
		},
	},
	{
		repo = "rmagatti/auto-session",
		deps = {},
		config = function()
			require("auto-session").setup({
				enabled = true,
				auto_save = true,
				auto_restore = false,
				auto_create = false,
				bypass_save_filetypes = { "alpha", "dashboard", "snacks_dashboard" },
			})
		end,
		keys = {
			{ "<leader>wr", "<cmd>AutoSession search<cr>", { desc = "Search Session" } },
			{ "<leader>ws", "<cmd>AutoSession save<cr>", { desc = "Save Session" } },
			{ "<leader>wa", "<cmd>AutoSession toggle<cr>", { desc = "Toggle autosession" } },
		},
	},
	-- {
	-- 	repo = "nvimdev/dashboard-nvim",
	-- 	deps = { "nvim-tree/nvim-web-devicons" },
	-- 	config = function()
	-- 		require("dashboard").setup({
	-- 			theme = "hyper",
	-- 			config = {
	-- 				week_header = {
	-- 					enable = true,
	-- 				},
	-- 				shortcut = {
	-- 					{ desc = "󰊳 Update", group = "@property", action = "Lazy update", key = "u" },
	-- 					{
	-- 						icon = " ",
	-- 						icon_hl = "@variable",
	-- 						desc = "Files",
	-- 						group = "Label",
	-- 						action = "FzfLua files",
	-- 						key = "f",
	-- 					},
	-- 					{
	-- 						desc = " Apps",
	-- 						group = "DiagnosticHint",
	-- 						action = "Telescope app",
	-- 						key = "a",
	-- 					},
	-- 					{
	-- 						desc = " dotfiles",
	-- 						group = "Number",
	-- 						action = "Telescope dotfiles",
	-- 						key = "d",
	-- 					},
	-- 				},
	-- 				project = {
	-- 					enable = true,
	-- 					limit = 5,
	-- 					action = function(path)
	-- 						vim.schedule(function()
	-- 							local ok, auto_session = pcall(require, "auto-session")
	-- 							if ok and auto_session.RestoreSessionByPath then
	-- 								-- 首选：按目录路径恢复对应的 session
	-- 								auto_session.RestoreSessionByPath(path)
	-- 							else
	-- 								-- 回退：cd 到目录后恢复
	-- 								vim.cmd("cd " .. vim.fn.fnameescape(path))
	-- 								pcall(vim.cmd, "AutoSession restore")
	-- 							end
	-- 						end)
	-- 					end,
	-- 				},
	-- 			},
	-- 		})
	-- 	end,
	-- },
})
