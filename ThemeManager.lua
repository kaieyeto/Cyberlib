--[[
    ThemeManager
    Handles theme switching and customization
]]

local ThemeManager = {}

function ThemeManager.Initialize(library)
    ThemeManager.Library = library
end

function ThemeManager.SetTheme(themeName)
    ThemeManager.Library:SetTheme(themeName)
end

function ThemeManager.AddTheme(name, config)
    ThemeManager.Library:AddTheme(name, config)
end

function ThemeManager.GetCurrentTheme()
    return ThemeManager.Library:GetTheme()
end

function ThemeManager.GetAllThemes()
    return ThemeManager.Library.Themes
end

return ThemeManager
