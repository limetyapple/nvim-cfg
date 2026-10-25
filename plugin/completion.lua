local function get_loaded_bufnrs()
	local bufs = {}
	for _, buf in ipairs(vim.api.nvim_list_bufs()) do
		if vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].buftype == "" then
			table.insert(bufs, buf)
		end
	end
	return bufs
end

require("core.plugin").plugin({
	repo = "saghen/blink.cmp",
	deps = {
		"rafamadriz/friendly-snippets",
		"saghen/blink.lib",
	},
	config = function()
		require("blink.cmp").setup({
			keymap = { preset = "default" },
			completion = { documentation = { auto_show = false } },
			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
				providers = {
					buffer = {
						opts = {
							get_bufnrs = get_loaded_bufnrs,
						},
					},
				},
			},
			fuzzy = { implementation = "rust" },
		})
	end,
})
