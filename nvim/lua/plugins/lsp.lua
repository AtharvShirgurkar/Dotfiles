return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "clangd",
          "ts_ls",
          "gopls",
          "pyright",
          "bashls",
        },
      })

      vim.lsp.config('lua_ls', {
        settings = {
          Lua = {
            diagnostics = { globals = { "vim" } },
          },
        },
      })

      local capabilities = require('blink.cmp').get_lsp_capabilities()

      local servers = { "lua_ls", "clangd", "ts_ls", "gopls", "pyright", "bashls" }
      for _, lsp in ipairs(servers) do
        vim.lsp.config(lsp, { capabilities = capabilities })
        vim.lsp.enable(lsp)
      end
    end,
  },
}
