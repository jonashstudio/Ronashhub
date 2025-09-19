-- =========================
-- RONASH v2🔥 PART 1
-- Loader + Main UI + Fly Tab
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
logo.Image="rbxassetid://96680008830476"
logo.BackgroundTransparency=1
logo.Parent=bg

-- Progress Text
local progText = Instance.new("TextLabel")
progText.Size = UDim2.new(0, 300, 0, 20)
progText.Position = UDim2.new(0.5,-150,1,-80)
progText.BackgroundTransparency = 1
progText.Font = Enum.Font.SourceSans
progText.TextSize = 18
progText.TextColor3 = Color3.fromRGB(0,255,255)
progText.Text = "Loading..."
progText.Parent = bg

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
    progText.Text = "Loading... "..math.floor(percent*100).."%"
    TweenService:Create(barFill,TweenInfo.new(totalTime/steps,Enum.EasingStyle.Linear),{Size=UDim2.new(percent,0,1,0)}):Play()
    task.wait(totalTime/steps)
end

task.wait(0.5)
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

-- ===== FLY TAB =====
local FlyTab = Window:Tab({Title = "Fly", Icon = "star"}) do
    FlyTab:Section({Title = "Player Flight Controls"})

    local flying=false
    local flySpeed=50
    local moveVector=Vector3.new(0,0,0)
    local RunService=game:GetService("RunService")
    local UIS=game:GetService("UserInputService")
    local LocalPlayer=game.Players.LocalPlayer
    local HRP=LocalPlayer.Character:WaitForChild("HumanoidRootPart")
    local Humanoid=LocalPlayer.Character:WaitForChild("Humanoid")
    local BodyGyro,BodyVelocity

    FlyTab:Toggle({
        Title="Enable Fly",
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

    FlyTab:Slider({
        Title="Fly Speed",
        Min=10,
        Max=300,
        Value=50,
        Callback=function(val)
            flySpeed=val
        end
    })

    -- Fly movement
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
end
-- =========================
-- RONASH v2🔥 PART 2
-- Teleports + Extras Tab
-- =========================

-- ===== TELEPORT TAB =====
local TeleportTab = Window:Tab({Title="Teleports", Icon="map"}) do
    TeleportTab:Section({Title="Teleport to Places"})

    -- Example Teleports
    TeleportTab:Button({
        Title="Spawn",
        Callback=function()
            local plr = game.Players.LocalPlayer
            if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                plr.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(0,5,0))
            end
            Window:Notify({Title="Teleport", Desc="Teleported to Spawn", Time=2})
        end
    })

    TeleportTab:Button({
        Title="Shop",
        Callback=function()
            local plr = game.Players.LocalPlayer
            if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                plr.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(100,5,0))
            end
            Window:Notify({Title="Teleport", Desc="Teleported to Shop", Time=2})
        end
    })
end

-- ===== EXTRAS TAB =====
local ExtrasTab = Window:Tab({Title="Extras", Icon="gear"}) do
    ExtrasTab:Section({Title="Player Utilities"})

    -- WalkSpeed
    local walkSpeed = 16
    ExtrasTab:Slider({
        Title="WalkSpeed",
        Min=16,
        Max=500,
        Value=16,
        Callback=function(val)
            walkSpeed = val
            local plr = game.Players.LocalPlayer
            if plr.Character and plr.Character:FindFirstChildOfClass("Humanoid") then
                plr.Character:FindFirstChildOfClass("Humanoid").WalkSpeed = walkSpeed
            end
        end
    })

    -- JumpPower
    local jumpPower = 50
    ExtrasTab:Slider({
        Title="JumpPower",
        Min=50,
        Max=500,
        Value=50,
        Callback=function(val)
            jumpPower = val
            local plr = game.Players.LocalPlayer
            if plr.Character and plr.Character:FindFirstChildOfClass("Humanoid") then
                plr.Character:FindFirstChildOfClass("Humanoid").JumpPower = jumpPower
            end
        end
    })

    -- Noclip Toggle
    local noclip=false
    ExtrasTab:Toggle({
        Title="Noclip",
        Value=false,
        Callback=function(v)
            noclip=v
            local plr = game.Players.LocalPlayer
            if v then
                Window:Notify({Title="Noclip", Desc="Enabled", Time=2})
            else
                Window:Notify({Title="Noclip", Desc="Disabled", Time=2})
            end
        end
    })

    -- Anti AFK
    ExtrasTab:Toggle({
        Title="Anti AFK",
        Value=true,
        Callback=function(v)
            local plr = game.Players.LocalPlayer
            if v then
                for i,connection in pairs(getconnections or {}) do
                    if connection.Name=="Idled" then
                        connection:Disable()
                    end
                end
                Window:Notify({Title="AntiAFK", Desc="Enabled", Time=2})
            else
                Window:Notify({Title="AntiAFK", Desc="Disabled", Time=2})
            end
        end
    })
end
-- =========================
-- RONASH v2🔥 PART 3
-- Valex + Ronin + Settings + Discord
-- =========================

-- ===== VALEx TAB =====
local ValexTab = Window:Tab({Title="Valex", Icon="star"}) do
    ValexTab:Section({Title="Valex Features"})

    -- Example Feature: Auto Farm
    ValexTab:Toggle({
        Title="Auto Farm",
        Value=false,
        Callback=function(v)
            if v then
                Window:Notify({Title="Valex", Desc="Auto Farm Enabled", Time=2})
                -- Insert Auto Farm logic here
            else
                Window:Notify({Title="Valex", Desc="Auto Farm Disabled", Time=2})
            end
        end
    })

    -- Example Feature: Auto Collect
    ValexTab:Toggle({
        Title="Auto Collect",
        Value=false,
        Callback=function(v)
            if v then
                Window:Notify({Title="Valex", Desc="Auto Collect Enabled", Time=2})
                -- Insert Auto Collect logic here
            else
                Window:Notify({Title="Valex", Desc="Auto Collect Disabled", Time=2})
            end
        end
    })
end

-- ===== RONIN TAB =====
local RoninTab = Window:Tab({Title="Ronin", Icon="sword"}) do
    RoninTab:Section({Title="Ronin Features"})

    -- Example Feature: Kill Aura
    RoninTab:Toggle({
        Title="Kill Aura",
        Value=false,
        Callback=function(v)
            if v then
                Window:Notify({Title="Ronin", Desc="Kill Aura Enabled", Time=2})
                -- Insert Kill Aura logic here
            else
                Window:Notify({Title="Ronin", Desc="Kill Aura Disabled", Time=2})
            end
        end
    })

    -- Example Feature: Auto Stab
    RoninTab:Toggle({
        Title="Auto Stab",
        Value=false,
        Callback=function(v)
            if v then
                Window:Notify({Title="Ronin", Desc="Auto Stab Enabled", Time=2})
                -- Insert Auto Stab logic here
            else
                Window:Notify({Title="Ronin", Desc="Auto Stab Disabled", Time=2})
            end
        end
    })
end

-- ===== SETTINGS TAB =====
local SettingsTab = Window:Tab({Title="Settings", Icon="cog"}) do
    SettingsTab:Section({Title="UI Settings"})

    -- Toggle UI Visibility
    SettingsTab:Toggle({
        Title="Show/Hide UI",
        Value=true,
        Callback=function(v)
            Window:SetVisible(v)
        end
    })

    -- UI Theme
    SettingsTab:Dropdown({
        Title="UI Theme",
        Options={"Dark","Light","Neon","Classic"},
        Callback=function(theme)
            Window:SetTheme(theme)
        end
    })
end

-- ===== DISCORD TAB =====
local DiscordTab = Window:Tab({Title="Discord", Icon="discord"}) do
    DiscordTab:Section({Title="Join Our Discord"})

    DiscordTab:Button({
        Title="Join Now",
        Callback=function()
            setclipboard("https://discord.gg/pvywPyskHT")
            Window:Notify({Title="Discord", Desc="Link Copied to Clipboard!", Time=3})
        end
    })
end
