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
    opts = {
      mappings = {
        add = "msa",
        delete = "msd",
        find = "msf",
        find_left = "msF",
        highlight = "msh",
        replace = "msr",
        update_n_lines = "msn",
        suffix_last = "ml",
        suffix_next = "mn"
      }
    },
    config = function(_, opts)
      require("mini.surround").setup(opts)
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
      { "<C-j>",     "<Cmd>MultipleCursorsAddDown<CR>",          mode = { "n", "x" }, desc = "Add cursor and move down" },
      { "<C-k>",     "<Cmd>MultipleCursorsAddUp<CR>",            mode = { "n", "x" }, desc = "Add cursor and move up" },
      { "<Leader>a", "<Cmd>MultipleCursorsAddMatches<CR>",       mode = { "n", "x" }, desc = "Add cursors to cword" },
      { "<Leader>A", "<Cmd>MultipleCursorsAddMatchesV<CR>",      mode = { "n", "x" }, desc = "Add cursors to cword in previous area" },
      { "<Leader>d", "<Cmd>MultipleCursorsAddJumpNextMatch<CR>", mode = { "n", "x" }, desc = "Add cursor and jump to next cword" },
      { "<Leader>D", "<Cmd>MultipleCursorsJumpNextMatch<CR>",    mode = { "n", "x" }, desc = "Jump to next cword" },
      { "<Leader>l", "<Cmd>MultipleCursorsLock<CR>",             mode = { "n", "x" }, desc = "Lock virtual cursors" },
    },

  },
  { -- completion
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-calc",
      "hrsh7th/cmp-emoji",
      "saadparwaiz1/cmp_luasnip",
      "f3fora/cmp-spell",
      "ray-x/cmp-treesitter",
      "kdheepak/cmp-latex-symbols",
      "jmbuhr/cmp-pandoc-references",
      "L3MON4D3/LuaSnip",
      "rafamadriz/friendly-snippets",
      "onsails/lspkind-nvim",
      "jmbuhr/otter.nvim",
    },
    config = function()
      local cmp = require "cmp"
      local luasnip = require "luasnip"
      local lspkind = require "lspkind"

      local has_words_before = function()
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
      end

      cmp.setup {
        -- snippet = {
        --   expand = function(args)
        --     luasnip.lsp_expand(args.body)
        --   end,
        -- },
        completion = { completeopt = "menu,menuone,noinsert,noselect" },
        mapping = {
          ["<C-f>"] = cmp.mapping.scroll_docs(-4),
          ["<C-d>"] = cmp.mapping.scroll_docs(4),
          ["<C-n>"] = cmp.mapping(function(fallback)
            if luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
              fallback()
            end
          end, { "i", "s" }),
          ["<C-p>"] = cmp.mapping(function(fallback)
            if luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<c-y>"] = cmp.mapping.confirm {
            select = true,
          },
          ["<CR>"] = cmp.mapping.confirm {
            select = true,
          },
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif has_words_before() then
              cmp.complete()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<C-l>"] = cmp.mapping(function()
            if luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            end
          end, { "i", "s" }),
          ["<C-h>"] = cmp.mapping(function()
            if luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            end
          end, { "i", "s" }),
        },
        autocomplete = false,

        ---@diagnostic disable-next-line: missing-fields
        formatting = {
          format = lspkind.cmp_format {
            mode = "symbol",
            menu = {
              otter = "[🦦]",
              nvim_lsp = "[LSP]",
              nvim_lsp_signature_help = "[sig]",
              luasnip = "[snip]",
              buffer = "[buf]",
              path = "[path]",
              spell = "[spell]",
              pandoc_references = "[ref]",
              tags = "[tag]",
              treesitter = "[TS]",
              calc = "[calc]",
              latex_symbols = "[tex]",
              emoji = "[emoji]",
            },
          },
        },
        sources = {
          { name = "otter" }, -- for code chunks in quarto
          { name = "path" },
          { name = "nvim_lsp_signature_help" },
          { name = "nvim_lsp" },
          { name = "luasnip",                keyword_length = 3, max_item_count = 3 },
          { name = "pandoc_references" },
          { name = "buffer",                 keyword_length = 5, max_item_count = 3 },
          { name = "spell" },
          { name = "treesitter",             keyword_length = 5, max_item_count = 3 },
          { name = "calc" },
          { name = "latex_symbols" },
          { name = "emoji" },
        },
        view = {
          entries = {
            name = "custom",
            selection_order = "near_cursor"
          }
        },
        window = {
          completion = {
            border = require("util.style").border,
          },
          -- documentation = {
          --   enable = false,
          --   border = require("util.style").border,
          -- },
        },
      }
      -- for friendly snippets
      require("luasnip.loaders.from_vscode").lazy_load()
      -- for custom snippets
      require("luasnip.loaders.from_vscode").lazy_load { paths = { vim.fn.stdpath "config" .. "/snips" } }
      -- link quarto and rmarkdown to markdown snippets
      luasnip.filetype_extend("quarto", { "markdown" })
      luasnip.filetype_extend("rmarkdown", { "markdown" })
    end,
  },

}
