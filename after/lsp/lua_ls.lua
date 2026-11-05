return {
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT", -- Neovim 用 LuaJIT
			},
			diagnostics = {
				globals = { "vim" }, -- 认识 vim 全局变量
			},
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true), -- Neovim API 补全
				checkThirdParty = false,
			},
			telemetry = {
				enable = false,
			},
			hint = {
				enable = true,
				semicolon = "Disable",
			},
			format = {
				enable = false, -- 格式化交给 conform
			},
		},
	},
}
