-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
require("lazyvim.plugins.lsp.keymaps")._keys = {}

-- Mouse handling
vim.cmd([[
    function! s:MouseToggleFunc()
        if !exists('s:old_mouse')
            let s:old_mouse = 'a'
        endif

        if &mouse ==? ''
            let &mouse = s:old_mouse
            echo 'Mouse is for Vim (' . &mouse . ')'
        else
            let s:old_mouse = &mouse
            let &mouse=''
            echo 'Mouse is for terminal'
        endif
    endfunction
    command! MouseToggle :call <SID>MouseToggleFunc()
]])

-- Toggle numbers
vim.cmd([[
    function! s:NuModeToggleFunc()
        if &number == 1
            set relativenumber!
        else
            set number!
        endif
    endfunction
    command! NuModeToggle :call <SID>NuModeToggleFunc()
]])

-- No numbers
vim.cmd([[
    function! s:NoNuModeFunc()
        set norelativenumber
        set nonumber
    endfunction
    command! NoNuMode :call <SID>NoNuModeFunc()
]])

-- Open neotree
local function focus_neotree()
    local neotree = require("neo-tree.command")
    local bufname = vim.bo.filetype
    if bufname == "neo-tree" then
        vim.api.nvim_command("wincmd l")
    else
        neotree.execute({ action = "focus" })
    end
end

-- Sudo write
vim.keymap.set("n", "<leader>W", "<cmd>SudaWrite<cr>", { silent = true, desc = "Write as root" })
-- Open neotree
-- TODO: fix keumaps for this
vim.keymap.set({ "n", "i" }, "<F3>", focus_neotree, { desc = "Toggle and focus Neo-tree with F3" })
vim.keymap.set({ "n", "i" }, "<S-F3>", "<lua>Neotree close<cr>", { desc = "Close Neo-tree with Shift+F3" })
-- Neotest
vim.keymap.set({ "n", "i" }, "<F4>", function()
    require("neotest").summary.toggle()
end, { noremap = true, silent = true, desc = "Toggle Neotest summary" })
-- Coverage
vim.keymap.set({ "n", "i" }, "<F5>", function()
    vim.cmd("CoverageSummary")
end, { noremap = true, silent = true, desc = "Toggle Coverage summary" })
-- Mouse toggle
vim.keymap.set("n", "<F6>", "<cmd>MouseToggle<cr>", { noremap = true, silent = true, desc = "Toggle mouse mode" })

-- Move to windows
-- vim.keymap.set({ "n", "i", "t" }, "<C-k>", "<cmd>wincmd k<cr>", { desc = "Move to window above" })
-- vim.keymap.set({ "n", "i", "t" }, "<A-Up>", "<cmd>wincmd k<cr>", { desc = "Move to window above" })
-- vim.keymap.set({ "n", "i", "t" }, "<C-j>", "<cmd>wincmd j<cr>", { desc = "Move to window below" })
-- vim.keymap.set({ "n", "i", "t" }, "<A-Down>", "<cmd>wincmd j<cr>", { desc = "Move to window below" })
-- vim.keymap.set({ "n", "i", "t" }, "<C-h>", "<cmd>wincmd h<cr>", { desc = "Move to window left" })
-- vim.keymap.set({ "n", "i", "t" }, "<A-Left>", "<cmd>wincmd h<cr>", { desc = "Move to window left" })
-- vim.keymap.set({ "n", "i", "t" }, "<C-l>", "<cmd>wincmd l<cr>", { desc = "Move to window right" })
-- vim.keymap.set({ "n", "i", "t" }, "<A-Right>", "<cmd>wincmd l<cr>", { desc = "Move to window right" })
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window", remap = true })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window", remap = true })

-- Better movements
vim.keymap.set({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true, desc = "Move Up" })
vim.keymap.set({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true, desc = "Move down" })
vim.keymap.set("n", "<", "<<", { desc = "Indent left" })
vim.keymap.set("n", ">", ">>", { desc = "Indent right" })

-- Clear highlight with <esc>
vim.keymap.set({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and Clear hlsearch" })

-- Yank/cut/paste
vim.api.nvim_set_keymap("x", "<c-c>", '"*y :let @+=@*<CR>', { noremap = true, silent = true })

-- Terminals
vim.keymap.set({ "n", "i", "t" }, "<c-\\>", function()
    Snacks.terminal(nil, {
        border = "rounded",
        cwd = LazyVim.root.get(),
        win = {
            position = "float",
            border = "rounded",
            relative = "editor",
        },
        env = { TERM_TYPE = "float" },
    })
end, { noremap = true, silent = true, desc = "Float terminal" })
vim.keymap.set({ "n", "i", "t" }, "<c-enter>", function()
    Snacks.terminal(nil, {
        border = "rounded",
        cwd = LazyVim.root.get(),
        win = { position = "bottom", relative = "editor" },
        env = { TERM_TYPE = "bottom" },
    })
end, { noremap = true, silent = true, desc = "Bottom terminal" })

-- Misc
vim.keymap.set("n", "<leader>w", "<cmd>w! | lua vim.notify('File written')<cr>", { desc = "Save buffer" })
vim.keymap.set("n", "<leader>`", "<cmd>e #<cr>", { desc = "Switch buffer" })
vim.keymap.set("n", "<leader>um", "<cmd>MouseToggle<cr>", { desc = "Toggle mouse mode" })
vim.keymap.set("n", "<leader>ur", "<cmd>NuModeToggle<cr>", { desc = "Toggle number mode" })
vim.keymap.set("n", "<leader>uN", "<cmd>NoNuMode<cr>", { desc = "No number mode" })
vim.keymap.set("n", "<leader>uk", "<cmd>Telescope keymaps<cr>", { desc = "Key Maps" })
Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")

-- test
vim.api.nvim_create_user_command("Format", function(args)
    local range = nil
    if args.count ~= -1 then
        local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
        range = {
            start = { args.line1, 0 },
            ["end"] = { args.line2, end_line:len() },
        }
    end
    require("conform").format({ async = true, lsp_format = "fallback", range = range })
end, { range = true })
