return {
  'stevearc/conform.nvim',
  lazy = false,
  config = function()
    require('conform').setup({
      formatters_by_ft = {
        c = { 'clang_format' },
        cpp = { 'clang_format' },
        javascript = { 'prettier' },
        typescript = { 'prettier' },
        javascriptreact = { 'prettier' },
        typescriptreact = { 'prettier' },
        ['*'] = { 'lsp_format' },
      },

      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
      },
    })
  end,
}
