vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- butter movement
vim.keymap.set({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { noremap = true, silent = true, expr = true })
vim.keymap.set({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { noremap = true, silent = true, expr = true }) 
vim.keymap.set("n", "<C-d>", "<C-d>zz", { noremap = true, silent = true })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { noremap = true, silent = true })
vim.keymap.set("n", "j", "jzz", { noremap = true, silent = true })
vim.keymap.set("n", "k", "kzz", { noremap = true, silent = true })
vim.keymap.set("i", "jk", "<Esc>", { noremap = true, silent = true })

-- move lines
vim.keymap.set("n", "<A-j>", "<cmd>m .+1<cr>==", { noremap = true, silent = true })
vim.keymap.set("n", "<A-k>", "<cmd>m .-2<cr>==", { noremap = true, silent = true })

-- clear search <esc>
vim.keymap.set({ "i", "n" }, "<Esc>", "<cmd>noh<cr><Esc>", { noremap = true, silent = true })

-- do something with indenting 
-- should be able to highlight
-- spam < & > to move indent

-- diagnostic
local diagnostic_goto = function(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    go({ severity = severity })
  end
end
vim.keymap.set("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
vim.keymap.set("n", "]d", diagnostic_goto(true), { desc = "Next Diagnostic" })
vim.keymap.set("n", "[d", diagnostic_goto(false), { desc = "Prev Diagnostic" })
vim.keymap.set("n", "]e", diagnostic_goto(true, "ERROR"), { desc = "Next Error" })
vim.keymap.set("n", "[e", diagnostic_goto(false, "ERROR"), { desc = "Prev Error" })
vim.keymap.set("n", "]w", diagnostic_goto(true, "WARN"), { desc = "Next Warning" })
vim.keymap.set("n", "[w", diagnostic_goto(false, "WARN"), { desc = "Prev Warning" })

-- splits
vim.keymap.set("n", "<leader>|", "<C-w>v", { remap = true, silent = true , desc = "[|]Vertical Split" })
vim.keymap.set("n", "<leader>-", "<C-w>s", { remap = true, silent = true , desc = "[-]Horizontal Split" })
vim.keymap.set("n", "<leader>wd", "<C-w>c", { remap = true, silent = true , desc = "[W]indow [D]elete" })

-- im done
vim.keymap.set("n", "<leader>qq", "<cmd>qa<cr>", { desc = "[Q]uit [A]ll" })
