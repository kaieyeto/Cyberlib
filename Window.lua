--[[
    Window Module
    Handles main window creation with dragging, resizing, minimize, maximize
]]

local Window = {}
Window.__index = Window

local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local EffectManager = require(script.Parent:WaitForChild("EffectManager"))

function Window.new(config, library)
    local self = setmetatable({}, Window)
    
    self.Title = config.Title or "CyberLib Window"
    self.Subtitle = config.Subtitle or ""
    self.Theme = library:GetTheme(config.Theme or "Cyberpunk")
    self.SaveConfig = config.SaveConfig or false
    self.ConfigFolder = config.ConfigFolder or "CyberLib"
    
    self.Tabs = {}
    self.Active = true
    self.Minimized = false
    self.Maximized = false
    self.isDragging = false
    self.isResizing = false
    self.dragStart = Vector2.new(0, 0)
    self.sizeStart = Vector2.new(0, 0)
    
    self.InstanceId = game:GetService("HttpService"):GenerateGUID(false)
    self.Library = library
    
    self:CreateWindow()
    
    return self
end

function Window:CreateWindow()
    -- Main container
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "CyberLib_" .. self.InstanceId
    screenGui.ResetOnSpawn = false
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    if RunService:IsStudio() then
        screenGui.Parent = game:GetService("CoreGui")
    else
        screenGui.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
    end
    
    -- Window frame
    local windowFrame = Instance.new("Frame")
    windowFrame.Name = "WindowFrame"
    windowFrame.Size = UDim2.new(0, 600, 0, 400)
    windowFrame.Position = UDim2.new(0.5, -300, 0.5, -200)
    windowFrame.BackgroundColor3 = self.Theme.Background
    windowFrame.BorderSizePixel = 2
    windowFrame.BorderColor3 = self.Theme.Border
    windowFrame.Parent = screenGui
    
    -- Apply glow border effect
    EffectManager.ApplyGlowBorder(windowFrame, self.Theme.Accent)
    
    -- Title bar
    local titleBar = Instance.new("Frame")
    titleBar.Name = "TitleBar"
    titleBar.Size = UDim2.new(1, 0, 0, 40)
    titleBar.BackgroundColor3 = self.Theme.Background
    titleBar.BorderColor3 = self.Theme.Border
    titleBar.BorderSizePixel = 1
    titleBar.Parent = windowFrame
    
    -- Add gradient to title bar
    EffectManager.ApplyGradient(titleBar, self.Theme.Accent, self.Theme.Secondary, 0.3)
    
    -- Title text
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Name = "TitleLabel"
    titleLabel.Size = UDim2.new(1, -100, 1, 0)
    titleLabel.Position = UDim2.new(0, 10, 0, 0)
    titleLabel.BackgroundTransparency = 1
    titleLabel.TextColor3 = self.Theme.Text
    titleLabel.TextSize = 14
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Text = self.Title
    if self.Subtitle ~= "" then
        titleLabel.Text = self.Title .. " - " .. self.Subtitle
    end
    titleLabel.Parent = titleBar
    
    -- Control buttons container
    local controlsContainer = Instance.new("Frame")
    controlsContainer.Name = "Controls"
    controlsContainer.Size = UDim2.new(0, 90, 1, 0)
    controlsContainer.Position = UDim2.new(1, -90, 0, 0)
    controlsContainer.BackgroundTransparency = 1
    controlsContainer.Parent = titleBar
    
    -- Minimize button
    local minimizeBtn = self:CreateControlButton("—", controlsContainer, 0, self.Theme)
    minimizeBtn.MouseButton1Click:Connect(function()
        self:Toggle()
    end)
    
    -- Maximize button
    local maximizeBtn = self:CreateControlButton("▢", controlsContainer, 30, self.Theme)
    maximizeBtn.MouseButton1Click:Connect(function()
        self:Maximize()
    end)
    
    -- Close button
    local closeBtn = self:CreateControlButton("✕", controlsContainer, 60, self.Theme)
    closeBtn.MouseButton1Click:Connect(function()
        self:Close()
    end)
    closeBtn.TextColor3 = Color3.fromRGB(255, 0, 0)
    
    -- Content area
    local contentFrame = Instance.new("Frame")
    contentFrame.Name = "ContentFrame"
    contentFrame.Size = UDim2.new(1, 0, 1, -40)
    contentFrame.Position = UDim2.new(0, 0, 0, 40)
    contentFrame.BackgroundTransparency = 1
    contentFrame.Parent = windowFrame
    
    -- Tab navigation (sidebar)
    local sidebar = Instance.new("Frame")
    sidebar.Name = "Sidebar"
    sidebar.Size = UDim2.new(0, 150, 1, 0)
    sidebar.BackgroundColor3 = self.Theme.Background
    sidebar.BorderColor3 = self.Theme.Border
    sidebar.BorderSizePixel = 1
    sidebar.Parent = contentFrame
    
    -- Tab scroll
    local scrollContainer = Instance.new("ScrollingFrame")
    scrollContainer.Name = "TabScroll"
    scrollContainer.Size = UDim2.new(1, 0, 1, 0)
    scrollContainer.BackgroundTransparency = 1
    scrollContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
    scrollContainer.ScrollBarThickness = 4
    scrollContainer.Parent = sidebar
    
    -- Main content
    local mainContent = Instance.new("Frame")
    mainContent.Name = "MainContent"
    mainContent.Size = UDim2.new(1, -150, 1, 0)
    mainContent.Position = UDim2.new(0, 150, 0, 0)
    mainContent.BackgroundTransparency = 1
    mainContent.Parent = contentFrame
    
    -- Store references
    self.ScreenGui = screenGui
    self.WindowFrame = windowFrame
    self.TitleBar = titleBar
    self.Sidebar = sidebar
    self.TabScroll = scrollContainer
    self.MainContent = mainContent
    
    -- Setup dragging
    self:SetupDragging(titleBar)
    
    -- Setup resizing
    self:SetupResizing(windowFrame)
end

function Window:CreateControlButton(text, parent, position, theme)
    local button = Instance.new("TextButton")
    button.Name = "ControlBtn"
    button.Size = UDim2.new(0, 30, 1, 0)
    button.Position = UDim2.new(0, position, 0, 0)
    button.BackgroundColor3 = theme.Background
    button.BorderSizePixel = 0
    button.TextColor3 = theme.Text
    button.TextSize = 12
    button.Font = Enum.Font.GothamBold
    button.Text = text
    button.Parent = parent
    
    button.MouseEnter:Connect(function()
        button.BackgroundColor3 = theme.Secondary
    end)
    
    button.MouseLeave:Connect(function()
        button.BackgroundColor3 = theme.Background
    end)
    
    return button
end

function Window:CreateTab(config)
    local Tab = require(script.Parent:WaitForChild("Tab"))
    local tab = Tab.new(config, self)
    table.insert(self.Tabs, tab)
    return tab
end

function Window:SetupDragging(titleBar)
    local dragging = false
    local dragStart = Vector2.new(0, 0)
    local windowStart = Vector2.new(0, 0)
    
    titleBar.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            windowStart = self.WindowFrame.Position
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input, gameProcessed)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            self.WindowFrame.Position = UDim2.new(
                windowStart.X.Scale, windowStart.X.Offset + delta.X,
                windowStart.Y.Scale, windowStart.Y.Offset + delta.Y
            )
        end
    end)
    
    UserInputService.InputEnded:Connect(function(input, gameProcessed)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
end

function Window:SetupResizing(windowFrame)
    -- Create resize handle
    local resizeHandle = Instance.new("Frame")
    resizeHandle.Name = "ResizeHandle"
    resizeHandle.Size = UDim2.new(0, 15, 0, 15)
    resizeHandle.Position = UDim2.new(1, -15, 1, -15)
    resizeHandle.BackgroundColor3 = self.Theme.Accent
    resizeHandle.BorderSizePixel = 0
    resizeHandle.Parent = windowFrame
    
    local resizing = false
    local resizeStart = Vector2.new(0, 0)
    local sizeStart = Vector2.new(0, 0)
    
    resizeHandle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            resizing = true
            resizeStart = input.Position
            sizeStart = windowFrame.Size
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if resizing and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - resizeStart
            windowFrame.Size = UDim2.new(
                0, math.max(400, sizeStart.X.Offset + delta.X),
                0, math.max(300, sizeStart.Y.Offset + delta.Y)
            )
        end
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            resizing = false
        end
    end)
end

function Window:Toggle()
    self.Minimized = not self.Minimized
    if self.Minimized then
        self.MainContent.Visible = false
    else
        self.MainContent.Visible = true
    end
end

function Window:Maximize()
    self.Maximized = not self.Maximized
    if self.Maximized then
        self.WindowFrame.Size = UDim2.new(1, 0, 1, 0)
        self.WindowFrame.Position = UDim2.new(0, 0, 0, 0)
    else
        self.WindowFrame.Size = UDim2.new(0, 600, 0, 400)
        self.WindowFrame.Position = UDim2.new(0.5, -300, 0.5, -200)
    end
end

function Window:Close()
    self.Active = false
    self.ScreenGui:Destroy()
end

function Window:UpdateTheme(theme)
    self.Theme = theme
    self.WindowFrame.BackgroundColor3 = theme.Background
    self.WindowFrame.BorderColor3 = theme.Border
    self.TitleBar.BackgroundColor3 = theme.Background
    self.TitleBar.BorderColor3 = theme.Border
end

function Window:Cleanup()
    if self.ScreenGui then
        self.ScreenGui:Destroy()
    end
end

return Window
