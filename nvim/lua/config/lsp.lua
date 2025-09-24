-- [[ LSPs ]]

-- Use the standard lspconfig setup pattern via mason-lspconfig handlers.

require('mason').setup()

local capabilities = require('cmp_nvim_lsp').default_capabilities()

local on_attach = function(client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>f', function()
    vim.lsp.buf.format({ async = true })
  end, bufopts)
end

local servers = {
  -- Java
  jdtls = {},
  -- JavaScript / TypeScript
  ts_ls = {},
  -- Python
  pyright = {},
  -- C / C++
  clangd = {},
  -- Rust
  rust_analyzer = {},
  -- Lua (for Neovim config)
  lua_ls = {
    settings = {
      Lua = {
        diagnostics = {
          globals = { 'vim' },
        },
      },
    },
  },
  -- Emmet is a bit of an outlier since it doesn't need external setup like jdtls
  emmet_ls = {},
}

-- Get a list of server names from the keys of the 'servers' table
local installed_servers = vim.tbl_keys(servers)

require('mason-lspconfig').setup({
  -- Configure Mason to ensure these LSPs are installed
  ensure_installed = installed_servers,

  -- Define a handler function that will be called for all installed LSPs.
  handlers = {
    -- This 'handler' will be used for all servers that don't have a specific handler
    ['*'] = function(server_name)
      -- Get the custom config from our 'servers' table, or an empty table if none exists
      local custom_config = servers[server_name] or {}

      -- Set up the LSP with our on_attach, capabilities, and any custom settings
      require('lspconfig')[server_name].setup(
        vim.tbl_deep_extend('force', {
          on_attach = on_attach,
          capabilities = capabilities,
        }, custom_config)
      )
    end,
    -- NOTE: jdtls often requires a specific setup. You might need to add a dedicated handler for it later.
    -- For now, the generic handler should work for simple cases.
  },
})

-- REMOVE THE PREVIOUS LOOP:
-- for server_name, config in pairs(servers) do
--   local server_config = vim.tbl_deep_extend('force', {
--     on_attach = on_attach,
--     capabilities = capabilities,
--   }, config)
--
--   -- Use the new vim.lsp.config API to define the server configuration.
--   vim.lsp.config(server_name, server_config)
--
--   -- Use vim.lsp.enable to activate the LSP for the current buffer.
--   -- You can also use this in an autocommand to automatically enable it on certain filetypes.
--   vim.lsp.enable(server_name)
-- end
