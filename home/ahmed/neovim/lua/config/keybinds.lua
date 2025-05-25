-- Custom keybinds
--
-- Main map function
local function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.keymap.set(mode, lhs, rhs, options)
end


-- Leader key
-- vim.g.mapleader = " "
-- vim.g.mapocalleader = " "

-- NvimTree toggle
map("n", "<leader>e", ":NvimTreeToggle<CR>")

-- Telescope
map('n', '<leader>ff', ':Telescope find_files<CR>')
map('n', '<leader>fg', ':Telescope live_grep<CR>')
map('n', '<leader>fb', ':Telescope buffers<CR>')
map('n', '<leader>fh', ':Telescope help_tags<CR>')

-- Window navigation
map('n', '<A-h>', '<C-w>h')
map('n', '<A-j>', '<C-w>j')
map('n', '<A-k>', '<C-w>k')
map('n', '<A-l>', '<C-w>l')

-- Tab navigation
map('n', '<A-1>', '1gt')
map('n', '<A-2>', '2gt')
map('n', '<A-3>', '3gt')
map('n', '<A-4>', '4gt')
map('n', '<A-5>', '5gt')
map('n', '<A-6>', '6gt')
map('n', '<A-7>', '7gt')
map('n', '<A-8>', '8gt')
map('n', '<A-9>', '9gt')
map('n', '<A-0>', '10gt')

-- Toggle between current and previous
map('n', '<A-d>', '<C-^>') -- window
map('n', '<A-Tab>', '<C-w>p') -- tab

-- Center screen after jumping with hjkl
map('n', 'j', 'jzz')
map('n', 'k', 'kzz')
map('n', '<C-d>', '<C-d>zz')
map('n', '<C-u>', '<C-u>zz')
