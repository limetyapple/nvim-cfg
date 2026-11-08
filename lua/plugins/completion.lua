local function get_loaded_bufnrs()
	local bufs = {}
	for _, buf in ipairs(vim.api.nvim_list_bufs()) do
		if vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].buftype == "" then
			table.insert(bufs, buf)
		end
	end
	return bufs
end

return {
	"saghen/blink.cmp",
	dependencies = {
		"rafamadriz/friendly-snippets",
		"saghen/blink.lib",
	},
	build = function()
		require("blink.cmp").build():pwait()
	end,
	opts = {
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
	},
}
