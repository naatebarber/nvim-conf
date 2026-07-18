return {

	--- Environment

	{
		-- main branch is a full rewrite (required for Neovim 0.12; master is frozen).
		-- No opts table / ensure_installed / highlight.enable anymore — parsers are
		-- installed explicitly here, and highlighting is turned on via a FileType
		-- autocmd in init.lua (see "Treesitter highlighting").
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		lazy = false,
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter").install({
				"tsx",
				"javascript",
				"typescript",
				"html",
				"css",
				"rust",
				"python",
				"markdown",
				"markdown_inline",
			})
		end,
	},
	{
		"nvim-telescope/telescope.nvim",
	},
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		config = true,
		opts = {
			shell = "bash --login",
		},
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
			{ "3rd/image.nvim", opts = {} }, -- Optional image support in preview window: See `# Preview Mode` for more information
		},
		lazy = false, -- neo-tree will lazily load itself
		-- Configured via require("neo-tree").setup(...) in init.lua.
		-- No `opts`/`config` here on purpose, so lazy.nvim doesn't run a
		-- second, competing setup() with empty options.
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		},
		keys = {
			{
				"<leader>?",
				function()
					require("which-key").show({ global = false })
				end,
				desc = "Buffer Local Keymaps (which-key)",
			},
		},
	},
	{ "nvim-tree/nvim-web-devicons", opts = {} },
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},
	{
		"ojroques/nvim-osc52",
		config = function()
			require("osc52").setup({
				max_length = 0, -- no limit
				silent = true,
				trim = false,
			})

			-- Automatically copy with y
			local function copy()
				if vim.v.event.operator == "y" and vim.v.event.regname == "" then
					require("osc52").copy_register('"')
				end
			end

			vim.api.nvim_create_autocmd("TextYankPost", { callback = copy })
		end,
	},
	{ "tpope/vim-surround" },

	-- Git

	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			current_line_blame = false, -- toggle with <leader>gb
			on_attach = function(bufnr)
				local gs = require("gitsigns")
				local function map(mode, l, r, desc)
					vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
				end

				-- Navigation between hunks
				map("n", "]h", gs.next_hunk, "Next git hunk")
				map("n", "[h", gs.prev_hunk, "Prev git hunk")

				-- Actions
				map("n", "<leader>gs", gs.stage_hunk, "Stage hunk")
				map("n", "<leader>gr", gs.reset_hunk, "Reset hunk")
				map("n", "<leader>gp", gs.preview_hunk, "Preview hunk")
				map("n", "<leader>gb", function()
					gs.blame_line({ full = true })
				end, "Blame line")
				map("n", "<leader>gB", gs.toggle_current_line_blame, "Toggle inline blame")
				map("n", "<leader>gd", gs.diffthis, "Diff this")
			end,
		},
	},

	-- Language Server and Autocompletion

	{
		"neovim/nvim-lspconfig",
	},
	{ "Vimjas/vim-python-pep8-indent" },
	{
		-- blink.cmp replaces nvim-cmp + cmp-buffer + cmp-nvim-lsp. Built-in
		-- lsp/buffer/path/snippet sources, so no separate cmp-* source plugins.
		-- LSP capabilities are wired in init.lua via blink.cmp.get_lsp_capabilities().
		"saghen/blink.cmp",
		dependencies = { "rafamadriz/friendly-snippets" },
		version = "1.*", -- prebuilt fuzzy-matcher binary; avoids needing a Rust toolchain
		opts = {
			-- Keymap kept the same as the old nvim-cmp setup.
			keymap = {
				preset = "none",
				["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
				["<C-e>"] = { "hide", "fallback" },
				["<Tab>"] = { "select_and_accept", "fallback" }, -- confirm({ select = true })
				["<C-b>"] = { "scroll_documentation_up", "fallback" },
				["<C-f>"] = { "scroll_documentation_down", "fallback" },
				["<C-p>"] = { "select_prev", "fallback" },
				["<C-n>"] = { "select_next", "fallback" },
				["<Up>"] = { "select_prev", "fallback" },
				["<Down>"] = { "select_next", "fallback" },
			},
			completion = {
				documentation = { auto_show = true },
				menu = { border = "rounded" },
			},
			sources = {
				default = { "lsp", "buffer", "path", "snippets" },
			},
		},
		opts_extend = { "sources.default" },
	},
	{
		"windwp/nvim-ts-autotag",
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
		-- use opts = {} for passing setup options
		-- this is equivalent to setup({}) function
	},
	-- {
	-- 	"L3MON4D3/LuaSnip",
	-- 	dependencies = { "rafamadriz/friendly-snippets" },
	-- 	config = function()
	-- 		require("luasnip.loaders.from_vscode").lazy_load()
	-- 	end,
	-- },

	-- Theme

	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {},
		config = function()
			vim.cmd("colorscheme tokyonight")
		end,
	},
	-- 	{
	-- 		"rose-pine/neovim",
	-- 		name = "rose-pine",
	-- 		config = function()
	-- 			require("rose-pine").setup({
	-- 				highlight_groups = {
	-- 					["String"] = { fg = "#27d653" },
	-- 				},
	-- 			})
	--
	-- 			vim.cmd("colorscheme rose-pine")
	-- 		end,
	-- 	},
	{
		"rktjmp/lush.nvim",
	},
	{
		"nvimdev/dashboard-nvim",
		event = "VimEnter",
		config = function()
			require("dashboard").setup({
				theme = "doom",
				config = {
					header = {
						"                  ⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣶⢿⡿⣶⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
						"                  ⠀⠀⠀⠀⠀⠀⠀⠀⣠⡼⣯⡿⣽⡷⣿⢿⡿⣷⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
						"                  ⠀⠀⠀⠀⠀⠀⠀⠐⣿⣽⣷⡟⣯⣿⣽⣯⣿⣽⠂⠀⢠⣶⣿⡟⣦⠀⣶⣶⣶⣶⡄⠀⠀",
						"                  ⠀⠀⠀⠀⠀⠀⠀⠀⢻⣽⣾⣻⠏⠀⠈⣿⣞⠟⢀⣴⣿⣻⢾⣽⣟⡿⣯⢿⣽⢯⣷⠀⠀",
						"                  ⠀⠀⠀⠀⠀⡀⠀⡀⢀⠻⣾⡽⣷⠀⠀⠸⣻⠀⣸⣟⠾⣽⣯⠷⣻⣽⣟⡿⣾⣻⢧⠀⠀",
						"                  ⠀⠀⠀⢠⣾⣇⣀⢧⣨⣇⣏⡙⠯⣧⡄⠀⣟⠀⡿⠀⠀⠈⠀⠀⢀⣿⢾⣻⡷⣟⣿⠃⠀",
						"                  ⠀⠀⠀⠘⢷⡏⠐⠊⠰⠃⠈⠛⢷⡷⣄⡀⠀⠀⡅⠀⢀⣠⣶⡿⠻⠏⢛⡓⠛⠋⠁⠀⠀",
						"                  ⠀⠀⢀⣤⣦⣴⡶⣶⢶⣴⣤⣀⠀⠙⢟⡿⣦⠀⠀⠀⠛⣉⣴⡴⣞⡿⣟⣿⣻⣗⣦⠀⠀",
						"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀        ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀                   ",
						"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀        ⠀⠀    nv    ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀         ",
						"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀        ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀                   ",
						"⠀⢀⣾⡿⣽⣯⢷⠛⠈⠉⠛⠛⠂⠀⠘⢷⣻⠀⠀⠀⠒⠛⠉⠁⢻⡷⣟⣯⡿⣽⢿⡄                   ",
						"⣠⣿⢯⣟⣷⣻⢿⣤⣤⡤⠤⠶⣶⠆⠀⠀⠀⠀⣠⡀⠀⠀⠀⠀⠉⠙⢻⣽⣻⢯⣟⡿⡄                  ",
						"⠙⠋⢿⣻⣞⣯⣿⣽⠚⢁⣤⡾⠁⠀⠀⠀⣾⠀⣿⣇⠀⠀⢰⣦⣀⣠⣼⢯⣟⡿⣽⣻⢿                  ",
						"⠀⠀⠀⠀⠀⠀⠀⣿⡽⣟⣾⣯⡷⣟⣧⣤⣿⣻⡀⠹⣟⣾⡽⣿⣞⡿⣯⠃⠉⠉⠁⠀                   ",
						"⠀⠀⠀⠀⠀⠀⠀⠻⠻⢿⣧⣟⡿⣿⣻⢧⣟⣧⡇⠀⠘⠟⣿⣧⢿⠻⠃⠀⠀⠀⠀⠀                   ",
						"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢿⣞⣿⣳⣿⣻⣽⢯⡇⠀⠀⠀⠀⠉⠀⠀⠀⠀⠀⠀⠀⠀                   ",
						"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠿⣾⣽⡾⠙⠊⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀                   ",
						"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀        ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀                   ",
						"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀        ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀                   ",
					},
					center = {
						{
							-- icon = 'ueae9',
							-- icon_hl = 'group',
							-- desc_hl = 'group',
							-- key_hl = 'group',
							-- key_format = ' [%s]', -- `%s` will be substituted with value of `key`
							desc = "Recent Files",
							key = "r",
							action = "Telescope oldfiles",
						},
					},
					vertical_center = true,
				},
			})
		end,
		dependencies = { { "nvim-tree/nvim-web-devicons" } },
	},
}
