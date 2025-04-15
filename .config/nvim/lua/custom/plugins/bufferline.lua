return {
  'akinsho/bufferline.nvim',
  version = '*',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  event = 'VimEnter',
  init = function()
    vim.opt.termguicolors = true
  end,
  opts = {
    highlights = {
      buffer_selected = {
        italic = false,
      },
      diagnostic_selected = {
        italic = false,
      },
    },
    options = {
      close_command = 'bd! %d',
      show_tab_indicators = true,
      separator_style = 'thick',
      diagnostics = 'nvim_lsp',
      hover = {
        enabled = true,
        reveal = { 'close' },
      },
      offsets = {
        {
          filetype = 'neo-tree',
          text = 'Neo-tree',
          highlight = 'Directory',
          text_align = 'left',
        },
        {
          filetype = 'snacks_layout_box',
        },
      },
      max_name_length = 100,
    },
  },
  keys = {
    { '<leader>bp', '<cmd>BufferLineTogglePin<cr>', desc = 'Toggle pin' },
    { '<leader>bP', '<cmd>BufferLineGroupClose ungrouped<cr>', desc = 'Delete non-pinned buffers' },
    { '<leader>bo', '<cmd>BufferLineCloseOthers<cr>', desc = 'Delete other buffers' },
    { '<leader>br', '<cmd>BufferLineCloseRight<cr>', desc = 'Delete buffers right' },
    { '<leader>bl', '<cmd>BufferLineCloseLeft<cr>', desc = 'Delete buffers left' },
    { '<leader>bD', '<cmd>:bw!<cr>', desc = 'Delete buffer force' },
    { '<S-h>', '<cmd>BufferLineCyclePrev<cr>', desc = 'Prev buffer' },
    { '<S-l>', '<cmd>BufferLineCycleNext<cr>', desc = 'Next buffer' },
    { '[b', '<cmd>BufferLineCyclePrev<cr>', desc = 'Prev buffer' },
    { ']b', '<cmd>BufferLineCycleNext<cr>', desc = 'Next buffer' },
    { '[B', '<cmd>BufferLineMovePrev<cr>', desc = 'Move buffer prev' },
    { ']B', '<cmd>BufferLineMoveNext<cr>', desc = 'Move buffer next' },
  },
}
