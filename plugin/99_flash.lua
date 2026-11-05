require("core.plugin").flush()

vim.keymap.set("n", "<leader>se", function()
	local fzf = require("fzf-lua")
	local cwd = vim.fn.getcwd()

	fzf.fzf_live(function(s)
		local input = s and s[1] or ""
		local pattern = "$RET " .. (input == "" and "$NAME" or input) .. "($$$);"
		local cmd = "ast-grep run --color=never --lang c -p " .. vim.fn.shellescape(pattern) .. " -- ."
		return cmd
	end, {
		prompt = "AST> ",
		previewer = "builtin",
		cwd = cwd,
		actions = {
			["default"] = fzf.actions.file_edit,
			["ctrl-s"] = fzf.actions.file_split,
			["ctrl-v"] = fzf.actions.file_vsplit,
			["ctrl-t"] = fzf.actions.file_tabedit,
		},
	})
end, { desc = "AST: C function declarations (live)" })

vim.keymap.set("n", "<leader>sd", function()
	local pattern = "$RET $NAME($$$);"
	local cmd = "ast-grep run --color=never --lang c -p " .. vim.fn.shellescape(pattern) .. " -- ."

	local out = vim.fn.systemlist(cmd)
	if #out == 0 then
		vim.notify("ast-grep 无匹配", vim.log.levels.WARN)
		return
	end

	local fzf = require("fzf-lua")
	fzf.fzf_exec("ast-grep run --color=never --lang c -p " .. vim.fn.shellescape(pattern) .. " -- .", {
		prompt = "AST> ",
		previewer = "builtin",
		actions = {
			["default"] = fzf.actions.file_edit,
			["ctrl-s"] = fzf.actions.file_split,
			["ctrl-v"] = fzf.actions.file_vsplit,
			["ctrl-t"] = fzf.actions.file_tabedit,
		},
	})
end, { desc = "AST: C function declarations" })

local function ast_grep_outline()
	local file = vim.api.nvim_buf_get_name(0)
	if file == "" then
		vim.notify("Buffer has no file name", vim.log.levels.WARN)
		return
	end

	local cmd = { "ast-grep", "outline", file, "--json" }
	local output = vim.fn.system(cmd)
	if vim.v.shell_error ~= 0 then
		vim.notify("ast-grep outline failed: " .. output, vim.log.levels.ERROR)
		return
	end

	local ok, data = pcall(vim.json.decode, output)
	if not ok or type(data) ~= "table" then
		vim.notify("Failed to parse ast-grep JSON", vim.log.levels.ERROR)
		return
	end

	local filename = vim.fn.fnamemodify(file, ":t")
	local lines = {}

	-- 递归收集一个符号节点及其所有 members
	local function collect(node)
		if type(node) ~= "table" then
			return
		end
		local r = node.range and node.range.start
		if r then
			local name = node.name or ""
			local sig = node.signature or ""
			local kind = node.astKind or "?"

			-- 显示文本：优先 name，没有就用 signature，都没有就显示 astKind
			local display
			if name ~= "" and sig ~= "" then
				display = name .. " " .. sig
			elseif name ~= "" then
				display = name
			elseif sig ~= "" then
				display = sig
			else
				display = kind
			end

			-- 格式：file:line:col: kind display
			table.insert(lines, string.format("%s:%d:%d: [%s] %s", filename, r.line, r.column, kind, display))
		end

		-- 关键：递归处理 members（struct 的 field、class 的 method 等）
		if node.members then
			for _, m in ipairs(node.members) do
				collect(m)
			end
		end
	end

	-- 顶层是数组，每个元素是一个文件对象，符号在 .items 下
	for _, file_obj in ipairs(data) do
		for _, item in ipairs(file_obj.items or {}) do
			collect(item)
		end
	end

	if #lines == 0 then
		vim.notify("No symbols found", vim.log.levels.INFO)
		return
	end

	require("fzf-lua").fzf_exec(lines, {
		prompt = "AST Symbols> ",
		actions = {
			["default"] = function(selected)
				if selected and selected[1] then
					local lnum, col = selected[1]:match("^[^:]+:(%d+):(%d+):")
					if lnum then
						-- nvim_win_set_cursor: 行是 1-based，列是 0-based
						vim.api.nvim_win_set_cursor(0, { tonumber(lnum), math.max(0, tonumber(col) - 1) })
					end
				end
			end,
		},
	})
end

vim.keymap.set("n", "<leader>sa", ast_grep_outline, { desc = "AST-grep Outline (Single File)" })
