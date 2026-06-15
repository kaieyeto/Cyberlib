--[[
    AssetManager
    Manages and loads UI assets (icons, images, fonts)
]]

local AssetManager = {}

local icons = {
    home = "🏠",
    settings = "⚙️",
    user = "👤",
    search = "🔍",
    close = "✕",
    minimize = "—",
    maximize = "▢",
    dropdown = "▼",
    upload = "📤",
    download = "📥",
    save = "💾",
    delete = "🗑️",
    edit = "✎",
    check = "✓",
    x = "✕"
}

local fonts = {
    Default = Enum.Font.Gotham,
    Bold = Enum.Font.GothamBold,
    Mono = Enum.Font.GothamMono
}

function AssetManager.GetIcon(iconName)
    return icons[iconName] or iconName
end

function AssetManager.GetFont(fontName)
    return fonts[fontName] or Enum.Font.Gotham
end

function AssetManager.AddIcon(name, icon)
    icons[name] = icon
end

function AssetManager.AddFont(name, font)
    fonts[name] = font
end

function AssetManager.GetAllIcons()
    return icons
end

function AssetManager.GetAllFonts()
    return fonts
end

return AssetManager
