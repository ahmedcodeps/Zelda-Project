-- code to test the stat changes


-- damage reduction test (INSIDE A PART)
local part = script.Parent

local players = game:GetService("Players")

local db = false

part.Touched:Connect(function(hitpart)
	local humanoid = hitpart.Parent:FindFirstChild("Humanoid")
	local player = players:GetPlayerFromCharacter(hitpart.Parent)
	
	if humanoid and player and db == false then
		local previoushealth = humanoid.Health

		db = true
		humanoid:TakeDamage(5 / player:GetAttribute("Defense")) 
		local damagetaken = humanoid.Health - previoushealth
		part.BillboardGui.Frame.TextLabel.Text = damagetaken
		task.wait(1)
		part.BillboardGui.Frame.TextLabel.Text = ""
		db = false
	end
end)

-- damage dealing test (INSIDE A RIG)
local humanoid = script.Parent.Humanoid
local char = script.Parent
local currenthealth = humanoid.Health

humanoid.HealthChanged:Connect(function(health)
	local damage = currenthealth - health
	char.Head.BillboardGui.Frame.Damage.Text = ""..damage
	currenthealth = health
	task.wait(0.5)
	char.Head.BillboardGui.Frame.Damage.Text = ""
end)

-- This Includes two Billboard GUI's in order to showcase the effects, containing a frame and a damage text label inside.
