-- Example usage for ks.luau (kiwisense)
-- Replace the placeholder Loadstring with your actual loader.

local Loadstring = [[
-- Example:
-- return loadstring(game:HttpGet("https://your.domain/ks.luau"))()
]]

-- Placeholder: replace with your own loadstring call
local Library, Options, MiscOptions, ESPFonts, SelectedESPFont

if Loadstring ~= "" then
    Library, Options, MiscOptions, ESPFonts, SelectedESPFont = loadstring(Loadstring)()
else
    -- Fallback to local require-style usage if you already have ks.luau in scope
    -- Library, Options, MiscOptions, ESPFonts, SelectedESPFont = loadstring(readfile("ks.luau"))()
    error("Please set Loadstring to your ks.luau loader.")
end

local Window = Library:Window({
    Name = "kiwisense demo",
    Version = "v2.1",
    Logo = "135215559087473",
    FadeSpeed = 0.25,
})

-- Optional utility panels
local Watermark = Library:Watermark("kiwisense demo", "135215559087473")
Watermark:SetVisibility(true)

local KeybindList = Library:KeybindsList()
KeybindList:SetVisibility(true)

Library:Notification({
    Name = "Loaded",
    Description = "Example UI created",
    Duration = 5,
    Icon = "116339777575852",
    IconColor = Color3.fromRGB(52, 255, 164)
})

-- Extra panels
local ESPPreview = Library:ESPPreview({
    MainFrame = Window.Items["MainFrame"]
})
ESPPreview:SetVisibility(true)

local ChatSystem = Library:ChatSystem({
    MainFrame = Window.Items["MainFrame"]
})
ChatSystem:SetVisibility(false)

-- Pages
local MainPage = Window:Page({
    Name = "Main",
    Icon = "111178525804834",
    Columns = 2,
    SubPages = true
})

local VisualsPage = Window:Page({
    Name = "Visuals",
    Icon = "111178525804834",
    Columns = 2,
    SubPages = false
})

local PlayerPage = Window:Page({
    Name = "Players",
    Icon = "111178525804834",
    Columns = 1,
    SubPages = false
})

-- SubPages
local SubPageA = MainPage:SubPage({
    Name = "SubPage A",
    Icon = "111178525804834",
    Columns = 2
})

local SubPageB = MainPage:SubPage({
    Name = "SubPage B",
    Icon = "111178525804834",
    Columns = 2
})

-- Sections
local LeftSection = MainPage:Section({
    Name = "Left Section",
    Icon = "9080568477801",
    Side = 1
})

local RightSection = MainPage:Section({
    Name = "Right Section",
    Icon = "9080568477801",
    Side = 2
})

local SubSection = SubPageA:Section({
    Name = "Sub Section",
    Icon = "9080568477801",
    Side = 1
})

local VisualsSection = VisualsPage:Section({
    Name = "Visuals",
    Icon = "9080568477801",
    Side = 1
})

-- Elements: Toggle + Keybind + Colorpicker
local CombatToggle = LeftSection:Toggle({
    Name = "Enable Feature",
    Default = false,
    Flag = "EnableFeature",
    Callback = function(Value)
        print("EnableFeature:", Value)
    end
})

CombatToggle:Keybind({
    Name = "Feature Keybind",
    Flag = "FeatureKeybind",
    Mode = "Toggle",
    Default = Enum.KeyCode.F,
    Callback = function(State)
        print("Feature keybind toggled:", State)
    end
})

CombatToggle:Colorpicker({
    Name = "Feature Color",
    Default = Color3.fromRGB(196, 231, 255),
    Flag = "FeatureColor",
    Alpha = 0,
    Callback = function(Color, Alpha)
        print("Feature color:", Color, Alpha)
    end
})

-- Slider
local SpeedSlider = LeftSection:Slider({
    Name = "Speed",
    Min = 0,
    Max = 100,
    Default = 50,
    Decimals = 1,
    Suffix = "%",
    Flag = "Speed",
    Callback = function(Value)
        print("Speed:", Value)
    end
})

-- Textbox
local NameTextbox = LeftSection:Textbox({
    Name = "Username",
    Placeholder = "Type here",
    Default = "Player",
    Flag = "Username",
    Callback = function(Value)
        print("Username:", Value)
    end
})

-- Dropdown (single)
local ModeDropdown = RightSection:Dropdown({
    Name = "Mode",
    Items = { "Easy", "Medium", "Hard" },
    Default = "Medium",
    MaxSize = 85,
    Flag = "Mode",
    Multi = false,
    Callback = function(Value)
        print("Mode:", Value)
    end
})

-- Dropdown (multi)
local MultiDropdown = RightSection:Dropdown({
    Name = "Options",
    Items = { "A", "B", "C" },
    Default = nil,
    MaxSize = 85,
    Flag = "MultiOptions",
    Multi = true,
    Callback = function(Value)
        print("Multi options:", table.concat(Value, ", "))
    end
})

-- Button
RightSection:Button({
    Name = "Apply",
    Callback = function()
        print("Apply pressed")
    end
})

-- Label + Keybind + Colorpicker
local Label = RightSection:Label("Keybind Label", "Left")
Label:Keybind({
    Name = "Label Keybind",
    Flag = "LabelKeybind",
    Mode = "Hold",
    Default = Enum.KeyCode.LeftShift,
    Callback = function(State)
        print("Label keybind:", State)
    end
})

Label:Colorpicker({
    Name = "Label Color",
    Default = Color3.fromRGB(255, 255, 255),
    Flag = "LabelColor",
    Alpha = 0,
    Callback = function(Color, Alpha)
        print("Label color:", Color, Alpha)
    end
})

-- SubPage elements
SubSection:Toggle({
    Name = "Sub Toggle",
    Default = true,
    Flag = "SubToggle",
    Callback = function(Value)
        print("Sub toggle:", Value)
    end
})

SubSection:Slider({
    Name = "Sub Slider",
    Min = 1,
    Max = 10,
    Default = 5,
    Decimals = 0,
    Flag = "SubSlider",
    Callback = function(Value)
        print("Sub slider:", Value)
    end
})

-- Visuals section using ESP Preview
VisualsSection:Button({
    Name = "Toggle ESP Preview",
    Callback = function()
        ESPPreview:SetVisibility(true)
    end
})

-- Playerlist page (special page type)
local Playerlist = PlayerPage:Playerlist({
    Callback = function(Player, Status, Team)
        if Player then
            print("Selected:", Player.Name, Status, Team)
        else
            print("Player selection cleared")
        end
    end
})

-- ChatSystem usage example
ChatSystem:OnMessageSendPressed(function()
    ChatSystem:SendMessage(
        "rbxassetid://78993485446406",
        "demo",
        ChatSystem:GetTypedMessage(),
        true
    )
end)

-- Ensure autoload configs/themes apply
Library:Init()
