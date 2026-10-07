return {
  {
    'nvim-telescope/telescope.nvim',
    version = '*',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    },
    keys = {
      { '<leader>fb', function() require('telescope.builtin').buffers() end },
      { '<leader>fr', function() require('telescope.builtin').oldfiles() end },
      { '<leader>fw', function() require('telescope.builtin').grep_string() end }, -- word under cursor
      { '<leader>fd', function() require('telescope.builtin').diagnostics() end },
      { '<leader>fh', function() require('telescope.builtin').help_tags() end },
      { '<leader>ff', function() require('telescope.builtin').find_files() end, desc = 'Find files' },
      { '<leader>fg', function() require('telescope.builtin').live_grep() end,  desc = 'Live grep' },
    },
    config = function()
      require('telescope').setup({})
      pcall(require('telescope').load_extension, 'fzf')
    end,
  },
}
