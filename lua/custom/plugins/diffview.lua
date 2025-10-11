return {
  'sindrets/diffview.nvim',
  event = 'InsertEnter',
  config = function()
    require('diffview').setup {}
    vim.keymap.set('n', '<leader>dvo', '<CMD>:DiffviewOpen<CR>', { desc = 'open diffview' })
    vim.keymap.set('n', '<leader>dvc', '<CMD>:DiffviewClose<CR>', { desc = 'close diffview' })
    vim.keymap.set('n', '<leader>dvh', '<CMD>:DiffviewFileHistory %<CR>', { desc = 'file history' })
  end,
}
