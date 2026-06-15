--[[
    Button Module
    Clickable button with animations
]]

local Button = {}
Button.__index = Button

local TweenService = game:GetService("TweenService")

function Button.new(config, section)
    local self = setmetatable({}, Button)
    
    self.Name = config.Name or "Button"
    self.Description = config.Description or ""
    self.Callback = config.Callback or function() end
    self.Section = section
    
    self:CreateButton()
    
    return self
end

function Button:CreateButton()
    local theme = self.Section.Tab.Window.Theme
    
    -- Button container
    local buttonContainer = Instance.new("Frame")
    buttonContainer.Name = self.Name
    buttonContainer.Size = UDim2.new(1, 0, 0, 50)
    buttonContainer.Position = UDim2.new(0, 0, 0, self.Section.CurrentY)
    buttonContainer.BackgroundTransparency = 1
    buttonContainer.Parent = self.Section.Container
    
    -- Button background
    local button = Instance.new("TextButton")
    button.Name = "Button"
    button.Size = UDim2.new(1, -10, 1, -5)
    button.Position = UDim2.new(0, 5, 0, 2)
    button.BackgroundColor3 = theme.Background
    button.BorderColor3 = theme.Border
    button.BorderSizePixel = 1
    button.AutoButtonColor = false
    button.Text = ""
    button.Parent = buttonContainer
    
    -- Apply gradient
    local EffectManager = require(script.Parent:WaitForChild("EffectManager"))
    EffectManager.ApplyGradient(button, theme.Accent, theme.Secondary, 0.2)
    
    -- Button text
    local buttonText = Instance.new("TextLabel")
    buttonText.Name = "Text"
    buttonText.Size = UDim2.new(1, -10, 0.5, 0)
    buttonText.Position = UDim2.new(0, 5, 0, 0)
    buttonText.BackgroundTransparency = 1
    buttonText.TextColor3 = theme.Text
    buttonText.TextSize = 12
    buttonText.Font = Enum.Font.GothamBold
    buttonText.TextXAlignment = Enum.TextXAlignment.Left
    buttonText.Text = self.Name
    buttonText.Parent = button
    
    -- Description text
    local descText = Instance.new("TextLabel")
    descText.Name = "Description"
    descText.Size = UDim2.new(1, -10, 0.5, 0)
    descText.Position = UDim2.new(0, 5, 0.5, 0)
    descText.BackgroundTransparency = 1
    descText.TextColor3 = theme.TextSecondary
    descText.TextSize = 10
    descText.Font = Enum.Font.Gotham
    descText.TextXAlignment = Enum.TextXAlignment.Left
    descText.Text = self.Description
    descText.Parent = button
    
    self.Container = buttonContainer
    self.Button = button
    self.ButtonText = buttonText
    
    -- Hover effects
    button.MouseEnter:Connect(function()
        TweenService:Create(
            button,
            TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {BackgroundColor3 = theme.Secondary}
        ):Play()
    end)
    
    button.MouseLeave:Connect(function()
        TweenService:Create(
            button,
            TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {BackgroundColor3 = theme.Background}
        ):Play()
    end)
    
    -- Click animation
    button.MouseButton1Click:Connect(function()
        -- Ripple effect
        local ripple = Instance.new("Frame")
        ripple.Shape = Enum.PartType.Ball
        ripple.Size = UDim2.new(0, 5, 0, 5)
        ripple.Position = UDim2.new(0.5, -2.5, 0.5, -2.5)
        ripple.BackgroundColor3 = theme.Accent
        ripple.BorderSizePixel = 0
        ripple.Parent = button
        
        local rippleTween = TweenService:Create(
            ripple,
            TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {Size = UDim2.new(0, 100, 0, 100), BackgroundTransparency = 1}
        )
        
        rippleTween:Play()
        rippleTween.Completed:Connect(function()
            ripple:Destroy()
        end)
        
        self.Callback()
    end)
    
    self.Section:AddElementHeight(50)
end

return Button
