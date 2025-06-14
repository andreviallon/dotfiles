return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    bigfile = { enabled = true },
    bufdelete = { enabled = true },
    dashboard = { enabled = true },
    explorer = { enabled = true },
    git = { enabled = true },
    lazygit = { enabled = true },
    gitbrowse = { enabled = true },
    indent = { enabled = true, animate = { enabled = false } },
    notifier = { enabled = true },
    notify = { enabled = true },
    picker = {
      enabled = true,
      formatters = {
        file = {
          truncate = 500,
        },
      },
      sources = {
        explorer = {
          cycle = true,
          hidden = true,
          title = '',
          border = 'none',
          layout = {
            layout = {
              width = 50,
            },
          },
          actions = {
            copy_file_path = {
              action = function(_, item)
                if not item then
                  return
                end

                local vals = {
                  ['FILENAME'] = vim.fn.fnamemodify(item.file, ':t'),
                  ['BASENAME'] = vim.fn.fnamemodify(item.file, ':t:r'),
                  ['PATH'] = item.file,
                  ['PATH (CWD)'] = vim.fn.fnamemodify(item.file, ':.'),
                  ['PATH (HOME)'] = vim.fn.fnamemodify(item.file, ':~'),
                  ['URI'] = vim.uri_from_fname(item.file),
                }

                local options = vim.tbl_filter(function(val)
                  return vals[val] ~= ''
                end, vim.tbl_keys(vals))
                if vim.tbl_isempty(options) then
                  vim.notify('No values to copy', vim.log.levels.WARN)
                  return
                end
                table.sort(options)
                vim.ui.select(options, {
                  prompt = 'Choose to copy to clipboard:',
                  format_item = function(list_item)
                    return ('%s: %s'):format(list_item, vals[list_item])
                  end,
                }, function(choice)
                  local result = vals[choice]
                  if result then
                    vim.fn.setreg('+', result)
                    Snacks.notify.info('Yanked `' .. result .. '`')
                  end
                end)
              end,
            },
            search_in_directory = {
              action = function(_, item)
                if not item then
                  return
                end
                local dir = vim.fn.fnamemodify(item.file, ':p:h')
                Snacks.picker.grep {
                  cwd = dir,
                  cmd = 'rg',
                  args = {
                    '-g',
                    '!.git',
                    '-g',
                    '!node_modules',
                    '-g',
                    '!dist',
                    '-g',
                    '!build',
                    '-g',
                    '!coverage',
                    '-g',
                    '!.DS_Store',
                    '-g',
                    '!.docusaurus',
                    '-g',
                    '!.dart_tool',
                  },
                  show_empty = true,
                  hidden = true,
                  ignored = true,
                  follow = false,
                  supports_live = true,
                }
              end,
            },
          },
          win = {
            list = {
              keys = {
                ['y'] = 'copy_file_path',
                ['s'] = 'search_in_directory',
              },
            },
          },
        },
      },
    },
  },
   -- stylua: ignore
   keys = {
     -- Top Pickers
    { "<leader><leader>", function() Snacks.picker.smart() end, desc = "Smart Find Files" },
    { "<leader>/", function() Snacks.picker.grep() end, desc = "Grep" },
    { "<leader>:", function() Snacks.picker.command_history() end, desc = "Command History" },
    {"<leader>e", function() Snacks.explorer.open() end, desc = "Explorer" },
    {
      "<leader>ft",
      function()
        local filetype = vim.fn.input 'Enter file extension:'
        if filetype ~= '' then
          Snacks.picker.grep { glob = '**/*.' .. filetype }
        end
      end,
      desc = "Search by File Type" },

    -- Buffers
    { "<leader>bd", function() Snacks.bufdelete() end, desc = "Delete buffer" },
    { "<leader>bb", function() Snacks.picker.buffers() end, desc = "Buffers" },
    { "<leader>.", function() Snacks.picker.buffers() end, desc = "Buffers" },
    { "<C-b>", function() Snacks.picker.buffers() end, desc = "Buffers" },

    -- Files & Search
    { "<leader>fb", function() Snacks.picker.buffers() end, desc = "Buffers" },
    { "<leader>fc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find Config File" },
    { "<leader>ff", function() Snacks.picker.files() end, desc = "Find Files" },
    { "<leader>fg", function() Snacks.picker.git_files() end, desc = "Find Git Files" },
    { "<leader>fp", function() Snacks.picker.projects() end, desc = "Projects" },
    { "<leader>fr", function() Snacks.picker.recent() end, desc = "Recent" },
    { "<leader>fR", function() Snacks.picker.resume() end, desc = "Resume" },
    { "<leader>fu", function() Snacks.picker.undo() end, desc = "Undo History" },
    { "<leader>fs", function() Snacks.picker.lsp_symbols() end, desc = "LSP Symbols" },
    { "<leader>fS", function() Snacks.picker.lsp_workspace_symbols() end, desc = "LSP Workspace Symbols" },
    { "<leader>fk", function() Snacks.picker.keymaps() end, desc = "Keymaps" },
    { "<leader>fd", function() Snacks.picker.pick("files", { root = false }) end, desc = "Find Files (cwd)" },

    -- Diagnostics
    { "<leader>dd", function() Snacks.picker.diagnostics() end, desc = "Diagnostics" },

     -- Git
    { "<leader>gg", function() Snacks.lazygit() end, desc = "LazyGit" },
    { "<leader>go", function() Snacks.gitbrowse() end, desc = "Git Browse", mode = { "n", "v" } },
    { "<leader>gB", function() Snacks.picker.git_branches() end, desc = "Git Branches" },
    { "<leader>gl", function() Snacks.picker.git_log() end, desc = "Git Log" },
    { "<leader>gL", function() Snacks.picker.git_log_line() end, desc = "Git Log Line" },
    { "<leader>gs", function() Snacks.picker.git_status() end, desc = "Git Status" },
    { "<leader>gS", function() Snacks.picker.git_stash() end, desc = "Git Stash" },
    { "<leader>gD", function() Snacks.picker.git_diff() end, desc = "Git Diff (Hunks)" },
    { "<leader>gf", function() Snacks.picker.git_log_file() end, desc = "Git Log File" },

    -- LSP
    { "gd", function() Snacks.picker.lsp_definitions() end, desc = "Goto Definition" },
    { "gD", function() Snacks.picker.lsp_declarations() end, desc = "Goto Declaration" },
    { "gr", function() Snacks.picker.lsp_references() end, nowait = true, desc = "References" },
    { "gi", function() Snacks.picker.lsp_implementations() end, desc = "Goto Implementation" },
    { "gt", function() snacks.picker.lsp_type_definitions() end, desc = "goto type definition" },

    -- Notifier
    { "<leader>n", function()
      if Snacks.config.picker and Snacks.config.picker.enabled then
        Snacks.picker.notifications()
      else
        Snacks.notifier.show_history()
      end
    end, desc = "Notification History" },
    { "<leader>un", function() Snacks.notifier.hide() end, desc = "Dismiss All Notifications" },

    -- UI
    { "<leader>uc", function() Snacks.picker.colorschemes() end, desc = "Colorschemes" },
   },
}
