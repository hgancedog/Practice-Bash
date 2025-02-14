-- Configuraciones generales
vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.smartindent = true
vim.opt.termguicolors = true
vim.opt.cursorline = true
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Configurar el símbolo de retorno de carro para las líneas que se ajustan
vim.opt.showbreak = "↪ "
-- Para identar la línea del símbolo retorno de carro
vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.breakindent = true

-- Establecer portapapeles del sistema
vim.opt.clipboard = ("unnamedplus")

-- Instalación de lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- Configuración de plugins
require("lazy").setup("heks.plugins")

