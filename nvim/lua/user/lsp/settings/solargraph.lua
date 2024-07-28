require'lspconfig'.solargraph.setup{
  cmd = { "solargraph", "stdio" },
  filetypes = { "ruby" },
  init_options = {
    formatting = true,
  },
  root_dir = root_pattern("Gemfile", ".git"),
  settings = {
    solargraph = { diagnostics = true }
  }
}


-- rubocop
vim.opt.signcolumn = "yes"
vim.api.nvim_create_autocmd("FileType", {
  pattern = "ruby",
  callback = function()
    vim.lsp.start {
      name = "rubocop",
      cmd = { "rubocop", "--lsp" },
    }
  end,
})
