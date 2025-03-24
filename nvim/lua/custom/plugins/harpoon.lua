return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  config = function()
    local harpoon = require 'harpoon'
    harpoon:setup {
      settings = {
        save_on_toggle = true,
        save_on_change = true,
      },
    }

    local function harpoon_fzf()
      local entries = {}
      for i, item in ipairs(harpoon:list().items) do
        table.insert(entries, string.format('%d: %s', i, item.value))
      end
      require('fzf-lua').fzf_exec(entries, {
        actions = {
          ['default'] = function(selected)
            local index = tonumber(selected[1]:match '^%d+')
            if index then
              harpoon:list():select(index)
            end
          end,
        },
      })
    end

    vim.keymap.set('n', '<leader>ha', function()
      harpoon:list():add()
    end, { desc = 'Add file to Harpoon' })

    vim.keymap.set('n', '<C-S-h>', function()
      harpoon:list():prev()
    end)
    vim.keymap.set('n', '<C-S-l>', function()
      harpoon:list():next()
    end)

    vim.keymap.set('n', '<C-e>', function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, { desc = 'Harpoon menu' })

    for i = 1, 9 do
      vim.keymap.set('n', string.format('<leader>%d', i), function()
        harpoon:list():select(i)
      end, { desc = 'Go to Harpoon file ' .. i })
    end

    for i = 1, 9 do
      vim.keymap.set('n', string.format('<leader>h%d', i), function()
        harpoon:list():set(i, vim.fn.expand '%:p')
      end, { desc = 'Set Harpoon to ' .. i })
    end

    vim.keymap.set('n', '<leader>hc', function()
      harpoon:list():clear()
    end, { desc = 'Clear all Harpoon entries' })
  end,
}
