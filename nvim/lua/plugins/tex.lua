return {
  "lervag/vimtex",
  lazy = false, -- Vimtex recommends not lazy-loading for full functionality
  init = function()
    -- Vimtex configuration goes here
    vim.g.vimtex_view_method = "zathura"
    
    -- Optional: Set the compiler engine if you prefer something other than pdflatex
    -- vim.g.vimtex_compiler_method = 'latexmk'
    
    -- Optional: Automatic opening of the quickfix window on errors
    vim.g.vimtex_quickfix_mode = 0
  end
}
