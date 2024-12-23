--open source but don't steal

-- Instances:
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local Frame_2 = Instance.new("Frame")
local TextLabel = Instance.new("TextLabel")
local TextButton = Instance.new("TextButton")
local MadeByLabel = Instance.new("TextLabel")

-- Properties:
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.ResetOnSpawn = false
print("sub to DuplexScripts")

Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)  -- Transparent black background
Frame.BackgroundTransparency = 0.4  -- Adjusted transparency for better visibility
Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
Frame.BorderSizePixel = 0
Frame.Position = UDim2.new(0.388539821, 0, 0.427821517, 0)
Frame.Size = UDim2.new(0, 180, 0, 120)
Frame.AnchorPoint = Vector2.new(0.5, 0.5)
Frame.Rotation = 0
Frame.ClipsDescendants = true
Frame.CornerRadius = UDim.new(0, 15)  -- Rounded corners

-- Header for the GUI
Frame_2.Parent = Frame
Frame_2.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
Frame_2.BackgroundTransparency = 0.3  -- Slight transparency for the header
Frame_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
Frame_2.BorderSizePixel = 0
Frame_2.Size = UDim2.new(1, 0, 0, 25)
Frame_2.CornerRadius = UDim.new(0, 10)

TextLabel.Parent = Frame_2
TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.BackgroundTransparency = 1.000
TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
TextLabel.BorderSizePixel = 0
TextLabel.Position = UDim2.new(0.1, 0, -0.015, 0)
TextLabel.Size = UDim2.new(0, 130, 0, 26)
TextLabel.Font = Enum.Font.SourceSansBold
TextLabel.Text = "Touch Fling"
TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.TextSize = 22

-- Button: Transparent black with text "ON/OFF"
TextButton.Parent = Frame
TextButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)  -- Transparent black button
TextButton.BackgroundTransparency = 0.5  -- Semi-transparent button
TextButton.BorderColor3 = Color3.fromRGB(255, 255, 255)
TextButton.BorderSizePixel = 0
TextButton.Position = UDim2.new(0.1, 0, 0.35, 0)
TextButton.Size = UDim2.new(0, 160, 0, 40)
TextButton.Font = Enum.Font.SourceSansItalic
TextButton.Text = "OFF"
TextButton.TextColor3 = Color3.fromRGB(255, 255, 255)  -- White text for better visibility
TextButton.TextSize = 18
TextButton.TextTransparency = 0  -- Ensure text is visible
TextButton.TextStrokeTransparency = 0.5
TextButton.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)  -- Shadow effect for text readability
TextButton.CornerRadius = UDim.new(0, 10)  -- Rounded corners for the button

-- "Made By Wayne" Label (outside button)
MadeByLabel.Parent = Frame
MadeByLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
MadeByLabel.BackgroundTransparency = 1
MadeByLabel.Position = UDim2.new(0.3, 0, 0.75, 0)
MadeByLabel.Size = UDim2.new(0, 120, 0, 20)
MadeByLabel.Font = Enum.Font.SourceSansBold
MadeByLabel.Text = "Made By Wayne"
MadeByLabel.TextColor3 = Color3.fromRGB(255, 255, 255)  -- White text for better visibility
MadeByLabel.TextSize = 14
MadeByLabel.TextTransparency = 0  -- Ensure text is visible
MadeByLabel.TextStrokeTransparency = 0.5
MadeByLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)  -- Shadow effect for text readability

-- Scripts:
local function IIMAWH_fake_script() -- TextButton.LocalScript 
	local script = Instance.new('LocalScript', TextButton)

	local ReplicatedStorage = game:GetService("ReplicatedStorage")
	local RunService = game:GetService("RunService")
	local Players = game:GetService("Players")
	
	local toggleButton = script.Parent
	local hiddenfling = false
	local flingThread 
	if not ReplicatedStorage:FindFirstChild("juisdfj0i32i0eidsuf0iok") then
		local detection = Instance.new("Decal")
		detection.Name = "juisdfj0i32i0eidsuf0iok"
		detection.Parent = ReplicatedStorage
	end
	
	local function fling()
		local lp = Players.LocalPlayer
		local c, hrp, vel, movel = nil, nil, nil, 0.1
	
		while hiddenfling do
			RunService.Heartbeat:Wait()
			c = lp.Character
			hrp = c and c:FindFirstChild("HumanoidRootPart")
	
			if hrp then
				vel = hrp.Velocity
				hrp.Velocity = vel * 10000 + Vector3.new(0, 10000, 0)
				RunService.RenderStepped:Wait()
				hrp.Velocity = vel
				RunService.Stepped:Wait()
				hrp.Velocity = vel + Vector3.new(0, movel, 0)
				movel = -movel
			end
		end
	end
	
	toggleButton.MouseButton1Click:Connect(function()
		hiddenfling = not hiddenfling
		toggleButton.Text = hiddenfling and "ON" or "OFF"
	
		if hiddenfling then
			flingThread = coroutine.create(fling)
			coroutine.resume(flingThread)
		else
			hiddenfling = false
		end
	end)
	
end
coroutine.wrap(IIMAWH_fake_script)()

-- Draggable Frame Script
local function QCJQJL_fake_script() -- Frame.LocalScript 
	local script = Instance.new('LocalScript', Frame)

	script.Parent.Active = true
	script.Parent.Draggable = true
end
coroutine.wrap(QCJQJL_fake_script)()
