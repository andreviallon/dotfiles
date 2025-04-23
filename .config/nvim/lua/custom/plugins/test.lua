return {
  'vim-test/vim-test',
  init = function()
    vim.g['test#custom_strategies'] = {
      zellij = function(cmd)
        if os.getenv 'ZELLIJ' == nil then
          vim.notify('Cannot create Zellij pane to run tests. You are not in Zellij context.', 'error')
          return
        end

        local pipe_file_path = '/tmp/zellij-nvim-test-fifo'

        local pgrepHandle = io.popen("ps aux | grep '[t]ail -f " .. pipe_file_path .. "'")
        local pgrepOutput = pgrepHandle:read '*a'
        pgrepHandle:close()

        local is_pane_already_listening = pgrepOutput ~= ''

        if not is_pane_already_listening then
          os.execute('rm -f' .. pipe_file_path)
          os.execute('mkfifo -m 600 ' .. pipe_file_path)
          os.execute("zellij run -d down -c -n Tests -- bash -c 'tail -f " .. pipe_file_path .. " | bash' &")

          -- Focus back to Neovim
          -- os.execute 'zellij action focus-previous-pane'
          -- os.execute 'sleep 0.05'
        else
          vim.notify('Running tests in existing Zellij pane', 'info')
        end

        local escaped_cmd = cmd:gsub('"', '\\"')
        os.execute("echo '" .. escaped_cmd .. "' > " .. pipe_file_path)
      end,
    }

    vim.g['test#strategy'] = 'zellij'
  end,
  cmd = {
    'TestNearest',
    'TestFile',
    'TestSuite',
    'TestLast',
    'TestVisit',
  },
  keys = {
    { '<leader>tt', '<cmd>TestNearest<CR>' },
    { '<leader>tf', '<cmd>TestFile<CR>' },
    { '<leader>ts', '<cmd>TestSuite<CR>' },
    { '<leader>tl', '<cmd>TestLast<CR>' },
  },
}
