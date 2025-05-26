return {
  {
    'saghen/blink.cmp',
    dependencies = {
      'Kaiser-Yang/blink-cmp-avante',
    },
    version = '*',
    opts = {
      keymap = {
        preset = 'enter',
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
          treesitter_highlighting = true,
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
      },
      sources = {
        default = { 'lsp', 'avante', 'buffer', 'path' },
        providers = {
          avante = {
            module = 'blink-cmp-avante',
            name = 'Avante',
          },
        },
      },
      signature = {
        enabled = true,
      },
    },
    opts_extend = { 'sources.default' },
  },
}
