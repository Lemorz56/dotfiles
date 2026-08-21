local ok, _ = pcall(require, 'mason-registry')
if not ok then
    vim.notify 'mason-registry could not be loaded'
    return
end

-- local angularls_path =
--     mason_registry.get_package('angular-language-server'):get_install_path()
local install_location = require('mason-core.installer.InstallLocation')
local path = install_location.global():package('angular-language-server')

local cmd = {
    'ngserver',
    '--stdio',
    '--tsProbeLocations',
    table.concat({
        path,
        vim.uv.cwd(),
    }, ','),
    '--ngProbeLocations',
    table.concat({
        path .. '/node_modules/@angular/language-server',
        vim.uv.cwd(),
    }, ','),
}

return {
    "neovim/nvim-lspconfig",
    opts = {
        servers = {
            angularls = {
                cmd = cmd,
                on_new_config = function(new_config, new_root_dir)
                    new_config.cmd = cmd
                end,
                -- filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
                -- root_dir = function(fname)
                --     return require("lspconfig.util").root_pattern("angular.json", "angular.yaml", "angular.yml", ".git")(fname) or vim.loop.os_homedir()
                -- end,
            },
        },
    },
}
