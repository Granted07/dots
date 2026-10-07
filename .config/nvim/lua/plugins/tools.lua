return {
  {
    'stevearc/conform.nvim',
    event = 'BufWritePre',
    opts = {
      formatters_by_ft = {
        c = { 'clang-format' },
        cpp = { 'clang-format' },
        lua = { 'stylua' },
        python = { 'black' },
        javascript = { 'prettier' },
        typescript = { 'prettier' },
      },
      format_on_save = { timeout_ms = 1000, lsp_format = 'fallback' },
    },
  },

  -- git signs in the gutter, hunk navigation and staging
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      on_attach = function(buf)
        local gs = require('gitsigns')
        local m = function(k, f) vim.keymap.set('n', k, f, { buffer = buf }) end
        m(']h', gs.next_hunk)
        m('[h', gs.prev_hunk)
        m('<leader>hp', gs.preview_hunk)
        m('<leader>hs', gs.stage_hunk)
        m('<leader>hb', gs.blame_line)
      end,
    },
  },

  -- nice list of all errors/warnings in the project
  {
    'folke/trouble.nvim',
    opts = {},
    keys = { { '<leader>xx', '<cmd>Trouble diagnostics toggle<cr>', desc = 'Diagnostics' } },
  },

  -- undo history as a tree
  { 'mbbill/undotree', keys = { { '<leader>u', '<cmd>UndotreeToggle<cr>' } } },
}
