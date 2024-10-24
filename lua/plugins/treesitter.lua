return {

  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    main = "nvim-treesitter.configs",
    config = function()
      require("nvim-treesitter.install").compilers = { "zig", "clang" }
      require("nvim-treesitter.install").prefer_git = false
      ---@diagnostic disable-next-line:missing-fields
      require("nvim-treesitter.configs").setup({
        auto_install = true,
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false, -- might need this
        },
        indent = {
          enable = true,
          disable = { "python", "go" },
        },
      })
    end,
  },
}
