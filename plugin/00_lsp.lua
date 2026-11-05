require("core.plugin").plugin({
	repo = "neovim/nvim-lspconfig",
})

vim.lsp.enable("lua_ls")
vim.lsp.enable("clangd")
