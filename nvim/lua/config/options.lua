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
vim.o.winborder = 'rounded'
vim.o.foldmethod = 'expr'
vim.o.guifont = 'JetBrainsMono Nerd Font:h10'
vim.o.foldexpr = 'v:lua.vim.lsp.foldexpr()'
vim.opt.path:append("**")
vim.opt.completeopt = { "menu", "menuone", "noselect", "popup" }

vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.hl.on_yank()
  end,
})

vim.cmd("packadd nvim.undotree")
vim.cmd.colorscheme('catppuccin')
vim.cmd.hi("StatusLine guibg=NONE")
