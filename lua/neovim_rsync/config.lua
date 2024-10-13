-- config.lua

local config = {}

config.options = {
    host = "",
    username = "",
    timeout = 30,
    remote_path = "",
    auto_sync = false
}

function config.setup(user_config)
    config.options = vim.tbl_extend("force", config.options, user_config or {})
end

function config.change_remote_path(remote_path)
    config.options.remote_path = remote_path
end

function config.change_remote_host(remote_host)
    config.options.host = remote_host
end

return config

