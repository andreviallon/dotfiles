return {
  'christoomey/vim-tmux-navigator',
  lazy = true,
  keys = {
    { '<C-h>', '<cmd><C-U>TmuxNavigateLeft<cr>' },
    { '<C-j>', '<cmd><C-U>TmuxNavigateDown<cr>' },
    { '<C-k>', '<cmd><C-U>TmuxNavigateUp<cr>' },
    { '<C-l>', '<cmd><C-U>TmuxNavigateRight<cr>' },
  },
}
