return {
  {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter').install({
        "rust", "javascript", "typescript", "tsx", "zig",
        "c", "cpp", "lua", "python", "vim", "bash", "markdown"
      })
    end,
  },
}
