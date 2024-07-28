-- STARTING MIGRATION
-- Automatically install lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Example using a list of specs with the default options
vim.g.mapleader = " " -- Make sure to set `mapleader` before lazy so your mappings are correct
vim.g.maplocalleader = "\\" -- Same for `maplocalleader`


-- Install your plugins here
require('lazy').setup({
  "nvim-lua/plenary.nvim", -- Useful lua functions used by lots of plugins
  {"windwp/nvim-autopairs", commit = "4fc96c8f3df89b6d23e5092d31c866c53a346347"}, -- Autopairs, integrates with both cmp and treesitter
  {"numToStr/Comment.nvim", commit = "97a188a98b5a3a6f9b1b850799ac078faa17ab67"} , -- autocomment 
  {"JoosepAlviste/nvim-ts-context-commentstring", commit = "4d3a68c41a53add8804f471fcc49bb398fe8de08"} ,
  "kyazdani42/nvim-web-devicons" ,
  {"kyazdani42/nvim-tree.lua", commit = "7282f7de8aedf861fe0162a559fc2b214383c51c"} , -- directory tree bar
  "tiagovla/scope.nvim" , -- limit per-tab buffers to current tab only
  "petertriho/nvim-scrollbar" , -- add scrollbar on the right and 
  {"moll/vim-bbye", commit = "25ef93ac5a87526111f43e5110675032dbcacf56"} ,
  {"akinsho/toggleterm.nvim", commit = "2a787c426ef00cb3488c11b14f5dcf892bbd0bda"} , -- toggle floating terminal
  {"ahmedkhalf/project.nvim", commit = "628de7e433dd503e782831fe150bb750e56e55d6"} ,
  "lewis6991/impatient.nvim" ,
  {"lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {}},
  "goolord/alpha-nvim", commit = "0bb6fc0646bcd1cdb4639737a1cee8d6e08bcc31" ,
  "folke/which-key.nvim", -- on-screen bar shortcut suggestions
  "kevinhwang91/nvim-bqf", -- nice quickfix window
  "romainl/vim-qf", -- to save quickfix
  "p00f/nvim-ts-rainbow", -- colorize paired symbols
  {
    "christoomey/vim-tmux-navigator",
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
    },
    keys = {
      { "<C-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
      { "<C-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
      { "<C-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
      { "<C-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
      { "<C-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
    }, -- integrate into tmux pane cycling workflow
  },
  "mg979/vim-visual-multi" , -- better multiline editing
  "liuchengxu/vista.vim" , -- lsp symbol view
    {'kevinhwang91/nvim-ufo', dependencies = 'kevinhwang91/promise-async'},
    {"LintaoAmons/bookmarks.nvim", dependencies = "stevearc/dressing.nvim"} ,
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
      })
    end
  }, -- surround string with symbol-pairs
  "nanozuki/tabby.nvim", -- tabline
  "Tummetott/reticle.nvim", -- move convenient cursor config
  "RRethy/vim-illuminate" , -- Automatically highligh same world
  "mbbill/undotree", -- display tree of changes
  "dhruvasagar/vim-table-mode", -- table-edit mode
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { {"nvim-lua/plenary.nvim"} }
  }, -- fast-access buffer list
  {
    "kevinhwang91/nvim-hlslens",
    -- config = function()
    --   -- require('hlslens').init() is not required
    --   require("scrollbar.handlers.search").init({
    --     -- hlslens config overrides
    --   })
    -- end,
  },

  -- Cmp 
  "hrsh7th/nvim-cmp" , -- The completion plugin
  "hrsh7th/cmp-buffer" , -- buffer completions
  "hrsh7th/cmp-path" , -- path completions
  "saadparwaiz1/cmp_luasnip" , -- snippet completions
  "hrsh7th/cmp-nvim-lsp" ,
  "hrsh7th/cmp-nvim-lua" ,

  -- Snippets
  "L3MON4D3/LuaSnip", commit = "8f8d493e7836f2697df878ef9c128337cbf2bb84" , --snippet engine
  "rafamadriz/friendly-snippets", commit = "2be79d8a9b03d4175ba6b3d14b082680de1b31b1" , -- a bunch of snippets to use

  -- LSP
  "neovim/nvim-lspconfig" , -- auto-configs for different lang-servers
  "williamboman/mason.nvim" , -- simple to use language server installer
  "williamboman/mason-lspconfig.nvim" , -- lspconfig integration with mason
  "puremourning/vimspector" , -- debug adapter
  -- "mhartington/formatter.nvim", -- for linters and formatters
  "sbdchd/neoformat" ,
  "tpope/vim-rails",
  "tpope/vim-bundler",
  "j-hui/fidget.nvim",

  -- Lanuage-specific
  "OrangeT/vim-csharp" , -- some csharp stuff

  -- Telescope
  "nvim-telescope/telescope.nvim" ,

  -- Treesitter
  "nvim-treesitter/nvim-treesitter" , -- syntax highlight

  -- nvim-ufo for better folding
  -- require('ufo').init({
  --   provider_selector = function(bufnr, filetype, buftype)
  --     return {'treesitter', 'indent'}
  --   end
  -- }), -- !!!

  -- exclude some filetypes from ufo
  -- vim.api.nvim_create_autocmd("FileType", {
  --   pattern = { "norg", "neo-tree" },
  --   callback = function()
  --     require("ufo").detach()
  --     vim.opt_local.foldenable = false
  --   end
  -- })

  -- Neorg (emacs org-mod nvim support)
  {
    "vhyrro/luarocks.nvim",
    priority = 1000, -- We'd like this plugin to load first out of the rest
    config = true, -- This automatically runs `require("luarocks-nvim").setup()`
  },

  {
    "nvim-neorg/neorg",
    -- tag = "*",
    ft = "norg", -- Specifies functions which load this plugin.
    lazy = ":Neorg sync-parsers", -- Post-update/install hook.
    after = { "nvim-treesitter", "telescope.nvim" }, -- You may want to specify Telescope here as well
    dependencies = { "luarocks.nvim", "nvim-treesitter", "telescope.nvim" },
    config = function()
      require('neorg').setup({
        load = {
          ["core.defaults"] = {}, -- Loads default behaviour
          ["core.autocommands"] = {},
          ["core.concealer"] = {
            config = {
              folds = true,
              icon_preset = "varied",
              init_open_folds = "always",
              icons = {
                list = {
                  icons = { "󰫢", "󰫤", "󰫣", "󰫥", "", "" },
                },
                heading = {
                  icons = { "󱗝", "", "", "󰺕", "", "󰺖" },
                },
                definition = {
                  single = { icon = "󰷐" },
                  multi_prefix = { icon = "󰺲"},
                  multi_suffix = { icon = "󰉺"},
                },
                ordered = {
                  -- icons = { "•", "◇", "▪", "-", "→", "⇒" },
                  level_1 = { icon = "󰬺" },
                  level_2 = { icon = "󰬻" },
                  level_3 = { icon = "󰬼" },
                },
                todo = {
                  -- done = { icon = "" },
                  pending = { icon = "󰔟" },
                  uncertain = { icon = "" },
                  on_hold = { icon = "" },
                  cancelled = { icon = "󰜺" },
                  undone = { icon = "" },
                },
                delimiter = {
                  horizontal_line = {
                    highlight = "@neorg.delimiters.horizontal_line",
                  },
                },
                code_block = {
                  spell_check = false,
                  content_only = true,
                  width = "content",
                  padding = {
                  },
                  conceal = true,
                  nodes = { "ranged_verbatim_tag" },
                  highlight = "CursorColumn",
                  insert_enabled = false,
                },
              },
            },
          }, -- Adds pretty icons to your documents
          ["core.syntax"] = {},
          ["core.export"] = {},
          ["core.highlights"] = {
            -- https://github.com/nvim-neorg/neorg/wiki/Core-Highlights
            config = {
              highlights = {
                links = {
                  location = {
                    url = "+@markup.link.url"
                  }
                },
                lists = {
                  unordered = {
                    prefix = "+@markup.list"
                  }
                },
                headings = {
                  level_3 = {title = "+@field"},
                },
              },
              dim = {
                tags = {
                  ranged_verbatim = {
                    code_block = {
                      affect = "background",
                      pencentage = 1,
                      reference = "Normal",
                    },
                  },
                },
              },
            },
          },
          ["core.dirman"] = { -- Manages Neorg workspaces
          config = {
            workspaces = {
              notes = "/home/spil/main/documents/nvim_vault",
            },
          },
        },
      },
    })
    end
  },

  -- Git
  {
    "lewis6991/gitsigns.nvim",
    -- config = function()
      -- require('gitsigns').init()
      -- require("scrollbar.handlers.gitsigns").init()
      -- end
      branch = "release", -- breaking changes in main
  },

  -- Colorschemes
  {
    "/home/spil/home/.config/nvim/gruvbox.nvim", -- current
      dir = "/home/spil/home/.config/nvim/gruvbox.nvim"
  },
})
