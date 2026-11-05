return {
	cmd = {
		"clangd",
		"--background-index", -- 后台建立索引，提升性能
		"--clang-tidy", -- 启用 clang-tidy 静态分析
		-- "--header-insertion=iwyu", -- 头文件插入策略 (Include What You Use)
		"--completion-style=detailed", -- 更详细的补全信息
		"--limit-results=100", -- 0 表示不限制结果数量
	},
	filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
	root_markers = { "compile_commands.json", "compile_flags.txt", ".git" },
}
