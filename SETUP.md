# CyberLib v1.0 - Installation & Setup Guide

## Installation

### Step 1: Download/Copy Files
Copy all CyberLib files into your Roblox game:
- Place in `ServerScriptService` or `StarterPlayer.StarterCharacterScripts`
- Recommended location: `ServerScriptService/CyberLib/`

### Step 2: Basic Setup
```lua
local Library = require(game.ServerScriptService.CyberLib.Library)

local Window = Library:CreateWindow({
    Title = "Your Hub Name",
    Theme = "Cyberpunk"
})
```

## Configuration

### Window Options
```lua
{
    Title = "Window Title",           -- Main title
    Subtitle = "Subtitle text",       -- Optional subtitle
    Theme = "Cyberpunk",              -- Theme name
    SaveConfig = true,               -- Auto-save configs
    ConfigFolder = "CyberLib"         -- Config folder name
}
```

### Available Themes
- `Cyberpunk` (default) - Cyan & Magenta
- `Matrix` - Green neon
- `Crimson` - Red dark
- `Ocean` - Blue

### Element Flags
Flags are used for config saving/loading:
```lua
Toggle:CreateToggle({
    Flag = "UniqueIdentifier"  -- Used for saving state
})
```

## Module Overview

| Module | Purpose |
|--------|---------|
| **Library.lua** | Main entry point & theme management |
| **Window.lua** | Window UI with dragging/resizing |
| **Tab.lua** | Tab navigation system |
| **Section.lua** | Element grouping |
| **Button.lua** | Clickable buttons with ripple |
| **Toggle.lua** | On/off switches with glow |
| **Slider.lua** | Value input with drag |
| **Dropdown.lua** | Option selection |
| **Keybind.lua** | Keyboard input binding |
| **ThemeManager.lua** | Theme switching |
| **ConfigManager.lua** | Save/load settings |
| **NotificationManager.lua** | Toast notifications |
| **EffectManager.lua** | Visual effects |
| **ProfileManager.lua** | User profiles |
| **MobileManager.lua** | Touch support |
| **AssetManager.lua** | Icons & assets |

## Usage Examples

### Create Button
```lua
section:CreateButton({
    Name = "Button Name",
    Description = "Description text",
    Callback = function()
        print("Button clicked!")
    end
})
```

### Create Toggle
```lua
section:CreateToggle({
    Name = "Feature",
    Default = false,
    Flag = "FeatureFlag",
    Callback = function(value)
        print("Toggle:", value)
    end
})
```

### Create Slider
```lua
section:CreateSlider({
    Name = "Value",
    Min = 0,
    Max = 100,
    Default = 50,
    Flag = "ValueFlag",
    Callback = function(value)
        print("Slider:", value)
    end
})
```

### Create Dropdown
```lua
section:CreateDropdown({
    Name = "Option",
    Options = {"A", "B", "C"},
    Multi = false,
    Callback = function(value)
        print("Selected:", value)
    end
})
```

### Create Keybind
```lua
section:CreateKeybind({
    Name = "Toggle UI",
    Default = Enum.KeyCode.RightShift,
    Callback = function()
        print("Hotkey pressed!")
    end
})
```

### Show Notification
```lua
Library:Notify({
    Title = "Title",
    Content = "Message",
    Duration = 3,
    Style = "Success"  -- Success, Error, Warning, Info
})
```

## Theme Customization

### Built-in Themes
All themes have these properties:
- `Accent` - Primary color
- `Secondary` - Secondary color
- `Background` - Background color
- `Text` - Text color
- `TextSecondary` - Secondary text color
- `Border` - Border color

### Create Custom Theme
```lua
Library:AddTheme("MyTheme", {
    Accent = Color3.fromRGB(255, 100, 100),
    Secondary = Color3.fromRGB(200, 50, 50),
    Background = Color3.fromRGB(20, 10, 10),
    Text = Color3.fromRGB(255, 255, 255),
    TextSecondary = Color3.fromRGB(180, 180, 180),
    Border = Color3.fromRGB(100, 30, 30)
})

Library:SetTheme("MyTheme")
```

## Config System

### Save Config
```lua
Library:SaveConfig("ConfigName")
```

### Load Config
```lua
Library:LoadConfig("ConfigName")
```

### Delete Config
```lua
Library:DeleteConfig("ConfigName")
```

### List All Configs
```lua
local configs = Library:ListConfigs()
for _, name in ipairs(configs) do
    print(name)
end
```

## Mobile Support

CyberLib automatically detects and adapts to mobile devices:
- Auto UI scaling
- Touch drag support
- Touch scroll support
- Safe area handling

### Mobile Detection
```lua
local MobileManager = require(CyberLib.MobileManager)
if MobileManager.IsMobile() then
    -- Mobile-specific code
end
```

## Performance Tips

1. **Lazy Load**: Only create elements when needed
2. **Cleanup**: Call `Library:Cleanup()` when done
3. **Debounce**: Use callbacks efficiently
4. **Callbacks**: Keep callback functions lightweight

## Troubleshooting

### Window Not Appearing
- Ensure script is in correct location
- Check console for errors
- Verify theme exists

### Config Not Saving
- Check flag names are unique
- Ensure SaveConfig is enabled
- Verify ConfigFolder exists

### Mobile Issues
- Test on actual mobile device
- Check safe area settings
- Verify touch input handling

## Advanced Features

### Custom Effects
```lua
local EffectManager = require(script.Parent.EffectManager)
EffectManager.ApplyGlowBorder(frame, theme.Accent)
EffectManager.ApplyHologramEffect(frame, theme.Secondary)
```

### Profile System
```lua
local profile = Library:CreateProfile("Username", 12345)
profile.Premium = true
```

## Best Practices

1. **Use Flags**: Always use flags for configurable elements
2. **Group Elements**: Use sections to organize features
3. **Clear Descriptions**: Add descriptions to buttons
4. **Handle Errors**: Wrap callbacks in pcall()
5. **Test Mobile**: Always test on mobile devices

## Support & License

CyberLib v1.0 - Roblox UI Framework
Created with inspiration from Rayfield, Fluent, MacLib, Kavo UI, and Argon Hub X

For issues or questions, refer to inline code documentation.
