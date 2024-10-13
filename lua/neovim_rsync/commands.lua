-- commands.lua

local commands = {}
local rsync_client = require("neovim_rsync.rsync_client")
local config = require("neovim_rsync.config")

function commands.setup()
    if config.options.auto_sync == true then
        print('Auto sync is open!\n')
        rsync_client.autosync('*')
    end

    vim.api.nvim_create_user_command("SyncProject", function()
        local local_path = vim.fn.getcwd()
        rsync_client.sync(local_path)
    end, {})

    vim.api.nvim_create_user_command("SyncAuto", function()
        local pattern = vim.fn.input("Enter file pattern (e.g., *.php): ")
        if pattern == "" then
            pattern = "*"
        end
        rsync_client.autosync(pattern)
    end, { nargs = 0})

    vim.api.nvim_create_user_command("SyncRemoveAuto", function()
        rsync_client.remove_autosync()
    end, {})

    vim.api.nvim_create_user_command("SyncRemotePath", function(opts)
        config.change_remote_path(opts.fargs[1])
        vim.notify('remote path set as ' .. opts.fargs[1], vim.log.levels.INFO)
    end, { nargs = "*"})

    vim.api.nvim_create_user_command("SyncRemoteHost", function(opts)
        config.change_remote_host(opts.fargs[1])
        vim.notify('remote host set as ' .. opts.fargs[1], vim.log.levels.INFO)
    end, { nargs = "*"})

    vim.api.nvim_create_user_command("SyncInfo", function()
        vim.notify('Remote host: ' .. config.options.host, vim.log.levels.INFO)
        vim.notify('Remote path: ' .. config.options.remote_path, vim.log.levels.INFO)
        vim.notify('Local path: ' .. vim.fn.getcwd(), vim.log.levels.INFO)
    end, {})
end

return commands

