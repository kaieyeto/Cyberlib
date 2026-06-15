# CyberLib - GitHub Setup Guide

## How to Upload to GitHub

### Step 1: Create a GitHub Repository

1. Go to [github.com/new](https://github.com/new)
2. **Repository name**: `CyberLib`
3. **Description**: `Futuristic Roblox UI Framework v1.0`
4. **Public** (so others can download it)
5. Click **Create repository**

### Step 2: Initialize Git Locally

```powershell
cd "$env:USERPROFILE\Downloads\CyberLib"
git init
git config user.name "Your Name"
git config user.email "your.email@example.com"
```

### Step 3: Upload to GitHub

```powershell
git add .
git commit -m "Initial commit: CyberLib v1.0 framework"
git branch -M main
git remote add origin https://github.com/YOUR_USERNAME/CyberLib.git
git push -u origin main
```

**Replace `YOUR_USERNAME` with your actual GitHub username**

---

## How to Use GitHub Link Locally

### Option A: Using the Loader (Recommended)

1. **Download the repository** to your local game:
   ```bash
   git clone https://github.com/YOUR_USERNAME/CyberLib.git
   ```

2. **In your game, use Loader.lua**:
   ```lua
   local Loader = require(script.Parent.Loader)
   
   -- Load from local files
   local Library = Loader:LoadLibrary()
   
   -- OR switch to GitHub
   Loader.Config.UseGithub = true
   Loader.Config.GitHubUsername = "YOUR_USERNAME"
   local Library = Loader:LoadLibrary()
   ```

### Option B: Direct GitHub Loading (No Local Copy)

```lua
local HttpService = game:GetService("HttpService")

local function loadFromGitHub(path)
    local url = "https://raw.githubusercontent.com/YOUR_USERNAME/CyberLib/main/" .. path
    return loadstring(HttpService:GetAsync(url))()
end

-- Load library directly from GitHub
local Library = loadFromGitHub("Library.lua")

local Window = Library:CreateWindow({
    Title = "My Hub",
    Theme = "Cyberpunk"
})
```

### Option C: Mixed Mode (GitHub + Local)

```lua
local Loader = require(script.Parent.Loader)

-- Configure
Loader.Setup({
    UseGithub = false,  -- Use local files
    GitHubUsername = "YOUR_USERNAME",
    GitHubRepo = "CyberLib",
    GitHubBranch = "main"
})

-- Load library (will use local files)
local Library = Loader:LoadLibrary()

-- But you can switch anytime
Loader.Config.UseGithub = true
-- Now it will load from GitHub
```

---

## GitHub Repository Structure

After uploading, your GitHub repo will look like:

```
YOUR_USERNAME/CyberLib
├── Library.lua
├── Window.lua
├── Tab.lua
├── Section.lua
├── Button.lua
├── Toggle.lua
├── Slider.lua
├── Dropdown.lua
├── Keybind.lua
├── ThemeManager.lua
├── ConfigManager.lua
├── NotificationManager.lua
├── EffectManager.lua
├── ProfileManager.lua
├── MobileManager.lua
├── AssetManager.lua
├── Loader.lua
├── Example.lua
├── README.md
├── SETUP.md
├── FEATURES.md
├── INDEX.md
├── INSTALLATION.md
└── GITHUB_SETUP.md
```

**GitHub URL**: `https://github.com/YOUR_USERNAME/CyberLib`

---

## Sharing with Others

### Share GitHub Link
```
https://github.com/YOUR_USERNAME/CyberLib
```

### Share Raw File Links
- Library: `https://raw.githubusercontent.com/YOUR_USERNAME/CyberLib/main/Library.lua`
- Window: `https://raw.githubusercontent.com/YOUR_USERNAME/CyberLib/main/Window.lua`
- Etc...

### Share Clone Command
```bash
git clone https://github.com/YOUR_USERNAME/CyberLib.git
```

---

## Using Loader Configurations

### Example: Auto-Detect Environment
```lua
local Loader = require(script.Parent.Loader)

-- Check if GitHub is available
local githubAvailable = pcall(function()
    local HttpService = game:GetService("HttpService")
    HttpService:GetAsync("https://github.com")
end)

-- Use GitHub if available, otherwise local
Loader.Config.UseGithub = githubAvailable
Loader.Config.GitHubUsername = "YOUR_USERNAME"

local Library = Loader:LoadLibrary()
```

### Example: Custom GitHub Organization
```lua
local Loader = require(script.Parent.Loader)

Loader.Setup({
    UseGithub = true,
    GitHubUsername = "MyOrganization",  -- Organization name
    GitHubRepo = "CyberLib",
    GitHubBranch = "main"
})

local Library = Loader:LoadLibrary()
```

---

## Checking Loader Status

```lua
local Loader = require(script.Parent.Loader)

-- Print current configuration
Loader:PrintStatus()

-- Get status programmatically
local status = Loader:GetStatus()
print("Current Mode:", status.Mode)
print("GitHub URL:", status.GitHubUrl)
```

---

## Updating CyberLib on GitHub

After making changes locally:

```powershell
cd "$env:USERPROFILE\Downloads\CyberLib"
git add .
git commit -m "Update: Added new feature"
git push origin main
```

---

## Version Management

### Create a Release on GitHub

1. Go to your repository
2. Click **Releases** on the right sidebar
3. Click **Create a new release**
4. Tag: `v1.0.0`
5. Title: `CyberLib v1.0`
6. Describe changes
7. Click **Publish release**

Then people can download specific versions:
```bash
# Download v1.0.0
git clone --branch v1.0.0 https://github.com/YOUR_USERNAME/CyberLib.git
```

---

## Quick Links Template

Save this and share with others:

```markdown
# CyberLib v1.0

Futuristic Roblox UI Framework

- **GitHub**: https://github.com/YOUR_USERNAME/CyberLib
- **Installation**: `git clone https://github.com/YOUR_USERNAME/CyberLib.git`
- **Documentation**: https://github.com/YOUR_USERNAME/CyberLib/blob/main/README.md
- **Quick Start**: https://github.com/YOUR_USERNAME/CyberLib/blob/main/SETUP.md

### Features
- 4 built-in themes
- Draggable & resizable windows
- Mobile support
- Config save/load system
- Notification system
- And more...
```

---

## Troubleshooting

### "HttpService not enabled" Error
- Go to Game Settings → Security
- Enable HttpService for both Client and Server

### "Failed to authenticate" Error
- Check your GitHub credentials
- Verify repository is public
- Check internet connection

### Module not found locally
- Ensure all files are in the same folder
- Check folder permissions
- Verify folder structure

### GitHub rate limiting
- GitHub limits unauthenticated requests to 60/hour
- Add authentication for more requests
- Or use the local loading option

---

## Final Steps

1. ✅ Create GitHub repository
2. ✅ Upload CyberLib files
3. ✅ Update `YOUR_USERNAME` in Loader.lua
4. ✅ Test loading (local first, then GitHub)
5. ✅ Share the repository link

**Your CyberLib is now version-controlled and shareable!** 🎉
