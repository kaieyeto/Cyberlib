--[[
    MobileManager
    Handles mobile support with adaptive scaling and touch input
]]

local MobileManager = {}

local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local isMobile = false
local screenSize = nil

function MobileManager.Initialize()
    -- Detect mobile
    isMobile = UserInputService.TouchEnabled and not UserInputService.MouseEnabled
    
    -- Get screen size
    local screenGui = Instance.new("ScreenGui")
    screenSize = screenGui.AbsoluteSize
    screenGui:Destroy()
end

function MobileManager.IsMobile()
    return isMobile
end

function MobileManager.AdaptiveScale(baseSize)
    if not isMobile then
        return baseSize
    end
    
    -- Scale down for mobile screens
    local scale = math.min(screenSize.X / 1920, screenSize.Y / 1080)
    return baseSize * scale
end

function MobileManager.HandleTouchDrag(element, callback)
    if not isMobile then
        return
    end
    
    local touchStart = Vector2.new(0, 0)
    local elementStart = Vector2.new(0, 0)
    local isDragging = false
    
    element.TouchBegan:Connect(function(touch)
        isDragging = true
        touchStart = touch.Position
        elementStart = element.Position
    end)
    
    element.TouchMoved:Connect(function(touch)
        if isDragging then
            local delta = touch.Position - touchStart
            callback(elementStart, delta)
        end
    end)
    
    element.TouchEnded:Connect(function()
        isDragging = false
    end)
end

function MobileManager.HandleTouchScroll(scrollFrame)
    if not isMobile then
        return
    end
    
    local touchStart = Vector2.new(0, 0)
    local isScrolling = false
    
    scrollFrame.TouchBegan:Connect(function(touch)
        isScrolling = true
        touchStart = touch.Position
    end)
    
    scrollFrame.TouchMoved:Connect(function(touch)
        if isScrolling then
            local delta = touch.Position.Y - touchStart.Y
            scrollFrame.CanvasPosition = scrollFrame.CanvasPosition - Vector2.new(0, delta)
            touchStart = touch.Position
        end
    end)
    
    scrollFrame.TouchEnded:Connect(function()
        isScrolling = false
    end)
end

function MobileManager.AdjustUIForSafeArea(gui)
    -- Adjust for notches and safe areas on mobile devices
    if not isMobile then
        return
    end
    
    local safeAreaOffset = 20
    gui.Position = gui.Position + UDim2.new(0, safeAreaOffset, 0, safeAreaOffset)
end

function MobileManager.CreateTouchButton(name, size, position, callback)
    local button = Instance.new("TextButton")
    button.Name = name
    button.Size = size
    button.Position = position
    button.BackgroundColor3 = Color3.fromRGB(100, 100, 200)
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.TextSize = 14
    button.Font = Enum.Font.GothamBold
    button.Text = name
    
    button.MouseButton1Click:Connect(callback)
    button.TouchTap:Connect(callback)
    
    return button
end

return MobileManager
