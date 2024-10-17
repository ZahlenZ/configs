return {

  {
    "folke/tokyonight.nvim",
    lazy = false,
    prriority = 1000,
    opts = {
      transparent = true,
      style = "night"
    },
    config = function(_, opts)
      require("tokyonight").setup(opts)
      vim.cmd.colorscheme("tokyonight-night")
    end,
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      term_colors = true,
      transparent_background = true,
    },
    config = function(_, opts)
      require("catppuccin").setup(opts)
      -- vim.cmd.colorscheme("catppuccin-mocha")
    end,
  },
  {
    "rebelot/kanagawa.nvim",
    name = "rebelot",
    priority = 1000,
    opts = {
      transparent = true,
      colors = {
        theme = {
          all = {
            ui = {
              bg_gutter = "none"
            },
          },
        },
      },
    overrides = function(colors)
      local theme = colors.theme
      return {
        TelescopeTitle = { fg = theme.ui.special, bold = true },
        TelescopePromptNormal = { bg = "none" },
        TelescopePromptBorder = { fg = theme.ui.fg_dim, bg = "none" },
        TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = "none" },
        TelescopeResultsBorder = { fg = theme.ui.fg_dim, bg = "none" },
        TelescopePreviewNormal = { bg = "none" },
        TelescopePreviewBorder = { fg = theme.ui.fg_dim, bg = "none" },
      }
    end,
    },
    config = function(_, opts)
      require("kanagawa").setup(opts)
      -- vim.cmd.colorscheme("kanagawa-wave")
    end,
  },
  {
    "navarasu/onedark.nvim",
    name = "onedark",
    priority = 1000,
    opts = {
      style = "deep",
      transparent = true
    },
    config = function(_, opts)
      -- require("onedark").setup(opts)
      -- require("onedark").load()
    end,
  }

}

