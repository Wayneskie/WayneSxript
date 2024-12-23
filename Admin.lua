-- Services
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")

-- Variables
local flying = false
local antiFlingEnabled = false
local MAX_VELOCITY = 100 -- Max velocity for anti-fling
local version = "0.1"

-- Functions for flying
local function enableFly()
    if not flying then
        flying = true
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
        local bodyVelocity = Instance.new("BodyVelocity")
        bodyVelocity.MaxForce = Vector3.new(100000, 100000, 100000)
        bodyVelocity.Velocity = Vector3.new(0, 0, 0)
        bodyVelocity.Parent = humanoidRootPart
        warn("Fly enabled!")
    end
end

local function disableFly()
    if flying then
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
        local bodyVelocity = humanoidRootPart:FindFirstChild("BodyVelocity")
        if bodyVelocity then
            bodyVelocity:Destroy()
        end
        flying = false
        warn("Fly disabled!")
    end
end

-- Anti-fling function
local function toggleAntiFling(state)
    antiFlingEnabled = state
    if state then
        warn("Anti-Fling enabled!")
        local character = player.Character or player.CharacterAdded:Wait()
        local rootPart = character:WaitForChild("HumanoidRootPart", 10)
        if not rootPart then return end

        while antiFlingEnabled do
            local velocity = rootPart.Velocity
            if velocity.Magnitude > MAX_VELOCITY then
                rootPart.Velocity = Vector3.zero
                rootPart.AssemblyLinearVelocity = Vector3.zero
                warn("Anti-Fling triggered! Velocity reset.")
            end
            wait(0.1)
        end
    else
        warn("Anti-Fling disabled!")
    end
end

-- Command handler
local function onChat(message)
    local lowerMessage = message:lower()
    
    if lowerMessage == ".fly" then
        enableFly()
    elseif lowerMessage == ".unfly" then
        disableFly()
    elseif lowerMessage == ".antifling" then
        toggleAntiFling(true)
    elseif lowerMessage == ".cmds" then
        game:GetService("Players").LocalPlayer:SendNotification({
            Title = "Commands",
            Text = ".fly - Enable flying\n.unfly - Disable flying\n.antifling - Enable anti-fling\nVersion: " .. version .. "\nCreated by: Wayne"
        })
    end
end

-- Listen for chat messages
game:GetService("Players").LocalPlayer.Chatted:Connect(onChat)

-- Add credits and version info in chat when the script runs
warn("Script Loaded! Version: " .. version .. " | Created by: Wayne")
