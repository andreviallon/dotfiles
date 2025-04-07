return {
  -- Avante
  {
    'yetone/avante.nvim',
    event = 'VeryLazy',
    lazy = true,
    version = false,
    opts = {
      file_selector = 'snacks',
      provider = 'openai',
      hints = { enabled = false },
      openai = {
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
