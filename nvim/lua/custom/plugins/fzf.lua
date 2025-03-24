return {
  'ibhagwan/fzf-lua',
  event = 'VimEnter',
  lazy = true,
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    local fzf = require 'fzf-lua'
    fzf.setup {}

    vim.keymap.set('n', '<leader>fd', function()
      local fzf = require 'fzf-lua'
      fzf.fzf_exec('fd --type d --hidden --exclude .git', {
        prompt = 'Select Directory: ',
        cwd = vim.fn.getcwd(),
        actions = {
          ['default'] = function(selected)
            local dir = selected[1]
            if dir and dir ~= '' then
              fzf.live_grep { cwd = dir }
            end
          end,
        },
      })
    end, { desc = 'Grep in directory' })
  end,
}
