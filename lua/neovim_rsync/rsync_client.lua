-- rsync_client.lua
--
local config = require("neovim_rsync.config")

local rsync_client = {}

function rsync_client.sync(local_path)
    rsync_client.check_config()

    local command = string.format("rsync -aqz --timeout=%s %s/ %s@%s:%s", config.options.timeout, local_path, config.options.username, config.options.host, config.options.remote_path)

    vim.fn.jobstart(command, {
        on_stdout = function (_, data, _)
            if data then
                print(table.concat(data, "\n"))
            end
        end,
        on_stderr = function (_, data, _)
            if data then
                print("Error: " .. table.concat(data, "\n"))
            end
        end,
        on_exit = function (_, code, _)
            print("Synced! Job exited with code " .. code)
        end,
    })
end

function rsync_client.autosync(pattern)
    rsync_client.check_config()

    local group = vim.api.nvim_create_augroup("SyncProjectGroup", { clear = true })
    vim.api.nvim_create_autocmd('BufWritePost', {
        pattern = pattern,
        command = "SyncProject",
        group = group
    })

    print("\nAuto sync set for pattern: " .. pattern)
end

function rsync_client.remove_autosync(pattern)
    vim.api.nvim_clear_autocmds({ group = "SyncProjectGroup" })
    vim.notify("Auto sync removed", vim.log.levels.INFO)
end

function rsync_client.check_config()
    if config.options.host == '' or config.options.host == nil then
        local remote_host = vim.fn.input("Enter remote host: ")
        config.change_remote_host(remote_host)
    end

    if config.options.remote_path == '' or config.options.remote_path == nil then
        local remote_path = vim.fn.input("Enter remote path (e.g., /www/api/prod/): ")
        config.change_remote_path(remote_path)
    end
end

return rsync_client

