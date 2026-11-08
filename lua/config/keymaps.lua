vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set("n", "<leader>tr", function()
	vim.wo.relativenumber = not vim.wo.relativenumber
	if not vim.wo.relativenumber then
		vim.wo.number = true
	end
end, { desc = "Toggle relative number" })
