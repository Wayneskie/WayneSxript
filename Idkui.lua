-- Services
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Create UI
local screenGui = Instance.new("ScreenGui", playerGui)
screenGui.Name = "HackedUI"

-- Change the background to black
local background = Instance.new("Frame", screenGui)
background.Size = UDim2.new(1, 0, 1, 0)  -- Fill the whole screen
background.Position = UDim2.new(0, 0, 0, 0)
background.BackgroundColor3 = Color3.fromRGB(0, 0, 0)  -- Black background

-- Create a message label
local messageLabel = Instance.new("TextLabel", background)
messageLabel.Size = UDim2.new(0, 600, 0, 100)  -- Size of the message box
messageLabel.Position = UDim2.new(0.5, -300, 0.5, -50)  -- Center the message on screen
messageLabel.Text = "HACKED BY COOLKHIDO!!!"  -- Message text
messageLabel.TextColor3 = Color3.fromRGB(255, 0, 0)  -- Red text for impact
messageLabel.TextSize = 40
messageLabel.TextStrokeTransparency = 0.8  -- Add stroke for better visibility
messageLabel.TextStrokeColor3 = Color3.fromRGB(255, 255, 255)  -- White stroke
messageLabel.Font = Enum.Font.SourceSansBold
messageLabel.BackgroundTransparency = 1  -- No background behind text
messageLabel.TextScaled = true  -- Auto scale text to fit

-- Optional: Add a sound effect
local sound = Instance.new("Sound", player.Character)
sound.SoundId = "rbxassetid://241503331"  -- Sound ID for dramatic effect (you can change this)
sound:Play()

-- Optional: Add visual effects like flickering
local function flickerEffect()
    for i = 1, 10 do
        background.BackgroundColor3 = Color3.fromRGB(math.random(0, 255), math.random(0, 255), math.random(0, 255))
        wait(0.1)
    end
    background.BackgroundColor3 = Color3.fromRGB(0, 0, 0)  -- Reset to black
end

flickerEffect()

-- Optional: Add a timer to remove the message
wait(10)  -- Wait 10 seconds before removing the UI
screenGui:Destroy()  -- Remove the UI
