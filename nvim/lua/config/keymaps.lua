local keymap = vim.keymap
local opts = { noremap = true, silent = true }

keymap.set("n", "x", '"_x')

-- Increment/decrement
keymap.set("n", "+", "<C-a>")
keymap.set("n", "-", "<C-x>")

-- Select all
keymap.set("n", "<C-a>", "gg<S-v>G")

-- Save file and quit
keymap.set("n", "<Leader>w", ":update<Return>", opts)
keymap.set("n", "<Leader>q", ":quit<Return>", opts)
keymap.set("n", "<Leader>Q", ":qa<Return>", opts)

-- File explorer with NvimTree
keymap.set("n", "<Leader>f", ":NvimTreeFindFile<Return>", opts)
keymap.set("n", "<Leader>t", ":NvimTreeToggle<Return>", opts)

-- Tabs
keymap.set("n", "te", ":tabedit")
keymap.set("n", "<tab>", ":tabnext<Return>", opts)
keymap.set("n", "<s-tab>", ":tabprev<Return>", opts)
keymap.set("n", "tw", ":tabclose<Return>", opts)

-- Split window
keymap.set("n", "ss", ":split<Return>", opts)
keymap.set("n", "sv", ":vsplit<Return>", opts)

-- Move window
keymap.set("n", "sh", "<C-w>h")
keymap.set("n", "sk", "<C-w>k")
keymap.set("n", "sj", "<C-w>j")
keymap.set("n", "sl", "<C-w>l")

-- Resize window
keymap.set("n", "<C-S-h>", "<C-w><")
keymap.set("n", "<C-S-l>", "<C-w>>")
keymap.set("n", "<C-S-k>", "<C-w>+")
keymap.set("n", "<C-S-j>", "<C-w>-")

-- Telescope file finder
keymap.set("n", "<Leader><Leader>", function()
	require("telescope.builtin").find_files()
end, opts)

-- Search in all files including hidden files
keymap.set("n", "<Leader>fa", function()
	require("telescope.builtin").find_files({
		hidden = true,
		no_ignore = true,
		no_ignore_parent = true,
	})
end, { desc = "Find all files (including hidden)" })

-- Live grep in all files including hidden
keymap.set("n", "<Leader>ga", function()
	require("telescope.builtin").live_grep({
		additional_args = function()
			return { "--hidden", "--no-ignore" }
		end,
	})
end, { desc = "Live grep all files (including hidden)" })

-- Search text in all files including hidden
keymap.set("n", "<Leader>sa", function()
	require("telescope.builtin").grep_string({
		additional_args = function()
			return { "--hidden", "--no-ignore" }
		end,
	})
end, { desc = "Search current word in all files (including hidden)" })

-- Diagnostics
keymap.set("n", "<C-j>", function()
	vim.diagnostic.goto_next()
end, opts)

-- VS Code-style insert mode keybindings
-- Delete entire line (like Ctrl+Shift+K in VS Code)
keymap.set("i", "<C-S-k>", "<Esc>dd<S-A>", { desc = "Delete entire line" })
keymap.set("i", "<C-l>", "<Esc>dd<S-A>", { desc = "Delete entire line (alternative)" })

-- Duplicate line (like Ctrl+Shift+D in VS Code)
keymap.set("i", "<C-S-d>", "<Esc>yyp<S-A>", { desc = "Duplicate line" })

-- Move line up/down (like Alt+Up/Down in VS Code)
keymap.set("i", "<M-Up>", "<Esc>:m .-2<CR>==gi", { desc = "Move line up" })
keymap.set("i", "<M-Down>", "<Esc>:m .+1<CR>==gi", { desc = "Move line down" })
keymap.set("i", "<M-k>", "<Esc>:m .-2<CR>==gi", { desc = "Move line up" })
keymap.set("i", "<M-j>", "<Esc>:m .+1<CR>==gi", { desc = "Move line down" })

-- Select word (like Ctrl+D in VS Code)
keymap.set("i", "<C-d>", "<Esc>viw", { desc = "Select current word" })

-- Delete word backward/forward
keymap.set("i", "<C-Backspace>", "<C-w>", { desc = "Delete word backward" })
keymap.set("i", "<C-Delete>", "<Esc>dawi", { desc = "Delete word forward" })

-- Beginning/End of line (like Home/End)
keymap.set("i", "<C-a>", "<Home>", { desc = "Go to beginning of line" })
keymap.set("i", "<C-e>", "<End>", { desc = "Go to end of line" })

-- Undo/Redo in insert mode
keymap.set("i", "<C-z>", "<Esc>ui", { desc = "Undo" })
keymap.set("i", "<C-y>", "<Esc><C-r>i", { desc = "Redo" })

-- Save file in insert mode
keymap.set("i", "<C-s>", "<Esc>:w<CR>a", { desc = "Save file" })
