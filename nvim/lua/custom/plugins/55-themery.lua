return {
  'zaldih/themery.nvim',
  lazy = false,
  config = function()
    require('themery').setup {
      globalBefore = [[
        vim.opt.background = "dark"
      ]],
      themes = {
        {
          name = 'Palenight',
          colorscheme = 'palenight',
        },
        {
          name = 'Sonokai',
          colorscheme = 'sonokai',
        },
        {
          name = 'Kanagawa Wave',
          colorscheme = 'kanagawa-wave',
        },
        {
          name = 'Kanagawa Dragon',
          colorscheme = 'kanagawa-dragon',
        },
        {
          name = 'Tokyonight Night',
          colorscheme = 'tokyonight-night',
        },
        {
          name = 'Tokyonight Storm',
          colorscheme = 'tokyonight-storm',
        },
        {
          name = 'Tokyonight Moon',
          colorscheme = 'tokyonight-moon',
        },
        {
          name = 'Catppuccin Frappe',
          colorscheme = 'catppuccin-frappe',
        },
        {
          name = 'Catppuccin Macchiato',
          colorscheme = 'catppuccin-macchiato',
        },
        {
          name = 'Catppuccin Mocha',
          colorscheme = 'catppuccin-mocha',
        },
      },
    }
  end,
}
