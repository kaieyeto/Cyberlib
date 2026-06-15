--[[
    Keybind Module
    Keyboard binding system
]]

local Keybind = {}
Keybind.__index = Keybind

local UserInputService = game:GetService("UserInputService")

function Keybind.new(config, section)
    local self = setmetatable({}, Keybind)
    
    self.Name = config.Name or "Keybind"
    self.Default = config.Default or Enum.KeyCode.RightShift
    self.Current = self.Default
    self.Callback = config.Callback or function() end
    self.Section = section
    self.Listening = false
    
    self:CreateKeybind()
    
    return self
end

function Keybind:CreateKeybind()
    local theme = self.Section.Tab.Window.Theme
    
    -- Container
    local container = Instance.new("Frame")
    container.Name = self.Name
    container.Size = UDim2.new(1, 0, 0, 35)
    container.Position = UDim2.new(0, 0, 0, self.Section.CurrentY)
    container.BackgroundTransparency = 1
    container.Parent = self.Section.Container
    
    -- Background
    local bg = Instance.new("Frame")
    bg.Name = "Background"
    bg.Size = UDim2.new(1, -10, 1, -5)
    bg.Position = UDim2.new(0, 5, 0, 2)
    bg.BackgroundColor3 = theme.Background
    bg.BorderColor3 = theme.Border
    bg.BorderSizePixel = 1
    bg.Parent = container
    
    -- Label
    local label = Instance.new("TextLabel")
    label.Name = "Label"
    label.Size = UDim2.new(0.6, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.TextColor3 = theme.Text
    label.TextSize = 12
    label.Font = Enum.Font.GothamBold
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Text = "  " .. self.Name
    label.Parent = bg
    
    -- Key display
    local keyDisplay = Instance.new("TextButton")
    keyDisplay.Name = "KeyDisplay"
    keyDisplay.Size = UDim2.new(0.3, 0, 1, 0)
    keyDisplay.Position = UDim2.new(0.6, 0, 0, 0)
    keyDisplay.BackgroundColor3 = theme.Secondary
    keyDisplay.BorderColor3 = theme.Border
    keyDisplay.BorderSizePixel = 1
    keyDisplay.TextColor3 = theme.Accent
    keyDisplay.TextSize = 11
    keyDisplay.Font = Enum.Font.GothamBold
    keyDisplay.Text = tostring(self.Current):split(".")[3]
    keyDisplay.Parent = bg
    
    self.Container = container
    self.KeyDisplay = keyDisplay
    
    -- Start listening for key
    keyDisplay.MouseButton1Click:Connect(function()
        self.Listening = true
        keyDisplay.Text = "..."
        keyDisplay.BackgroundColor3 = theme.Accent
        keyDisplay.TextColor3 = theme.Background
    end)
    
    -- Listen for input
    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if not self.Listening then return end
        
        if input.UserInputType == Enum.UserInputType.Keyboard then
            self.Current = input.KeyCode
            keyDisplay.Text = tostring(input.KeyCode):split(".")[3]
            keyDisplay.BackgroundColor3 = theme.Secondary
            keyDisplay.TextColor3 = theme.Accent
            self.Listening = false
        end
    end)
    
    -- Keybind activation
    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed or self.Listening then return end
        
        if input.KeyCode == self.Current then
            self.Callback()
        end
    end)
    
    self.Section:AddElementHeight(35)
end

return Keybind
