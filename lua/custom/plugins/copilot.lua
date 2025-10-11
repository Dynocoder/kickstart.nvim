return {
  'github/copilot.vim',
  config = function()
    vim.api.nvim_create_autocmd('FileType', {
      pattern = { 'markdown', 'text', 'gitcommit', 'env' },
      callback = function()
        vim.b.copilot_enabled = false
      end,
    })
  end,
}
