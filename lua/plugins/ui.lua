return {
	{
		"lukas-reineke/indent-blankline.nvim",
		config = function()
			require("ibl").setup({
				indent = {
					char = "│", -- 空格缩进的线
					tab_char = "│", -- Tab 缩进的线（不设就没线）
				},
			})
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		opts = {
			sections = {
				lualine_a = { "mode" },
				lualine_b = {
					"branch",
					"diff",
				},
				lualine_c = {},
				lualine_x = { "lsp_status", "encoding", "fileformat", "filetype" },
				lualine_y = { "progress" },
				lualine_z = { "location" },
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = {
					"filename",
				},
				lualine_x = {
					"location",
				},
				lualine_y = {},
				lualine_z = {},
			},
		},
	},
	{
		"akinsho/bufferline.nvim",
		opts = {
			options = {
				mode = "buffers", -- tabs
				show_buffer_close_icons = false,
			},
		},
	},
	{
		"folke/which-key.nvim",
		opts = {},
	},
}
