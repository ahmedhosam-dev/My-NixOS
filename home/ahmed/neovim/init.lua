-- Main
package.path = package.path .. ';/etc/nixos/home/ahmed/neovim/lua/?.lua;'
require('config.options')
require('config.dashboard')
require('config.ui')
require('config.file-explorer')
require('config.keybinds')
require('config.presence')
require('config.lsp')
require('config.treesitter')
require('config.autosave')
require('config.cmp')
require('config.vsnip')
require('config.gitsigns')
require('config.indentation')
-- require('config.whichkey')

-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- enable 24-bit colour
vim.opt.termguicolors = true

-- Enable telescope fuzzy finder
require('telescope').setup{}

-- Vertical line 
-- vim.cmd[[ highlight CursorColumn guibg=#5E81AC ]]
-- vim.o.cursorcolumn = true

-- For coding
require('nvim-autopairs').setup({
  disable_filetype = { "TelescopePrompt" , "vim" },
})

require("toggleterm").setup({
  size = 20,
  open_mapping = [[<leader>\]],
  direction = 'float', -- or 'horizontal'/'vertical'
})
