-- plugins.lua

return {
    -- Treesitter para resaltado de sintaxis mejorado
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = { "lua", "bash" },  -- Asegúrate de incluir 'lua' y otros lenguajes que necesites
                highlight = { enable = true },
                auto_install = true,  -- Esto instalará automáticamente los parsers al abrir archivos
            })
        end,
    },

    -- Lualine para una barra de estado mejorada
    {
        "nvim-lualine/lualine.nvim",
        config = function()
            require("lualine").setup({
                options = {
                    theme = "onedark",
                    component_separators = "|",
                    section_separators = "",
                    disabled_filetypes = { statusline = { "NvimTree" } },
                },
            })
        end,
    },

    -- indent-blankline para guías de indentación (versión 3)
    {
        "lukas-reineke/indent-blankline.nvim",
        config = function()
            require('ibl').setup({
                exclude = {
                    buftypes = { 'terminal' },
                    filetypes = { 'dashboard', 'NvimTree', 'packer', 'lsp-installer' }
                },
                scope = {
                    enabled = true,
                    show_end = true
                }
            })
        end,
    },

    -- LSP para autocompletado y detección de errores
    {
        "neovim/nvim-lspconfig",
        config = function()
            local lspconfig = require("lspconfig")

            -- Configuración del servidor LSP para Bash
            lspconfig.bashls.setup{
                filetypes = { "sh", "zsh" },  -- Asegúrate de incluir los tipos de archivo que necesitas
            }

            -- Configuración de Shellcheck como un linter a través de efm-langserver
            lspconfig.efm.setup{
                init_options = { documentFormatting = true },
                filetypes = { "sh", "zsh" },
                settings = {
                    rootMarkers = {".git/"},
                    languages = {
                        sh = {
                            { command = "shellcheck", args = {"--format", "json"}, formatStdin = true }
                        }
                    }
                }
            }
        end,
    },

    -- Mason para gestionar servidores LSP
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end,
    },

    -- Mason LSP Config para facilitar la configuración de LSPs
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = { "bashls", "efm" },  -- Asegúrate de incluir los servidores que necesitas
            })
        end,
    },

    -- Complemento de autocompletado nvim-cmp
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
            "rafamadriz/friendly-snippets",
            "onsails/lspkind.nvim",
        },
        config = function()
            local cmp = require('cmp')
            local luasnip = require('luasnip')
            local lspkind = require('lspkind')

            require("luasnip.loaders.from_vscode").lazy_load()

            cmp.setup({
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<CR>'] = cmp.mapping.confirm({ select = true }),
                    ['<Tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),
                    ['<S-Tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),
                }),
                sources = cmp.config.sources({
                    { name = 'nvim_lsp' },
                    { name = 'luasnip' },
                    { name = 'buffer' },
                    { name = 'path' },
                }),
                formatting = {
                    format = lspkind.cmp_format({
                        mode = 'symbol_text',
                        maxwidth = 50,
                        ellipsis_char = '...',
                    })
                }
            })
        end,
    },

    -- Tema OneDark
    {
        "navarasu/onedark.nvim",
        config = function()
            require("onedark").setup({
                style = "darker"
            })
            require("onedark").load()
        end,
    },
}

