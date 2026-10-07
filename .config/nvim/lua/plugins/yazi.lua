return {
  {
    'mikavilpas/yazi.nvim',
    version = '*',
    event = 'VeryLazy',
    dependencies = {
      { 'nvim-lua/plenary.nvim', lazy = true },
    },
    keys = {
      -- open yazi at the current file
      { '<leader>y',  '<cmd>Yazi<cr>',        desc = 'Yazi (current file)' },
      -- open yazi in nvim's working directory
      { '<leader>Y',  '<cmd>Yazi cwd<cr>',    desc = 'Yazi (cwd)' },
      -- resume the last yazi session
      { '<leader>yr', '<cmd>Yazi toggle<cr>', desc = 'Yazi (resume)' },
    },
    opts = {
      -- leave directory opening to oil, so the two don't fight over netrw
      open_for_directories = false,
      keymaps = {
        show_help = '<f1>',
      },
    },
  },
}
