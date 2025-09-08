-- Ronash Hub ✧ v1.0.0.8
local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

-- 🌌 Blue Theme
WindUI:AddTheme({
    Name = "Ronash_Blue",
    Accent = "#1E90FF", -- DodgerBlue
    Outline = "#FFFFFF",
    Text = "#FFFFFF",
    Placeholder = "#87CEFA", -- LightSkyBlue
    Background = "#0A0A1A", -- Deep navy blue
    Button = "#4169E1", -- RoyalBlue
    Icon = "#1E90FF",
})
WindUI:SetTheme("Ronash_Blue")

-- 📦 Create Window
local Window = WindUI:CreateWindow({
    Title = "Ronash Hub ✧",
    Icon = "sparkles",
    Author = "Jonash",
    Folder = "RonashHub",
    Size = UDim2.fromOffset(580, 460), -- stable for mobile + pc
    Transparent = false,
    Theme = "Ronash_Blue",
    SideBarWidth = 200,
})

-- 📑 Tabs
local StatusTab = Window:Tab({ Title = "Status", Icon = "home" })
local MainTab   = Window:Tab({ Title = "Main", Icon = "settings" })
local PlayerTab = Window:Tab({ Title = "Player", Icon = "user" })
local ExtrasTab = Window:Tab({ Title = "Extras", Icon = "star" })
local AdminTab  = Window:Tab({ Title = "Admin", Icon = "hammer" })

-- 🟢 STATUS TAB
StatusTab:Paragraph({
    Title = "Ronash Hub v1.0.0.8",
    Desc = "✅ Loaded successfully\n🎨 Blue Theme applied\n👥 ESP Enabled\n⚡ Stable Build",
    Color = "Blue",
})

-- ⚡ MAIN TAB (Walk, Jump, Inf Jump)
local walkEnabled, jumpEnabled, infJump = false, false, false
local walkSpeed, jumpPower = 16, 50
local humanoid = nil

local function updateHumanoid()
    local char = game.Players.LocalPlayer.Character
    if char then humanoid = char:FindFirstChildOfClass("Humanoid") end
end
game.Players.LocalPlayer.CharacterAdded:Connect(updateHumanoid)
updateHumanoid()

-- WalkSpeed
MainTab:Toggle({
    Title = "WalkSpeed",
    Desc = "Toggle custom speed",
    Callback = function(v)
        walkEnabled = v
        if humanoid then humanoid.WalkSpeed = v and walkSpeed or 16 end
    end
})
MainTab:Slider({
    Title = "Speed Value",
    Value = { Min = 16, Max = 200, Default = 16 },
    Callback = function(v)
        walkSpeed = v
        if walkEnabled and humanoid then humanoid.WalkSpeed = v end
    end
})

-- JumpPower
MainTab:Toggle({
    Title = "JumpPower",
    Desc = "Toggle custom jump",
    Callback = function(v)
        jumpEnabled = v
        if humanoid then humanoid.JumpPower = v and jumpPower or 50 end
    end
})
MainTab:Slider({
    Title = "Jump Value",
    Value = { Min = 50, Max = 300, Default = 50 },
    Callback = function(v)
        jumpPower = v
        if jumpEnabled and humanoid then humanoid.JumpPower = v end
    end
})

-- Infinite Jump
MainTab:Toggle({
    Title = "Infinite Jump",
    Desc = "Toggle unlimited jumping",
    Callback = function(v) infJump = v end
})
game:GetService("UserInputService").JumpRequest:Connect(function()
    if infJump and humanoid then humanoid:ChangeState("Jumping") end
end)

-- 👤 PLAYER TAB
PlayerTab:Button({
    Title = "Freeze (self)",
    Callback = function()
        local hrp = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if hrp then hrp.Anchored = true end
    end
})
PlayerTab:Button({
    Title = "Unfreeze (self)",
    Callback = function()
        local hrp = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if hrp then hrp.Anchored = false end
    end
})

-- NoClip
local noclip = false
PlayerTab:Toggle({
    Title = "NoClip",
    Callback = function(v) noclip = v end
})
game:GetService("RunService").Stepped:Connect(function()
    if noclip and humanoid and humanoid.Parent then
        for _, part in ipairs(humanoid.Parent:GetDescendants()) do
            if part:IsA("BasePart") and part.CanCollide then part.CanCollide = false end
        end
    end
end)

-- Anti-Fling / Unfling
PlayerTab:Toggle({
    Title = "Unfling (Anti-Fling)",
    Callback = function(v)
        local lp = game.Players.LocalPlayer
        local char = lp.Character
        if not char then return end
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if not hrp then return end

        if v then
            hrp.CustomPhysicalProperties = PhysicalProperties.new(0, 0, 0)
        else
            hrp.CustomPhysicalProperties = PhysicalProperties.new(1, 0.3, 0.5)
        end
    end
})

-- 👁 ESP TAB (inside Player for stability)
PlayerTab:Toggle({
    Title = "ESP (Players)",
    Callback = function(v)
        for _, p in ipairs(game.Players:GetPlayers()) do
            if p ~= game.Players.LocalPlayer then
                local char = p.Character
                if char then
                    local highlight = char:FindFirstChildOfClass("Highlight")
                    if v then
                        if not highlight then
                            local h = Instance.new("Highlight", char)
                            h.FillColor = Color3.fromRGB(0, 162, 255)
                            h.OutlineColor = Color3.fromRGB(255, 255, 255)
                            h.FillTransparency = 0.5
                        end
                    else
                        if highlight then highlight:Destroy() end
                    end
                end
            end
        end
    end
})

-- ⭐ EXTRAS TAB
local ff = nil
ExtrasTab:Toggle({
    Title = "ForceField",
    Callback = function(v)
        local char = game.Players.LocalPlayer.Character
        if v then
            if char and not ff then ff = Instance.new("ForceField", char) end
        else
            if ff then ff:Destroy() ff = nil end
        end
    end
})
ExtrasTab:Button({
    Title = "Credits",
    Callback = function()
        WindUI:Notify({ Title = "Ronash Hub ✧", Content = "Made by Jonash" })
    end
})

-- 🔨 ADMIN TAB
AdminTab:Button({
    Title = "Joke Ban",
    Callback = function()
        WindUI:Popup({
            Title = "⚠️ Ban Alert",
            Content = "You are banned! (just kidding 😆)",
            Buttons = { { Title = "OK", Callback = function() end } }
        })
    end
})
AdminTab:Button({
    Title = "Hammer",
    Callback = function()
        WindUI:Notify({ Title = "Bonk! 🔨", Content = "You used the admin hammer." })
    end
})

-- 🔁 Reapply toggles after respawn
game.Players.LocalPlayer.CharacterAdded:Connect(function()
    task.wait(1)
    updateHumanoid()
    if humanoid then
        if walkEnabled then humanoid.WalkSpeed = walkSpeed end
        if jumpEnabled then humanoid.JumpPower = jumpPower end
    end
end)

