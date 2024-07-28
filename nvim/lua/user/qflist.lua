


local send_all_to_qf = function(prompt_bufnr, mode, target)
  local picker = action_state.get_current_picker(prompt_bufnr)
  local manager = picker.manager

  local qf_entries = {}
  for entry in manager:iter() do
    table.insert(qf_entries, entry_to_qf(entry))
  end

  local prompt = picker:_get_prompt()
  actions.close(prompt_bufnr)

  vim.api.nvim_exec_autocmds("QuickFixCmdPre", {})
  local qf_title = string.format([[%s (%s)]], picker.prompt_title, prompt)
  if target == "loclist" then
    vim.fn.setloclist(picker.original_win_id, qf_entries, mode)
    vim.fn.setloclist(picker.original_win_id, {}, "a", { title = qf_title })
  else
    vim.fn.setqflist(qf_entries, mode)
    vim.fn.setqflist({}, "a", { title = qf_title })
  end
  vim.api.nvim_exec_autocmds("QuickFixCmdPost", {})
end

actions.send_to_qflist = {
  pre = append_to_history,
  action = function(prompt_bufnr)
    send_all_to_qf(prompt_bufnr, " ")
  end,
}



files.grep_string = function(opts)
  local vimgrep_arguments = vim.F.if_nil(opts.vimgrep_arguments, conf.vimgrep_arguments)
  if not has_rg_program("grep_string", vimgrep_arguments[1]) then
    return
  end
  local word
  local visual = vim.fn.mode() == "v"

  if visual == true then
    local saved_reg = vim.fn.getreg "v"
    vim.cmd [[noautocmd sil norm! "vy]]
    local sele = vim.fn.getreg "v"
    vim.fn.setreg("v", saved_reg)
    word = vim.F.if_nil(opts.search, sele)
  else
    word = vim.F.if_nil(opts.search, vim.fn.expand "<cword>")
  end
  local search = opts.use_regex and word or escape_chars(word)

  local additional_args = {}
  if opts.additional_args ~= nil then
    if type(opts.additional_args) == "function" then
      additional_args = opts.additional_args(opts)
    elseif type(opts.additional_args) == "table" then
      additional_args = opts.additional_args
    end
  end

  if opts.file_encoding then
    additional_args[#additional_args + 1] = "--encoding=" .. opts.file_encoding
  end

  if search == "" then
    search = { "-v", "--", "^[[:space:]]*$" }
  else
    search = { "--", search }
  end

  local args
  if visual == true then
    args = flatten {
      vimgrep_arguments,
      additional_args,
      search,
    }
  else
    args = flatten {
      vimgrep_arguments,
      additional_args,
      opts.word_match,
      search,
    }
  end

  opts.__inverted, opts.__matches = opts_contain_invert(args)

  if opts.grep_open_files then
    for _, file in ipairs(get_open_filelist(opts.grep_open_files, opts.cwd)) do
      table.insert(args, file)
    end
  elseif opts.search_dirs then
    for _, path in ipairs(opts.search_dirs) do
      table.insert(args, vim.fn.expand(path))
    end
  end

  opts.entry_maker = opts.entry_maker or make_entry.gen_from_vimgrep(opts)
  pickers
    .new(opts, {
      prompt_title = "Find Word (" .. word:gsub("\n", "\\n") .. ")",
      finder = finders.new_oneshot_job(args, opts),
      previewer = conf.grep_previewer(opts),
      sorter = conf.generic_sorter(opts),
    })
    :find()
end
