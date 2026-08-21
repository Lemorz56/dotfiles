return {
    {
        "mzlogin/vim-markdown-toc",
        ft = "markdown",
        lazy = true,
        cmd = { "GenTocGFM", "GenTocGitLab", "GenTocMarked", "GenTocModeline", "GenTocRedcarpet" },
    },
    {
        "jghauser/follow-md-links.nvim",
        ft = { "markdown" },
    },
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        ft = { "markdown" },
        build = function()
            vim.fn["mkdp#util#install"]()
        end,
        config = function()
            -- /mnt/c/Program\ Files/Google/Chrome/Application/chrome.exe
            -- let cmd = "google-chrome-stable --new-window " . shellescape(a:url) . " &"
            vim.cmd([[do FileType]])
            -- vim.cmd([[
            --     function OpenMarkdownPreview (url)
            --         let cmd = "/mnt/c/Program\ Files/Google/Chrome/Application/chrome.exe --new-window " . shellescape(a:url) . " &"
            --         silent call system(cmd)
            --     endfunction
            -- ]])
            vim.g.mkdp_browserfunc = "OpenMarkdownPreview"
        end,
    },
}
