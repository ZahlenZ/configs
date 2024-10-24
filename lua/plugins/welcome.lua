return {
  {
    "goolord/alpha-nvim",
    dependencies = {
      "echasnovski/mini.icons",
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      local alpha = require("alpha")
      local dashboard = require("alpha.themes.dashboard")
      local banner = require("util.banner")
      local config_path = "C:/Users/zzbinden/AppData/Local/nvim"
      local fortune = require("alpha.fortune")

      local function get_random_banner()
        math.randomseed(os.time())
        local index = math.random(1, #banner)
        return banner[index]
      end

      local logo = get_random_banner()
      logo = string.rep("\n", 8) .. logo .. "\n\n"

      dashboard.section.header.val = vim.split(logo, "\n")

      dashboard.section.buttons.val = {
        dashboard.button("f", "󰩉  Search Files", ":Telescope find_files<CR>"),
        dashboard.button("n", "  New File", ":ene <BAR> startinsert <CR>"),
        dashboard.button(
          "p",
          "󰑣  Open Project",
          ":lua require('telescope').extensions.project.project{} <CR>"
        ),
        dashboard.button("s", "󰡦  Sql", ":lua vim.cmd('bd!') vim.cmd('DBUI') <CR>"),
        dashboard.button(
          "c",
          "  Vim Config",
          ":lua vim.cmd('cd "
            .. config_path
            .. "') require('telescope.builtin').find_files({ cwd = '"
            .. config_path
            .. "' })<CR>"
        ),
        dashboard.button("q", "󰚦  Quit", ":qa<CR>"),
      }

      dashboard.section.footer.val = fortune()
      dashboard.section.footer.opts.hl = "keyword"
      dashboard.section.header.opts.hl = "keyword"

      alpha.setup(dashboard.opts)

      -- disable folding on alpha buffer
      vim.cmd([[
      autocmd FileType alpha setlocal nofoldenable
      ]])

      if vim.o.filetype == "lazy" then
        vim.api.nvim_create_autocmd("WinClosed", {
          pattern = tostring(vim.api.nvim_get_current_win()),
          once = true,
          callback = function()
            vim.schedule(function()
              if vim.o.filetype == "lazy" then
                vim.cmd("close")
              end
              require("alpha").start()
            end)
          end,
        })
      end
    end,
  },
}
