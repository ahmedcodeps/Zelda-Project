-- in starter character scripts
local uis = game:GetService("UserInputService")

local player = game.Players.LocalPlayer

local additem = game.ReplicatedStorage.AddItem

local itemRetrieved = nil

local function insideInventory(itemname)
	return player:FindFirstChild("Inventory"):FindFirstChild(itemname)
end

uis.InputBegan:Connect(function(input,processed)
	if processed then return end 
	
	if input.KeyCode == Enum.KeyCode.One then
		if insideInventory("Item1") then return end 
		itemRetrieved = additem:InvokeServer(1)
	end
	
	if input.KeyCode == Enum.KeyCode.Two then 
		if insideInventory("Item2") then return end 
		itemRetrieved = additem:InvokeServer(2)
	end
	
end)
