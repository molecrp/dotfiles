require'lspconfig'.terraformls.setup{}
vim.api.nvim_create_autocmd({"BufWritePre"}, {
  root_dir = function (pattern)
    local cwd  = vim.loop.cwd();
    local root = util.root_pattern("composer.json", ".git")(pattern);

    -- prefer cwd if root is a descendant
    return util.path.is_descendant(cwd, root) and cwd or root;
  end;
  pattern = {"*.tf", "*.tfvars"},
  callback = function()
    vim.lsp.buf.format()
  end,
})
