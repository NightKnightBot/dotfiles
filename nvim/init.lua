vim.g.mapleader = ' '
vim.o.number = true
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.o.foldlevel = 2
vim.o.expandtab = true
vim.o.autoindent = true
vim.o.smartindent = true
vim.o.signcolumn = 'yes'
vim.o.foldlevel = 99
vim.o.hlsearch = false
vim.o.swapfile = true
vim.o.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.o.undofile = true
vim.o.smartcase = true
vim.o.ignorecase = true
vim.o.scrolloff = 8
vim.opt.path:append("**")
vim.o.winborder = 'rounded'
vim.o.foldmethod = 'expr'
vim.o.guifont = 'IntoneMono NF:h10'
vim.o.foldexpr = 'v:lua.vim.lsp.foldexpr()'
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client ~= nil and client:supports_method('textDocument/foldingRange') then
      local win = vim.api.nvim_get_current_win()
      vim.wo[win][0].foldexpr = 'v:lua.vim.lsp.foldexpr()'
    end
  end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.cmd("packadd nvim.undotree")
vim.keymap.set("n", "<leader>u", require("undotree").open)

vim.pack.add { 'https://github.com/stevearc/dressing.nvim' }  -- Dependency for flutter tools
vim.pack.add { 'https://github.com/nvim-lua/plenary.nvim' }   -- Dependency for flutter tools
vim.pack.add { 'https://github.com/nvim-flutter/flutter-tools.nvim' }
vim.pack.add { 'https://github.com/nvim-mini/mini.icons' }    -- Dependency for mini.completion
vim.pack.add { 'https://github.com/nvim-mini/mini.snippets' } -- Dependency for mini.completion

vim.pack.add { 'https://github.com/lewis6991/gitsigns.nvim' }
vim.pack.add { 'https://github.com/nvim-treesitter/nvim-treesitter' }
vim.pack.add { 'https://github.com/OXY2DEV/markview.nvim' }
vim.pack.add { 'https://github.com/nvim-mini/mini.completion' }
vim.pack.add { 'https://github.com/nvim-mini/mini.surround' }
vim.pack.add { 'https://github.com/nvim-mini/mini.ai' }
vim.pack.add { 'https://github.com/nvim-mini/mini.move' }
vim.pack.add { 'https://github.com/nvim-mini/mini.files' }
vim.pack.add { 'https://github.com/nvim-treesitter/nvim-treesitter-context' }
vim.pack.add { 'https://github.com/echasnovski/mini.pick' }
vim.pack.add { 'https://github.com/onsails/diaglist.nvim' }
vim.pack.add { 'https://github.com/HakonHarnes/img-clip.nvim' }
vim.pack.add { 'https://github.com/akinsho/toggleterm.nvim' }
vim.pack.add { 'https://github.com/mason-org/mason.nvim' }
vim.pack.add { 'https://github.com/jghauser/follow-md-links.nvim' }
vim.pack.add { 'https://github.com/rachartier/tiny-inline-diagnostic.nvim' }

vim.pack.add { "https://github.com/MunifTanjim/nui.nvim" }  -- Dependency for laravel.nvim
vim.pack.add { "https://github.com/nvim-lua/plenary.nvim" } -- Dependency for laravel.nvim
vim.pack.add { 'https://github.com/adibhanna/laravel.nvim' }

vim.pack.add { 'https://github.com/neovim/nvim-lspconfig' }

-- Plugin Setup
require('mason').setup()
require('flutter-tools').setup {}
require('mini.surround').setup()
require('mini.ai').setup()
require('mini.pick').setup()
require('mini.move').setup()
require('mini.files').setup()
require('mini.completion').setup()
require("tiny-inline-diagnostic").setup()
require('toggleterm').setup()
require('diaglist').init()
require('gitsigns').setup()
require("laravel").setup()
require 'treesitter-context'.setup { enable = true }

vim.cmd.colorscheme('catppuccin')
vim.cmd.hi("StatusLine guibg=NONE")

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.*",
  callback = function() vim.lsp.buf.format() end,
})

vim.lsp.enable("lua_ls")

-- Keymaps
vim.keymap.set("i", "", "<C-S-H>", { desc = "Solution for xterm" })
vim.keymap.set({ "n", "v" }, "j", "gj", { desc = "Personal preference" })
vim.keymap.set({ "n", "v" }, "k", "gk", { desc = "Personal preference" })
vim.keymap.set("n", "<leader><space>e", "<cmd>lua MiniFiles.open()<CR>", { desc = 'Open Mini.Files' })
vim.keymap.set("n", "<leader>cw", require('diaglist').open_all_diagnostics, { desc = 'Open diagnostics' })
vim.keymap.set("n", "<leader>cl", "<cmd>cclose<cr>", { desc = 'Open diagnostics' })
vim.keymap.set("n", "<leader>pv", "<cmd>Ex<CR>", { desc = "Open netrw" })
vim.keymap.set("n", "<leader>ff", "<cmd>Pick files<CR>", { desc = "Open file Picker" })
vim.keymap.set("n", "<leader>fg", "<cmd>Pick grep_live<CR>", { desc = "Open Live Grep" })
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set({ "n", "v" }, "<leader>y", "\"+y", { desc = "Copy to system clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>yy", "V\"+y", { desc = "Copy to system clipboard" })
vim.keymap.set({ "n" }, "<leader>p", "\"+p", { desc = "Paste system clipboard" })
vim.keymap.set("v", "<leader>d", "\"_d", { desc = "Delete without copying to buffer" })
vim.keymap.set("n", "<leader>dd", "V\"+d", { desc = "Delete without copying to buffer" })
vim.keymap.set({ 'n', 'i' }, '<C-l>', '<CMD>tabnext<CR>', { desc = "Move to next tab" })
vim.keymap.set({ 'n', 'i' }, '<C-h>', '<CMD>tabprevious<CR>', { desc = "Move to previous tab" })
vim.keymap.set("n", "<C-j>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-k>", "<cmd>cprev<CR>zz")
vim.keymap.set({ "n", "t" }, "<leader>/", "<cmd>ToggleTerm<CR>")
vim.keymap.set("n", "gx", function()
  local url = vim.fn.expand("<cfile>")
  vim.fn.jobstart({ "xdg-open", url }, { detach = true })
end, { desc = "Open URL with xdg-open" })

vim.diagnostic.config({ virtual_text = false })
