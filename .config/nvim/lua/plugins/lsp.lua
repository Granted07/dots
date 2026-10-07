return {
  { 'mason-org/mason.nvim', opts = {} },
  {
    'mason-org/mason-lspconfig.nvim',
    dependencies = { 'mason-org/mason.nvim', 'neovim/nvim-lspconfig' },
    opts = {
      ensure_installed = { 'clangd', 'lua_ls', 'pyright', 'rust_analyzer', 'ts_ls' },
    },
    config = function(_, opts)
      vim.lsp.config('*', {
        capabilities = require('blink.cmp').get_lsp_capabilities(),
      })
      require('mason-lspconfig').setup(opts)  -- auto-enables installed servers

      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(ev)
          local m = function(k, f, d)
            vim.keymap.set('n', k, f, { buffer = ev.buf, desc = d })
          end
          m('gd', vim.lsp.buf.definition, 'Go to definition')
          m('gD', vim.lsp.buf.declaration, 'Go to declaration')
          m('<leader>rn', vim.lsp.buf.rename, 'Rename')
          m('<leader>ca', vim.lsp.buf.code_action, 'Code action')
          m('<leader>e', vim.diagnostic.open_float, 'Line diagnostics')
          m('<leader>fs', function() require('telescope.builtin').lsp_document_symbols() end, 'Symbols')
          m('gr', function() require('telescope.builtin').lsp_references() end, 'References')
        end,
      })
    end,
  },
}
