--[[
    EffectManager
    Handles visual effects like glow borders and gradients
]]

local EffectManager = {}

local TweenService = game:GetService("TweenService")

function EffectManager.ApplyGlowBorder(frame, glowColor)
    -- Create inner glow
    local stroke = Instance.new("UIStroke")
    stroke.Color = glowColor
    stroke.Thickness = 2
    stroke.Parent = frame
    
    -- Add shadow effect with multiple frames
    local shadow = Instance.new("Frame")
    shadow.Name = "Glow"
    shadow.Size = frame.Size + UDim2.new(0, 4, 0, 4)
    shadow.Position = frame.Position - UDim2.new(0, 2, 0, 2)
    shadow.BackgroundColor3 = glowColor
    shadow.BorderSizePixel = 0
    shadow.BackgroundTransparency = 0.9
    shadow.ZIndex = frame.ZIndex - 1
    
    if frame.Parent then
        shadow.Parent = frame.Parent
    end
end

function EffectManager.ApplyGradient(frame, color1, color2, transparency)
    transparency = transparency or 0.5
    
    -- Create gradient
    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, color1),
        ColorSequenceKeypoint.new(1, color2)
    })
    gradient.Transparency = NumberSequence.new(transparency)
    gradient.Rotation = 45
    gradient.Parent = frame
    
    return gradient
end

function EffectManager.ApplyHologramEffect(frame, accentColor)
    -- Animate scan lines
    local scanLines = Instance.new("Frame")
    scanLines.Name = "ScanLines"
    scanLines.Size = UDim2.new(1, 0, 0.1, 0)
    scanLines.Position = UDim2.new(0, 0, 0, 0)
    scanLines.BackgroundColor3 = accentColor
    scanLines.BackgroundTransparency = 0.7
    scanLines.BorderSizePixel = 0
    scanLines.Parent = frame
    
    -- Animate scan lines moving down
    local animSpeed = 2
    spawn(function()
        while scanLines and scanLines.Parent do
            for i = 0, 10 do
                scanLines.Position = UDim2.new(0, 0, i / 10, 0)
                wait(animSpeed / 10)
            end
        end
    end)
end

function EffectManager.ApplyParticleBackground(frame, particleColor)
    -- Create particle background effect
    for i = 1, 5 do
        local particle = Instance.new("Frame")
        particle.Name = "Particle" .. i
        particle.Size = UDim2.new(0, math.random(2, 8), 0, math.random(2, 8))
        particle.Position = UDim2.new(math.random(0, 100) / 100, 0, math.random(0, 100) / 100, 0)
        particle.BackgroundColor3 = particleColor
        particle.BackgroundTransparency = 0.8
        particle.BorderSizePixel = 0
        particle.Parent = frame
        
        -- Animate floating
        spawn(function()
            while particle and particle.Parent do
                TweenService:Create(
                    particle,
                    TweenInfo.new(math.random(3, 8), Enum.EasingStyle.Linear),
                    {Position = particle.Position + UDim2.new(0, math.random(-50, 50), 0, math.random(-50, 50))}
                ):Play()
                wait(math.random(3, 8))
            end
        end)
    end
end

function EffectManager.ApplyScanEffect(frame, accentColor)
    -- Create scanning line effect
    local scanEffect = Instance.new("Frame")
    scanEffect.Size = UDim2.new(0, 2, 1, 0)
    scanEffect.BackgroundColor3 = accentColor
    scanEffect.BackgroundTransparency = 0.3
    scanEffect.BorderSizePixel = 0
    scanEffect.Position = UDim2.new(0, 0, 0, 0)
    scanEffect.Parent = frame
    
    -- Animate scan from left to right
    spawn(function()
        while scanEffect and scanEffect.Parent do
            TweenService:Create(
                scanEffect,
                TweenInfo.new(1, Enum.EasingStyle.Linear),
                {Position = UDim2.new(1, -2, 0, 0)}
            ):Play()
            wait(1.1)
            scanEffect.Position = UDim2.new(0, 0, 0, 0)
        end
    end)
end

return EffectManager
