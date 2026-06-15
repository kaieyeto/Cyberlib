--[[
    NotificationManager
    Displays notifications to the user
]]

local NotificationManager = {}

local TweenService = game:GetService("TweenService")

local notificationGui = nil

function NotificationManager.Initialize()
    -- Create notification GUI
    notificationGui = Instance.new("ScreenGui")
    notificationGui.Name = "CyberLib_Notifications"
    notificationGui.ResetOnSpawn = false
    notificationGui.Parent = game:GetService("CoreGui")
end

function NotificationManager.Show(config)
    local title = config.Title or "Notification"
    local content = config.Content or ""
    local duration = config.Duration or 3
    local style = config.Style or "Info"
    
    local colors = {
        Success = Color3.fromRGB(0, 255, 0),
        Error = Color3.fromRGB(255, 0, 0),
        Warning = Color3.fromRGB(255, 200, 0),
        Info = Color3.fromRGB(0, 170, 255)
    }
    
    local accentColor = colors[style] or colors.Info
    
    -- Notification frame
    local notification = Instance.new("Frame")
    notification.Name = "Notification"
    notification.Size = UDim2.new(0, 250, 0, 70)
    notification.Position = UDim2.new(1, -260, 0, 10)
    notification.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
    notification.BorderColor3 = accentColor
    notification.BorderSizePixel = 2
    notification.Parent = notificationGui
    
    -- Title
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Name = "Title"
    titleLabel.Size = UDim2.new(1, -10, 0, 20)
    titleLabel.Position = UDim2.new(0, 5, 0, 5)
    titleLabel.BackgroundTransparency = 1
    titleLabel.TextColor3 = accentColor
    titleLabel.TextSize = 12
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Text = title
    titleLabel.Parent = notification
    
    -- Content
    local contentLabel = Instance.new("TextLabel")
    contentLabel.Name = "Content"
    contentLabel.Size = UDim2.new(1, -10, 0.5, 0)
    contentLabel.Position = UDim2.new(0, 5, 0, 25)
    contentLabel.BackgroundTransparency = 1
    contentLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    contentLabel.TextSize = 11
    contentLabel.Font = Enum.Font.Gotham
    contentLabel.TextXAlignment = Enum.TextXAlignment.Left
    contentLabel.Text = content
    contentLabel.TextWrapped = true
    contentLabel.Parent = notification
    
    -- Animate in
    TweenService:Create(
        notification,
        TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {Position = UDim2.new(1, -260, 0, 10)}
    ):Play()
    
    -- Animate out after duration
    wait(duration)
    
    TweenService:Create(
        notification,
        TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
        {Position = UDim2.new(1, 260, 0, 10), BackgroundTransparency = 1}
    ):Play()
    
    game:GetService("Debris"):AddItem(notification, 0.5)
end

return NotificationManager
