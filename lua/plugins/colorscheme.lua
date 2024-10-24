return {

  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      term_colors = true,
      transparent_background = true,
      integrations = {
        mini = {
          enabled = true,
        },
        treesitter = true,
        alpha = true,
        leap = true,
        mason = true,
        noice = true,
        notify = true,
        dadbod_ui = true,
        barbar = true,
      },
    },
    config = function(_, opts)
      require("catppuccin").setup(opts)
      vim.cmd.colorscheme("catppuccin-mocha")
    end,
  },
  {
    "rebelot/kanagawa.nvim",
    name = "rebelot",
    lazy = false,
    priority = 1000,
    opts = {
      transparent = true,
      colors = {
        theme = { all = { ui = { bg_gutter = "none" }}}
      }
    },
    config = function (_, opts)
      require("kanagawa").setup(opts)
    end
  },
  {
    "ribru17/bamboo.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      transparent = true,
      term_colors = true,
    },
    config = function (_, opts)
      require("bamboo").setup(opts)
    end
  }
  -- {
  --   "cpea2506/one_monokai.nvim",
  --   lazy = false,
  --   priority = 1000,
  --   enable = false,
  --   opts = {
  --     transparent = true,
  --     colors = {
  --       w_string = "#e3b341",
  --       w_blue = "#4a90e2",
  --       w_green = "#5fee9b",
  --       w_greenAlt = "#A4EF58",
  --       w_orange = "#ffae82",
  --       w_pink = "#fda7f7",
  --       w_purple = "#c39eff",
  --       w_red = "#f7775a",
  --       w_salmon = "#ff8ea0",
  --       w_turquoize = "#44f8e9",
  --       w_yellow = "#ffdb4a",
  --       -- w_yellow = "#fce38a",
  --       w_danger = "#f7775a",
  --       w_info = "#8ad0ff",
  --       w_success = "#5fee9b",
  --       w_warning = "#ffae82",
  --       w_border = "#000000",
  --       w_default = "#bdb6d3",
  --       w_defaultMain = "#bfb9da",
  --       w_defaultalt = "#585775",
  --       w_primary = "#b498f5",
  --       w_primaryalt = "#231e36",
  --       w_uibackground = "#14111f",
  --       w_uibackgroundalt = "#0d0a14",
  --       w_uibackgroundmid = "#100e1a",
  --       w_autocomp_bg = "#181526",
  --       w_autocomp_sel = "#292340",
  --       w_variable_member = "#00CCA1",
  --       w_aqua = "#61afef",
  --     },
  --     themes = function(colors)
  --       return {
  --
  --         -- ui
  --         CursorLine = { bg = colors.w_defaultalt:darken(0.50) },
  --         Pmenu = { bg = colors.w_autocomp_bg },
  --         PmenuSel = { bg = colors.w_defaultalt },
  --         -- this does the float for signature help on completion
  --         -- NormalFloat = { bg = colors.w_defaultalt },
  --
  --
  --         -- syntax
  --         Delimiter = { fg = colors.w_aqua },
  --         Keyword = { fg = colors.w_purple },
  --         Function = { fg = colors.w_turquoize },
  --         Identifier = { fg = colors.w_salmon },
  --         Include = { fg = colors.w_pink },
  --         Statement = { fg = colors.w_yellow },
  --         String = { fg = colors.w_string },
  --         Type = { fg = colors.w_purple },
  --
  --         -- treesitter
  --         ["@variable"] = { fg = colors.w_salmon },
  --         ["@variable.builtin"] = { fg = colors.w_variable_member, italic = true },
  --         ["@variable.member"] = { fg = colors.w_variable_member },
  --         ["@variable.parameter"] = { fg = colors.w_variable_member },
  --         ["@variableparameter.builtin"] = { fg = colors.w_variable_member },
  --
  --         ["@constant"] = { fg = colors.w_red },
  --         ["@constant.builtin"] = { fg = colors.w_red },
  --         ["@constant.macro"] = { fg = colors.w_red },
  --
  --         ["@module"] = { fg = colors.w_pink },
  --         ["@module.builtin"] = { link = "@module" },
  --         ["@label"] = { link = "@module" },
  --
  --         ["@string"] = { fg = colors.w_string },
  --         ["@string.documentation"] = { fg = colors.w_string:darken(0.40), italic = true },
  --         ["@string.regexp"] = { link = "String" },
  --         ["@string.escape"] = { link = "SpecialChar" },
  --         ["@string.special"] = { link = "Special" },
  --         ["@string.special.symbol"] = { link = "Identifier" },
  --         ["@string.special.url"] = { fg = colors.aqua, undercurl = true },
  --         ["@string.special.path"] = { fg = colors.aqua, undercurl = true },
  --
  --         ["@character"] = { fg = colors.w_red },
  --         ["@character.special"] = { link = "SpecialChar" },
  --
  --         ["@boolean"] = { fg = colors.w_aqua },
  --         ["@number"] = { link = "Number" },
  --         ["@number.float"] = { link = "Float" },
  --
  --         ["@type"] = { fg = colors.w_orange },
  --         ["@type.builtin"] = { fg = colors.w_orange },
  --         ["@type.definition"] = { fg = colors.w_orange },
  --
  --         ["@attribute"] = { link = "Type" },
  --         ["@attribute.bultin"] = { link = "@attribute" },
  --         ["@property"] = { link = "Identifier" },
  --
  --         ["@function"] = { link = "Function" },
  --         ["@function.builtin"] = { link = "Function" },
  --         ["@function.call"] = { link = "Function" },
  --         ["@function.macro"] = { link = "Macro" },
  --
  --         ["@function.method"] = { link = "Function" },
  --         ["@function.method.call"] = { link = "Function" },
  --
  --         ["@constructor"] = { fg = colors.aqua },
  --         ["@operator"] = { fg = colors.w_red },
  --
  --         ["@keyword"] = { link = "Keyword"},
  --         ["@keyword.function"] = { link = "Keyword"},
  --         ["@keyword.import"] = { link = "Keyword"},
  --         ["@keyword.operator"] = { link = "Keyword"},
  --         ["@keyword.coroutine"] = { link = "Keyword"},
  --         ["@keyword.type"] = { link = "Keyword"},
  --         ["@keyword.modifier"] = { link = "Keyword"},
  --         ["@keyword.repeat"] = { link = "Keyword"},
  --         ["@keyword.return"] = { link = "Keyword"},
  --         ["@keyword.debug"] = { link = "Keyword"},
  --         ["@keyword.exception"] = { link = "Keyword"},
  --
  --         ["@keyword.conditional"] = { link = "Conditional" },
  --         ["@keyword.conditional.ternary"] = { link = "Conditional" },
  --
  --         ["@keyword.directive"] = { link = "PreProc" },
  --         ["@keyword.directive.define"] = { link = "@keyword.directive" },
  --
  --         ["@punctuation.delimiter"] = { link = "Delimiter" },
  --         ["@punctuation.bracket"] = { link = "Delimiter" },
  --         ["@punctuation.special"] = { link = "Delimiter" },
  --
  --         ["@comment"] = { link = "Comment" },
  --         ["@comment.error"] = { link = "ErrorMsg" },
  --         ["@comment.hint"] = { link = "SpecialComment" },
  --         ["@comment.todo"] = { link = "Todo" },
  --         ["@comment.warning"] = { link = "WarningMsg" },
  --
  --         ["@markup.strong"] = { bold = true },
  --         ["@markup.italic"] = { italic = true },
  --         ["@markup.strikethrough"] = { strikethrough = true },
  --         ["@markup.underline"] = { underline = true },
  --
  --         ["@markup.heading"] = { link = "Title" },
  --
  --         ["@markup.math"] = { link = "Special" },
  --
  --         ["@markup.link"] = { link = "Constant" },
  --         ["@markup.link.label"] = { link = "SpecialChar" },
  --         ["@markup.link.url"] = { fg = colors.aqua, undercurl = true },
  --
  --         ["@markup.raw"] = { link = "String" },
  --
  --         ["@markup.list"] = { link = "Delimiter" },
  --         ["@markup.list.checked"] = { fg = colors.green },
  --         ["@markup.list.unchecked"] = { fg = colors.pink },
  --
  --         ["@tag"] = { link = "Label" },
  --         ["@tag.attribute"] = { link = "Identifier" },
  --         ["@tag.delimiter"] = { link = "Delimiter" },
  --
  --         ["@none"] = {},
  --
  --         -- semantic tokens
  --         -- ["@lsp.mod.deprecated"] = { fg = colors.light_gray, strikethrough = true },
  --         -- ["@lsp.mod.documentation"] = { link = "Constant" },
  --         -- ["@lsp.type.class"] = { link = "Type" },
  --         -- ["@lsp.type.comment"] = { link = "Comment" },
  --         -- ["@lsp.type.enum"] = { link = "Type" },
  --         -- ["@lsp.type.enumMember"] = { link = "Constant" },
  --         -- ["@lsp.type.function"] = { link = "Function" },
  --         -- ["@lsp.type.macro"] = { link = "Function" },
  --         -- ["@lsp.type.method"] = { link = "Function" },
  --         -- ["@lsp.type.number"] = { link = "Number" },
  --         -- ["@lsp.type.operator"] = { link = "Operator" },
  --         -- ["@lsp.type.parameter"] = { fg = colors.orange, italic = true },
  --         -- ["@lsp.type.property"] = { link = "Identifier" },
  --         -- ["@lsp.type.string"] = { link = "String" },
  --         -- ["@lsp.type.struct"] = { link = "Type" },
  --         -- ["@lsp.type.typeParameter"] = { link = "Type" },
  --         -- ["@lsp.type.xmlDocCommentName"] = { fg = colors.pink },
  --         -- ["@lsp.type.xmlDocCommentAttributeQuotes"] = { fg = colors.yellow },
  --         -- ["@lsp.type.xmldoccommentattributename"] = { fg = colors.green },
  --
  --         ["@lsp.mod.deprecated"] = {},
  --         ["@lsp.mod.documentation"] = {},
  --         ["@lsp.type.class"] = {},
  --         ["@lsp.type.comment"] = {},
  --         ["@lsp.type.enum"] = {},
  --         ["@lsp.type.enumMember"] = {},
  --         ["@lsp.type.function"] = {},
  --         ["@lsp.type.macro"] = {},
  --         ["@lsp.type.method"] = {},
  --         ["@lsp.type.number"] = {},
  --         ["@lsp.type.operator"] = {},
  --         ["@lsp.type.parameter"] = {},
  --         ["@lsp.type.property"] = {},
  --         ["@lsp.type.string"] = {},
  --         ["@lsp.type.struct"] = {},
  --         ["@lsp.type.typeParameter"] = {},
  --         ["@lsp.type.xmlDocCommentName"] = {},
  --         ["@lsp.type.xmlDocCommentAttributeQuotes"] = {},
  --         ["@lsp.type.xmldoccommentattributename"] = {},
  --       }
  --     end,
  --   },
  --   config = function(_, opts)
  --     require("one_monokai").setup(opts)
  --     vim.cmd.colorscheme("one_monokai")
  --   end,
  -- },
}
