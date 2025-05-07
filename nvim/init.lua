-- Neovim Lua config for Lakshin ⚡

local opt = vim.opt

opt.number = true
opt.relativenumber = true
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.smartindent = true
opt.mouse = 'a'
opt.clipboard = 'unnamedplus'
opt.scrolloff = 8
opt.termguicolors = true
opt.swapfile = false

opt.hlsearch = true
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true

opt.showmode = true
opt.showcmd = true
opt.ruler = true

opt.fileformats = { "unix", "dos" }
opt.encoding = "utf-8"
opt.fileencoding = "utf-8"

opt.backup = false
opt.writebackup = false
opt.undofile = true
opt.undodir = vim.fn.stdpath("cache") .. "/undo"
opt.guicursor = ""

pcall(vim.cmd, "colorscheme desert")

vim.keymap.set("n", "<Space>", ":", { noremap = true, silent = false })

require("lazy").setup({
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup({
        view = {
          width = 30,
          side = "left",
          relativenumber = true,
        },
        git = { enable = true },
        filters = { dotfiles = false },
      })
      vim.cmd([[autocmd BufEnter * if winnr('$') == 1 && &filetype == 'NvimTree' | quit | endif]])
    end,
  },

  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
  },

  "neovim/nvim-lspconfig",

  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "L3MON4D3/LuaSnip",
    },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "c", "cpp", "lua", "python" },
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },
})

local lspconfig = require("lspconfig")
lspconfig.pyright.setup({})
lspconfig.clangd.setup({})

local cmp = require("cmp")
cmp.setup({
  mapping = cmp.mapping.preset.insert({
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  }),
  sources = {
    { name = 'nvim_lsp' },
    { name = 'buffer' },
  },
})

vim.keymap.set("n", "<C-b>", ":NvimTreeToggle<CR>", { noremap = true, silent = true })
