return {
  -- CodeCompanion
  {
    'olimorris/codecompanion.nvim',
    event = 'VeryLazy',
    version = false,
    dependencies = {
      'nvim-lua/plenary.nvim',
      'stevearc/dressing.nvim',
      'MunifTanjim/nui.nvim',
      'nvim-tree/nvim-web-devicons',
      'zbirenbaum/copilot.lua',
      'echasnovski/mini.diff',
      'nvim-treesitter/nvim-treesitter',
      'j-hui/fidget.nvim',
      {
        'HakonHarnes/img-clip.nvim',
        event = 'VeryLazy',
        opts = {
          default = {
            drag_and_drop = { insert_mode = true },
          },
        },
      },
      {
        'MeanderingProgrammer/render-markdown.nvim',
        opts = { file_types = { 'markdown', 'CodeCompanion' } },
      },
      {
        'OXY2DEV/markview.nvim',
        lazy = false,
        opts = {
          preview = {
            filetypes = { 'markdown', 'codecompanion' },
            ignore_buftypes = {},
          },
        },
      },
    },
    opts = {
      strategies = {
        chat = {
          adapter = 'openai',
        },
        inline = {
          adapter = 'openai',
        },
      },
      display = {
        chat = {
          show_header_separator = true,
          separator = '─',
          show_token_count = true,
          start_in_insert_mode = true,
        },
        diff = {
          enabled = true,
          close_chat_at = 240,
          layout = 'vertical',
          opts = {
            'internal',
            'filler',
            'closeoff',
            'algorithm:patience',
            'followwrap',
            'linematch:120',
          },
          provider = 'mini_diff',
        },
      },
      hints = { enabled = true },
      log_level = 'INFO',
    },
    config = function(_, opts)
      require('codecompanion').setup(opts)

      local progress = require 'fidget.progress'
      local handles = {}
      local group = vim.api.nvim_create_augroup('CodeCompanionFidget', {})

      vim.api.nvim_create_autocmd('User', {
        pattern = 'CodeCompanionRequestStarted',
        group = group,
        callback = function(e)
          handles[e.data.id] = progress.handle.create {
            title = 'CodeCompanion',
            message = 'Thinking...',
            lsp_client = { name = e.data.adapter.formatted_name },
          }
        end,
      })

      vim.api.nvim_create_autocmd('User', {
        pattern = 'CodeCompanionRequestFinished',
        group = group,
        callback = function(e)
          local h = handles[e.data.id]
          if h then
            h.message = e.data.status == 'success' and 'Done' or 'Failed'
            h:finish()
            handles[e.data.id] = nil
          end
        end,
      })
    end,
    keys = {
      {
        '<leader>aa',
        '<cmd>CodeCompanionActions<cr>',
        mode = { 'n', 'v' },
        desc = 'Open CodeCompanion Actions',
      },
      {
        '<leader>at',
        '<cmd>CodeCompanionChat Toggle<cr>',
        mode = { 'n', 'v' },
        desc = 'Toggle CodeCompanion Chat',
      },
      {
        '<leader>ac',
        '<cmd>CodeCompanionChat Add<cr>',
        mode = 'v',
        desc = 'Add selection to CodeCompanion Chat',
      },
    },
  },
  -- Avante
  -- {
  --   'yetone/avante.nvim',
  --   event = 'VeryLazy',
  --   lazy = true,
  --   version = false,
  --   opts = {
  --     selector = {
  --       provider = 'fzf_lua',
  --     },
  --     provider = 'openai',
  --     hints = { enabled = false },
  --     smart_tab = true,
  --     openai = {
  --       model = 'gpt-4o',
  --       timeout = 30000,
  --       temperature = 0,
  --       max_tokens = 4096,
  --     },
  --   },
  --   build = 'make',
  --   dependencies = {
  --     'ibhagwan/fzf-lua',
  --     'nvim-treesitter/nvim-treesitter',
  --     'stevearc/dressing.nvim',
  --     'nvim-lua/plenary.nvim',
  --     'MunifTanjim/nui.nvim',
  --     'nvim-tree/nvim-web-devicons',
  --     {
  --       'HakonHarnes/img-clip.nvim',
  --       event = 'VeryLazy',
  --       opts = {
  --         default = {
  --           embed_image_as_base64 = false,
  --           prompt_for_file_name = false,
  --           drag_and_drop = {
  --             insert_mode = true,
  --           },
  --         },
  --       },
  --     },
  --     {
  --       'MeanderingProgrammer/render-markdown.nvim',
  --       opts = {
  --         file_types = { 'markdown', 'Avante' },
  --       },
  --       ft = { 'markdown', 'Avante' },
  --     },
  --   },
  -- },

  -- Copilot
  {
    'github/copilot.vim',
    dependencies = { 'catppuccin/nvim' },
    event = 'VimEnter',
    lazy = true,
    {
      'CopilotC-Nvim/CopilotChat.nvim',
      dependencies = {
        { 'nvim-lua/plenary.nvim', branch = 'master' },
      },
      build = 'make tiktoken',
    },
  },
}
