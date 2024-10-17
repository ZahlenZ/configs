return {

  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = {
      install = {
        prefer_git = false,
        compilers = { "zig", "clang" }
      },
      auto_install = true,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      indent = {
        enable = true
      },
    },
    config = function(_, opts)
      require("nvim-treesitter.install").compilers = { "zig", "clang" }
      require("nvim-treesitter.install").prefer_git = false
      require("nvim-treesitter.configs").setup(opts)
    end,
  },

}

