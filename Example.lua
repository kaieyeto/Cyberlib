--[[
    CyberLib v1.0 - Example Usage
    This file demonstrates how to use the CyberLib UI framework
]]

-- Get the library
local Library = require(script.Parent.Library)

-- ============================================================================
-- WINDOW CREATION
-- ============================================================================

local Window = Library:CreateWindow({
    Title = "Jayden Hub",
    Subtitle = "Cyber Edition",
    Theme = "Cyberpunk",
    SaveConfig = true,
    ConfigFolder = "CyberLib"
})

-- ============================================================================
-- TAB CREATION
-- ============================================================================

local MainTab = Window:CreateTab({
    Name = "Main",
    Icon = "🏠"
})

local VisualsTab = Window:CreateTab({
    Name = "Visuals",
    Icon = "👁️"
})

local SettingsTab = Window:CreateTab({
    Name = "Settings",
    Icon = "⚙️"
})

-- ============================================================================
-- MAIN TAB - COMBAT SECTION
-- ============================================================================

local Combat = MainTab:CreateSection("Combat")

Combat:CreateButton({
    Name = "Enable Combat Mode",
    Description = "Activates combat features",
    Callback = function()
        Library:Notify({
            Title = "Combat",
            Content = "Combat mode activated!",
            Duration = 2,
            Style = "Success"
        })
    end
})

Combat:CreateToggle({
    Name = "Auto Attack",
    Default = false,
    Flag = "AutoAttack",
    Callback = function(Value)
        print("Auto attack:", Value)
    end
})

Combat:CreateSlider({
    Name = "Attack Speed",
    Min = 0,
    Max = 100,
    Default = 50,
    Flag = "AttackSpeed",
    Callback = function(Value)
        print("Attack speed:", Value)
    end
})

-- ============================================================================
-- MAIN TAB - PLAYER SECTION
-- ============================================================================

local Player = MainTab:CreateSection("Player")

Player:CreateDropdown({
    Name = "Game Mode",
    Options = {"Survival", "Sandbox", "Creative", "Adventure"},
    Multi = false,
    Callback = function(Value)
        Library:Notify({
            Title = "Mode Changed",
            Content = "Game mode set to: " .. tostring(Value),
            Duration = 2
        })
    end
})

Player:CreateKeybind({
    Name = "Toggle Combat",
    Default = Enum.KeyCode.C,
    Callback = function()
        Library:Notify({
            Title = "Hotkey",
            Content = "Combat toggle activated!",
            Duration = 1,
            Style = "Info"
        })
    end
})

-- ============================================================================
-- VISUALS TAB
-- ============================================================================

local Vision = VisualsTab:CreateSection("Vision")

Vision:CreateToggle({
    Name = "ESP",
    Default = false,
    Flag = "ESP",
    Callback = function(Value)
        print("ESP:", Value)
    end
})

Vision:CreateToggle({
    Name = "Aimbot",
    Default = false,
    Flag = "Aimbot",
    Callback = function(Value)
        print("Aimbot:", Value)
    end
})

local Effects = VisualsTab:CreateSection("Effects")

Effects:CreateDropdown({
    Name = "Particle Effect",
    Options = {"None", "Fire", "Ice", "Electric", "Neon"},
    Multi = false,
    Callback = function(Value)
        print("Particle effect:", Value)
    end
})

Effects:CreateSlider({
    Name = "Effect Intensity",
    Min = 0,
    Max = 100,
    Default = 50,
    Flag = "EffectIntensity",
    Callback = function(Value)
        print("Effect intensity:", Value)
    end
})

-- ============================================================================
-- SETTINGS TAB
-- ============================================================================

local UISettings = SettingsTab:CreateSection("UI Settings")

UISettings:CreateDropdown({
    Name = "Theme",
    Options = {"Cyberpunk", "Matrix", "Crimson", "Ocean"},
    Multi = false,
    Callback = function(Value)
        Library:SetTheme(Value)
        Library:Notify({
            Title = "Theme",
            Content = "Theme changed to: " .. Value,
            Duration = 2,
            Style = "Success"
        })
    end
})

UISettings:CreateSlider({
    Name = "UI Scale",
    Min = 50,
    Max = 150,
    Default = 100,
    Flag = "UIScale",
    Callback = function(Value)
        print("UI scale:", Value)
    end
})

local Config = SettingsTab:CreateSection("Configuration")

Config:CreateButton({
    Name = "Save Config",
    Description = "Saves current settings",
    Callback = function()
        Library:SaveConfig("DefaultConfig")
        Library:Notify({
            Title = "Config",
            Content = "Settings saved!",
            Duration = 2,
            Style = "Success"
        })
    end
})

Config:CreateButton({
    Name = "Load Config",
    Description = "Loads saved settings",
    Callback = function()
        Library:LoadConfig("DefaultConfig")
        Library:Notify({
            Title = "Config",
            Content = "Settings loaded!",
            Duration = 2,
            Style = "Success"
        })
    end
})

Config:CreateButton({
    Name = "Reset to Defaults",
    Description = "Resets all settings",
    Callback = function()
        Library:Notify({
            Title = "Reset",
            Content = "Settings reset to defaults",
            Duration = 2,
            Style = "Warning"
        })
    end
})

-- ============================================================================
-- ADDITIONAL FEATURES
-- ============================================================================

-- Example hotkey
task.delay(1, function()
    Library:Notify({
        Title = "Welcome",
        Content = "CyberLib v1.0 loaded successfully!",
        Duration = 3,
        Style = "Success"
    })
end)

-- Return window for external access
return Window
