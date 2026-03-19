vim.opt.termguicolors = false
vim.cmd.colorscheme('default')

local groups = { "Normal", "NormalFloat", "LineNr", "SignColumn", "NonText", "EndOfBuffer" }
for _, group in ipairs(groups) do
    vim.api.nvim_set_hl(0, group, { ctermbg = "none" })
end
