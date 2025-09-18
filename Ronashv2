-- =========================
-- RONASH v2🔥 PART 1
-- Loader + Main UI + Sidebar
-- =========================

-- Load UI Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/x2zu/OPEN-SOURCE-UI-ROBLOX/refs/heads/main/X2ZU%20UI%20ROBLOX%20OPEN%20SOURCE/DummyUi-leak-by-x2zu/fetching-main/Tools/Framework.luau"))()

-- ===== LOADER =====
local loaderGui=Instance.new("ScreenGui")
loaderGui.Name="RonashLoader"
loaderGui.Parent=game:GetService("CoreGui")

local bg=Instance.new("Frame")
bg.Size=UDim2.new(0,400,0,200)
bg.Position=UDim2.new(0.5,-200,0.5,-100)
bg.BackgroundColor3=Color3.fromRGB(20,20,20)
bg.BorderSizePixel=0
bg.Parent=loaderGui

-- Logo
local logo=Instance.new("ImageLabel")
logo.Size=UDim2.new(0,150,0,150)
logo.Position=UDim2.new(0.5,-75,0,20)
logo.Image="rbxassetid://96680008830476" -- your logo
logo.BackgroundTransparency=1
logo.Parent=bg

-- Progress Bar Background
local barBG=Instance.new("Frame")
barBG.Size=UDim2.new(0,300,0,20)
barBG.Position=UDim2.new(0.5,-150,1,-50)
barBG.BackgroundColor3=Color3.fromRGB(60,60,60)
barBG.BorderSizePixel=0
barBG.Parent=bg

-- Progress Fill
local barFill=Instance.new("Frame")
barFill.Size=UDim2.new(0,0,1,0)
barFill.BackgroundColor3=Color3.fromRGB(0,255,255)
barFill.BorderSizePixel=0
barFill.Parent=barBG

-- TweenService for smooth progress
local TweenService=game:GetService("TweenService")
local totalTime=2.5
local steps=50

for i=1,steps do
    local percent=i/steps
    TweenService:Create(barFill,TweenInfo.new(totalTime/steps,Enum.EasingStyle.Linear),{Size=UDim2.new(percent,0,1,0)}):Play()
    task.wait(totalTime/steps)
end

-- Glow effect on logo
local uigrad=Instance.new("UIGradient")
uigrad.Color=ColorSequence.new({ColorSequenceKeypoint.new(0,Color3.fromRGB(0,255,255)),ColorSequenceKeypoint.new(1,Color3.fromRGB(0,128,255))})
uigrad.Rotation=45
uigrad.Parent=logo

task.wait(0.5) -- small delay before removing loader
loaderGui:Destroy()

-- ===== CREATE MAIN WINDOW =====
local Window = Library:Window({
    Title = "Ronash v2🔥",
    Desc = "Ronash on top",
    Icon = 96680008830476,
    Theme = "Dark",
    Config = {
        Keybind = Enum.KeyCode.LeftControl,
        Size = UDim2.new(0, 575, 0, 387)
    },
    CloseUIButton = {
        Enabled = true,
        Text = "Ronash"
    }
})

-- Sidebar Vertical Separator
local SidebarLine = Instance.new("Frame")
SidebarLine.Size = UDim2.new(0, 1, 1, 0)
SidebarLine.Position = UDim2.new(0, 120, 0, 0)
SidebarLine.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
SidebarLine.BorderSizePixel = 0
SidebarLine.ZIndex = 5
SidebarLine.Name = "SidebarLine"
SidebarLine.Parent = Window.Gui

-- ===== MAIN TAB =====
local Tab = Window:Tab({Title = "Main", Icon = "star"}) do
    Tab:Section({Title = "All UI Components"})

    -- Toggle
    Tab:Toggle({
        Title = "Enable Feature",
        Desc = "Toggle to enable or disable the feature",
        Value = false,
        Callback = function(v)
            print("Toggle:", v)
        end
    })

    -- Button
    Tab:Button({
        Title = "Run Action",
        Desc = "Click to perform something",
        Callback = function()
            print("Button clicked!")
            Window:Notify({
                Title = "Button",
                Desc = "Action performed successfully.",
                Time = 3
            })
        end
    })

    -- Textbox
    Tab:Textbox({
        Title = "Input Text",
        Desc = "Type something here",
        Placeholder = "Enter value",
        Value = "",
        ClearTextOnFocus = false,
        Callback = function(text)
            print("Textbox value:", text)
        end
    })

    -- Slider
    Tab:Slider({
        Title = "Set Speed",
        Min = 0,
        Max = 100,
        Rounding = 0,
        Value = 25,
        Callback = function(val)
            print("Slider:", val)
        end
    })

    -- Dropdown
    Tab:Dropdown({
        Title = "Choose Option",
        List = {"Option 1", "Option 2", "Option 3"},
        Value = "Option 1",
        Callback = function(choice)
            print("Selected:", choice)
        end
    })
end
-- =========================
-- RONASH v2🔥 PART 2
-- TP + Extras (Stable Fly, Smooth TP, Noclip, WalkSpeed/JumpPower, Anti-AFK)
-- =========================

local RunService=game:GetService("RunService")
local Players=game:GetService("Players")
local LocalPlayer=Players.LocalPlayer
local Character=LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local HRP=Character:WaitForChild("HumanoidRootPart")
local Humanoid=Character:WaitForChild("Humanoid")
local UIS=game:GetService("UserInputService")

-- ===== TP TAB =====
local TP=Window:Tab({Title="Teleport",Icon="arrow"}) do
    TP:Section({Title="Teleport to Players & Locations",Size=UDim2.new(0,370,0,200)})

    TP:Dropdown({
        Title="Select Player",
        List=(function()
            local plrs={}
            for _,v in pairs(Players:GetPlayers()) do
                if v~=LocalPlayer then table.insert(plrs,v.Name) end
            end
            return plrs
        end)(),
        Value="",
        Callback=function(name)
            local target=Players:FindFirstChild(name)
            if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
                local targetHRP = target.Character.HumanoidRootPart
                local tweenTime = 0.5
                local startPos = HRP.Position
                local goalPos = targetHRP.Position
                for i=0,1,0.1 do
                    HRP.CFrame=CFrame.new(startPos:lerp(goalPos,i))
                    task.wait(tweenTime*0.1)
                end
                HRP.CFrame=CFrame.new(goalPos)
                Window:Notify({Title="TP",Desc="Teleported to "..name,Time=3})
            end
        end
    })

    TP:Dropdown({
        Title="Preset Locations",
        List={"Spawn","Arena","Marketplace"},
        Value="Spawn",
        Callback=function(loc)
            local cf
            if loc=="Spawn" then cf=CFrame.new(0,10,0) end
            if loc=="Arena" then cf=CFrame.new(100,10,0) end
            if loc=="Marketplace" then cf=CFrame.new(-50,10,100) end
            if cf then
                local startPos = HRP.Position
                local goalPos = cf.Position
                for i=0,1,0.1 do
                    HRP.CFrame=CFrame.new(startPos:lerp(goalPos,i))
                    task.wait(0.05)
                end
                HRP.CFrame=cf
                Window:Notify({Title="TP",Desc="Teleported to "..loc,Time=3})
            end
        end
    })
end

-- ===== EXTRAS TAB =====
local Extras=Window:Tab({Title="Extras",Icon="star"}) do
    Extras:Section({Title="Utilities",Size=UDim2.new(0,370,0,200)})

    -- Stable Fly
    local flying=false
    local BodyGyro,BodyVelocity
    local moveVector=Vector3.new(0,0,0)
    local flySpeed=50

    Extras:Toggle({
        Title="Fly",
        Value=false,
        Callback=function(v)
            flying=v
            if v then
                BodyGyro=Instance.new("BodyGyro",HRP)
                BodyGyro.P=9e4
                BodyGyro.MaxTorque=Vector3.new(9e5,9e5,9e5)
                BodyGyro.CFrame=HRP.CFrame

                BodyVelocity=Instance.new("BodyVelocity",HRP)
                BodyVelocity.MaxForce=Vector3.new(9e5,9e5,9e5)
                BodyVelocity.Velocity=Vector3.new(0,0,0)

                Window:Notify({Title="Fly",Desc="Enabled",Time=3})
            else
                if BodyGyro then BodyGyro:Destroy() end
                if BodyVelocity then BodyVelocity:Destroy() end
                Window:Notify({Title="Fly",Desc="Disabled",Time=3})
            end
        end
    })

    Extras:Slider({
        Title="Fly Speed",
        Min=10,
        Max=300,
        Value=50,
        Callback=function(val)
            flySpeed=val
        end
    })

    -- Fly movement controls
    UIS.InputBegan:Connect(function(input,gp)
        if gp then return end
        if input.KeyCode==Enum.KeyCode.W then moveVector = Vector3.new(0,0,-1) end
        if input.KeyCode==Enum.KeyCode.S then moveVector = Vector3.new(0,0,1) end
        if input.KeyCode==Enum.KeyCode.A then moveVector = Vector3.new(-1,0,0) end
        if input.KeyCode==Enum.KeyCode.D then moveVector = Vector3.new(1,0,0) end
        if input.KeyCode==Enum.KeyCode.Space then moveVector = Vector3.new(0,1,0) end
        if input.KeyCode==Enum.KeyCode.LeftShift then moveVector = Vector3.new(0,-1,0) end
    end)

    UIS.InputEnded:Connect(function(input,gp)
        if gp then return end
        if input.KeyCode==Enum.KeyCode.W or input.KeyCode==Enum.KeyCode.S or
           input.KeyCode==Enum.KeyCode.A or input.KeyCode==Enum.KeyCode.D or
           input.KeyCode==Enum.KeyCode.Space or input.KeyCode==Enum.KeyCode.LeftShift then
            moveVector = Vector3.new(0,0,0)
        end
    end)

    RunService.Heartbeat:Connect(function()
        if flying and BodyVelocity then
            local camCFrame=workspace.CurrentCamera.CFrame
            local direction=camCFrame:VectorToWorldSpace(moveVector)
            BodyVelocity.Velocity=direction * flySpeed
            BodyGyro.CFrame=CFrame.new(HRP.Position, HRP.Position + camCFrame.LookVector)
        end
    end)

    -- Optimized Noclip
    local noclip=false
    Extras:Toggle({
        Title="Noclip",
        Value=false,
        Callback=function(v)
            noclip=v
            Window:Notify({Title="Noclip",Desc=(v and "Enabled" or "Disabled"),Time=3})
        end
    })

    RunService.Stepped:Connect(function()
        if noclip then
            for _,p in pairs(Character:GetDescendants()) do
                if p:IsA("BasePart") then
                    p.CanCollide=false
                end
            end
        end
    end)

    -- WalkSpeed / JumpPower
    Extras:Slider({Title="WalkSpeed",Min=16,Max=500,Value=16,Callback=function(val)
        Humanoid.WalkSpeed=val
    end})

    Extras:Slider({Title="JumpPower",Min=50,Max=300,Value=50,Callback=function(val)
        Humanoid.JumpPower=val
    end})

    -- Anti-AFK
    Players.LocalPlayer.Idled:Connect(function()
        game:GetService("VirtualUser"):CaptureController()
        game:GetService("VirtualUser"):ClickButton2(Vector2.new(0,0))
    end)
end
-- =========================
-- RONASH v2🔥 PART 3
-- Valex + Ronin + Settings + Glow + Resizable UI + Final Notification
-- =========================

-- ===== VALEx TAB =====
local ValexTab=Window:Tab({Title="Valex",Icon="shield"}) do
    ValexTab:Section({Title="Valex Features"})

    ValexTab:Button({
        Title="Activate Valex Feature",
        Desc="Run special Valex action",
        Callback=function()
            Window:Notify({Title="Valex",Desc="Valex feature activated!",Time=3})
            print("Valex feature executed")
        end
    })
end

-- ===== RONIN TAB =====
local RoninTab=Window:Tab({Title="Ronin",Icon="samurai"}) do
    RoninTab:Section({Title="Ronin Features"})

    RoninTab:Button({
        Title="Activate Ronin Feature",
        Desc="Run special Ronin action",
        Callback=function()
            Window:Notify({Title="Ronin",Desc="Ronin feature activated!",Time=3})
            print("Ronin feature executed")
        end
    })
end

-- ===== SETTINGS TAB =====
local SettingsTab=Window:Tab({Title="Settings",Icon="wrench"}) do
    SettingsTab:Section({Title="UI Settings"})

    -- Glowing buttons example
    local function makeGlow(button)
        local uigrad=Instance.new("UIGradient")
        uigrad.Color=ColorSequence.new({ColorSequenceKeypoint.new(0,Color3.fromRGB(0,255,255)),ColorSequenceKeypoint.new(1,Color3.fromRGB(0,128,255))})
        uigrad.Rotation=45
        uigrad.Parent=button
    end

    SettingsTab:Button({
        Title="Glow Test Button",
        Desc="Example glowing button",
        Callback=function()
            Window:Notify({Title="Glow",Desc="Button glow applied!",Time=3})
        end
    })

    -- Resizable UI example
    SettingsTab:Slider({
        Title="Resize UI Width",
        Min=400,
        Max=800,
        Value=575,
        Callback=function(val)
            Window.Config.Size=UDim2.new(0,val,0,Window.Config.Size.Y.Offset)
            Window:UpdateSize()
        end
    })

    SettingsTab:Slider({
        Title="Resize UI Height",
        Min=300,
        Max=600,
        Value=387,
        Callback=function(val)
            Window.Config.Size=UDim2.new(0,Window.Config.Size.X.Offset,0,val)
            Window:UpdateSize()
        end
    })
end

-- ===== FINAL NOTIFICATION =====
Window:Notify({
    Title="Ronash v2🔥",
    Desc="All features loaded successfully! Enjoy the hub!",
    Time=4
})
