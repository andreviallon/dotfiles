return {
  'vim-test/vim-test',
  lazy = true,
  dependencies = {
    'preservim/vimux',
  },
  config = function()
    vim.g.VimuxHeight = '25'
    vim.keymap.set('n', '<leader>tt', ':TestNearest<CR>', { desc = 'Run nearest' })
    vim.keymap.set('n', '<leader>tT', ':TestFile<CR>', { desc = 'Run file' })
    vim.keymap.set('n', '<leader>ts', ':TestSuite<CR>', { desc = 'Run suite' })
    vim.keymap.set('n', '<leader>tr', ':TestLast<CR>', { desc = 'Rerun last' })
    vim.keymap.set('n', '<leader>tv', ':TestVisit<CR>', { desc = 'Visit' })
    vim.cmd "let test#strategy = 'vimux'"
  end,
}
