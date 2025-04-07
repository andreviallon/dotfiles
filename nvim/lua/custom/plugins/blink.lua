return {
  {
    'saghen/blink.cmp',
    version = '*',
    opts = {
      keymap = {
        preset = 'enter',
        ['<Tab>'] = { 'accept' },
        ['<C-k>'] = { 'select_prev', 'fallback' },
        ['<C-j>'] = { 'select_next', 'fallback' },
      },
      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = 'mono',
      },
      completion = {
        accept = { auto_brackets = { enabled = true } },
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 250,
          treesitter_highlighting = true,
          window = { border = 'rounded' },
        },
        list = {
          selection = {
            preselect = function(ctx)
              return ctx.mode ~= 'cmdline'
            end,
            auto_insert = function(ctx)
              return ctx.mode == 'cmdline'
            end,
          },
        },
        menu = {
          border = 'rounded',
        },
      },
      sources = {
        default = { 'lsp', 'buffer', 'path' },
      },
      signature = {
        enabled = true,
        window = {
          border = 'rounded',
        },
      },
    },
    opts_extend = { 'sources.default' },
  },
}
