return {
  -- Avante
  {
    'yetone/avante.nvim',
    event = 'VeryLazy',
    lazy = true,
    version = false,
    opts = {
      provider = 'openai',
      hints = { enabled = false },
      openai = {
        endpoint = 'https://api.openai.com/v1',
        model = 'gpt-4o',
        timeout = 30000,
        temperature = 0,
        max_tokens = 4096,
      },
    },
    build = 'make',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'stevearc/dressing.nvim',
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
      'hrsh7th/nvim-cmp',
      'ibhagwan/fzf-lua',
      'nvim-tree/nvim-web-devicons',
      {
        'HakonHarnes/img-clip.nvim',
        event = 'VeryLazy',
        opts = {
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
          },
        },
      },
      {
        'MeanderingProgrammer/render-markdown.nvim',
        opts = {
          file_types = { 'markdown', 'Avante' },
        },
        ft = { 'markdown', 'Avante' },
      },
    },
  },

  -- Codecompanion
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
        ft = { 'markdown', 'codecompanion' },
      },
    },
    opts = {
      strategies = {
        chat = {
          adapter = 'openai',
          slash_commands = {
            ['file'] = {
              callback = 'strategies.chat.slash_commands.file',
              description = 'Select a file using Telescope',
              opts = {
                provider = 'fzf_lua',
                contains_code = true,
              },
            },
          },
        },
        inline = {
          keymaps = {
            accept_change = {
              modes = { n = 'ga' },
              description = 'Accept the suggested change',
            },
            reject_change = {
              modes = { n = 'gr' },
              description = 'Reject the suggested change',
            },
          },
        },
      },
      display = {
        chat = {
          intro_message = 'Welcome to CodeCompanion ✨! Press ? for options',
          show_header_separator = true,
          separator = '─',
          show_references = true,
          show_settings = true,
          show_token_count = true,
          start_in_insert_mode = false,
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
    keys = {
      {
        '<leader>cc',
        '<cmd>CodeCompanionActions<cr>',
        mode = { 'n', 'v' },
        desc = 'Open CodeCompanion Actions',
      },
    },
  },

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
