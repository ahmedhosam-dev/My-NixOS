-- Main
package.path = package.path .. ';/etc/nixos/home/ahmed/neovim/lua/?.lua;'
require('config.options')
require('config.dashboard')
require('config.ui')
require('config.telescope')
require('config.netrw')

-- For coding
require('nvim-autopairs').setup({
  disable_filetype = { "TelescopePrompt" , "vim" },
})

require("toggleterm").setup({
  size = 20,
  open_mapping = [[<c-\>]],
  direction = 'float', -- or 'horizontal'/'vertical'
})
