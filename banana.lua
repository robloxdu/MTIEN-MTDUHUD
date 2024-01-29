-- Script name: nguyenphidu2012
-- Author:du
-- Logo: 🍌

local plr, char, mouse, rs, ts, ws, npcs, remotes, fruits, gui = game.Players.LocalPlayer, game.Players.LocalPlayer.Character or game.Players.LocalPlayer.CharacterAdded:Wait(), game.Players.LocalPlayer:GetMouse(), game:GetService("RunService"), game:GetService("TweenService"), game:GetService("Workspace"), game:GetService("Workspace").NPCs, game.ReplicatedStorage.Remotes, game.ReplicatedStorage.Fruits, game.CoreGui -- Define variables
local library, window, folder, toggle, drop, slider, button, label = loadstring(game:HttpGet("https://pastebin.com/raw/edJT9EGX"))(), library:CreateWindow("Blox Fruit Hack"), window:AddFolder("Main"), folder:AddToggle({text = "Auto Farm", flag = "autoFarm"}), folder:AddDropdown({text = "Select NPC", flag = "selectNPC", list = {"Bandit", "Pirate", "Marine", "World Seeker", "Desert Bandit", "Snowman"}}), folder:AddSlider({text = "Distance", flag = "distance", min = 10, max = 100, value = 50}), folder:AddButton({text = "Teleport to Fruit", callback = function() teleportToFruit() end}), folder:AddLabel({text = "Made by Bing"}) -- Define UI elements

local function teleportTo(pos) -- Function for teleporting to position
    local tween = ts:Create(char.HumanoidRootPart, TweenInfo.new((char.HumanoidRootPart.Position - pos).Magnitude / 100, Enum.EasingStyle.Linear), {CFrame = CFrame.new(pos)}) -- Create tween
    tween:Play() -- Play tween
end

local function teleportToFruit() -- Function for teleporting to fruit
    local closest, target = math.huge, nil -- Define variables
    for i, v in pairs(fruits:GetChildren()) do -- Loop through all fruits
        if v:IsA("Tool") and v.Handle then -- If it is a tool and has a handle
            local dist = (v.Handle.Position - char.HumanoidRootPart.Position).Magnitude -- Calculate distance
            if dist < closest then -- If distance is less than closest distance
                closest, target = dist, v -- Update variables
            end
        end
    end
    if target then -- If there is a target
        teleportTo(target.Handle.Position) -- Teleport to target
    end
end

local function attackNPC() -- Function for attacking NPC
    local closest, target = math.huge, nil -- Define variables
    for i, v in pairs(npcs:GetChildren()) do -- Loop through all NPCs
        if v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 and v.Name == library.flags.selectNPC then -- If it has a Humanoid, health is greater than 0 and name matches the selection
            local dist = (v.HumanoidRootPart.Position - char.HumanoidRootPart.Position).Magnitude -- Calculate distance
            if dist < closest and dist < library.flags.distance then -- If distance is less than closest distance and less than adjusted distance
                closest, target = dist, v -- Update variables
            end
        end
    end
    if target then -- If there is a target
        mouse.Target, remotes["Click"]:FireServer() = target.HumanoidRootPart, nil -- Set mouse cursor to target and call Click remote function
    end
end

local function bypassKey() -- Function for bypassing key
    local mt, oldNamecall = getrawmetatable(game), getrawmetatable(game).__namecall -- Define variables
    