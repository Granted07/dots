return {
  -- jump anywhere on screen in 2-3 keystrokes (replaces the mouse)
  {
    'folke/flash.nvim',
    event = 'VeryLazy',
    opts = {},
    keys = {
      { 's', mode = { 'n', 'x', 'o' }, function() require('flash').jump() end,       desc = 'Flash jump' },
      { 'S', mode = { 'n', 'x', 'o' }, function() require('flash').treesitter() end, desc = 'Flash treesitter' },
    },
  },

  -- file explorer as an editable buffer: press - to open the parent dir
  {
    'stevearc/oil.nvim',
    opts = { view_options = { show_hidden = true } },
    keys = { { '-', '<cmd>Oil<cr>', desc = 'File explorer' } },
  },

  -- surround, auto-pairs, better text objects (va), yi, etc.)
  {
    'echasnovski/mini.nvim',
    version = false,
    config = function()
      require('mini.surround').setup() -- gsa add, gsd delete, gsr replace
      require('mini.pairs').setup()
      require('mini.ai').setup()
      require('mini.comment').setup() -- gcc toggles a comment, gc in visual
    end,
  },

  -- shows available keys as you type a prefix
  { 'folke/which-key.nvim', event = 'VeryLazy', opts = {} },

  -- pin 3-4 files and jump between them instantly
  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local h = require('harpoon')
      h:setup()
      vim.keymap.set('n', '<leader>a', function() h:list():add() end)
      vim.keymap.set('n', '<leader>h', function() h.ui:toggle_quick_menu(h:list()) end)
      for i = 1, 4 do
        vim.keymap.set('n', '<leader>' .. i, function() h:list():select(i) end)
      end
    end,
  },


}

