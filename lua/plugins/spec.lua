return {

	--- Environment

	{
		"nvim-treesitter/nvim-treesitter",
		build = function()
			require("nvim-treesitter.install").update({ with_sync = true })()
		end,
		opts = {
			ensure_installed = {
				"typescriptreact",
				"javascriptreact",
				"javascript",
				"typescript",
				"html",
				"css",
				"rust",
				"python",
				"markdown",
				"markdown_inline",
			},
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = { "markdown" },
			},
		},
	},
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
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
		---@module "neo-tree"
		---@type neotree.Config?
		opts = {
			-- fill any relevant options here
		},
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

	-- Language Server and Autocompletion

	{
		"neovim/nvim-lspconfig",
	},
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-nvim-lsp" },
		},
		opts = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")

			return {
				snippet = {
					expand = function(args)
						vim.snippet.expand(args.body)
					end,
				},
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<Tab>"] = cmp.mapping.confirm({ select = true }),
					--
					-- ['<Tab>'] = function(fallback)
					-- 	if cmp.visible() then
					-- 		cmp.confirm()
					-- 	elseif luasnip.expand_or_jumpable() then
					-- 		luasnip.expand_or_jump()
					-- 	else
					-- 		fallback()
					-- 	end
					-- end,
					--
					-- ['<S-Tab>'] = function(fallback)
					-- 	if cmp.visible() then
					-- 		cmp.confirm()
					-- 	elseif luasnip.jumpable(-1) then
					-- 		luasnip.jump(-1)
					-- 	else
					-- 		fallback()
					-- 	end
					-- end,
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
				}, {
					{ name = "buffer" },
				}),
			}
		end,
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
	{
		"L3MON4D3/LuaSnip",
		dependencies = { "rafamadriz/friendly-snippets" },
		config = function()
			require("luasnip.loaders.from_vscode").lazy_load()
		end,
	},

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
