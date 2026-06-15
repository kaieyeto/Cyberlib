# CyberLib v1.0 - Installation Methods

## Method 1: Direct Download from GitHub

### Download the Repository
1. Go to: https://github.com/YOUR_USERNAME/CyberLib
2. Click the green "Code" button
3. Select "Download ZIP"
4. Extract to your Roblox project folder

### Or Use Git Clone
```bash
git clone https://github.com/YOUR_USERNAME/CyberLib.git
```

## Method 2: Use as Roblox Model (Wally Package)

### Create `wally.toml` in your project:
```toml
[package]
name = "yourname/cyberlib"
description = "CyberLib v1.0 - Futuristic Roblox UI Framework"
version = "1.0.0"
license = "MIT"
realm = "shared"

[dependencies]
```

### Then install:
```bash
wally install
```

## Method 3: Manual Integration

1. Copy all `.lua` files to your game
2. Place in `ServerScriptService` or appropriate location
3. Require the Library: `local Library = require(game.ServerScriptService.CyberLib.Library)`

## Method 4: GitHub Raw Links (Advanced)

### Load Directly from GitHub:
```lua
local HttpService = game:GetService("HttpService")

local function loadFromGithub(path)
    local url = "https://raw.githubusercontent.com/YOUR_USERNAME/CyberLib/main/" .. path
    local response = HttpService:GetAsync(url)
    return loadstring(response)()
end

-- Load library
local Library = loadFromGithub("Library.lua")
```

## Quick Start After Installation

```lua
local Library = require(script.Parent.CyberLib.Library)

local Window = Library:CreateWindow({
    Title = "My Hub",
    Theme = "Cyberpunk"
})

local Main = Window:CreateTab({Name = "Main", Icon = "🏠"})
local Section = Main:CreateSection("Welcome")

Section:CreateButton({
    Name = "Hello World",
    Callback = function()
        print("CyberLib loaded!")
    end
})
```

## Troubleshooting

### "Module not found" Error
- Ensure all files are in the same folder
- Check folder structure matches your require paths
- Verify script location and parent hierarchy

### GitHub Raw Links Not Working
- Verify YOUR_USERNAME is replaced with actual GitHub username
- Check internet connection
- Ensure HttpService is enabled

### Permission Denied
- Run game as administrator
- Check file permissions
- Ensure folder is not read-only

## Support

For issues, visit: https://github.com/YOUR_USERNAME/CyberLib/issues

## GitHub Links

- **Repository**: https://github.com/YOUR_USERNAME/CyberLib
- **Releases**: https://github.com/YOUR_USERNAME/CyberLib/releases
- **Documentation**: https://github.com/YOUR_USERNAME/CyberLib#readme
