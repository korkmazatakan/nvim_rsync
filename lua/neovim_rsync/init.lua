
local M = {}

local config = require("neovim_rsync.config")
local commands = require("neovim_rsync.commands")

function M.setup(opts)
    config.setup(opts)
    commands.setup()
end

return M

