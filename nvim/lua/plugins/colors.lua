return {
  'uga-rosa/ccc.nvim',
  cmd = 'CccPick',
  keys = {
    {
      '<leader>cp',
      '<cmd>CccPick<CR>',
      mode = 'n',
      desc = 'Open Color Picker (ccc.nvim)',
    },
  },
  config = function()
    require('ccc').setup({
      highlighter = {
        auto_enable = true,
      },
    })
  end,
}
