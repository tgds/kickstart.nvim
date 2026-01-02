-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  {
    'pmizio/typescript-tools.nvim',
    dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
    ft = { 'typescript', 'typescriptreact', 'javascript', 'javascriptreact' },
    opts = {},
    config = function()
      require('typescript-tools').setup {}

      -- Add keymap for Go to Source Definition
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('typescript-tools-keymaps', { clear = true }),
        callback = function(event)
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.name == 'typescript-tools' then
            vim.keymap.set('n', 'grs', '<cmd>TSToolsGoToSourceDefinition<CR>', {
              buffer = event.buf,
              desc = 'LSP: [G]oto [S]ource Definition',
            })
          end
        end,
      })
    end,
  },
  {
    'rmagatti/auto-session',
    dependencies = { 'nvim-telescope/telescope.nvim' },
    opts = {
      auto_restore = true,
      auto_save = true,
      session_lens = {
        load_on_setup = true,
      },
    },
    config = function(_, opts)
      require('auto-session').setup(opts)

      -- Add keymap to search sessions
      vim.keymap.set('n', '<leader>sp', '<cmd>Telescope session-lens<CR>', { desc = '[S]earch Sessions ([P]rojects)' })
    end,
  },
}
