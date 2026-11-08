return {
	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				rust = { "rustfmt", lsp_format = "fallback" },
				c = { "clang_format" },
				cpp = { "clang_format" },
			},
			formatters = {
				clang_format = {
					prepend_args = {
						"--style=file:" .. vim.fn.getcwd() .. "/.clang-format",
					},
				},
			},
			format_on_save = {
				timeout_ms = 500,
				lsp_format = "fallback",
			},
		},
		config = function(_, opts) -- 第二个参数就是顶层 opts
			require("conform").setup(opts)
			vim.api.nvim_create_user_command("Format", function(args)
				local range = nil
				if args.count ~= -1 then
					local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
					range = {
						start = { args.line1, 0 },
						["end"] = { args.line2, end_line:len() },
					}
				end
				require("conform").format({ async = true, lsp_format = "fallback", range = range })
			end, { range = true })
		end,
		keys = {
			{
				"<leader>u",
				function()
					require("conform").format({ async = true, lsp_format = "fallback" })
				end,
				mode = { "n", "v" }, -- 普通和可视模式都能用
				desc = "Format buffer/selection",
			},
		},
	},
}
