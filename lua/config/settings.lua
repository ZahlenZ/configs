-- screen
vim.opt.termguicolors = true
vim.opt.virtualedit = "block" -- cursor to move where there is no text in vis mode
vim.opt.wildmode = "longest:full,full" -- CMD Line completion
vim.opt.cmdheight = 1 -- hide CMD Line when not used
vim.opt.showtabline = 0 -- no tabs
vim.opt.number = true
vim.opt.relativenumber = true

-- popups
vim.opt.pumblend = 10
vim.opt.pumheight = 10

-- cursor stuff
vim.opt.clipboard = vim.env.SSH_TTY and "" or "unnamedplus"
vim.opt.cursorline = true
vim.opt.scrolloff = 3
vim.opt.sidescrolloff = 8

-- status & gutter 
-- lazyvim has a whole status column util
-- puts line numbers in order and such /shrug? kewl?
vim.opt.showmode = false
vim.opt.signcolumn = "yes:1"
vim.opt.laststatus = 3
vim.opt.ruler = false

-- diagnostics
vim.diagnostic.config {
  virtual_text = true,
  underline = true,
  signs = true,
}

-- search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- automagic comments
vim.opt.formatoptions:remove "c"
vim.opt.formatoptions:remove "r"
vim.opt.formatoptions:remove "o"

-- splits
vim.opt.splitbelow = true
vim.opt.splitright = true

-- indents
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true 
vim.opt.shiftround = true 
vim.opt.smartindent = true 

vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "json",
    "yaml",
    "html",
    "css",
    "scss",
    "lua",
    "dart",
    "elixier",
    "r",
    "qmd",
    "rmd",
    "md",
  },
  callback = function()
    vim.bo.tabstop = 2
    vim.bo.shiftwidth = 2
    vim.bo.expandtab = true
    vim.bo.formatoptions = vim.bo.formatoptions:gsub("[cro]", "")
  end,
})

-- wraps
vim.opt.wrap = false
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown", "qmd", "rmd", "ipynb", },
  callback = function()
    vim.opt.wrap = true
  end,
})

-- folds
vim.opt.fillchars = {
  foldopen = "",
  foldclose = "",
  fold = " ",
  foldsep = " ",
  diff = "╱",
  eob = " ",
}

vim.opt.foldlevel = 99
