--[[ 
Anti-Fling Toggle Script  
Created by Wayne  
Description: Adds a button to toggle the Anti-Fling feature on or off.  
]]  

-- Services  
local Players = game:GetService("Players")  
local player = Players.LocalPlayer  

-- Variables  
local button = script.Parent  
local antiFlingEnabled = false -- Default state of Anti-Fling  

-- Configuration  
local MAX_VELOCITY = 100 -- Set maximum allowable velocity  

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
button.Text = "Enable Anti-Fling"  
button.MouseButton1Click:Connect(function()  
    antiFlingEnabled = not antiFlingEnabled  
    if antiFlingEnabled then  
        button.Text = "Disable Anti-Fling"  
        toggleAntiFling(true)  
    else  
        button.Text = "Enable Anti-Fling"  
        toggleAntiFling(false)  
    end  
end)
