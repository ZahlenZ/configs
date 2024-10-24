return {

  { -- completion & snippet AIO
    "hrsh7th/nvim-cmp",
    version = false,
    event = "InsertEnter",
    dependencies = {
      { "hrsh7th/cmp-nvim-lsp" },
      { "hrsh7th/cmp-buffer" },
      { "hrsh7th/cmp-path" },
      -- snippet support
      { "L3MON4D3/LuaSnip" },
      { "saadparwaiz1/cmp_luasnip" },
      { "rafamadriz/friendly-snippets" },
      -- other completions
      { "ray-x/cmp-sql" },
      { "hrsh7th/cmp-nvim-lua" },
      { "KadoBOT/cmp-plugins" },
      -- { "ray-x/cmp-treesitter" },
      { "Saecki/crates.nvim" },
      {
        "vrslev/cmp-pypi",
        dependencies = { "nvim-lua/plenary.nvim" },
        ft = "toml",
      },
      -- { "Snikimonkd/cmp-go-pkgs" },
      { "onsails/lspkind-nvim" },
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      local lspkind = require("lspkind")

      cmp.setup({

        -- snippet support
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },

        -- completion setting
        completion = { completeopt = "menu,menuone,noinsert,noselect" },
        -- completion = { completeopt = "menu,menuone,noinsert" },
        preselect = cmp.PreselectMode.None,

        sorting = {
          comparators = {
            cmp.config.compare.score,
            cmp.config.compare.kind,
          }
        },

        -- ui
        view = {
          entries = {
            name = "custom",
            selection_order = "near_cursor",
            follow_cursor = true,
          },
          docs = {
            auto_open = false,
            maxwidth = function()
              return math.floor(0.10 * vim.o.columns)
            end,
          },
        },
        -- window = {
        --   completion = {
        --     border = require("util.style").border,
        --   },
        --   documentation = {
        --     border = require("util.style").border,
        --   },
        -- },

        -- keymaps
        mapping = cmp.mapping.preset.insert({
          ["<C-e>"] = cmp.mapping.abort(),
          ["<C-d>"] = cmp.mapping(function(fallback)
            if cmp.visible_docs() then
              cmp.mapping.scroll_docs(4)
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<C-u>"] = cmp.mapping(function(fallback)
            if cmp.visible_docs() then
              cmp.mapping.scroll_docs(-4)
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<C-n>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<C-p>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<C-y>"] = cmp.mapping.confirm({
            select = true,
          }),
          ["<C-l>"] = cmp.mapping(function(fallback)
            if luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<C-h>"] = cmp.mapping(function(fallback)
            if luasnip.expand_or_locally_jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<C-g>"] = cmp.mapping(function()
            if cmp.visible_docs() then
              cmp.close_docs()
            else
              cmp.open_docs()
            end
          end, { "i", "s" }),
        }),

        -- formatting
        ---@diagnostic disable-next-line: missing-fields
        formatting = {
          format = lspkind.cmp_format({
            mode = "symbol",
            menu = {
              luasnip = "[lsnip]",
              nvim_lsp = "[lsp]",
              path = "[pth]",
              buffer = "[buf]",
              nvim_lua = "[nlua]",
              plugins = "[plugs]",
              -- treesitter = "[tree]",
              crates = "[crate]",
              pypi = "[pypi]",
              -- go_pkgs = "[gopkg]",
              sql = "[sql]",
            },
            maxwidth = function()
              return math.floor(0.33 * vim.o.columns)
            end,
          }),
        },

        -- source config for completion
        sources = cmp.config.sources({
          {
            name = "luasnip",
          },
          {
            name = "nvim_lsp",
            keywork_length = 3,
          },
          {
            name = "path",
          },
          { name = "buffer", keyword_length = 2 },
          { name = "nvim_lua" },
          { name = "plugins" },
          -- { name = "treesitter", keyword_length = 2 },
          { name = "crates" },
          { name = "pypi", keyword_length = 2 },
          -- { name = "go_pkgs" },
        }),

        -- sql only in sql files
        cmp.setup.filetype({ "sql" }, {
          sources = cmp.config.sources({
            { name = "sql", keyword_length = 2 },
            { name = "nvim_lsp" },
            { name = "buffer" },
            { name = "path" },
            { name = "luasnip" },
          }),
        }),
      })

      require("luasnip.loaders.from_vscode").lazy_load()
    end,
  },
}
