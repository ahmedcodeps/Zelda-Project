local datastore = game:GetService("DataStoreService"):GetDataStore("Inventory","Items")

game.Players.PlayerAdded:Connect(function(player)
	local InventoryFolder = Instance.new("Folder",player)
	InventoryFolder.Name = "Inventory"
	
	player:SetAttribute("Luck",1)
	player:SetAttribute("Defense",1)
	player:SetAttribute("Health",1)
	player:SetAttribute("Attack",1)
	player:SetAttribute("Speed",1)

	local Inventory = datastore:GetAsync(player.UserId)
	

for i,v in Inventory do 
		local Item = Instance.new("StringValue",InventoryFolder)
		Item.Name = i
		Item.Value = ""
	end

	
end)
