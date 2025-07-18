-- The setup config table shows all available config options with their default values:
require("presence").setup({
    -- General options
    auto_update         = true,
    neovim_image_text   = "Die with a smile",
    main_image          = "https://i.pinimg.com/736x/17/96/da/1796da275a1259f002921255f1b269e8.jpg",
    log_level           = nil,
    debounce_timeout    = 10,
    enable_line_number  = false,
    blacklist           = {},
    buttons             = true,
    file_assets         = {},
    show_time           = true,

    -- Rich Presence text options
    editing_text        = "Editing %s",
    file_explorer_text  = "Browsing %s",
    git_commit_text     = "Committing changes",
    plugin_manager_text = "Managing plugins",
    reading_text        = "Reading %s",
    workspace_text      = "Working on %s",
    line_number_text    = "Line %s out of %s",
})
