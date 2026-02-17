--[[
    MODERN UI LIBRARY FOR ROBLOX MOBILE
    Complete with: Button, Toggle, Input, Dropdown, Slider
    Center on screen, with Author field
]]

local Library = {}
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local Mouse = Player:GetMouse()

-- Utility Functions
local function Create(class, properties)
    local obj = Instance.new(class)
    for prop, value in pairs(properties) do
        obj[prop] = value
    end
    return obj
end

-- MAIN WINDOW CREATION
function Library:CreateWindow(config)
    local Window = {}
    
    -- Main GUI
    local ScreenGui = Create("ScreenGui", {
        Name = "ModernUI",
        Parent = Player:WaitForChild("PlayerGui"),
        ResetOnSpawn = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        DisplayOrder = 999
    })
    
    -- Main Frame (Responsive for Mobile)
    local MainFrame = Create("Frame", {
        Name = "MainFrame",
        Parent = ScreenGui,
        -- Menggunakan Scale agar responsive di semua device
        Size = UDim2.new(0.9, 0, 0.7, 0), -- 90% lebar, 70% tinggi layar
        Position = UDim2.new(0.5, 0, 0.5, 0), -- Tengah
        AnchorPoint = Vector2.new(0.5, 0.5), -- Anchor point tengah
        BackgroundColor3 = Color3.fromRGB(25, 25, 30),
        BorderSizePixel = 0,
        ClipsDescendants = true
    })
    
    -- Rounded Corners
    local UICorner = Create("UICorner", {
        Parent = MainFrame,
        CornerRadius = UDim.new(0, 12) -- Lebih rounded untuk mobile
    })
    
    -- Shadow Effect
    local Shadow = Create("ImageLabel", {
        Parent = MainFrame,
        Name = "Shadow",
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        Size = UDim2.new(1, 20, 1, 20),
        Image = "rbxassetid://601589843",
        ImageColor3 = Color3.fromRGB(0, 0, 0),
        ImageTransparency = 0.5,
        BackgroundTransparency = 1,
        ZIndex = -1
    })
    
    -- Title Bar
    local TitleBar = Create("Frame", {
        Name = "TitleBar",
        Parent = MainFrame,
        Size = UDim2.new(1, 0, 0, 45), -- Lebih tinggi untuk mobile
        BackgroundColor3 = Color3.fromRGB(20, 20, 25),
        BorderSizePixel = 0
    })
    
    local TitleBarCorner = Create("UICorner", {
        Parent = TitleBar,
        CornerRadius = UDim.new(0, 12)
    })
    
    -- Title Text
    local TitleText = Create("TextLabel", {
        Name = "TitleText",
        Parent = TitleBar,
        Size = UDim2.new(1, -90, 1, 0),
        Position = UDim2.new(0, 15, 0, 0),
        BackgroundTransparency = 1,
        Text = config.Title or "Modern UI",
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextXAlignment = Enum.TextXAlignment.Left,
        Font = Enum.Font.GothamBold,
        TextSize = 16,
        TextScaled = true,
        FontSize = Enum.FontSize.Size14
    })
    
    -- Author Text
    if config.Author then
        local AuthorText = Create("TextLabel", {
            Name = "AuthorText",
            Parent = TitleBar,
            Size = UDim2.new(1, -90, 0, 20),
            Position = UDim2.new(0, 15, 0, 22),
            BackgroundTransparency = 1,
            Text = "by " .. config.Author,
            TextColor3 = Color3.fromRGB(150, 150, 150),
            TextXAlignment = Enum.TextXAlignment.Left,
            Font = Enum.Font.Gotham,
            TextSize = 11
        })
    end
    
    -- Minimize Button
    local MinimizeButton = Create("ImageButton", {
        Name = "MinimizeButton",
        Parent = TitleBar,
        Size = UDim2.new(0, 30, 0, 30),
        Position = UDim2.new(1, -75, 0.5, -15),
        BackgroundTransparency = 1,
        Image = "rbxassetid://6031280882",
        ImageColor3 = Color3.fromRGB(200, 200, 200),
        ScaleType = Enum.ScaleType.Fit
    })
    
    -- Close Button
    local CloseButton = Create("ImageButton", {
        Name = "CloseButton",
        Parent = TitleBar,
        Size = UDim2.new(0, 30, 0, 30),
        Position = UDim2.new(1, -40, 0.5, -15),
        BackgroundTransparency = 1,
        Image = "rbxassetid://6031280369",
        ImageColor3 = Color3.fromRGB(200, 200, 200),
        ScaleType = Enum.ScaleType.Fit
    })
    
    -- Tab Container
    local TabContainer = Create("Frame", {
        Name = "TabContainer",
        Parent = MainFrame,
        Size = UDim2.new(1, 0, 0, 50),
        Position = UDim2.new(0, 0, 0, 45),
        BackgroundColor3 = Color3.fromRGB(30, 30, 35),
        BorderSizePixel = 0
    })
    
    local TabList = Create("ScrollingFrame", {
        Name = "TabList",
        Parent = TabContainer,
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        ScrollBarThickness = 0,
        CanvasSize = UDim2.new(2, 0, 0, 0),
        AutomaticCanvasSize = Enum.AutomaticSize.X,
        ScrollingDirection = Enum.ScrollingDirection.X
    })
    
    local TabListLayout = Create("UIListLayout", {
        Parent = TabList,
        FillDirection = Enum.FillDirection.Horizontal,
        HorizontalAlignment = Enum.HorizontalAlignment.Left,
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, 8)
    })
    
    local TabListPadding = Create("UIPadding", {
        Parent = TabList,
        PaddingLeft = UDim.new(0, 12),
        PaddingRight = UDim.new(0, 12)
    })
    
    -- Content Container (Main Area)
    local ContentContainer = Create("ScrollingFrame", {
        Name = "ContentContainer",
        Parent = MainFrame,
        Size = UDim2.new(1, 0, 1, -95),
        Position = UDim2.new(0, 0, 0, 95),
        BackgroundColor3 = Color3.fromRGB(25, 25, 30),
        BorderSizePixel = 0,
        ScrollBarThickness = 4,
        ScrollBarImageColor3 = Color3.fromRGB(0, 150, 255),
        CanvasSize = UDim2.new(0, 0, 0, 0),
        AutomaticCanvasSize = Enum.AutomaticSize.Y
    })
    
    local ContentPadding = Create("UIPadding", {
        Parent = ContentContainer,
        PaddingTop = UDim.new(0, 12),
        PaddingBottom = UDim.new(0, 12),
        PaddingLeft = UDim.new(0, 8),
        PaddingRight = UDim.new(0, 8)
    })
    
    local ContentListLayout = Create("UIListLayout", {
        Parent = ContentContainer,
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, 10)
    })
    
    -- Variables
    local tabs = {}
    local minimized = false
    local originalSize = MainFrame.Size
    local dragging = false
    local dragOffset = Vector2.new()
    
    -- Dragging Functionality
    TitleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragOffset = Vector2.new(input.Position.X - MainFrame.AbsolutePosition.X, 
                                    input.Position.Y - MainFrame.AbsolutePosition.Y)
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.Touch or 
                        input.UserInputType == Enum.UserInputType.MouseMovement) then
            local newPos = UDim2.new(0, input.Position.X - dragOffset.X, 
                                    0, input.Position.Y - dragOffset.Y)
            MainFrame.Position = newPos
        end
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch or 
           input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    
    -- Minimize Function
    MinimizeButton.MouseButton1Click:Connect(function()
        if not minimized then
            TweenService:Create(MainFrame, TweenInfo.new(0.3), {
                Size = UDim2.new(0.9, 0, 0, 45)
            }):Play()
            ContentContainer.Visible = false
            TabContainer.Visible = false
            MinimizeButton.Image = "rbxassetid://6031280882"
        else
            TweenService:Create(MainFrame, TweenInfo.new(0.3), {
                Size = UDim2.new(0.9, 0, 0.7, 0)
            }):Play()
            task.wait(0.3)
            ContentContainer.Visible = true
            TabContainer.Visible = true
            MinimizeButton.Image = "rbxassetid://6031280369"
        end
        minimized = not minimized
    end)
    
    -- Close Function
    CloseButton.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
    end)
    
    -- TAB CREATION FUNCTION
    function Window:Tab(config)
        local Tab = {}
        
        -- Tab Button
        local TabButton = Create("TextButton", {
            Parent = TabList,
            Size = UDim2.new(0, 80, 0, 35),
            BackgroundColor3 = Color3.fromRGB(35, 35, 40),
            Text = config.Title or "Tab",
            TextColor3 = Color3.fromRGB(200, 200, 200),
            Font = Enum.Font.Gotham,
            TextSize = 14,
            AutoButtonColor = false
        })
        
        local TabButtonCorner = Create("UICorner", {
            Parent = TabButton,
            CornerRadius = UDim.new(0, 6)
        })
        
        -- Page Frame
        local Page = Create("Frame", {
            Parent = ContentContainer,
            Size = UDim2.new(1, 0, 0, 0),
            BackgroundTransparency = 1,
            Visible = false
        })
        
        local PageLayout = Create("UIListLayout", {
            Parent = Page,
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0, 8)
        })
        
        -- Select Tab
        TabButton.MouseButton1Click:Connect(function()
            for _, otherTab in pairs(tabs) do
                otherTab.Button.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
                otherTab.Button.TextColor3 = Color3.fromRGB(200, 200, 200)
                otherTab.Page.Visible = false
            end
            TabButton.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
            TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
            Page.Visible = true
        end)
        
        -- Add to tabs list
        table.insert(tabs, {Button = TabButton, Page = Page})
        
        -- Select first tab by default
        if #tabs == 1 then
            TabButton.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
            TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
            Page.Visible = true
        end
        
        -- SECTION CREATION
        function Tab:Section(config)
            local Section = {}
            
            local SectionFrame = Create("Frame", {
                Parent = Page,
                Size = UDim2.new(1, 0, 0, 0),
                BackgroundColor3 = Color3.fromRGB(35, 35, 40),
                BorderSizePixel = 0,
                AutomaticSize = Enum.AutomaticSize.Y
            })
            
            local SectionCorner = Create("UICorner", {
                Parent = SectionFrame,
                CornerRadius = UDim.new(0, 8)
            })
            
            if config.Title then
                local SectionTitle = Create("TextLabel", {
                    Parent = SectionFrame,
                    Size = UDim2.new(1, -16, 0, 30),
                    Position = UDim2.new(0, 8, 0, 0),
                    BackgroundTransparency = 1,
                    Text = config.Title,
                    TextColor3 = Color3.fromRGB(255, 255, 255),
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Font = Enum.Font.GothamBold,
                    TextSize = 16
                })
            end
            
            local SectionContent = Create("Frame", {
                Parent = SectionFrame,
                Size = UDim2.new(1, -16, 0, 0),
                Position = UDim2.new(0, 8, 0, config.Title and 30 or 8),
                BackgroundTransparency = 1,
                AutomaticSize = Enum.AutomaticSize.Y
            })
            
            local SectionLayout = Create("UIListLayout", {
                Parent = SectionContent,
                SortOrder = Enum.SortOrder.LayoutOrder,
                Padding = UDim.new(0, 8)
            })
            
            -- COMPONENT: BUTTON
            function Section:Button(config)
                local ButtonFrame = Create("Frame", {
                    Parent = SectionContent,
                    Size = UDim2.new(1, 0, 0, 40),
                    BackgroundColor3 = Color3.fromRGB(45, 45, 50),
                    BorderSizePixel = 0
                })
                
                local ButtonCorner = Create("UICorner", {
                    Parent = ButtonFrame,
                    CornerRadius = UDim.new(0, 6)
                })
                
                local Button = Create("TextButton", {
                    Parent = ButtonFrame,
                    Size = UDim2.new(1, 0, 1, 0),
                    BackgroundTransparency = 1,
                    Text = config.Title or "Button",
                    TextColor3 = Color3.fromRGB(255, 255, 255),
                    Font = Enum.Font.Gotham,
                    TextSize = 14
                })
                
                Button.MouseButton1Click:Connect(function()
                    TweenService:Create(ButtonFrame, TweenInfo.new(0.1), {
                        BackgroundColor3 = Color3.fromRGB(30, 30, 35)
                    }):Play()
                    task.wait(0.1)
                    TweenService:Create(ButtonFrame, TweenInfo.new(0.1), {
                        BackgroundColor3 = Color3.fromRGB(45, 45, 50)
                    }):Play()
                    
                    if config.Callback then
                        config.Callback()
                    end
                end)
            end
            
            -- COMPONENT: TOGGLE
            function Section:Toggle(config)
                local ToggleFrame = Create("Frame", {
                    Parent = SectionContent,
                    Size = UDim2.new(1, 0, 0, 40),
                    BackgroundTransparency = 1
                })
                
                local Title = Create("TextLabel", {
                    Parent = ToggleFrame,
                    Size = UDim2.new(1, -60, 1, 0),
                    BackgroundTransparency = 1,
                    Text = config.Title or "Toggle",
                    TextColor3 = Color3.fromRGB(255, 255, 255),
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Font = Enum.Font.Gotham,
                    TextSize = 14
                })
                
                local ToggleButton = Create("Frame", {
                    Parent = ToggleFrame,
                    Size = UDim2.new(0, 50, 0, 24),
                    Position = UDim2.new(1, -55, 0.5, -12),
                    BackgroundColor3 = config.Value and Color3.fromRGB(0, 150, 255) or Color3.fromRGB(60, 60, 65),
                    BorderSizePixel = 0
                })
                
                local ToggleCorner = Create("UICorner", {
                    Parent = ToggleButton,
                    CornerRadius = UDim.new(1, 0)
                })
                
                local ToggleKnob = Create("Frame", {
                    Parent = ToggleButton,
                    Size = UDim2.new(0, 20, 0, 20),
                    Position = config.Value and UDim2.new(1, -22, 0.5, -10) or UDim2.new(0, 2, 0.5, -10),
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                    BorderSizePixel = 0
                })
                
                local KnobCorner = Create("UICorner", {
                    Parent = ToggleKnob,
                    CornerRadius = UDim.new(1, 0)
                })
                
                local Button = Create("TextButton", {
                    Parent = ToggleFrame,
                    Size = UDim2.new(1, 0, 1, 0),
                    BackgroundTransparency = 1,
                    Text = ""
                })
                
                local toggled = config.Value or false
                
                Button.MouseButton1Click:Connect(function()
                    toggled = not toggled
                    ToggleButton.BackgroundColor3 = toggled and Color3.fromRGB(0, 150, 255) or Color3.fromRGB(60, 60, 65)
                    
                    TweenService:Create(ToggleKnob, TweenInfo.new(0.2), {
                        Position = toggled and UDim2.new(1, -22, 0.5, -10) or UDim2.new(0, 2, 0.5, -10)
                    }):Play()
                    
                    if config.Callback then
                        config.Callback(toggled)
                    end
                end)
            end
            
            -- COMPONENT: INPUT
            function Section:Input(config)
                local InputFrame = Create("Frame", {
                    Parent = SectionContent,
                    Size = UDim2.new(1, 0, 0, 60),
                    BackgroundTransparency = 1
                })
                
                local Title = Create("TextLabel", {
                    Parent = InputFrame,
                    Size = UDim2.new(1, 0, 0, 20),
                    BackgroundTransparency = 1,
                    Text = config.Title or "Input",
                    TextColor3 = Color3.fromRGB(200, 200, 200),
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Font = Enum.Font.Gotham,
                    TextSize = 13
                })
                
                local InputContainer = Create("Frame", {
                    Parent = InputFrame,
                    Size = UDim2.new(1, 0, 0, 35),
                    Position = UDim2.new(0, 0, 0, 22),
                    BackgroundColor3 = Color3.fromRGB(40, 40, 45),
                    BorderSizePixel = 0
                })
                
                local ContainerCorner = Create("UICorner", {
                    Parent = InputContainer,
                    CornerRadius = UDim.new(0, 6)
                })
                
                local TextBox = Create("TextBox", {
                    Parent = InputContainer,
                    Size = UDim2.new(1, -20, 1, 0),
                    Position = UDim2.new(0, 10, 0, 0),
                    BackgroundTransparency = 1,
                    Text = config.Value or "",
                    PlaceholderText = config.Placeholder or "Type here...",
                    TextColor3 = Color3.fromRGB(255, 255, 255),
                    PlaceholderColor3 = Color3.fromRGB(120, 120, 120),
                    Font = Enum.Font.Gotham,
                    TextSize = 14
                })
                
                TextBox.FocusLost:Connect(function()
                    if config.Callback then
                        config.Callback(TextBox.Text)
                    end
                end)
            end
            
            -- COMPONENT: DROPDOWN
            function Section:Dropdown(config)
                local DropdownFrame = Create("Frame", {
                    Parent = SectionContent,
                    Size = UDim2.new(1, 0, 0, 45),
                    BackgroundTransparency = 1
                })
                
                local Title = Create("TextLabel", {
                    Parent = DropdownFrame,
                    Size = UDim2.new(1, 0, 0, 20),
                    BackgroundTransparency = 1,
                    Text = config.Title or "Dropdown",
                    TextColor3 = Color3.fromRGB(255, 255, 255),
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Font = Enum.Font.Gotham,
                    TextSize = 14
                })
                
                local DropdownButton = Create("Frame", {
                    Parent = DropdownFrame,
                    Size = UDim2.new(1, 0, 0, 25),
                    Position = UDim2.new(0, 0, 0, 20),
                    BackgroundColor3 = Color3.fromRGB(45, 45, 50),
                    BorderSizePixel = 0
                })
                
                local ButtonCorner = Create("UICorner", {
                    Parent = DropdownButton,
                    CornerRadius = UDim.new(0, 6)
                })
                
                local SelectedText = Create("TextLabel", {
                    Parent = DropdownButton,
                    Size = UDim2.new(1, -35, 1, 0),
                    Position = UDim2.new(0, 10, 0, 0),
                    BackgroundTransparency = 1,
                    Text = config.Value or config.Values[1] or "Select",
                    TextColor3 = Color3.fromRGB(255, 255, 255),
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Font = Enum.Font.Gotham,
                    TextSize = 13
                })
                
                local Arrow = Create("ImageLabel", {
                    Parent = DropdownButton,
                    Size = UDim2.new(0, 15, 0, 15),
                    Position = UDim2.new(1, -25, 0.5, -7.5),
                    BackgroundTransparency = 1,
                    Image = "rbxassetid://6031280882",
                    ImageColor3 = Color3.fromRGB(200, 200, 200)
                })
                
                local Button = Create("TextButton", {
                    Parent = DropdownFrame,
                    Size = UDim2.new(1, 0, 0, 25),
                    Position = UDim2.new(0, 0, 0, 20),
                    BackgroundTransparency = 1,
                    Text = ""
                })
                
                -- Dropdown List
                local DropdownList = Create("ScrollingFrame", {
                    Parent = SectionContent,
                    Size = UDim2.new(1, 0, 0, 0),
                    BackgroundColor3 = Color3.fromRGB(35, 35, 40),
                    BorderSizePixel = 0,
                    Visible = false,
                    ScrollBarThickness = 4,
                    ZIndex = 10,
                    AutomaticSize = Enum.AutomaticSize.Y
                })
                
                local ListCorner = Create("UICorner", {
                    Parent = DropdownList,
                    CornerRadius = UDim.new(0, 6)
                })
                
                local ListLayout = Create("UIListLayout", {
                    Parent = DropdownList,
                    Padding = UDim.new(0, 2)
                })
                
                -- Create items
                for _, value in ipairs(config.Values) do
                    local ItemFrame = Create("Frame", {
                        Parent = DropdownList,
                        Size = UDim2.new(1, 0, 0, 35),
                        BackgroundColor3 = Color3.fromRGB(45, 45, 50),
                        BorderSizePixel = 0
                    })
                    
                    local ItemText = Create("TextLabel", {
                        Parent = ItemFrame,
                        Size = UDim2.new(1, -10, 1, 0),
                        Position = UDim2.new(0, 5, 0, 0),
                        BackgroundTransparency = 1,
                        Text = value,
                        TextColor3 = Color3.fromRGB(255, 255, 255),
                        TextXAlignment = Enum.TextXAlignment.Left,
                        Font = Enum.Font.Gotham,
                        TextSize = 13
                    })
                    
                    local ItemButton = Create("TextButton", {
                        Parent = ItemFrame,
                        Size = UDim2.new(1, 0, 1, 0),
                        BackgroundTransparency = 1,
                        Text = ""
                    })
                    
                    ItemButton.MouseButton1Click:Connect(function()
                        SelectedText.Text = value
                        DropdownList.Visible = false
                        Arrow.Rotation = 0
                        if config.Callback then
                            config.Callback(value)
                        end
                    end)
                end
                
                -- Toggle dropdown
                Button.MouseButton1Click:Connect(function()
                    DropdownList.Visible = not DropdownList.Visible
                    Arrow.Rotation = DropdownList.Visible and 180 or 0
                end)
            end
            
            -- COMPONENT: SLIDER
            function Section:Slider(config)
                local SliderFrame = Create("Frame", {
                    Parent = SectionContent,
                    Size = UDim2.new(1, 0, 0, 60),
                    BackgroundTransparency = 1
                })
                
                local Title = Create("TextLabel", {
                    Parent = SliderFrame,
                    Size = UDim2.new(0.7, 0, 0, 20),
                    BackgroundTransparency = 1,
                    Text = config.Title or "Slider",
                    TextColor3 = Color3.fromRGB(255, 255, 255),
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Font = Enum.Font.Gotham,
                    TextSize = 14
                })
                
                local ValueLabel = Create("TextLabel", {
                    Parent = SliderFrame,
                    Size = UDim2.new(0.3, 0, 0, 20),
                    Position = UDim2.new(0.7, 0, 0, 0),
                    BackgroundTransparency = 1,
                    Text = tostring(config.Value.Default or 50),
                    TextColor3 = Color3.fromRGB(0, 150, 255),
                    TextXAlignment = Enum.TextXAlignment.Right,
                    Font = Enum.Font.Gotham,
                    TextSize = 14
                })
                
                if config.Desc then
                    local Desc = Create("TextLabel", {
                        Parent = SliderFrame,
                        Size = UDim2.new(1, 0, 0, 15),
                        Position = UDim2.new(0, 0, 0, 18),
                        BackgroundTransparency = 1,
                        Text = config.Desc,
                        TextColor3 = Color3.fromRGB(150, 150, 150),
                        TextXAlignment = Enum.TextXAlignment.Left,
                        Font = Enum.Font.Gotham,
                        TextSize = 11
                    })
                end
                
                local SliderContainer = Create("Frame", {
                    Parent = SliderFrame,
                    Size = UDim2.new(1, 0, 0, 25),
                    Position = UDim2.new(0, 0, 0, config.Desc and 38 or 25),
                    BackgroundColor3 = Color3.fromRGB(45, 45, 50),
                    BorderSizePixel = 0
                })
                
                local ContainerCorner = Create("UICorner", {
                    Parent = SliderContainer,
                    CornerRadius = UDim.new(1, 0)
                })
                
                local Fill = Create("Frame", {
                    Parent = SliderContainer,
                    Size = UDim2.new(0, 0, 1, 0),
                    BackgroundColor3 = Color3.fromRGB(0, 150, 255),
                    BorderSizePixel = 0
                })
                
                local FillCorner = Create("UICorner", {
                    Parent = Fill,
                    CornerRadius = UDim.new(1, 0)
                })
                
                local Knob = Create("Frame", {
                    Parent = SliderContainer,
                    Size = UDim2.new(0, 16, 0, 16),
                    Position = UDim2.new(0, 0, 0.5, -8),
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                    BorderSizePixel = 0
                })
                
                local KnobCorner = Create("UICorner", {
                    Parent = Knob,
                    CornerRadius = UDim.new(1, 0)
                })
                
                local min = config.Value.Min or 0
                local max = config.Value.Max or 100
                local defaultValue = config.Value.Default or 50
                
                local function UpdateSlider(input)
                    local posX = math.clamp(input.Position.X - SliderContainer.AbsolutePosition.X, 0, SliderContainer.AbsoluteSize.X)
                    local percentage = posX / SliderContainer.AbsoluteSize.X
                    
                    Knob.Position = UDim2.new(percentage, -8, 0.5, -8)
                    Fill.Size = UDim2.new(percentage, 0, 1, 0)
                    
                    local value = math.floor(min + (max - min) * percentage)
                    ValueLabel.Text = tostring(value)
                    
                    if config.Callback then
                        config.Callback(value)
                    end
                end
                
                -- Initialize
                local initialPercentage = (defaultValue - min) / (max - min)
                Knob.Position = UDim2.new(initialPercentage, -8, 0.5, -8)
                Fill.Size = UDim2.new(initialPercentage, 0, 1, 0)
                
                local dragging = false
                
                Knob.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.Touch or 
                       input.UserInputType == Enum.UserInputType.MouseButton1 then
                        dragging = true
                    end
                end)
                
                UserInputService.InputChanged:Connect(function(input)
                    if dragging and (input.UserInputType == Enum.UserInputType.Touch or 
                                    input.UserInputType == Enum.UserInputType.MouseMovement) then
                        UpdateSlider(input)
                    end
                end)
                
                UserInputService.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.Touch or 
                       input.UserInputType == Enum.UserInputType.MouseButton1 then
                        dragging = false
                    end
                end)
                
                SliderContainer.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.Touch or 
                       input.UserInputType == Enum.UserInputType.MouseButton1 then
                        UpdateSlider(input)
                        dragging = true
                    end
                end)
            end
            
            return Section
        end
        
        return Tab
    end
    
    return Window
end
