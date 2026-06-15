--[[
    ProfileManager
    Handles user profile display and management
]]

local ProfileManager = {}

local Players = game:GetService("Players")

local currentProfile = nil

function ProfileManager.Initialize()
    -- Initialize profile system
end

function ProfileManager.CreateProfile(username, userId)
    local profile = {
        Username = username,
        UserId = userId,
        Premium = false,
        JoinDate = os.date("%Y-%m-%d"),
        Badges = {},
        Effects = {}
    }
    
    currentProfile = profile
    return profile
end

function ProfileManager.GetCurrentProfile()
    if not currentProfile then
        local player = Players.LocalPlayer
        currentProfile = ProfileManager.CreateProfile(player.Name, player.UserId)
    end
    return currentProfile
end

function ProfileManager.UpdateProfile(updates)
    if currentProfile then
        for key, value in pairs(updates) do
            currentProfile[key] = value
        end
    end
end

function ProfileManager.DisplayProfile(window)
    -- Create profile card UI
    local profileFrame = Instance.new("Frame")
    profileFrame.Name = "ProfileCard"
    profileFrame.Size = UDim2.new(0, 200, 0, 200)
    profileFrame.BackgroundColor3 = window.Theme.Background
    profileFrame.BorderColor3 = window.Theme.Border
    profileFrame.BorderSizePixel = 1
    
    local profile = ProfileManager.GetCurrentProfile()
    
    -- Avatar placeholder
    local avatar = Instance.new("Frame")
    avatar.Name = "Avatar"
    avatar.Size = UDim2.new(0, 50, 0, 50)
    avatar.Position = UDim2.new(0.5, -25, 0, 10)
    avatar.BackgroundColor3 = window.Theme.Secondary
    avatar.BorderSizePixel = 0
    avatar.Parent = profileFrame
    
    -- Username
    local usernameLabel = Instance.new("TextLabel")
    usernameLabel.Name = "Username"
    usernameLabel.Size = UDim2.new(1, 0, 0, 20)
    usernameLabel.Position = UDim2.new(0, 0, 0, 65)
    usernameLabel.BackgroundTransparency = 1
    usernameLabel.TextColor3 = window.Theme.Text
    usernameLabel.TextSize = 11
    usernameLabel.Font = Enum.Font.GothamBold
    usernameLabel.Text = ProfileManager.BlurUsername(profile.Username)
    usernameLabel.Parent = profileFrame
    
    -- Join date
    local joinDateLabel = Instance.new("TextLabel")
    joinDateLabel.Name = "JoinDate"
    joinDateLabel.Size = UDim2.new(1, 0, 0, 20)
    joinDateLabel.Position = UDim2.new(0, 0, 0, 90)
    joinDateLabel.BackgroundTransparency = 1
    joinDateLabel.TextColor3 = window.Theme.TextSecondary
    joinDateLabel.TextSize = 9
    joinDateLabel.Font = Enum.Font.Gotham
    joinDateLabel.Text = profile.JoinDate
    joinDateLabel.Parent = profileFrame
    
    -- Premium status
    local premiumLabel = Instance.new("TextLabel")
    premiumLabel.Name = "Premium"
    premiumLabel.Size = UDim2.new(1, 0, 0, 20)
    premiumLabel.Position = UDim2.new(0, 0, 0, 110)
    premiumLabel.BackgroundTransparency = 1
    premiumLabel.TextColor3 = profile.Premium and Color3.fromRGB(255, 215, 0) or window.Theme.TextSecondary
    premiumLabel.TextSize = 9
    premiumLabel.Font = Enum.Font.GothamBold
    premiumLabel.Text = profile.Premium and "⭐ Premium" or "Free User"
    premiumLabel.Parent = profileFrame
    
    return profileFrame
end

function ProfileManager.BlurUsername(username)
    if #username <= 2 then
        return username
    end
    
    local first = string.sub(username, 1, 1)
    local last = string.sub(username, -1)
    local middle = string.rep("*", #username - 2)
    
    return first .. middle .. last
end

return ProfileManager
