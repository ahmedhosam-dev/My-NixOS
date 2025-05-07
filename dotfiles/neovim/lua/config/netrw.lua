require("netrw").setup({
    use_devicons = true,
    mappings = {
      -- Function mappings receive an object describing the node under the cursor
      ['p'] = function(payload) print(vim.inspect(payload)) end,
      -- String mappings are executed as vim commands
      ['<Leader>p'] = ":echo 'hello world'<CR>",
  },
})

-- Options for list view
vim.g.netrw_liststyle = 3
vim.g.netrw_banner = 0
vim.g.netrw_altv = 1
vim.g.netrw_winsize = 25

-- Enable relativenumber in netrw
vim.api.nvim_create_autocmd("FileType", {
  pattern = "netrw",
  callback = function()
    vim.opt_local.relativenumber = true
  end,
})

-- Toggle Netrw
vim.keymap.set('n', '<leader>e', function()
    local bufname = vim.api.nvim_buf_get_name(0)
    if bufname:match("NetrwTreeListing") ~= nil then
        vim.cmd("bd")  -- Close Netrw if open
    else
        vim.cmd("Lexplore")  -- Open Netrw in a sidebar (alternatively: "Explore")
    end
end, { desc = "Toggle Netrw" })
