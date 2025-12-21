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

-- Clone 'mini.nvim' manually in a way that it gets managed by 'mini.deps'
local path_package = vim.fn.stdpath('data') .. '/site/'
local mini_path = path_package .. 'pack/deps/start/mini.nvim'
if not vim.loop.fs_stat(mini_path) then
  vim.cmd('echo "Installing `mini.nvim`" | redraw')
  local clone_cmd = {
    'git', 'clone', '--filter=blob:none',
    'https://github.com/nvim-mini/mini.nvim', mini_path
  }
  vim.fn.system(clone_cmd)
  vim.cmd('packadd mini.nvim | helptags ALL')
  vim.cmd('echo "Installed `mini.nvim`" | redraw')
end

vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
})

require('mini.deps').setup({ path = { package = path_package } })

local add = require('mini.deps').add
add({
  source = 'nvim-flutter/flutter-tools.nvim',
  depends = {
    'stevearc/dressing.nvim',
    'nvim-lua/plenary.nvim'
  }
})
add({ source = 'lewis6991/gitsigns.nvim' })
add({ source = 'tpope/vim-fugitive' })
add({ source = 'folke/tokyonight.nvim' })
add({ source = 'nvim-treesitter/nvim-treesitter' })
add({ source = 'OXY2DEV/markview.nvim' })
add({
  source = 'nvim-mini/mini.completion',
  dependencies = {
    'nvim-mini/mini.icons',
    'nvim-mini/mini-snippets'
  }
})
add({ source = 'nvim-mini/mini.surround' })
add({ source = 'nvim-mini/mini.ai' })
add({ source = 'nvim-mini/mini.move' })
add({ source = 'nvim-mini/mini.files' })
add({ source = 'nvim-treesitter/nvim-treesitter-context' })
add({ source = 'echasnovski/mini.pick' })
add({ source = 'onsails/diaglist.nvim' })
add({ source = 'mbbill/undotree' })
add({ source = 'HakonHarnes/img-clip.nvim' })
add({ source = 'akinsho/toggleterm.nvim' })
add({ source = 'mason-org/mason.nvim' })
add({ source = 'neovim/nvim-lspconfig' })
add({ source = 'jghauser/follow-md-links.nvim' })
add({ source = 'rachartier/tiny-inline-diagnostic.nvim' })
add({
  source = 'adibhanna/laravel.nvim',
  dependencies = {
    "MunifTanjim/nui.nvim",
    "nvim-lua/plenary.nvim"
  }
})

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

vim.cmd.colorscheme('tokyonight-night')
vim.cmd.hi("StatusLine guibg=NONE")

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.*",
  callback = function() vim.lsp.buf.format() end,
})

-- Keymaps
vim.keymap.set("i", "", "<C-S-H>", { desc = "Solution for xterm" })
vim.keymap.set({ "n", "v" }, "j", "gj", { desc = "Personal preference" })
vim.keymap.set({ "n", "v" }, "k", "gk", { desc = "Personal preference" })
vim.keymap.set("n", "<leader><space>e", "<cmd>lua MiniFiles.open()<CR>", { desc = 'Open Mini.Files' })
vim.keymap.set("n", "<leader>cw", require('diaglist').open_all_diagnostics, { desc = 'Open diagnostics' })
vim.keymap.set("n", "<leader>cl", "<cmd>cclose<cr>", { desc = 'Open diagnostics' })
vim.keymap.set('n', '<leader><leader>u', vim.cmd.UndotreeToggle, { desc = 'Toggle undo tree' })
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

-- vim.keymap.set("i", "<C-e>", function()
--   if vim.fn.pumvisible() == 1 then
--     return "<C-y>"
--   else
--     return "<C-e>"
--   end
-- end, { expr = true, silent = true })a

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client ~= nil and client:supports_method('textDocument/completion') then
      vim.opt.completeopt = { 'menu', 'menuone', 'noselect', 'fuzzy', 'popup' }
      vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
      vim.keymap.set('i', '<C-Space>', function()
        vim.lsp.completion.get()
      end, { desc = 'Start Completion' })
    end
  end,
})

vim.diagnostic.config({ virtual_text = false })
