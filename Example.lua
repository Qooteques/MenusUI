local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/YourLibrary.lua"))()

local Window = Library:CreateWindow({
    Title = "PREMIUM HUB V2",
    Author = "FxzY"
})

local MainTab = Window:Tab({
    Title = "Main"
})

local PlayerSection = MainTab:Section({
    Title = "Player Settings"
})

PlayerSection:Toggle({
    Title = "Auto Farm",
    Value = false,
    Callback = function(value)
        if value then
            print("Auto Farm: ON")
        else
            print("Auto Farm: OFF")
        end
    end
})

PlayerSection:Toggle({
    Title = "Walk on Water",
    Value = false,
    Callback = function(value)
        print("Walk on Water: " .. tostring(value))
    end
})

PlayerSection:Slider({
    Title = "Walk Speed",
    Desc = "Adjust your movement speed",
    Value = { Min = 16, Max = 100, Default = 16 },
    Callback = function(value)
        print("Speed: " .. value)
    end
})

PlayerSection:Slider({
    Title = "Jump Power",
    Desc = "Adjust jump height",
    Value = { Min = 50, Max = 200, Default = 50 },
    Callback = function(value)
        print("Jump Power: " .. value)
    end
})

local CombatSection = MainTab:Section({
    Title = "Combat Settings"
})

CombatSection:Dropdown({
    Title = "Aimbot Mode",
    Values = {"Silent Aim", "Normal Aim", "Mouse Aim", "Disabled"},
    Value = "Disabled",
    Callback = function(value)
        print("Aimbot: " .. value)
    end
})

CombatSection:Dropdown({
    Title = "ESP Type",
    Values = {"Box", "Tracer", "Name", "Health", "All"},
    Value = "Box",
    Callback = function(value)
        print("ESP: " .. value)
    end
})

CombatSection:Toggle({
    Title = "Trigger Bot",
    Value = false,
    Callback = function(value)
        print("Trigger Bot: " .. tostring(value))
    end
})

CombatSection:Button({
    Title = "Refresh Players",
    Callback = function()
        print("Players Refreshed!")
    end
})

local VisualTab = Window:Tab({
    Title = "Visuals"
})

local EspSection = VisualTab:Section({
    Title = "ESP Settings"
})

EspSection:Toggle({
    Title = "Enable ESP",
    Value = true,
    Callback = function(value)
        print("ESP: " .. tostring(value))
    end
})

EspSection:Dropdown({
    Title = "Box Color",
    Values = {"Red", "Blue", "Green", "Yellow", "White"},
    Value = "Red",
    Callback = function(value)
        print("Box Color: " .. value)
    end
})

EspSection:Slider({
    Title = "ESP Distance",
    Desc = "Max render distance",
    Value = { Min = 100, Max = 1000, Default = 500 },
    Callback = function(value)
        print("Distance: " .. value)
    end
})

local WorldSection = VisualTab:Section({
    Title = "World Settings"
})

WorldSection:Toggle({
    Title = "Full Bright",
    Value = false,
    Callback = function(value)
        if value then
            game:GetService("Lighting").Brightness = 2
            game:GetService("Lighting").Ambient = Color3.new(1, 1, 1)
            print("Full Bright: ON")
        else
            game:GetService("Lighting").Brightness = 1
            game:GetService("Lighting").Ambient = Color3.new(0, 0, 0)
            print("Full Bright: OFF")
        end
    end
})

WorldSection:Toggle({
    Title = "Remove Fog",
    Value = false,
    Callback = function(value)
        if value then
            game:GetService("Lighting").FogEnd = 100000
            print("Fog Removed")
        else
            game:GetService("Lighting").FogEnd = 100000
            print("Fog Reset")
        end
    end
})

WorldSection:Slider({
    Title = "Time of Day",
    Desc = "0 = Midnight, 24 = Noon",
    Value = { Min = 0, Max = 24, Default = 12 },
    Callback = function(value)
        local hour = math.floor(value)
        local minute = (value - hour) * 60
        game:GetService("Lighting").ClockTime = value
        print("Time set to: " .. hour .. ":" .. string.format("%02d", minute))
    end
})

local ScriptsTab = Window:Tab({
    Title = "Scripts"
})

local AutoSection = ScriptsTab:Section({
    Title = "Auto Features"
})

AutoSection:Toggle({
    Title = "Auto Collect",
    Value = false,
    Callback = function(value)
        print("Auto Collect: " .. tostring(value))
    end
})

AutoSection:Toggle({
    Title = "Auto Attack",
    Value = false,
    Callback = function(value)
        print("Auto Attack: " .. tostring(value))
    end
})

AutoSection:Input({
    Title = "Auto Say Message",
    Placeholder = "Enter message...",
    Value = "Hello!",
    Callback = function(input)
        print("Auto Say: " .. input)
    end
})

AutoSection:Dropdown({
    Title = "Auto Farm Mode",
    Values = {"Normal", "Fast", "Insane", "Custom"},
    Value = "Normal",
    Callback = function(value)
        print("Farm Mode: " .. value)
    end
})

AutoSection:Button({
    Title = "Start All Auto Features",
    Callback = function()
        print("Starting all auto features...")
        wait(1)
        print("All features activated!")
    end
})

local MiscSection = ScriptsTab:Section({
    Title = "Miscellaneous"
})

MiscSection:Input({
    Title = "Custom Command",
    Placeholder = "Type command...",
    Value = "",
    Callback = function(input)
        if input == "kill" then
            print("Kill command executed")
        elseif input == "heal" then
            print("Heal command executed")
        else
            print("Unknown command: " .. input)
        end
    end
})

MiscSection:Slider({
    Title = "Camera FOV",
    Desc = "Field of View (60-120)",
    Value = { Min = 60, Max = 120, Default = 70 },
    Callback = function(value)
        workspace.CurrentCamera.FieldOfView = value
        print("FOV: " .. value)
    end
})

MiscSection:Button({
    Title = "Rejoin Game",
    Callback = function()
        print("Rejoining...")
        local TeleportService = game:GetService("TeleportService")
        local placeId = game.PlaceId
        TeleportService:Teleport(placeId)
    end
})

MiscSection:Button({
    Title = "Server Hop",
    Callback = function()
        print("Searching for new server...")
    end
})

local SettingsTab = Window:Tab({
    Title = "Settings"
})

local ConfigSection = SettingsTab:Section({
    Title = "Configuration"
})

ConfigSection:Toggle({
    Title = "Save Settings",
    Value = true,
    Callback = function(value)
        print("Auto Save: " .. tostring(value))
    end
})

ConfigSection:Dropdown({
    Title = "Theme",
    Values = {"Dark", "Light", "Blue", "Purple", "Red"},
    Value = "Dark",
    Callback = function(value)
        print("Theme changed to: " .. value)
    end
})

ConfigSection:Button({
    Title = "Load Config",
    Callback = function()
        print("Loading configuration...")
        wait(0.5)
        print("Config loaded!")
    end
})

ConfigSection:Button({
    Title = "Save Config",
    Callback = function()
        print("Saving configuration...")
        wait(0.5)
        print("Config saved!")
    end
})

ConfigSection:Button({
    Title = "Reset to Default",
    Callback = function()
        print("Resetting all settings...")
        wait(0.5)
        print("Settings reset complete!")
    end
})

local CreditSection = SettingsTab:Section({
    Title = "Credits"
})

CreditSection:Button({
    Title = "Discord Server",
    Callback = function()
        print("Discord: discord.gg/example")
        setclipboard("discord.gg/example")
        print("Link copied to clipboard!")
    end
})

CreditSection:Button({
    Title = "Check Updates",
    Callback = function()
        print("Checking for updates...")
        wait(0.5)
        print("You have the latest version!")
    end
})

print("UI Loaded Successfully!")
print("Window created with Author: FxzY")
print("All components ready to use!")
