--[[
    Tab Module
    Handles tab creation within windows
]]

local Tab = {}
Tab.__index = Tab

function Tab.new(config, window)
    local self = setmetatable({}, Tab)
    
    self.Name = config.Name or "Tab"
    self.Icon = config.Icon or "home"
    self.Sections = {}
    self.Window = window
    
    self:CreateTab()
    
    return self
end

function Tab:CreateTab()
    -- Create tab button in sidebar
    local tabButton = Instance.new("TextButton")
    tabButton.Name = self.Name
    tabButton.Size = UDim2.new(1, 0, 0, 35)
    tabButton.BackgroundColor3 = self.Window.Theme.Background
    tabButton.BorderColor3 = self.Window.Theme.Border
    tabButton.BorderSizePixel = 1
    tabButton.TextColor3 = self.Window.Theme.Text
    tabButton.TextSize = 12
    tabButton.Font = Enum.Font.Gotham
    tabButton.Text = self.Icon .. " " .. self.Name
    
    -- Add to scroll container
    local scrollContainer = self.Window.TabScroll
    tabButton.Parent = scrollContainer
    
    -- Update canvas size
    scrollContainer.CanvasSize = scrollContainer.CanvasSize + UDim2.new(0, 0, 0, 35)
    
    -- Create tab content container
    local tabContent = Instance.new("Frame")
    tabContent.Name = self.Name .. "_Content"
    tabContent.Size = UDim2.new(1, 0, 1, 0)
    tabContent.BackgroundTransparency = 1
    tabContent.Visible = false
    tabContent.Parent = self.Window.MainContent
    
    -- Scroll frame for content
    local scrollFrame = Instance.new("ScrollingFrame")
    scrollFrame.Name = "ContentScroll"
    scrollFrame.Size = UDim2.new(1, 0, 1, 0)
    scrollFrame.BackgroundTransparency = 1
    scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    scrollFrame.ScrollBarThickness = 6
    scrollFrame.Parent = tabContent
    
    self.TabButton = tabButton
    self.TabContent = tabContent
    self.ScrollFrame = scrollFrame
    
    -- Handle tab selection
    tabButton.MouseButton1Click:Connect(function()
        self:Select()
    end)
    
    -- Select first tab by default
    if #self.Window.Tabs == 1 then
        self:Select()
    end
end

function Tab:Select()
    -- Deselect all tabs
    for _, tab in ipairs(self.Window.Tabs) do
        tab.TabContent.Visible = false
        tab.TabButton.BackgroundColor3 = self.Window.Theme.Background
    end
    
    -- Select this tab
    self.TabContent.Visible = true
    self.TabButton.BackgroundColor3 = self.Window.Theme.Secondary
end

function Tab:CreateSection(name)
    local Section = require(script.Parent:WaitForChild("Section"))
    local section = Section.new(name, self)
    table.insert(self.Sections, section)
    return section
end

return Tab
