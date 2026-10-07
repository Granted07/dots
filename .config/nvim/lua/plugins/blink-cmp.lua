local accept_keys = {
  ['<CR>']   = { 'accept', 'fallback' },
  ['<Tab>']  = { 'select_and_accept', 'fallback' },
  ['<Up>']   = { 'select_prev', 'fallback' },
  ['<Down>'] = { 'select_next', 'fallback' },
}

return {
  {
    'saghen/blink.cmp',
    dependencies = { 'rafamadriz/friendly-snippets' },
    version = '1.*',
    opts = {
      keymap = vim.tbl_extend('force', { preset = 'none' }, accept_keys, {
        ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
        ['<C-e>']     = { 'hide', 'fallback' },
      }),

      appearance = { nerd_font_variant = 'mono' },
      completion = { documentation = { auto_show = false } },
      sources = { default = { 'lsp', 'path', 'snippets', 'buffer' } },
      fuzzy = { implementation = "prefer_rust_with_warning" },

      cmdline = {
        enabled = true,
        keymap = vim.tbl_extend('force', { preset = 'none' }, accept_keys),
        completion = {
          menu = { auto_show = true },
          list = { selection = { preselect = false } },
        },
      },
    },
    opts_extend = { "sources.default" },
  },
}
