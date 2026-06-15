--[[
    Toggle Module
    Switch with neon glow effects
]]

local Toggle = {}
Toggle.__index = Toggle

local TweenService = game:GetService("TweenService")

function Toggle.new(config, section)
    local self = setmetatable({}, Toggle)
    
    self.Name = config.Name or "Toggle"
    self.Default = config.Default or false
    self.Flag = config.Flag or self.Name
    self.Value = self.Default
    self.Callback = config.Callback or function() end
    self.Section = section
    
    self:CreateToggle()
    
    return self
end

function Toggle:CreateToggle()
    local theme = self.Section.Tab.Window.Theme
    
    -- Container
    local container = Instance.new("Frame")
    container.Name = self.Name
    container.Size = UDim2.new(1, 0, 0, 40)
    container.Position = UDim2.new(0, 0, 0, self.Section.CurrentY)
    container.BackgroundTransparency = 1
    container.Parent = self.Section.Container
    
    -- Toggle background
    local toggleBg = Instance.new("Frame")
    toggleBg.Name = "ToggleBg"
    toggleBg.Size = UDim2.new(1, -10, 1, -5)
    toggleBg.Position = UDim2.new(0, 5, 0, 2)
    toggleBg.BackgroundColor3 = theme.Background
    toggleBg.BorderColor3 = theme.Border
    toggleBg.BorderSizePixel = 1
    toggleBg.Parent = container
    
    -- Label
    local label = Instance.new("TextLabel")
    label.Name = "Label"
    label.Size = UDim2.new(0.7, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.TextColor3 = theme.Text
    label.TextSize = 12
    label.Font = Enum.Font.GothamBold
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Text = "  " .. self.Name
    label.Parent = toggleBg
    
    -- Switch
    local switchBg = Instance.new("Frame")
    switchBg.Name = "SwitchBg"
    switchBg.Size = UDim2.new(0, 50, 0, 24)
    switchBg.Position = UDim2.new(1, -55, 0.5, -12)
    switchBg.BackgroundColor3 = theme.Border
    switchBg.BorderSizePixel = 0
    switchBg.Parent = toggleBg
    
    -- Neon corner
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12)
    corner.Parent = switchBg
    
    -- Switch knob
    local knob = Instance.new("Frame")
    knob.Name = "Knob"
    knob.Size = UDim2.new(0, 20, 0, 20)
    knob.Position = UDim2.new(0, 2, 0.5, -10)
    knob.BackgroundColor3 = theme.Text
    knob.BorderSizePixel = 0
    knob.Parent = switchBg
    
    local knobCorner = Instance.new("UICorner")
    knobCorner.CornerRadius = UDim.new(0, 10)
    knobCorner.Parent = knob
    
    self.Container = container
    self.ToggleBg = toggleBg
    self.SwitchBg = switchBg
    self.Knob = knob
    
    -- Update switch appearance
    local function updateSwitch()
        if self.Value then
            switchBg.BackgroundColor3 = theme.Accent
            TweenService:Create(
                knob,
                TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                {Position = UDim2.new(0, 28, 0.5, -10)}
            ):Play()
        else
            switchBg.BackgroundColor3 = theme.Border
            TweenService:Create(
                knob,
                TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                {Position = UDim2.new(0, 2, 0.5, -10)}
            ):Play()
        end
    end
    
    -- Initial state
    updateSwitch()
    
    -- Click handler
    local clickZone = Instance.new("TextButton")
    clickZone.Size = UDim2.new(1, 0, 1, 0)
    clickZone.BackgroundTransparency = 1
    clickZone.BorderSizePixel = 0
    clickZone.Text = ""
    clickZone.Parent = toggleBg
    
    clickZone.MouseButton1Click:Connect(function()
        self.Value = not self.Value
        updateSwitch()
        self.Callback(self.Value)
    end)
    
    self.Section:AddElementHeight(40)
end

return Toggle
