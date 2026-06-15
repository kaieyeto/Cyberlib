--[[
    ConfigManager
    Handles saving and loading configurations
]]

local ConfigManager = {}

local HttpService = game:GetService("HttpService")

local configFolder = "CyberLib_Configs"

function ConfigManager.Initialize()
    -- Initialize config system
end

function ConfigManager.SaveConfig(configName, library)
    local configData = {
        Theme = library.CurrentTheme,
        CreatedAt = os.time(),
        Elements = {}
    }
    
    -- Iterate through windows and collect element states
    for _, window in ipairs(library.Windows) do
        for _, tab in ipairs(window.Tabs) do
            for _, section in ipairs(tab.Sections) do
                for _, element in ipairs(section.Elements) do
                    if element.Flag and element.Value then
                        configData.Elements[element.Flag] = element.Value
                    end
                end
            end
        end
    end
    
    -- Simulate save (in real implementation, use file system or LocalStorage)
    library.Configs[configName] = configData
    print("Config '" .. configName .. "' saved successfully")
end

function ConfigManager.LoadConfig(configName, library)
    if not library.Configs[configName] then
        warn("Config '" .. configName .. "' not found")
        return
    end
    
    local configData = library.Configs[configName]
    
    -- Load theme
    if configData.Theme then
        library:SetTheme(configData.Theme)
    end
    
    -- Load element states
    for _, window in ipairs(library.Windows) do
        for _, tab in ipairs(window.Tabs) do
            for _, section in ipairs(tab.Sections) do
                for _, element in ipairs(section.Elements) do
                    if element.Flag and configData.Elements[element.Flag] then
                        element.Value = configData.Elements[element.Flag]
                        if element.Callback then
                            element.Callback(element.Value)
                        end
                    end
                end
            end
        end
    end
    
    print("Config '" .. configName .. "' loaded successfully")
end

function ConfigManager.DeleteConfig(configName)
    ConfigManager.Configs[configName] = nil
    print("Config '" .. configName .. "' deleted")
end

function ConfigManager.ListConfigs()
    local configs = {}
    for name, _ in pairs(ConfigManager.Configs or {}) do
        table.insert(configs, name)
    end
    return configs
end

return ConfigManager
