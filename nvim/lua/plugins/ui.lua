return {
    -- Colorscheme
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        opts = {
            style = "night",
            styles = { comments = { italic = true }, keywords = { italic = false } },
        },
        config = function(_, opts)
            require("tokyonight").setup(opts)
            vim.cmd.colorscheme("tokyonight")
        end,
    },

    { "nvim-tree/nvim-web-devicons", lazy = true },

    -- Statusline
    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        opts = {
            options = {
                theme = "auto",
                globalstatus = true,
                section_separators = "",
                component_separators = "",
                disabled_filetypes = { statusline = { "snacks_dashboard" } },
            },
            sections = {
                lualine_a = { "mode" },
                lualine_b = { "branch", "diff" },
                lualine_c = {
                    { "filename", path = 1, symbols = { modified = " ●", readonly = " \u{f023}" } },
                },
                lualine_x = {
                    "diagnostics",
                    {
                        function()
                            local names = vim.tbl_map(function(c) return c.name end,
                                vim.lsp.get_clients({ bufnr = 0 }))
                            return #names > 0 and "\u{f085} " .. table.concat(names, ",") or ""
                        end,
                    },
                    "filetype",
                },
                lualine_y = { "progress" },
                lualine_z = { "location" },
            },
            extensions = { "lazy", "trouble", "quickfix" },
        },
    },

    -- Buffer tabs
    {
        "akinsho/bufferline.nvim",
        version = "*",
        event = "VeryLazy",
        keys = {
            { "<leader>bp", "<cmd>BufferLineTogglePin<cr>", desc = "Pin buffer" },
            { "<leader>bo", "<cmd>BufferLineCloseOthers<cr>", desc = "Close other buffers" },
            { "[b", "<cmd>BufferLineMovePrev<cr>", desc = "Move buffer left" },
            { "]b", "<cmd>BufferLineMoveNext<cr>", desc = "Move buffer right" },
        },
        opts = {
            options = {
                close_command = function(n) Snacks.bufdelete(n) end,
                right_mouse_command = function(n) Snacks.bufdelete(n) end,
                diagnostics = "nvim_lsp",
                always_show_bufferline = false,
                show_buffer_close_icons = false,
                offsets = {
                    { filetype = "snacks_layout_box", text = "", separator = true },
                },
            },
        },
    },

    -- Keymap hints
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {
            preset = "helix",
            spec = {
                { "<leader>b", group = "buffer" },
                { "<leader>c", group = "code" },
                { "<leader>f", group = "find" },
                { "<leader>g", group = "git" },
                { "<leader>gh", group = "hunks" },
                { "<leader>q", group = "quit" },
                { "<leader>s", group = "search" },
                { "<leader>u", group = "toggle" },
                { "<leader>w", group = "window" },
                { "<leader>x", group = "diagnostics" },
                { "[", group = "prev" },
                { "]", group = "next" },
                { "g", group = "goto" },
            },
        },
        keys = {
            { "<leader>?", function() require("which-key").show({ global = false }) end, desc = "Buffer keymaps" },
        },
    },
}
