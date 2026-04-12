return {
  'nvim-java/nvim-java',
  dependencies = {
    -- dresser
    'stevearc/dressing.nvim',
  },
  config = function()
    require('java').setup()
    vim.lsp.enable 'jdtls'
  end,
}
