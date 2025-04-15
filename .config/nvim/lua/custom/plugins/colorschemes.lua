return {
  'catppuccin/nvim',
  name = 'catppuccin',
  priority = 1000,
  config = function()
    require('catppuccin').setup {
      color_overrides = {
        latte = {
          pink = '#1E66F5',
        },
      },
      integrations = {
        blink_cmp = true,
        cmp = true,
        mason = true,
        snacks = {
          enabled = true,
        },
        lsp_trouble = true,
        which_key = true,
      },
    }

    vim.cmd.colorscheme 'catppuccin'
  end,
}
