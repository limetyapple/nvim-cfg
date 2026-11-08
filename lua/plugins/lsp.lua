return {
  "neovim/nvim-lspconfig",
  config = function()
    vim.lsp.config("lua_ls", {
      cmd = { '/home/limety/.local/bin/lua-language-server/bin/lua-language-server' }, -- ✅ 顶层
      filetypes = { "lua" }, -- 建议加上
      root_markers = { ".luarc.json", ".luarc.jsonc", ".git" }, -- 建议加上
      settings = {
        Lua = {
          runtime = {
            version = "LuaJIT",
          },
          diagnostics = {
            globals = { "vim" },
          },
          workspace = {
            library = vim.api.nvim_get_runtime_file("", true),
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
            enable = false,
          },
        },
      },
    })
    vim.lsp.enable("lua_ls")
  end,
}
