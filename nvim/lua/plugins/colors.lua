return {
  'norcalli/nvim-colorizer.lua',

  config = function()
    require('colorizer').setup({
      user_default_options = {
        mode = 'background',
        names = true,
        always_update = true,
      },

      filetypes = {
        'css',
        'scss',
        'less',
        'html',
        'javascript',
        'typescript',
        'lua',
      },
    })

    vim.api.nvim_create_autocmd('VimEnter', {
      callback = function()
        vim.cmd('ColorizerAttach')
      end,
    })
  end,
}
