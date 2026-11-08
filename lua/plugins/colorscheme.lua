return {
	{
		"folke/tokyonight.nvim",
		opts = {
			transparent = true,
		},
	},
	{
		"theme_manage",
		virtual = true,
		dependencies = { "folke/tokyonight.nvim" },
		config = function()
			print("fuck")
			vim.cmd.colorscheme("tokyonight-night")
		end,
	},
}
