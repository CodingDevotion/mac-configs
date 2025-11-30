-----------------------------------------------------------
-- Bootstrap Lazy.nvim plugin manager
-----------------------------------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

-----------------------------------------------------------
-- Plugins (super minimal)
-----------------------------------------------------------
require("lazy").setup({
  -- Colorscheme
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    config = function()
      vim.cmd("colorscheme gruvbox")
    end,
  },

  -- Treesitter (syntax highlighting)
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        highlight = { enable = true },
        ensure_installed = { "lua", "javascript", "typescript", "json", "html", "css" },
      })
    end,
  },

  -- LSP configuration
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")

      -- Lua language server
      lspconfig.lua_ls.setup({
        settings = {
          Lua = {
            diagnostics = { globals = { "vim" } },
          },
        },
      })

      -- TypeScript / JavaScript
      lspconfig.tsserver.setup({})
    end,
  },

  -- Fuzzy finder (Telescope)
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
  },
})

-----------------------------------------------------------
-- Basic settings
-----------------------------------------------------------
local opt = vim.opt

opt.number = true             -- Show line numbers
opt.relativenumber = true     -- Relative numbers
opt.encoding = "utf-8"
opt.scrolloff = 8
opt.wrap = false
opt.termguicolors = true

opt.expandtab = true          -- Use spaces instead of tabs
opt.shiftwidth = 2            -- Indent size
opt.tabstop = 2

opt.splitbelow = true         -- Splits below instead of above
opt.splitright = true         -- Splits right instead of left

-----------------------------------------------------------
-- Keymaps (minimal)
-----------------------------------------------------------
local map = vim.keymap.set

map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find files" })
map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>",  { desc = "Live grep" })

vim.g.mapleader = " "
