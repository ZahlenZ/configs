-- ui things
-- harpoon, telescope, notify, bufferline, lualine, noice, dashboard
return {

  {
    "nvim-telescope/telescope.nvim",
    event = "VimEnter",
    branch = "0.1.x",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release",
        cond = function()
          return vim.fn.executable("make") == 1
        end,
      },
      { "nvim-telescope/telescope-ui-select.nvim" },
      { "nvim-tree/nvim-web-devicons" },
      { "nvim-telescope/telescope-project.nvim" },
    },
    config = function()
      local actions = require("telescope.actions")
      require("telescope").setup({
        defaults = {
          prompt_prefix = " ",
          selection_caret = " ",
        },
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown(),
          },
          ["project"] = {
            base_dirs = {
              { path = "~/source/repos", max_depth = 5 },
            },
            theme = "dropdown",
          },
        },
      })

      pcall(require("telescope").load_extension, "fzf")
      pcall(require("telescope").load_extension, "ui-select")
      pcall(require("telescope").load_extension, "project")

      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
      vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
      vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
      vim.keymap.set(
        "n",
        "<leader>sg",
        builtin.git_files,
        { desc = "[S]earch [G]it file" }
      )
      vim.keymap.set(
        "n",
        "<leader>sd",
        builtin.diagnostics,
        { desc = "[S]earch [D]iagnostics" }
      )
      vim.keymap.set("n", "<leader>sl", builtin.live_grep, { desc = "[S]earch [L]ive" })
      vim.keymap.set(
        "n",
        "<leader>sc",
        builtin.colorscheme,
        { desc = "[S]earch [C]olors" }
      )

      vim.keymap.set("n", "<leader>/", function()
        builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
          winblend = 10,
          previewer = false,
        }))
      end, { desc = "[/] Fuzzily search in current buffer" })

      vim.keymap.set(
        "n",
        "<leader>sp",
        ":lua require('telescope').extensions.project.project{ display_type = 'minimal' }<CR>",
        { noremap = true, silent = true, desc = "[S]earch [P]rojects" }
      )
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      { "nvim-tree/nvim-web-devicons" },
    },
    config = function()
      local function get_time()
        return " " .. os.date("%R")
      end
      require("lualine").setup({
        options = {
          theme = "catppuccin-mocha",
          component_separators = "",
          section_separators = { left = "", right = "" },
        },
        sections = {
          lualine_a = { { "mode", separator = { left = "" }, right_padding = 2 } },
          lualine_b = { "filename", "branch" },
          lualine_c = {
            "%=",
            {
              require("noice").api.status.mode.get,
              cond = require("noice").api.status.mode.has,
            },
          },
          lualine_x = { "%=" },
          lualine_y = { "filetype", "location" },
          lualine_z = { { get_time, separator = { right = "" }, left_padding = 2 } },
        },
        tabline = {},
        extensions = {},
      })
    end,
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "rcarriga/nvim-notify",
    },
    opts = {
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      routes = {
        -- {
        --   filter = {
        --     event = "msg_show",
        --     kind = "",
        --     find = "written",
        --   },
        --   opts = { skip = true },
        -- },
        {
          filter = {
            event = "msg_show",
            any = {
              { find = "%d+L, %d+B" },
              { find = "; after #%d+" },
              { find = "; before #%d+" },
            },
          },
        },
      },
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
      },
    },
    keys = {
      { "<leader>sn", "", desc = "+noice" },
      {
        "<S-Enter>",
        function()
          require("noice").redirect(vim.fn.getcmdline())
        end,
        mode = "c",
        desc = "Redirect Cmdline",
      },
      {
        "<leader>snl",
        function()
          require("noice").cmd("last")
        end,
        desc = "Noice Last Message",
      },
      {
        "<leader>snh",
        function()
          require("noice").cmd("history")
        end,
        desc = "Noice History",
      },
      {
        "<leader>sna",
        function()
          require("noice").cmd("all")
        end,
        desc = "Noice All",
      },
      {
        "<leader>snd",
        function()
          require("noice").cmd("dismiss")
        end,
        desc = "Dismiss All",
      },
      {
        "<leader>snt",
        function()
          require("noice").cmd("pick")
        end,
        desc = "Noice Picker (Telescope/FzfLua)",
      },
      {
        "<c-f>",
        function()
          if not require("noice.lsp").scroll(4) then
            return "<c-f>"
          end
        end,
        silent = true,
        expr = true,
        desc = "Scroll Forward",
        mode = { "i", "n", "s" },
      },
      {
        "<c-b>",
        function()
          if not require("noice.lsp").scroll(-4) then
            return "<c-b>"
          end
        end,
        silent = true,
        expr = true,
        desc = "Scroll Backward",
        mode = { "i", "n", "s" },
      },
    },
    config = function(_, opts)
      if vim.o.filetype == "lazy" then
        vim.cmd([[messages clear]])
      end
      require("noice").setup(opts)
      ---@diagnostic disable-next-line: missing-fields
      require("notify").setup({
        background_colour = "#000000",
      })
    end,
  },
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
    },
    config = function(_, opts)
      local harpoon = require("harpoon")
      harpoon:setup()

      vim.keymap.set("n", "<leader>ha", function()
        harpoon:list():add()
      end)
      vim.keymap.set("n", "<leader>hl", function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end)
      vim.keymap.set("n", "<leader>hn", function()
        harpoon:list():next()
      end)
      vim.keymap.set("n", "<leader>hp", function()
        harpoon:list():prev()
      end)
    end,
  },
  {
    "stevearc/oil.nvim",
    dependencies = {
      { "echasnovski/mini.icons", opts = {} },
    },
    opts = {},
    config = function(_, opts)
      require("oil").setup()
      vim.keymap.set("n", "-", "<cmd>Oil<CR>", { desc = "Open Oil" })
    end,
  },
  {
    "romgrk/barbar.nvim",
    dependencies = {
      { "nvim-tree/nvim-web-devicons" },
    },
    init = function() vim.g.barbar_auto_setup = false end,
    opts = {},
    config = function (_, opts)
      require("barbar").setup(opts)
      vim.keymap.set("n", "<leader>bh", "<cmd>BufferPrevious<cr>", { noremap = true, silent = true, desc = "[B]uffer [P]revious" })
      vim.keymap.set("n", "<leader>bl", "<cmd>BufferNext<cr>", { noremap = true, silent = true, desc = "[B]uffer [N]ext" })
      vim.keymap.set("n", "<leader>bp", "<cmd>BufferPick<cr>", { noremap = true, silent = true, desc = "[B]uffer [P]ick" })
      vim.keymap.set("n", "<leader>bc", "<cmd>BufferClose<cr>", { noremap = true, silent = true, desc = "[B]uffer [C]lose" })
    end
  }
}
