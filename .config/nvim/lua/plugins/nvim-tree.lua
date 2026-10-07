-- lua/plugins/nvim-tree.lua
return {
  "nvim-tree/nvim-tree.lua",
  dependencies = { "nvim-tree/nvim-web-devicons" }, -- file icons (needs a Nerd Font)
  config = function()
    -- recommended: disable netrw so it doesn't conflict
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    require("nvim-tree").setup({
      view = {
        width = 30,
        side = "left",
      },
      renderer = {
        group_empty = true,
      },
      filters = {
        dotfiles = false, -- show hidden files
      },
    })

    -- toggle the sidebar with Ctrl+n
    vim.keymap.set("n", "<C-n>", ":NvimTreeToggle<CR>", { silent = true })
    -- jump to the current file in the tree
    vim.keymap.set("n", "<leader>e", ":NvimTreeFindFile<CR>", { silent = true })
  end,
}
