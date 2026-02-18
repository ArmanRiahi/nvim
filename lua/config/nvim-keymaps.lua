--Vim keymaps

-- Move between windows (normal mode)
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left pane" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right pane" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to below pane" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to upper pane" })

-- Move between windows (terminal mode)
vim.keymap.set("t", "<C-h>", [[<C-\><C-n><C-w>h]], { desc = "Terminal: left" })
vim.keymap.set("t", "<C-l>", [[<C-\><C-n><C-w>l]], { desc = "Terminal: right" })
vim.keymap.set("t", "<C-j>", [[<C-\><C-n><C-w>j]], { desc = "Terminal: down" })
vim.keymap.set("t", "<C-k>", [[<C-\><C-n><C-w>k]], { desc = "Terminal: up" })

-- Save file with Ctrl+S in normal, insert, and visual modes
vim.keymap.set("n", "<C-s>", "<cmd>w<CR>", { desc = "Save file" })
vim.keymap.set("n", "<leader>sn>", "<cmd>w<CR>", { desc = "Save file without formatting" })

-- Select all text
-- vim.keymap.set("n", "<C-a>", "GVgg", { desc = "Select all text" })

-- Quit file
vim.keymap.set("n", "<C-q>", "<cmd>q<CR>", { desc = "Quit file" })

-- OPTIONAL: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Resize splits using Ctrl + arrow keys
vim.keymap.set("n", "<C-Up>", "<cmd>resize +2<CR>", { desc = "Increase window height" })
vim.keymap.set("n", "<C-Down>", "<cmd>resize -2<CR>", { desc = "Decrease window height" })
vim.keymap.set("n", "<C-Left>", "<cmd>vertical resize -2<CR>", { desc = "Decrease window width" })
vim.keymap.set("n", "<C-Right>", "<cmd>vertical resize +2<CR>", { desc = "Increase window width" })

-- Better window navigation
vim.keymap.set("n", "<C-h>", ":wincmd h<cr>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", ":wincmd l<cr>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", ":wincmd j<cr>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", ":wincmd k<cr>", { desc = "Move focus to the upper window" })

vim.keymap.set("n", "<leader>tc", ":tabnew<cr>", { desc = "[T]ab [C]reat New" })
vim.keymap.set("n", "<leader>tn", ":tabnext<cr>", { desc = "[T]ab [N]ext" })
vim.keymap.set("n", "<leader>tp", ":tabprevious<cr>", { desc = "[T]ab [P]revious" })

-- Window Management
vim.keymap.set("n", "<leader>v", "<C-w>v", { desc = "split window vertically" })
vim.keymap.set("n", "<leader>h", "<C-w>s", { desc = "split window horizontally" })
vim.keymap.set("n", "<leader>se", "<C-w>=", { desc = "make windows equal width" })

-- Open Terminal
vim.keymap.set("n", "<leader>t", function()
	vim.cmd("vsplit") -- Create vertical split (opens on the left by default)
	vim.cmd("wincmd l") -- Move to the new right window
	vim.cmd("terminal") -- Open terminal
	vim.cmd("startinsert") -- Start in insert mode
end, { noremap = true, silent = true, desc = "Open terminal on the right" })

-- Remove search highlights after searching
vim.keymap.set("n", "<leader>rsh", "<cmd>nohlsearch<CR>", { desc = "Remove searching highlights" })

-- Exit vim's terminal mode
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Stay in indent mode
vim.keymap.set("v", "<", "<gv", { desc = "Indent left in visual mode" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent right in visual mode" })

-- Move current line or selected line down
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv+gv", {desc = "Move selected line down"})
vim.keymap.set("n", "<A-j>", ":m +1<CR>==", {desc = "Move curren line down"})

-- Move current line or selected line up
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv+gv", {desc = "Move selected line up"})
vim.keymap.set("n", "<A-k>", ":m -2<CR>==", {desc = "Move curren line up"})

