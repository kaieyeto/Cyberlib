--[[
    CyberLib v1.0 - Futuristic Roblox UI Framework
    Inspired by Rayfield, Fluent, MacLib, Kavo UI, and Argon Hub X
    
    Design Goals:
    - Fast, Mobile friendly, Lightweight
    - Highly customizable, Theme engine, Config system
    - Profile system, Modern animations
]]

local Library = {
    _Version = "1.0.0",
    _Name = "CyberLib",
    Windows = {},
    Themes = {},
    CurrentTheme = "Cyberpunk",
    Configs = {},
    Profiles = {}
}

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")

-- Preload UI Library files
local Window = require(script:WaitForChild("Window"))
local Tab = require(script:WaitForChild("Tab"))
local Section = require(script:WaitForChild("Section"))
local Button = require(script:WaitForChild("Button"))
local Toggle = require(script:WaitForChild("Toggle"))
local Slider = require(script:WaitForChild("Slider"))
local Dropdown = require(script:WaitForChild("Dropdown"))
local Keybind = require(script:WaitForChild("Keybind"))
local ThemeManager = require(script:WaitForChild("ThemeManager"))
local ConfigManager = require(script:WaitForChild("ConfigManager"))
local NotificationManager = require(script:WaitForChild("NotificationManager"))
local EffectManager = require(script:WaitForChild("EffectManager"))
local MobileManager = require(script:WaitForChild("MobileManager"))
local ProfileManager = require(script:WaitForChild("ProfileManager"))

-- ============================================================================
-- THEME DEFINITIONS
-- ============================================================================

Library.Themes = {
    Cyberpunk = {
        Accent = Color3.fromRGB(0, 255, 255),
        Secondary = Color3.fromRGB(255, 0, 255),
        Background = Color3.fromRGB(10, 10, 15),
        Text = Color3.fromRGB(255, 255, 255),
        TextSecondary = Color3.fromRGB(180, 180, 200),
        Border = Color3.fromRGB(50, 50, 70)
    },
    Matrix = {
        Accent = Color3.fromRGB(0, 255, 0),
        Secondary = Color3.fromRGB(50, 255, 50),
        Background = Color3.fromRGB(5, 5, 5),
        Text = Color3.fromRGB(200, 255, 200),
        TextSecondary = Color3.fromRGB(100, 200, 100),
        Border = Color3.fromRGB(30, 100, 30)
    },
    Crimson = {
        Accent = Color3.fromRGB(255, 0, 0),
        Secondary = Color3.fromRGB(255, 100, 100),
        Background = Color3.fromRGB(20, 5, 5),
        Text = Color3.fromRGB(255, 255, 255),
        TextSecondary = Color3.fromRGB(220, 150, 150),
        Border = Color3.fromRGB(100, 30, 30)
    },
    Ocean = {
        Accent = Color3.fromRGB(0, 170, 255),
        Secondary = Color3.fromRGB(0, 255, 255),
        Background = Color3.fromRGB(10, 20, 30),
        Text = Color3.fromRGB(255, 255, 255),
        TextSecondary = Color3.fromRGB(150, 200, 255),
        Border = Color3.fromRGB(30, 80, 120)
    }
}

-- ============================================================================
-- WINDOW CREATION
-- ============================================================================

function Library:CreateWindow(config)
    local window = Window.new(config, Library)
    table.insert(Library.Windows, window)
    return window
end

-- ============================================================================
-- THEME MANAGEMENT
-- ============================================================================

function Library:SetTheme(themeName)
    if not Library.Themes[themeName] then
        warn("CyberLib: Theme '" .. themeName .. "' not found")
        return
    end
    
    Library.CurrentTheme = themeName
    
    -- Update all windows with new theme
    for _, window in ipairs(Library.Windows) do
        window:UpdateTheme(Library.Themes[themeName])
    end
end

function Library:GetTheme(themeName)
    return Library.Themes[themeName or Library.CurrentTheme]
end

function Library:AddTheme(themeName, themeConfig)
    Library.Themes[themeName] = themeConfig
end

function Library:ExportTheme()
    local currentTheme = Library:GetTheme()
    return HttpService:JSONEncode(currentTheme)
end

function Library:ImportTheme(themeJson, themeName)
    local theme = HttpService:JSONDecode(themeJson)
    Library:AddTheme(themeName or "Imported", theme)
end

-- ============================================================================
-- CONFIG MANAGEMENT
-- ============================================================================

function Library:SaveConfig(configName)
    ConfigManager.SaveConfig(configName, Library)
end

function Library:LoadConfig(configName)
    ConfigManager.LoadConfig(configName, Library)
end

function Library:DeleteConfig(configName)
    ConfigManager.DeleteConfig(configName)
end

function Library:ListConfigs()
    return ConfigManager.ListConfigs()
end

-- ============================================================================
-- NOTIFICATION SYSTEM
-- ============================================================================

function Library:Notify(config)
    NotificationManager.Show(config)
end

-- ============================================================================
-- PROFILE SYSTEM
-- ============================================================================

function Library:CreateProfile(username, userId)
    return ProfileManager.CreateProfile(username, userId)
end

function Library:GetProfile()
    return ProfileManager.GetCurrentProfile()
end

-- ============================================================================
-- UTILITIES
-- ============================================================================

function Library:GetLocalPlayer()
    return Players.LocalPlayer
end

function Library:Cleanup()
    -- Cleanup all windows
    for _, window in ipairs(Library.Windows) do
        if window.Cleanup then
            window:Cleanup()
        end
    end
    Library.Windows = {}
end

function Library:GetVersion()
    return Library._Version
end

-- ============================================================================
-- INITIALIZATION
-- ============================================================================

-- Initialize Managers
ThemeManager.Initialize(Library)
ConfigManager.Initialize()
NotificationManager.Initialize()
ProfileManager.Initialize()
MobileManager.Initialize()

return Library
