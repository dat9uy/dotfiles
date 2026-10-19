-- set <space> as the leader key
-- must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- enable true color support
vim.opt.termguicolors = true

-- make line numbers default
vim.opt.number = true
vim.opt.relativenumber = true

-- enable mouse mode, can be useful for resizing splits
vim.opt.mouse = "a"

-- sync clipboard between OS and neovim.
--  remove this option if you want your OS clipboard to remain independent.
--  see `:help 'clipboard'`
-- vim.opt.clipboard = "unnamedplus"

-- save undo history
vim.opt.undofile = true

-- keep signcolumn on by default
vim.opt.signcolumn = "yes"

-- sets how neovim will display certain whitespace characters in the editor.
--  see `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- enable live preview of substitutions
vim.opt.inccommand = "split"

-- show which line your cursor is on
vim.opt.cursorline = true

-- set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true

-- enable break indent
vim.opt.breakindent = true

-- enable line wrapping
vim.opt.wrap = true

-- formatting
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.textwidth = 80

vim.diagnostic.config({
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = " ",
			[vim.diagnostic.severity.WARN] = " ",
			[vim.diagnostic.severity.INFO] = " ",
			[vim.diagnostic.severity.HINT] = " ",
		},
	},
	virtual_text = true, -- show inline diagnostics
})

-- clear search highlights with <Esc>
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- pynvim
vim.g.python3_host_prog = vim.fn.expand("~/.local/share/nvim/venv/bin/python3")

-- INFO: plugins
-- we install plugins with neovim's builtin package manager: vim.pack
-- and then enable/configure them by calling their setup functions.
--
-- (see `:h vim.pack` for more details on how it works)
-- you can press `gx` on any of the plugin urls below to open them in your
-- browser and check out their documentation and functionality.
-- alternatively, you can run `:h {plugin-name}` to read their documentation.
--
-- plugins are then loaded and configured with a call to `setup` functions
-- provided by each plugin. this is not a rule of neovim but rather a convention
-- followed by the community.
-- these setup calls take a table as an agument and their expected contents can
-- vary wildly. refer to each plugin's documentation for details.
vim.pack.add({ "https://github.com/khoido2003/monokai-v2.nvim" })
vim.pack.add({
	"https://github.com/nvim-tree/nvim-web-devicons",
	"https://github.com/nvim-lualine/lualine.nvim",
})
require("monokai-v2").setup({
	devicons = true,
	filter = "classic",
})
vim.cmd.colorscheme("monokai-v2")
require("lualine").setup({
	options = {
		theme = "monokai-v2",
	},
})

vim.pack.add({ "https://github.com/nvim-mini/mini.surround" })

-- INFO: fzf
vim.pack.add({ "https://github.com/ibhagwan/fzf-lua" })
require("fzf-lua").setup({
	fzf_colors = true,
	winopts = {
		on_create = function()
			-- Force the cursor to stay steady (non-blinking block) inside the fzf window
			vim.opt_local.guicursor = "t:block-blinkon0"
		end,
	},
})
-- Stop cursor from blinking
-- vim.opt.guicursor:remove({ "t:block-blinkon500-blinkoff500-TermCursor" })
vim.keymap.set("n", "<leader>ff", function()
	require("fzf-lua").files()
end, { desc = "Fzf Lua: Find Files" })

vim.keymap.set("n", "<leader>fg", function()
	require("fzf-lua").git_status()
end, { desc = "Fzf Lua: Files changed (Git)" })

vim.keymap.set("n", "<leader>fb", function()
	require("fzf-lua").buffers()
end, { desc = "Fzf Lua: List buffers" })

-- Oil.nvim
vim.pack.add({
	"https://github.com/stevearc/oil.nvim",
})
require("oil").setup()

-- INFO: Syntax highlighting
vim.pack.add({
	"https://github.com/nvim-treesitter/nvim-treesitter",
})

require("nvim-treesitter.config").setup({
	ensure_installed = { "elixir", "heex", "eex", "markdown", "lua", "rust", "go", "gomod", "gosum", "gotmpl" },

	highlight = {
		enable = true,
	},
})

vim.api.nvim_create_autocmd("PackChanged", {
	callback = function(event)
		if event.data.kind == "update" and event.data.spec.name == "nvim-treesitter" then
			vim.cmd("TSUpdate")
		end
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("tree-sitter-enable", { clear = true }),
	callback = function(args)
		local lang = vim.treesitter.language.get_lang(args.match)
		if not lang or not vim.treesitter.language.add(lang) then
			return
		end

		if vim.treesitter.query.get(lang, "highlights") then
			vim.treesitter.start(args.buf)
		end

		if vim.treesitter.query.get(lang, "indents") then
			vim.opt_local.indentexpr = 'v:lua.require("nvim-treesitter").indentexpr()'
		end

		-- if vim.treesitter.query.get(lang, "folds") then
		-- vim.opt_local.foldmethod = "expr"
		-- vim.opt_local.foldexpr = "v:lua.vim.treesitter.foldexpr()"
		-- end
	end,
})

-- INFO: completion engine
vim.pack.add({
	"https://github.com/tpope/vim-dadbod",
	"https://github.com/kristijanhusak/vim-dadbod-ui",
	"https://github.com/kristijanhusak/vim-dadbod-completion",
	"https://github.com/folke/lazydev.nvim",
})
vim.pack.add({
	"https://github.com/saghen/blink.lib",
	"https://github.com/saghen/blink.cmp",
	{
		src = "https://github.com/saghen/blink.pairs",
		version = vim.version.range("*"),
	},
})
local cmp = require("blink.cmp")
cmp.build():pwait()

require("vim._core.ui2").enable({})
require("blink.pairs").build():pwait(60000)

require("blink.pairs").setup({
	highlights = {
		enabled = true,
		-- requires require('vim._core.ui2').enable({}), otherwise has no effect
		cmdline = true,
		-- set to { 'BlinkPairs' } to disable rainbow highlighting
		groups = { "BlinkPairsOrange", "BlinkPairsPurple", "BlinkPairsBlue" },
		unmatched_group = "BlinkPairsUnmatched",

		-- highlights matching pairs under the cursor
		matchparen = {
			enabled = true,
			-- known issue where typing won't update matchparen highlight, disabled by default
			cmdline = false,
			-- also include pairs not on top of the cursor, but surrounding the cursor
			include_surrounding = false,
			group = "BlinkPairsMatchParen",
			priority = 250,
		},
	},
})

cmp.setup({
	completion = {
		documentation = {
			auto_show = true,
		},
	},

	-- default blink keymaps
	keymap = {
		["<C-p>"] = { "select_prev", "fallback_to_mappings" },
		["<C-n>"] = { "select_next", "fallback_to_mappings" },

		["<CR>"] = { "select_and_accept", "fallback" },

		["<C-e>"] = { "cancel", "fallback" },
		-- ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
		["<C-space>"] = { "show" },

		["<Tab>"] = { "snippet_forward", "fallback" },
		["<S-Tab>"] = { "snippet_backward", "fallback" },

		["<C-b>"] = { "scroll_documentation_up", "fallback" },
		["<C-f>"] = { "scroll_documentation_down", "fallback" },

		["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
	},

	sources = {
		per_filetype = {
			sql = { "dadbod" },
			lua = { inherit_defaults = true, "lazydev" },
		},
		providers = {
			dadbod = { module = "vim_dadbod_completion.blink" },
			lazydev = { module = "lazydev.integrations.blink" },
		},
	},

	signature = { enabled = true },

	fuzzy = {
		implementation = "lua",
	},
})

-- INFO: lsp server installation and configuration
vim.pack.add({
	"https://github.com/ray-x/go.nvim",
	"https://github.com/neovim/nvim-lspconfig", -- default configs for lsps
})

-- Config golang separately (use go.nvim)
require("go").setup({
	lsp_keymaps = false,
	lsp_codelens = false,
})
local gopls_cfg = require("go.lsp").config()

-- lsp servers we want to use and their configuration
-- see `:h lspconfig-all` for available servers and their settings
local lsp_servers = {
	lua_ls = {
		settings = {
			Lua = {
				workspace = { library = vim.api.nvim_get_runtime_file("lua", true) },
			},
		},
	},
	expert = {},
	pyrefly = {},
	gopls = gopls_cfg,
}

-- configure each lsp server on the table
-- to check what clients are attached to the current buffer, use
-- `:checkhealth vim.lsp`. to view default lsp keybindings, use `:h lsp-defaults`.
for server, config in pairs(lsp_servers) do
	vim.lsp.config(server, config)
	vim.lsp.config(server, {
		-- only create the keymaps if the server attaches successfully
		on_attach = function(_, bufnr)
			vim.keymap.set("n", "grd", vim.lsp.buf.definition, { buffer = bufnr, desc = "vim.lsp.buf.definition()" })
			vim.keymap.set("n", "grf", vim.lsp.buf.format, { buffer = bufnr, desc = "vim.lsp.buf.format()" })
		end,
	})

	vim.lsp.enable(server)
end

local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*.go",
	callback = function()
		require("go.format").goimports()
	end,
	group = format_sync_grp,
})

-- INFO: Formatter
vim.pack.add({ "https://github.com/stevearc/conform.nvim" })
require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		-- Conform will run multiple formatters sequentially
		-- python = { "isort", "black" },
		-- You can customize some of the format options for the filetype (:help conform.format)
		-- rust = { "rustfmt", lsp_format = "fallback" },
		-- Conform will run the first available formatter
		-- javascript = { "prettierd", "prettier", stop_after_first = true },
	},
	format_on_save = {
		timeout_ms = 500,
		lsp_format = "fallback",
	},
})

-- Navigator
vim.pack.add({
	"https://github.com/christoomey/vim-tmux-navigator",
})
vim.keymap.set("n", "<M-h>", "<cmd>TmuxNavigateLeft<cr>")
vim.keymap.set("n", "<M-j>", "<cmd>TmuxNavigateDown<cr>")
vim.keymap.set("n", "<M-k>", "<cmd>TmuxNavigateUp<cr>")
vim.keymap.set("n", "<M-l>", "<cmd>TmuxNavigateRight<cr>")
