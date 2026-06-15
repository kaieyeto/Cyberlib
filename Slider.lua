--[[
    Slider Module
    Numeric value input with smooth dragging
]]

local Slider = {}
Slider.__index = Slider

local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

function Slider.new(config, section)
    local self = setmetatable({}, Slider)
    
    self.Name = config.Name or "Slider"
    self.Min = config.Min or 0
    self.Max = config.Max or 100
    self.Default = config.Default or 50
    self.Flag = config.Flag or self.Name
    self.Value = self.Default
    self.Callback = config.Callback or function() end
    self.Section = section
    self.isDragging = false
    
    self:CreateSlider()
    
    return self
end

function Slider:CreateSlider()
    local theme = self.Section.Tab.Window.Theme
    
    -- Container
    local container = Instance.new("Frame")
    container.Name = self.Name
    container.Size = UDim2.new(1, 0, 0, 50)
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
    label.Size = UDim2.new(0.5, 0, 0.4, 0)
    label.Position = UDim2.new(0, 5, 0, 2)
    label.BackgroundTransparency = 1
    label.TextColor3 = theme.Text
    label.TextSize = 12
    label.Font = Enum.Font.GothamBold
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Text = self.Name
    label.Parent = bg
    
    -- Value display
    local valueLabel = Instance.new("TextLabel")
    valueLabel.Name = "Value"
    valueLabel.Size = UDim2.new(0.4, 0, 0.4, 0)
    valueLabel.Position = UDim2.new(0.5, -5, 0, 2)
    valueLabel.BackgroundTransparency = 1
    valueLabel.TextColor3 = theme.Accent
    valueLabel.TextSize = 11
    valueLabel.Font = Enum.Font.GothamBold
    valueLabel.TextXAlignment = Enum.TextXAlignment.Right
    valueLabel.Text = tostring(self.Value)
    valueLabel.Parent = bg
    
    -- Slider track
    local track = Instance.new("Frame")
    track.Name = "Track"
    track.Size = UDim2.new(1, -10, 0, 4)
    track.Position = UDim2.new(0, 5, 0.6, 0)
    track.BackgroundColor3 = theme.Border
    track.BorderSizePixel = 0
    track.Parent = bg
    
    -- Progress fill
    local fill = Instance.new("Frame")
    fill.Name = "Fill"
    fill.Size = UDim2.new((self.Value - self.Min) / (self.Max - self.Min), 0, 1, 0)
    fill.BackgroundColor3 = theme.Accent
    fill.BorderSizePixel = 0
    fill.Parent = track
    
    -- Slider thumb
    local thumb = Instance.new("Frame")
    thumb.Name = "Thumb"
    thumb.Size = UDim2.new(0, 12, 0, 12)
    thumb.Position = UDim2.new((self.Value - self.Min) / (self.Max - self.Min), -6, 0.5, -6)
    thumb.BackgroundColor3 = theme.Accent
    thumb.BorderSizePixel = 0
    thumb.Parent = track
    
    local thumbCorner = Instance.new("UICorner")
    thumbCorner.CornerRadius = UDim.new(0, 6)
    thumbCorner.Parent = thumb
    
    self.Container = container
    self.Track = track
    self.Fill = fill
    self.Thumb = thumb
    self.ValueLabel = valueLabel
    
    -- Drag functionality
    local function updateValue(input)
        local trackPos = track.AbsolutePosition.X
        local trackSize = track.AbsoluteSize.X
        local mousePos = input.Position.X
        
        local percent = math.clamp((mousePos - trackPos) / trackSize, 0, 1)
        self.Value = math.floor(self.Min + (self.Max - self.Min) * percent)
        
        -- Update visuals
        TweenService:Create(
            fill,
            TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {Size = UDim2.new(percent, 0, 1, 0)}
        ):Play()
        
        TweenService:Create(
            thumb,
            TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {Position = UDim2.new(percent, -6, 0.5, -6)}
        ):Play()
        
        valueLabel.Text = tostring(self.Value)
        self.Callback(self.Value)
    end
    
    thumb.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            self.isDragging = true
        end
    end)
    
    track.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            self.isDragging = true
            updateValue(input)
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if self.isDragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            updateValue(input)
        end
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            self.isDragging = false
        end
    end)
    
    self.Section:AddElementHeight(50)
end

return Slider
