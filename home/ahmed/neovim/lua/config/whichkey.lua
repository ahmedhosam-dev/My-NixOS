local wk = require("which-key")
wk.setup({
  plugins = {
    marks = true,       -- Show mappings for marks (e.g., `ma to set mark 'a')
    registers = true,   -- Show registers when pressing `"` or `@`
    spelling = {
      enabled = true,   -- Enable spell suggestions (e.g., `z=`)
      suggestions = 20,  -- Number of suggestions
    },
    presets = {
      operators = true,  -- Show motions (e.g., `d`, `y`, `c`)
      motions = true,    -- Show text object motions (e.g., `ib`, `aw`)
      text_objects = true,
      windows = true,    -- Default window commands (e.g., `<C-w>w`)
      nav = true,        -- Navigation (e.g., `]q` for quickfix)
      z = true,          -- Fold commands (e.g., `zR`)
      g = true,          -- Git commands (e.g., `gb` for git branch)
    },
  },
  win = {
    border = "rounded",  -- Border style (none, single, double, rounded, shadow)
    position = "bottom", -- Position (bottom, top)
  },
})

wk.add({
  { "<leader>f", group = "file" },
  { "<leader>g", group = "git" },
  { "<leader>l", group = "lsp" },
})
