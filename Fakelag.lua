-- Services
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

-- Variables
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local rootPart = character:WaitForChild("HumanoidRootPart")

-- Create GUI
local gui = Instance.new("ScreenGui", player.PlayerGui)
gui.Name = "FakeLagGUI"

-- Create Toggle Button
local button = Instance.new("TextButton", gui)
button.Size = UDim2.new(0, 200, 0, 50)
button.Position = UDim2.new(0.5, -100, 0.8, -50)
button.Text = "Enable Fake Lag"
button.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
button.Font = Enum.Font.SourceSansBold
button.TextSize = 18

-- States
local fakeLagEnabled = false
local lagDelay = 0.5  -- Time delay between "lag" actions
local originalPosition = rootPart.Position

-- Fake Lag Simulation Function
local function simulateFakeLag()
    while fakeLagEnabled do
        local randomOffset = math.random(-5, 5)
        rootPart.CFrame = rootPart.CFrame * CFrame.new(randomOffset, 0, randomOffset)
        wait(lagDelay)
    end
end

-- Toggle Fake Lag
button.MouseButton1Click:Connect(function()
    fakeLagEnabled = not fakeLagEnabled
    if fakeLagEnabled then
        button.Text = "Disable Fake Lag"
        -- Start Simulating Fake Lag
        simulateFakeLag()
        warn("Fake Lag Enabled")
    else
        button.Text = "Enable Fake Lag"
        -- Reset Position
        rootPart.CFrame = CFrame.new(originalPosition)
        warn("Fake Lag Disabled")
    end
end)
