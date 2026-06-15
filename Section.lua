--[[
    Section Module
    Groups related UI elements
]]

local Section = {}
Section.__index = Section

function Section.new(name, tab)
    local self = setmetatable({}, Section)
    
    self.Name = name
    self.Tab = tab
    self.Elements = {}
    
    self:CreateSection()
    
    return self
end

function Section:CreateSection()
    -- Section header
    local sectionHeader = Instance.new("TextLabel")
    sectionHeader.Name = self.Name .. "_Header"
    sectionHeader.Size = UDim2.new(1, 0, 0, 25)
    sectionHeader.BackgroundColor3 = self.Tab.Window.Theme.Background
    sectionHeader.BorderSizePixel = 0
    sectionHeader.TextColor3 = self.Tab.Window.Theme.Accent
    sectionHeader.TextSize = 12
    sectionHeader.Font = Enum.Font.GothamBold
    sectionHeader.TextXAlignment = Enum.TextXAlignment.Left
    sectionHeader.Text = "  " .. self.Name
    sectionHeader.Parent = self.Tab.ScrollFrame
    
    -- Section container
    local sectionContainer = Instance.new("Frame")
    sectionContainer.Name = self.Name .. "_Container"
    sectionContainer.Size = UDim2.new(1, -10, 0, 0)
    sectionContainer.Position = UDim2.new(0, 5, 0, 25)
    sectionContainer.BackgroundTransparency = 1
    sectionContainer.Parent = self.Tab.ScrollFrame
    
    self.Header = sectionHeader
    self.Container = sectionContainer
    self.CurrentY = 0
end

function Section:CreateButton(config)
    local Button = require(script.Parent:WaitForChild("Button"))
    local button = Button.new(config, self)
    table.insert(self.Elements, button)
    return button
end

function Section:CreateToggle(config)
    local Toggle = require(script.Parent:WaitForChild("Toggle"))
    local toggle = Toggle.new(config, self)
    table.insert(self.Elements, toggle)
    return toggle
end

function Section:CreateSlider(config)
    local Slider = require(script.Parent:WaitForChild("Slider"))
    local slider = Slider.new(config, self)
    table.insert(self.Elements, slider)
    return slider
end

function Section:CreateDropdown(config)
    local Dropdown = require(script.Parent:WaitForChild("Dropdown"))
    local dropdown = Dropdown.new(config, self)
    table.insert(self.Elements, dropdown)
    return dropdown
end

function Section:CreateKeybind(config)
    local Keybind = require(script.Parent:WaitForChild("Keybind"))
    local keybind = Keybind.new(config, self)
    table.insert(self.Elements, keybind)
    return keybind
end

function Section:AddElementHeight(height)
    self.CurrentY = self.CurrentY + height
    self.Container.Size = self.Container.Size + UDim2.new(0, 0, 0, height)
    
    -- Update scroll canvas
    local scrollFrame = self.Tab.ScrollFrame
    scrollFrame.CanvasSize = scrollFrame.CanvasSize + UDim2.new(0, 0, 0, height)
end

return Section
