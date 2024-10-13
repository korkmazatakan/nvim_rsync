# Neovim Remote Sync Plugin

This Neovim plugin, written in Lua, provides a set of commands to help synchronize your local project with a remote server using `rsync`. It enables you to manually sync your project, set up automatic sync based on file patterns, and manage the sync configuration within Neovim.

## Features

- **Manual Project Sync:** Sync your current project directory to the remote server using `SyncProject`.
- **Automatic Sync:** Automatically sync changes based on file patterns using `SyncAuto`.

## Installation

Use your preferred plugin manager to install the plugin.

For example:

**packer**
```lua
use({
    'korkmazatakan/neovim_rsync',
    config = function()
        require('neovim_rsync').setup({
            username = 'atakankorkmaz' -- your remote username
        })
    end
})
```

**lazy**
```lua
{
    "korkmazatakan/neovim_rsync",
    branch = "master",
    config = function ()
        local nr = require('neovim_rsync')
        nr.setup({
            username = 'atakankorkmaz' -- your remote username
        })
    end
}
```

## Commands

### `:SyncProject`

**Description:**  
Manually synchronize the current project directory with the remote server using `rsync`.

**Usage:**  
Simply run the command.


### `:SyncAuto`

**Description:**  
Automatically synchronize files based on a specified pattern. If no pattern is provided, it defaults to all files (`*`). This command watches for file changes and synchronizes the changes automatically.

**Usage:**  
You can specify a pattern (e.g., `*.php` to watch only PHP files):


### `:SyncRemotePath <path>`

**Description:**  
Set or update the remote directory path for synchronization.

**Usage:**  
Provide the remote path as an argument:
/path/to/remote/directory


### `:SyncRemoteHost <host>`

**Description:**  
Set or update the remote host address.

**Usage:**  
Provide the remote host as an argument:
user@remote-host.com


### `:SyncInfo`

**Description:**  
Displays the current synchronization configuration, including:

- **Remote Host**: The address of the remote server.
- **Remote Path**: The directory path on the remote server.
- **Local Path**: The current working directory of your Neovim instance.

**Usage:**  
Simply run the command to view the current sync configuration.

## Configuration

The plugin can be configured using a Lua setup function. This function allows you to set up default values for options like the remote host and path. Here’s an example of how you can configure it in your `init.lua`:

```lua
require('neovim-project-sync').setup({
    host = 'user@remote-server.com',
    remote_path = '/var/www/project',
    auto_sync = false, -- Optional: Set to true if you want to enable automatic sync by default.
})
```

### Available Configuration Options

- **`host`**: Default remote host address.  
  Example: `'user@remote-server.com'`

- **`remote_path`**: Default remote directory path.  
  Example: `'/var/www/project'`

- **`auto_sync`**: Enable or disable automatic sync by default (boolean).  
  Example: `true` or `false`

## Example Use Case

This plugin is particularly useful in scenarios where you need to synchronize code between your local development environment and a remote server. Some example use cases include:

1. **Remote Web Development**: You are working on a web project locally and want to deploy changes immediately to a remote server for testing. By using `:SyncAuto`, you can ensure that every time you save a file, it is automatically synced with the server.
2. **Collaborative Development**: Use the plugin to sync your changes to a shared development server where other team members can see updates in real-time.
3. **Quick Deployment**: Use `:SyncProject` to quickly push changes to a production or staging environment, saving you from manual deployment steps.

## Troubleshooting

### 1. **Rsync Not Found**

Ensure that `rsync` is installed and accessible from your system’s PATH. You can check this by running:

```bash
rsync --version
```
If rsync is not installed, install it using your package manager:

- **Ubuntu/Debian:** ``sudo apt-get install rsync``
- **macOS:**  ``brew install rsync``

### 2. **SSH Connectivity Issues**

If you encounter issues connecting to the remote server, check your SSH configuration. Ensure that you can manually SSH into the server:

```bash
ssh user@remote-server.com
```
If prompted for a password, consider setting up an SSH key for passwordless access.

### 3. **Permission Issues**

Make sure that the user specified in `SyncRemoteHost` has the necessary permissions to write to the `remote_path`. This might involve adjusting the directory permissions on the server or using a different user account.


