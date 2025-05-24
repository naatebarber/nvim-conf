require("config.lazy")

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = false
vim.opt.number = true
vim.g.mapleader = " "

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })

vim.keymap.set("n", "<leader>nf", ":Neotree float <CR>", { desc = "Open Neotree" })

vim.keymap.set("n", "<leader>nt", function()
	local count = vim.v.count
	if count == 0 then
		count = 1
	end
	vim.cmd("ToggleTerm" .. count)
end, { desc = "Open Terminal" })

vim.keymap.set("n", "<leader>kk", "<C-w>k", { desc = "Move to upper window" })
vim.keymap.set("n", "<leader>jj", "<C-w>j", { desc = "Move to lower window" })
vim.keymap.set("n", "<leader>hh", "<C-w>h", { desc = "Move to left window" })
vim.keymap.set("n", "<leader>ll", "<C-w>l", { desc = "Move to right window" })

vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { noremap = true, silent = true })

vim.keymap.set('v', '<Tab>', '>gv')
vim.keymap.set('v', '<S-Tab>', '<gv')

-- Language Servers

local lspconfig = require("lspconfig")

lspconfig.rust_analyzer.setup({
	settings = {
		rust_analyzer = {
			useLibraryCodeForTypes = true,
			autoSearchPaths = true,
			autoImportCompletions = false,
			reportMissingImports = true,
			followImportForHints = true,

			cargo = {
				allFeatures = true,
			},
			checkOnSave = {
				command = "cargo clippy",
			},
		},
	},
})

lspconfig.ts_ls.setup({
	filetypes = { "typescript", "typescriptreact", "typescript.tsx", "javascript.jsx", "javascriptreact", "javascript" },
	cmd = { "typescript-language-server", "--stdio" },
	root_dir = lspconfig.util.root_pattern("tsconfig.json"),
})

lspconfig.pyright.setup({})

-- Theme

require("neo-tree").setup({
	popup_border_style = "rounded",
	window = {
		position = "float",
	},
})

require("lualine").setup()

-- Diagnostics

vim.diagnostic.config({
	virtual_text = {
		prefix = "●",
		spacing = 2,
	}, -- Show inline error descriptions
	signs = true, -- Show signs in the gutter
	underline = true, -- Underline diagnostics
	update_in_insert = false, -- Update diagnostics insert mode
	severity_sort = true, -- Sort diagnostics by severity
})

vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic" })
vim.keymap.set("n", "<leader>de", vim.diagnostic.open_float, { desc = "Show diagnostic float" })
vim.keymap.set("n", "<leader>dq", vim.diagnostic.setloclist, { desc = "Populate diagnostics list" })
