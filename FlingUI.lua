-- Anti-Fling Script with GUI Toggle
-- Created by Wayne

-- Load Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

-- Get Local Player
local player = Players.LocalPlayer
local gui = Instance.new("ScreenGui", player.PlayerGui)
gui.Name = "FlingToggleGUI"

-- Create Button
local button = Instance.new("TextButton", gui)
button.Size = UDim2.new(0, 200, 0, 50)
button.Position = UDim2.new(0.5, -100, 0.9, -50)
button.Text = "Enable Fling"
button.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
button.Font = Enum.Font.SourceSansBold
button.TextSize = 18

-- Fling Toggle Variables
local flingEnabled = false
local MAX_FLING_FORCE = 3000

-- Fling Function
local function enableFling()
    local character = player.Character or player.CharacterAdded:Wait()
    local rootPart = character:WaitForChild("HumanoidRootPart")

    -- Add BodyAngularVelocity for fling
    local flingForce = Instance.new("BodyAngularVelocity", rootPart)
    flingForce.AngularVelocity = Vector3.new(0, MAX_FLING_FORCE, 0) -- Spin
    flingForce.MaxTorque = Vector3.new(0, math.huge, 0)
    flingForce.P = 10000

    -- Store fling for toggling off later
    rootPart:SetAttribute("FlingForce", flingForce)
end

local function disableFling()
    local character = player.Character
    if not character then return end
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    if rootPart then
        local flingForce = rootPart:GetAttribute("FlingForce")
        if flingForce and flingForce:IsA("BodyAngularVelocity") then
            flingForce:Destroy()
        end
    end
end

-- Button Logic
button.MouseButton1Click:Connect(function()
    flingEnabled = not flingEnabled
    if flingEnabled then
        button.Text = "Disable Fling"
        enableFling()
        warn("Fling Enabled")
    else
        button.Text = "Enable Fling"
        disableFling()
        warn("Fling Disabled")
    end
end)
