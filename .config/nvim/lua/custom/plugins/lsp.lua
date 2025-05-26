return {
  {
    'folke/lazydev.nvim',
    ft = 'lua',
  },
  {
    'jparise/vim-graphql',
    lazy = false,
  },
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      {
        'williamboman/mason.nvim',
        config = true,
        keys = {
          { '<leader>m', '<cmd>Mason<cr>', desc = 'Mason' },
        },
      },
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      { 'j-hui/fidget.nvim', opts = {} },
    },
    lazy = false,
    config = function()
      -- Set up LspAttach autocommand for keybindings and dynamic features
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc, mode)
            vim.keymap.set(mode or 'n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          local client = vim.lsp.get_client_by_id(event.data.client_id)

          if client then
            if client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
              local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
              vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
                buffer = event.buf,
                group = highlight_augroup,
                callback = vim.lsp.buf.document_highlight,
              })
              vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
                buffer = event.buf,
                group = highlight_augroup,
                callback = vim.lsp.buf.clear_references,
              })
              vim.api.nvim_create_autocmd('LspDetach', {
                group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
                callback = function(event2)
                  vim.lsp.buf.clear_references()
                  vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
                end,
              })
            end

            if client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
              map('<leader>uh', function()
                vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
              end, 'Toggle inlay hints')
            end
          end

          map('<leader>cr', vim.lsp.buf.rename, 'Rename')
          map('<leader>ca', vim.lsp.buf.code_action, 'Code action', { 'n', 'x' })
        end,
      })

      -- Get enhanced capabilities (e.g., from cmp-nvim)
      local capabilities = require('blink.cmp').get_lsp_capabilities()

      -- Setup Mason and Mason LSP
      local mason = require 'mason'
      local mason_lspconfig = require 'mason-lspconfig'

      mason.setup()

      mason_lspconfig.setup {
        ensure_installed = { 'lua_ls', 'vtsls' },
        automatic_installation = true,
      }

      -- Safely setup handlers
      if mason_lspconfig.setup_handlers then
        mason_lspconfig.setup_handlers {
          function(server_name)
            require('lspconfig')[server_name].setup {
              capabilities = capabilities,
              autostart = true,
            }
          end,
        }
      else
        -- Fallback in case setup_handlers is not available
        local servers = { 'lua_ls', 'vtsls' }
        for _, server_name in ipairs(servers) do
          require('lspconfig')[server_name].setup {
            capabilities = capabilities,
            autostart = true,
          }
        end
      end
    end,
  },
}
