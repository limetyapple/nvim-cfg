return {
  "neovim/nvim-lspconfig",
  config = function()
    vim.lsp.config("lua_ls", {
      cmd = { 'lua-language-server' },
      filetypes = { "lua" }, -- 建议加上
      root_markers = { ".luarc.json", ".luarc.jsonc", ".git" }, -- 建议加上
      settings = {
        Lua = {
          runtime = {
            version = "LuaJIT",
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
