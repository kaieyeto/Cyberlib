--[[
    CyberLib Loader
    Automatically loads CyberLib from local or GitHub
    Place this in your game and require it
]]

local Loader = {}

local HttpService = game:GetService("HttpService")

-- Configuration
Loader.Config = {
    -- Set to true to load from GitHub, false to load locally
    UseGithub = false,
    
    -- GitHub settings
    GitHubUsername = "YOUR_USERNAME",
    GitHubRepo = "CyberLib",
    GitHubBranch = "main",
    
    -- Local settings
    LocalPath = "ServerScriptService/CyberLib"
}

-- ============================================================================
-- GITHUB LOADING
-- ============================================================================

function Loader.GetGitHubUrl(filePath)
    return string.format(
        "https://raw.githubusercontent.com/%s/%s/%s/%s",
        Loader.Config.GitHubUsername,
        Loader.Config.GitHubRepo,
        Loader.Config.GitHubBranch,
        filePath
    )
end

function Loader.LoadFromGitHub(moduleName)
    local url = Loader.GetGitHubUrl(moduleName .. ".lua")
    
    local success, response = pcall(function()
        return HttpService:GetAsync(url)
    end)
    
    if success then
        return loadstring(response)()
    else
        error("Failed to load " .. moduleName .. " from GitHub: " .. tostring(response))
    end
end

function Loader.LoadFromGitHubAsync(moduleName, callback)
    task.spawn(function()
        local success, result = pcall(function()
            return Loader.LoadFromGitHub(moduleName)
        end)
        
        callback(success, result)
    end)
end

-- ============================================================================
-- LOCAL LOADING
-- ============================================================================

function Loader.GetLocalPath(moduleName)
    return game:GetService("ServerScriptService"):FindFirstChild("CyberLib"):FindFirstChild(moduleName)
end

function Loader.LoadLocally(moduleName)
    local module = Loader.GetLocalPath(moduleName)
    
    if not module then
        error("Module " .. moduleName .. " not found locally at " .. Loader.Config.LocalPath)
    end
    
    return require(module)
end

-- ============================================================================
-- UNIFIED LOADING
-- ============================================================================

function Loader.Load(moduleName)
    if Loader.Config.UseGithub then
        return Loader.LoadFromGitHub(moduleName)
    else
        return Loader.LoadLocally(moduleName)
    end
end

function Loader.LoadLibrary()
    return Loader.Load("Library")
end

-- ============================================================================
-- SETUP FUNCTION
-- ============================================================================

function Loader.Setup(config)
    if config then
        for key, value in pairs(config) do
            Loader.Config[key] = value
        end
    end
    
    return Loader.LoadLibrary()
end

-- ============================================================================
-- STATUS & DEBUG
-- ============================================================================

function Loader.GetStatus()
    return {
        UseGithub = Loader.Config.UseGithub,
        GitHubUrl = Loader.GetGitHubUrl(""),
        LocalPath = Loader.Config.LocalPath,
        Mode = Loader.Config.UseGithub and "GitHub" or "Local"
    }
end

function Loader.PrintStatus()
    local status = Loader.GetStatus()
    print("=== CyberLib Loader Status ===")
    print("Mode: " .. status.Mode)
    if status.UseGithub then
        print("GitHub URL: " .. status.GitHubUrl)
    else
        print("Local Path: " .. status.LocalPath)
    end
end

return Loader
