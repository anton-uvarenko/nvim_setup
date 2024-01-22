local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
vim.opt.rtp:prepend(lazypath)

local plugins = {
	{
		'nvim-telescope/telescope.nvim',
		branch = '0.1.x',
		dependencies = {
			'nvim-lua/plenary.nvim',
			-- Fuzzy Finder Algorithm which requires local dependencies to be built.
			-- Only load if `make` is available. Make sure you have the system
			-- requirements installed.
			{
				'nvim-telescope/telescope-fzf-native.nvim',
				-- NOTE: If you are having trouble with this installation,
				--       refer to the README for telescope-fzf-native for more instructions.
				build = 'make',
				cond = function()
					return vim.fn.executable 'make' == 1
				end,
			},
		},
		config = function()
			local cfg = require "plugins.configs.telescope"
			require("telescope").setup(cfg)

			-- Enable telescope fzf native, if installed
			pcall(require('telescope').load_extension, 'fzf')
		end,
	},
	{
		"catppuccin/nvim",
		name     = "catppuccin",
		priority = 1000,
		config   = function()
			local conf = require "plugins.configs.catpuccin"
			require("catppuccin").setup(conf)
			vim.api.nvim_command("colorscheme catppuccin")
		end,
	},
	{
		'neovim/nvim-lspconfig',
		dependencies = {
			{ 'williamboman/mason.nvim', config = true },
			'williamboman/mason-lspconfig.nvim',

			{ 'j-hui/fidget.nvim',       opts = {} },

			'folke/neodev.nvim',
		},
		-- config = require("plugins.configs.autoformat").au_format,
	},
	{
		-- Set lualine as statusline
		'nvim-lualine/lualine.nvim',
		-- See `:help lualine.txt`
		opts = {
			options = {
				icons_enabled = false,
				theme = 'catppuccin',
				component_separators = '|',
				section_separators = '',
			},
		},
	},
	{ 'folke/which-key.nvim',  opts = {} },
	{ 'numToStr/Comment.nvim', opts = {} },
	{
		-- Highlight, edit, and navigate code
		'nvim-treesitter/nvim-treesitter',
		dependencies = {
			'nvim-treesitter/nvim-treesitter-textobjects',
		},
		build = ':TSUpdate',
		config = function()
			local cfg = require "plugins.configs.treesitter"
			vim.defer_fn(function()
				require('nvim-treesitter.configs').setup(cfg)
			end, 0)
		end,
	},
	{
		'lewis6991/gitsigns.nvim',
		opts = require "plugins.configs.gitsigns",
	},
	{
		-- Autocompletion
		'hrsh7th/nvim-cmp',
		dependencies = {
			-- Snippet Engine & its associated nvim-cmp source
			'L3MON4D3/LuaSnip',
			'saadparwaiz1/cmp_luasnip',

			-- Adds LSP completion capabilities
			'hrsh7th/cmp-nvim-lsp',
			'hrsh7th/cmp-path',

			-- Adds a number of user-friendly snippets
			'rafamadriz/friendly-snippets',
		},
	},
	-- Git related plugins
	'tpope/vim-fugitive',
	'tpope/vim-rhubarb',
	{
		'jose-elias-alvarez/null-ls.nvim',
		ft = "go",
		opts = function()
			return require "plugins.configs.null-ls"
		end,
	},
}

require("lazy").setup(plugins)
require("plugins.configs.mason")
