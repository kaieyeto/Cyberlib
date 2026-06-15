# CyberLib v1.0 Documentation

## Quick Start

```lua
local Library = require(game.ServerScriptService.CyberLib.Library)

-- Create a window
local Window = Library:CreateWindow({
    Title = "Jayden Hub",
    Subtitle = "Cyber Edition",
    Theme = "Cyberpunk",
    SaveConfig = true,
    ConfigFolder = "CyberLib"
})

-- Create a tab
local Main = Window:CreateTab({
    Name = "Main",
    Icon = "home"
})

-- Create a section
local Combat = Main:CreateSection("Combat")

-- Create elements
Combat:CreateButton({
    Name = "Test Button",
    Description = "This is a test button",
    Callback = function()
        print("Button clicked!")
    end
})

Combat:CreateToggle({
    Name = "Enabled",
    Default = false,
    Flag = "Enabled",
    Callback = function(Value)
        print("Toggle state:", Value)
    end
})

Combat:CreateSlider({
    Name = "Speed",
    Min = 0,
    Max = 100,
    Default = 50,
    Flag = "Speed",
    Callback = function(Value)
        print("Slider value:", Value)
    end
})

Combat:CreateDropdown({
    Name = "Mode",
    Options = {"A", "B", "C"},
    Multi = false,
    Callback = function(Value)
        print("Selected:", Value)
    end
})

Combat:CreateKeybind({
    Name = "Toggle UI",
    Default = Enum.KeyCode.RightShift,
    Callback = function()
        print("Keybind triggered!")
    end
})
```

## Features

### Window
- **Draggable**: Click and drag the title bar to move
- **Resizable**: Drag the bottom-right corner to resize
- **Minimize/Maximize**: Use the control buttons in the title bar
- **Close**: Closes the window and cleans up resources

### Themes
Available themes:
- **Cyberpunk**: Cyan and Magenta (default)
- **Matrix**: Green matrix style
- **Crimson**: Red dark theme
- **Ocean**: Blue ocean theme

Switch themes:
```lua
Library:SetTheme("Matrix")
```

### Config System
Save, load, and manage configurations:
```lua
Library:SaveConfig("MyConfig")
Library:LoadConfig("MyConfig")
Library:DeleteConfig("MyConfig")
Library:ListConfigs()
```

### Notifications
Display notifications to users:
```lua
Library:Notify({
    Title = "Success",
    Content = "Operation completed",
    Duration = 3,
    Style = "Success" -- Success, Error, Warning, Info
})
```

### Mobile Support
- Adaptive UI scaling
- Touch drag support
- Touch scroll support
- Safe area handling

## Project Structure

```
CyberLib/
├── Library.lua              # Main library entry point
├── Window.lua               # Window management
├── Tab.lua                  # Tab management
├── Section.lua              # Section grouping
├── Button.lua               # Button component
├── Toggle.lua               # Toggle switch component
├── Slider.lua               # Slider component
├── Dropdown.lua             # Dropdown menu component
├── Keybind.lua              # Keybind management
├── ThemeManager.lua         # Theme system
├── ConfigManager.lua        # Config save/load
├── NotificationManager.lua  # Notification system
├── EffectManager.lua        # Visual effects
├── ProfileManager.lua       # User profile system
├── MobileManager.lua        # Mobile support
└── README.md                # This file
```

## Advanced Features

### Custom Themes
```lua
Library:AddTheme("MyTheme", {
    Accent = Color3.fromRGB(255, 100, 100),
    Secondary = Color3.fromRGB(200, 50, 50),
    Background = Color3.fromRGB(20, 10, 10),
    Text = Color3.fromRGB(255, 255, 255),
    TextSecondary = Color3.fromRGB(180, 180, 180),
    Border = Color3.fromRGB(100, 30, 30)
})
```

### Profile Management
```lua
local profile = Library:CreateProfile("Jayden", 12345)
profile = Library:GetProfile()
```

### Effect System
```lua
local EffectManager = require(script.Parent.EffectManager)
EffectManager.ApplyGlowBorder(frame, Color3.fromRGB(0, 255, 255))
EffectManager.ApplyHologramEffect(frame, theme.Accent)
EffectManager.ApplyParticleBackground(frame, theme.Accent)
```

## Design Inspiration

CyberLib draws inspiration from:
- **Rayfield**: Modern design patterns
- **Fluent**: UI component architecture
- **MacLib**: Aesthetic refinement
- **Kavo UI**: Mobile support and drag functionality
- **Argon Hub X**: Advanced visual effects

## License

CyberLib v1.0 - Created for Roblox

## Support

For issues or feature requests, please refer to the inline documentation in each module.
