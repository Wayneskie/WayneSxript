-- Services
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Variables
local antiFlingEnabled = false
local MAX_VELOCITY = 100 -- Max allowable velocity before anti-fling is triggered

-- UI Setup
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = playerGui
ScreenGui.Name = "AntiFlingUI"

-- UI Styling: Transparent Black Background
ScreenGui.BackgroundTransparency = 0.5
ScreenGui.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
ScreenGui.BorderSizePixel = 0

-- Button Setup
local button = Instance.new("TextButton")
button.Size = UDim2.new(0, 200, 0, 60)
button.Position = UDim2.new(0.5, -100, 0.5, -30)
button.Text = "Enable Anti-Fling"
button.TextColor3 = Color3.fromRGB(255, 255, 255)
button.BackgroundColor3 = Color3.fromRGB(0, 0, 0) -- Transparent black button
button.Font = Enum.Font.GothamBold
button.TextSize = 24
button.Parent = ScreenGui
button.AutoButtonColor = false -- Disable automatic button color change on hover

-- Button Transparency and Border
button.BackgroundTransparency = 0.5 -- Make the button transparent
button.BorderSizePixel = 2
button.BorderColor3 = Color3.fromRGB(255, 255, 255) -- White border for contrast
button.AnchorPoint = Vector2.new(0.5, 0.5)
button.Position = UDim2.new(0.5, 0, 0.5, 0)

-- Add Rounded Corners to the Button
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12) -- Round the corners
corner.Parent = button

-- Gradient Background for Button
local gradient = Instance.new("UIGradient")
gradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(50, 50, 50)),
}
gradient.Rotation = 45
gradient.Parent = button

-- UI Dragging Logic
local dragging, dragInput, dragStart, startPos
local function updateInput(input)
    local delta = input.Position - dragStart
    ScreenGui.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

button.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = ScreenGui.Position
        input.Changed:Connect(function()
            if not input.UserInputState == Enum.UserInputState.Change then return end
            updateInput(input)
        end)
    end
end)

button.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

-- Anti-Fling Function
local function toggleAntiFling(state)
    antiFlingEnabled = state
    if state then
        local character = player.Character or player.CharacterAdded:Wait()
        local rootPart = character:WaitForChild("HumanoidRootPart", 10)
        if not rootPart then return end

        warn("Anti-Fling Enabled")
        while antiFlingEnabled do
            local velocity = rootPart.Velocity
            if velocity.Magnitude > MAX_VELOCITY then
                rootPart.Velocity = Vector3.zero -- Reset velocity
                rootPart.AssemblyLinearVelocity = Vector3.zero -- Reset physics
                warn("Anti-Fling triggered! Velocity reset.")
            end
            wait(0.1) -- Check every 0.1 seconds
        end
    else
        warn("Anti-Fling Disabled")
    end
end

-- Button Logic
button.MouseButton1Click:Connect(function()
    antiFlingEnabled = not antiFlingEnabled
    if antiFlingEnabled then
        button.Text = "Disable Anti-Fling"
        button.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
        button.BorderColor3 = Color3.fromRGB(150, 0, 0)
        toggleAntiFling(true)
    else
        button.Text = "Enable Anti-Fling"
        button.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        button.BorderColor3 = Color3.fromRGB(255, 255, 255)
        toggleAntiFling(false)
    end
end)
