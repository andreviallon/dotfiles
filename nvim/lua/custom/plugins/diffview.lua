return {
  'sindrets/diffview.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local diffview = require 'diffview'
    diffview.setup {
      enhanced_diff_hl = true,
      use_icons = true,
    }

    vim.keymap.set('n', '<leader>gh', ':DiffviewFileHistory %<CR>', { desc = 'Git File History' })
    vim.keymap.set('n', '<leader>gH', ':DiffviewFileHistory<CR>', { desc = 'Git Project History' })
    vim.keymap.set('n', '<leader>gq', ':DiffviewClose<CR>', { desc = 'Close Diffview' })
  end,
}
