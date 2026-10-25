local M = {}

-- 日志开关：设为 false 可关闭所有日志
M.debug = false

local function log(fmt, ...)
	if not M.debug then
		return
	end
	local msg = select("#", ...) > 0 and fmt:format(...) or fmt
	vim.notify("[plugin] " .. msg, vim.log.levels.INFO)
end

local pending_specs = {}
local repo_to_spec = {}

local function collect(spec)
	if vim.islist(spec) then
		for _, item in ipairs(spec) do
			collect(item)
		end
		return
	end
	assert(spec.repo, "单个插件 spec 必须包含 repo 字段")

	if not repo_to_spec[spec.repo] then
		table.insert(pending_specs, spec)
		repo_to_spec[spec.repo] = spec
		log("入队: %s (deps: %s)", spec.repo, spec.deps and table.concat(spec.deps, ", ") or "无")
	else
		log("跳过重复: %s", spec.repo)
	end
end

function M.plugin(spec)
	collect(spec)
end

local function topo_sort()
	local ordered_repos = {}
	local ordered_specs = {}
	local state = {}

	local function visit(repo)
		if state[repo] == "done" then
			return
		end
		if state[repo] == "visiting" then
			log("检测到循环依赖，跳过: %s", repo)
			return
		end
		state[repo] = "visiting"

		local spec = repo_to_spec[repo]
		for _, dep in ipairs((spec and spec.deps) or {}) do
			visit(dep)
		end

		state[repo] = "done"
		table.insert(ordered_repos, repo)
		if spec then
			table.insert(ordered_specs, spec)
		end
	end

	for _, spec in ipairs(pending_specs) do
		visit(spec.repo)
	end

	return ordered_repos, ordered_specs
end

function M.flush()
	if #pending_specs == 0 then
		log("队列为空，无需安装")
		return
	end

	log("========== 收集完成，共 %d 个 spec ==========", #pending_specs)
	for i, spec in ipairs(pending_specs) do
		log("  [%d] %s", i, spec.repo)
	end

	local ordered_repos, ordered_specs = topo_sort()

	log("========== 拓扑排序结果（安装顺序） ==========")
	for i, repo in ipairs(ordered_repos) do
		local has_spec = repo_to_spec[repo] ~= nil
		log("  [%d] %s%s", i, repo, has_spec and "" or " (纯依赖)")
	end

	log("========== 开始安装 ==========")
	local urls = {}
	for _, repo in ipairs(ordered_repos) do
		table.insert(urls, "https://github.com/" .. repo)
	end
	vim.pack.add(urls)
	log("vim.pack.add 完成，共 %d 个 URL", #urls)

	log("========== 执行 config / keys ==========")
	for _, spec in ipairs(ordered_specs) do
		if spec.config then
			log("config: %s", spec.repo)
			local ok, err = pcall(spec.config)
			if not ok then
				vim.notify(("插件 [%s] config 出错: %s"):format(spec.repo, err), vim.log.levels.ERROR)
			end
		else
			log("config: %s (无)", spec.repo)
		end

		for _, k in ipairs(spec.keys or {}) do
			log("  keymap: %s -> %s", k[1], type(k[2]) == "string" and k[2] or "<function>")
			vim.keymap.set(k.mode or "n", k[1], k[2], { desc = k.desc })
		end
	end

	log("========== 全部完成 ==========")

	pending_specs = {}
	repo_to_spec = {}
end

return M
