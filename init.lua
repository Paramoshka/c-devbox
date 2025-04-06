-- Basic settings
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.termguicolors = true
vim.opt.cursorline = true

-- Leader key
vim.g.mapleader = " "

-- Install lazy.nvim plugin manager if not present
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

-- Plugins
require("lazy").setup({
    -- LSP Config
    { "neovim/nvim-lspconfig" },

    -- Autocompletion
    { "hrsh7th/nvim-cmp" },
    { "hrsh7th/cmp-nvim-lsp" },
    { "L3MON4D3/LuaSnip" },
    { "saadparwaiz1/cmp_luasnip" },

    -- Fuzzy Finder
    { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" } },

    -- File Explorer
    { "nvim-tree/nvim-tree.lua" },

    -- Treesitter for better syntax highlighting
    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
})

-- LSP settings
local lspconfig = require("lspconfig")
lspconfig.clangd.setup {}

-- Completion setup
local cmp = require("cmp")
cmp.setup({
    snippet = {
        expand = function(args)
            require("luasnip").lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
        ["<Tab>"] = cmp.mapping.select_next_item(),
        ["<S-Tab>"] = cmp.mapping.select_prev_item(),
    }),
    sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
    })
})

-- Telescope keybindings
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})

-- Nvim-tree setup and keybinding
require("nvim-tree").setup({
    actions = {
        open_file = {
            quit_on_open = false,
        },
    },
    filesystem_watchers = {
        enable = false,
    },
    update_focused_file = {
        enable = true,
        update_root = true,
        ignore_list = {},
    },
    view = {
        width = 30,
        side = "left",
    },
    renderer = {
        group_empty = true,
    },
    hijack_netrw = true,
    create_in_closed_folder = false, -- Prevent auto-creation of folders
})

vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { noremap = true, silent = true })

-- Treesitter setup
require("nvim-treesitter.configs").setup({
    highlight = { enable = true },
    indent = { enable = true },
})

-- Open file explorer on startup
vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
        vim.cmd("NvimTreeToggle")
    end,
})
