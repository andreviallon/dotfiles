return {
  'catppuccin/nvim',
  lazy = false,
  name = 'catppuccin',
  opts = { colorscheme = 'mocha' },
  init = function()
    vim.cmd.colorscheme 'catppuccin-mocha'
  end,
}
