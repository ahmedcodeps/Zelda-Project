-- starter character scripts
local uis = game:GetService("UserInputService")
local player = game.Players.LocalPlayer

uis.InputBegan:Connect(function(input,processed)
	if processed then return end 
	
	if input.KeyCode == Enum.KeyCode.E then 
		script.Script.RemoteFunction:InvokeServer(player)
	end
end)

-- child script with remote function inside 
local remote = script.RemoteFunction
local db = false

local function setHitbox(hitbox, player) 
	hitbox.Parent = workspace.FX
	hitbox.Size = Vector3.new(5,5,5)
	hitbox.CanCollide = false 
	hitbox.Anchored = true 
	hitbox.CFrame = player.Character.HumanoidRootPart.CFrame * CFrame.new(0,0,-5)
	hitbox.Transparency = 0.5
	hitbox.Color = Color3.new(1,0,0)
	hitbox.Material = Enum.Material.SmoothPlastic
	game.Debris:AddItem(hitbox,0.5)
end

remote.OnServerInvoke = function(player)
	local hitbox = Instance.new("Part")
	setHitbox(hitbox, player)
	
	hitbox.Touched:Connect(function(hitpart)
		local hitChar = hitpart.Parent
		local humanoid = hitChar:FindFirstChild("Humanoid")
		if humanoid and hitChar ~= player.Character and db == false then 
			db = true
			humanoid:TakeDamage(5 * player:GetAttribute("Attack")) 
			task.wait(0.7)
			db = false
		end
	end)
	
end
