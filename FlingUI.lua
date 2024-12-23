-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

-- Variables
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local rootPart = character:WaitForChild("HumanoidRootPart")

-- Create GUI
local gui = Instance.new("ScreenGui", player.PlayerGui)
gui.Name = "FlingFlyGUI"

-- Create Toggle Button
local button = Instance.new("TextButton", gui)
button.Size = UDim2.new(0, 200, 0, 50)
button.Position = UDim2.new(0.5, -100, 0.8, -50)
button.Text = "Enable Fling & Fly"
button.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
button.Font = Enum.Font.SourceSansBold
button.TextSize = 18

-- States
local flingEnabled = false
local flyEnabled = false
local flying = false

-- Fling Function
local function enableFling()
    local flingForce = Instance.new("BodyAngularVelocity", rootPart)
    flingForce.AngularVelocity = Vector3.new(0, 3000, 0) -- Spin
    flingForce.MaxTorque = Vector3.new(0, math.huge, 0)
    flingForce.P = 10000
    flingForce.Name = "FlingForce"
    flingForce.Parent = rootPart
end

local function disableFling()
    if rootPart:FindFirstChild("FlingForce") then
        rootPart.FlingForce:Destroy()
    end
end

-- Fly Function
local flyVelocity
local flyGyro

local function enableFly()
    flyEnabled = true
    flyVelocity = Instance.new("BodyVelocity", rootPart)
    flyVelocity.MaxForce = Vector3.new(9e9, 9e9, 9e9)
    flyVelocity.Velocity = Vector3.zero

    flyGyro = Instance.new("BodyGyro", rootPart)
    flyGyro.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
    flyGyro.CFrame = rootPart.CFrame

    flying = true

    -- Fly Movement
    RunService.RenderStepped:Connect(function()
        if flying and flyEnabled then
            local moveDirection = Vector3.zero

            if UserInputService:IsKeyDown(Enum.KeyCode.W) then
                moveDirection = moveDirection + workspace.CurrentCamera.CFrame.LookVector
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then
                moveDirection = moveDirection - workspace.CurrentCamera.CFrame.LookVector
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then
                moveDirection = moveDirection - workspace.CurrentCamera.CFrame.RightVector
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then
                moveDirection = moveDirection + workspace.CurrentCamera.CFrame.RightVector
            end

            moveDirection = Vector3.new(moveDirection.X, 0, moveDirection.Z).Unit * 50 -- Speed
            flyVelocity.Velocity = moveDirection + Vector3.new(0, UserInputService:IsKeyDown(Enum.KeyCode.Space) and 50 or 0, 0)
            flyGyro.CFrame = workspace.CurrentCamera.CFrame
        end
    end)
end

local function disableFly()
    flying = false
    flyEnabled = false
    if flyVelocity then flyVelocity:Destroy() end
    if flyGyro then flyGyro:Destroy() end
end

-- Button Logic
button.MouseButton1Click:Connect(function()
    flingEnabled = not flingEnabled
    if flingEnabled then
        button.Text = "Disable Fling & Fly"
        enableFling()
        enableFly()
        warn("Fling & Fly Enabled")
    else
        button.Text = "Enable Fling & Fly"
        disableFling()
        disableFly()
        warn("Fling & Fly Disabled")
    end
end)
