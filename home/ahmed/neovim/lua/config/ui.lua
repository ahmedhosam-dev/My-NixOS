-- Tokyo Night settings
require("tokyonight").setup({
  style = "night",
  transparent = false,
})

-- Set colorscheme 
vim.cmd[[ colorscheme tokyonight-night ]]

-- Lualine setup (statusline)
require('lualine').setup({
  options = {
    theme = 'tokyonight',
    icons_enabled = true,
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
})

-- Bufferline setup (tabline)
require("bufferline").setup{
  options = {
    mode = "tabs",
    separator_style = "slant",
    color_icons = true,
    show_buffer_close_icons = false,
  }
}

