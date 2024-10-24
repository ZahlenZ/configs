return {
  {
    "ggandor/leap.nvim",
    enabled = true,
    keys = {
      { "s", mode = { "n", "x", "o" }, desc = "Leap Forward to" },
      { "S", mode = { "n", "x", "o" }, desc = "Leap Backward to" },
      { "gs", mode = { "n", "x", "o" }, desc = "Leap from Windows" },
    },
    config = function(_, opts)
      local leap = require("leap")
      for k, v in pairs(opts) do
        leap.opts[k] = v
      end
      leap.add_default_mappings(true)
      vim.keymap.del({ "x", "o" }, "x")
      vim.keymap.del({ "x", "o" }, "X")
      vim.api.nvim_set_hl(0, "LeapBackdrop", { link = "Comment" })
      vim.api.nvim_set_hl(0, "LeapLabel", {
        fg = "#c678dd",
        bold = true,
        nocombine = true,
      })
    end,
  },
  {
    "echasnovski/mini.pairs",
    version = false,
    config = function(_, opts)
      require("mini.pairs").setup()
    end,
  },
  {
    "echasnovski/mini.surround",
    version = false,
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      respect_selection_type = true,
      mappings = {
        add = "msa",
        delete = "msd",
        find = "msf",
        find_left = "msF",
        highlight = "msh",
        replace = "msr",
        update_n_lines = "msn",
        suffix_last = "ml",
        suffix_next = "mn",
      },
    },
    config = function(_, opts)
      require("mini.surround").setup(opts)
    end,
  },
  {
    "echasnovski/mini.splitjoin",
    version = false,
    event = { "BufReadPost", "BufNewFile" },
    config = function(_, opts)
      require("mini.splitjoin").setup()
    end,
  },
  {
    "echasnovski/mini.indentscope",
    version = false,
    event = { "BufReadPost", "BufNewFile" },
    config = function(_, opts)
      require("mini.indentscope").setup({
        draw = {
          delay = 15,
          animation = require("mini.indentscope").gen_animation.none(),
          try_as_border = true,
        },
      })
    end,
  },
  {
    "echasnovski/mini.comment",
    version = false,
    config = function(_, opts)
      require("mini.comment").setup({})
    end,
  },
  {
    "echasnovski/mini.move",
    version = false,
    config = function(_, otps)
      require("mini.move").setup({
        mappings = {
          left = "<M-h>",
          right = "<M-l>",
          down = "<M-j>",
          up = "<M-k>",
          line_left = "<M-h>",
          line_right = "<M-l>",
          line_down = "<M-j>",
          line_up = "<M-k>",
        },
      })
    end,
  },
  {
    "echasnovski/mini.ai",
    version = false,
    opts = {
      mappings = {
        around = "a",
        inside = "i",
        around_next = "an",
        inside_next = "in",
        around_last = "al",
        inside_last = "il",
        goto_left = "g[",
        goto_right = "g]",
      },
    },
    config = function(_, opts)
      require("mini.ai").setup(opts)
    end,
  },
  {
    "brenton-leighton/multiple-cursors.nvim",
    version = "*",
    opts = {
      pre_hook = function ()
        vim.g.minipairs_disable = true
      end,
      post_hook = function ()
        vim.g.minipairs_disable = false
      end,
    },
    keys = {
      {
        "<C-j>",
        "<Cmd>MultipleCursorsAddDown<CR>",
        mode = { "n", "x" },
        desc = "Add cursor and move down",
      },
      {
        "<C-k>",
        "<Cmd>MultipleCursorsAddUp<CR>",
        mode = { "n", "x" },
        desc = "Add cursor and move up",
      },
      {
        "<Leader>a",
        "<Cmd>MultipleCursorsAddMatches<CR>",
        mode = { "n", "x" },
        desc = "Add cursors to cword",
      },
      {
        "<Leader>A",
        "<Cmd>MultipleCursorsAddMatchesV<CR>",
        mode = { "n", "x" },
        desc = "Add cursors to cword in previous area",
      },
      {
        "<Leader>d",
        "<Cmd>MultipleCursorsAddJumpNextMatch<CR>",
        mode = { "n", "x" },
        desc = "Add cursor and jump to next cword",
      },
      {
        "<Leader>D",
        "<Cmd>MultipleCursorsJumpNextMatch<CR>",
        mode = { "n", "x" },
        desc = "Jump to next cword",
      },
      {
        "<Leader>l",
        "<Cmd>MultipleCursorsLock<CR>",
        mode = { "n", "x" },
        desc = "Lock virtual cursors",
      },
    },
  },
  {
    "jiaoshijie/undotree",
    dependencies = "nvim-lua/plenary.nvim",
    opts = {
      float_diff = false,
    },
    keys = { -- load the plugin only when using it's keybinding:
      { "<leader>u", "<cmd>lua require('undotree').toggle()<cr>" },
    },
    config = function (_, opts)
      require("undotree").setup(opts)
    end
  },
  {
    "tpope/vim-dotenv"
  }
}
