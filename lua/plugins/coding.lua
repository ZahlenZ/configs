-- the typing experience 
-- anything that makes the typing better
-- auto-completes, snippets, indents, pared brackets..
return {
  
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
    config = function(_, opts)
      require("mini.surround").setup()
    end,
  },
  {
    "echasnovski/mini.splitjoin",
    version = false,
    config = function(_, opts)
      require("mini.splitjoin").setup()
    end,
  },
  {
    "echasnovski/mini.indentscope",
    version = false,
    config = function(_, opts)
      require("mini.indentscope").setup({
        draw = {
          delay = 15,
          animation = require("mini.indentscope").gen_animation.none(),
          try_as_border = true,
        }
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
        }        
      })
    end,
  },
  {
    "brenton-leighton/multiple-cursors.nvim",
    version = "*",
    opts = {},
    keys = {
    {"<C-j>", "<Cmd>MultipleCursorsAddDown<CR>", mode = {"n", "x"}, desc = "Add cursor and move down"},
    {"<C-k>", "<Cmd>MultipleCursorsAddUp<CR>", mode = {"n", "x"}, desc = "Add cursor and move up"},
    {"<Leader>a", "<Cmd>MultipleCursorsAddMatches<CR>", mode = {"n", "x"}, desc = "Add cursors to cword"},
    {"<Leader>A", "<Cmd>MultipleCursorsAddMatchesV<CR>", mode = {"n", "x"}, desc = "Add cursors to cword in previous area"},
    {"<Leader>d", "<Cmd>MultipleCursorsAddJumpNextMatch<CR>", mode = {"n", "x"}, desc = "Add cursor and jump to next cword"},
    {"<Leader>D", "<Cmd>MultipleCursorsJumpNextMatch<CR>", mode = {"n", "x"}, desc = "Jump to next cword"},
    {"<Leader>l", "<Cmd>MultipleCursorsLock<CR>", mode = {"n", "x"}, desc = "Lock virtual cursors"},
    },

  }

}
