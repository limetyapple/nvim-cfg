require("core.plugin").plugin({
	{
		repo = "folke/tokyonight.nvim",
    config = function()
      vim.cmd.colorscheme("tokyonight")
    end
	},
})

