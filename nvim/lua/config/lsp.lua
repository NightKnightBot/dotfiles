vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client ~= nil and client:supports_method('textDocument/foldingRange') then
      local win = vim.api.nvim_get_current_win()
      vim.wo[win].foldexpr = 'v:lua.vim.lsp.foldexpr()'
      vim.wo[win].foldmethod = 'expr'
    end
  end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function() vim.lsp.buf.format() end,
})

vim.lsp.enable(
  'lua_ls',
  'basedpyright',
  'rust-analyzer'
)

vim.diagnostic.config({ virtual_text = false })
