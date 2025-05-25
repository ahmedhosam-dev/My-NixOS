require("nvim-tree").setup({
  sort = {
    sorter = "case_sensitive",
  },
  view = {
    width = 30,
    side = "left",
    number = true,
    relativenumber = true,
    signcolumn = "yes",
  },
  renderer = {
    group_empty = true,
    highlight_git = true,
    indent_markers = {
      enable = true,
    },
    icons = {
      webdev_colors = true,
      git_placement = "before",
      show = {
        file = true,
        folder = true,
        folder_arrow = true,
        git = true,
      },
    },
  },
  filters = {
    dotfiles = false,
  },
  live_filter = {
    prefix = "[FILTER]: ",
    always_show_folders = true,
  },
})
