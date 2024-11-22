return {
  'ndonfris/fish-lsp',
  ft = 'fish',
  config = function()
    require('lspconfig').fish_lsp.setup {}
  end,
}
