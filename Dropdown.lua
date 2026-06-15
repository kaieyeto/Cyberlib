--[[
    Dropdown Module
    Multi-select dropdown menu
]]

local Dropdown = {}
Dropdown.__index = Dropdown

function Dropdown.new(config, section)
    local self = setmetatable({}, Dropdown)
    
    self.Name = config.Name or "Dropdown"
    self.Options = config.Options or {}
    self.Multi = config.Multi or false
    self.Selected = config.Default or {}
    self.Callback = config.Callback or function() end
    self.Section = section
    self.IsOpen = false
    
    self:CreateDropdown()
    
    return self
end

function Dropdown:CreateDropdown()
    local theme = self.Section.Tab.Window.Theme
    
    -- Container
    local container = Instance.new("Frame")
    container.Name = self.Name
    container.Size = UDim2.new(1, 0, 0, 35)
    container.Position = UDim2.new(0, 0, 0, self.Section.CurrentY)
    container.BackgroundTransparency = 1
    container.Parent = self.Section.Container
    
    -- Button background
    local buttonBg = Instance.new("Frame")
    buttonBg.Name = "ButtonBg"
    buttonBg.Size = UDim2.new(1, -10, 1, -5)
    buttonBg.Position = UDim2.new(0, 5, 0, 2)
    buttonBg.BackgroundColor3 = theme.Background
    buttonBg.BorderColor3 = theme.Border
    buttonBg.BorderSizePixel = 1
    buttonBg.Parent = container
    
    -- Dropdown button
    local button = Instance.new("TextButton")
    button.Name = "DropdownButton"
    button.Size = UDim2.new(1, 0, 1, 0)
    button.BackgroundTransparency = 1
    button.BorderSizePixel = 0
    button.TextColor3 = theme.Text
    button.TextSize = 11
    button.Font = Enum.Font.Gotham
    button.TextXAlignment = Enum.TextXAlignment.Left
    button.Text = "  " .. self.Name .. ": " .. (self.Options[1] or "Select...")
    button.Parent = buttonBg
    
    -- Dropdown icon
    local icon = Instance.new("TextLabel")
    icon.Name = "Icon"
    icon.Size = UDim2.new(0, 20, 1, 0)
    icon.Position = UDim2.new(1, -20, 0, 0)
    icon.BackgroundTransparency = 1
    icon.TextColor3 = theme.Accent
    icon.TextSize = 10
    icon.Font = Enum.Font.GothamBold
    icon.Text = "▼"
    icon.Parent = buttonBg
    
    -- Dropdown menu
    local menu = Instance.new("Frame")
    menu.Name = "Menu"
    menu.Size = UDim2.new(1, -10, 0, 0)
    menu.Position = UDim2.new(0, 5, 1, 5)
    menu.BackgroundColor3 = theme.Background
    menu.BorderColor3 = theme.Border
    menu.BorderSizePixel = 1
    menu.Visible = false
    menu.ZIndex = 100
    menu.Parent = container
    
    -- Menu scroll
    local scrollFrame = Instance.new("ScrollingFrame")
    scrollFrame.Name = "Scroll"
    scrollFrame.Size = UDim2.new(1, 0, 1, 0)
    scrollFrame.BackgroundTransparency = 1
    scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    scrollFrame.ScrollBarThickness = 4
    scrollFrame.Parent = menu
    
    self.Container = container
    self.ButtonBg = buttonBg
    self.Button = button
    self.Menu = menu
    self.ScrollFrame = scrollFrame
    
    -- Populate options
    for i, option in ipairs(self.Options) do
        local optionButton = Instance.new("TextButton")
        optionButton.Name = option
        optionButton.Size = UDim2.new(1, 0, 0, 25)
        optionButton.Position = UDim2.new(0, 0, 0, (i - 1) * 25)
        optionButton.BackgroundColor3 = theme.Background
        optionButton.BorderSizePixel = 0
        optionButton.TextColor3 = theme.Text
        optionButton.TextSize = 11
        optionButton.Font = Enum.Font.Gotham
        optionButton.Text = "  " .. option
        optionButton.Parent = scrollFrame
        
        optionButton.MouseEnter:Connect(function()
            optionButton.BackgroundColor3 = theme.Secondary
        end)
        
        optionButton.MouseLeave:Connect(function()
            optionButton.BackgroundColor3 = theme.Background
        end)
        
        optionButton.MouseButton1Click:Connect(function()
            if not self.Multi then
                self.Selected = option
                button.Text = "  " .. self.Name .. ": " .. option
            else
                if table.find(self.Selected, option) then
                    table.remove(self.Selected, table.find(self.Selected, option))
                else
                    table.insert(self.Selected, option)
                end
                button.Text = "  " .. self.Name .. ": " .. table.concat(self.Selected, ", ")
            end
            self.Callback(self.Selected)
            if not self.Multi then
                self:Close()
            end
        end)
        
        scrollFrame.CanvasSize = scrollFrame.CanvasSize + UDim2.new(0, 0, 0, 25)
    end
    
    -- Toggle menu
    button.MouseButton1Click:Connect(function()
        if self.IsOpen then
            self:Close()
        else
            self:Open()
        end
    end)
    
    self.Section:AddElementHeight(35)
end

function Dropdown:Open()
    self.IsOpen = true
    self.Menu.Visible = true
    self.Menu.Size = UDim2.new(1, -10, 0, math.min(#self.Options * 25, 150))
end

function Dropdown:Close()
    self.IsOpen = false
    self.Menu.Visible = false
end

return Dropdown
