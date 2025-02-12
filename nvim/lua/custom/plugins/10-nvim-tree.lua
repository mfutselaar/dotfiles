return {
  'nvim-tree/nvim-tree.lua',
  version = '*',
  lazy = false,
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    require('nvim-tree').setup {
      sort = {
        sorter = 'case_sensitive',
      },
      view = {
        width = 40,
      },
      renderer = {
        group_empty = true,
      },
      filters = {
        dotfiles = false,
      },
    }

    vim.g.toggle_tree = function(cwd)
      local view = require 'nvim-tree.view'
      if view.is_visible() then
        vim.cmd ':NvimTreeClose'
        require('barbar.api').set_offset(0)
      else
        require('barbar.api').set_offset(31)

        if cwd then
          vim.cmd ':NvimTreeOpen %:h'
        else
          vim.cmd ':NvimTreeOpen'
        end
      end
    end

    vim.api.nvim_set_keymap('n', '<C-o>', ':lua vim.g.toggle_tree(false)<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<leader>o', ':lua vim.g.toggle_tree(true)<CR>', { noremap = true, silent = true })
  end,
}
