-- inside ScreenGUI object
local datastore = game:GetService("DataStoreService"):GetDataStore("Inventory","Items")

local TweenS = game:GetService("TweenService")

local updateattributes = game.ReplicatedStorage.UpdateAttributes


local additem = game.ReplicatedStorage.AddItem

local gui = script.Parent
local mainframe = gui.InventoryFrame
local mainbutton = gui.InventoryButton

local player = script.Parent.Parent.Parent

local NFrame = gui.NFrame

local Items = {
	
}

local clone

local StatTables = {
	
	Item1 = {
		["Luck"] = 1,
		["Attack"] = 1.3,
		["Defense"] = 1.5,
		["Health"] = 1.2,
		["Speed"] = 1.5,
	},
	
	Item2 = {
		["Luck"] = 2,
		["Attack"] = 1,
		["Defense"] = 1.2,
		["Health"] = 1.1,
		["Speed"] = 1,
		
		
	}

}


local IsInside : boolean? 

local function CheckInventory()
	for i,v in player:FindFirstChild("Inventory"):GetChildren() do 
		if Items[v.Name] then continue end 
		
		if v then 
			IsInside = true 
			Items[v.Name] = ""
		else
			return
		end
		
	end
end

local function Notify(name)
	local noti = NFrame:FindFirstChild("Notification")
	local pingsound = noti:FindFirstChild("Ping"):Clone()
	
	
	NFrame.Visible = true
	
	pingsound.Parent = workspace
	pingsound:Play()
	
	noti.Text = "<Item Received!> "..name
	
	local Tweentrack = TweenS:Create(noti,TweenInfo.new(1.5),{TextTransparency = 1})
	Tweentrack:Play()
	Tweentrack.Completed:Connect(function()
		noti.Text = ""
		noti.TextTransparency = 0
		pingsound:Destroy()
		NFrame.Visible = false
	end)
end

local function UpdateValue(v)
	Items[v.Name] = v.Value
end



for i,v in player:FindFirstChild("Inventory"):GetChildren() do 
	if v then 
		IsInside = true 
		Items[v.Name] = ""
	else
		return
	end
end

mainbutton.MouseButton1Click:Connect(function() 
	if mainframe.Visible == true then 
		player.Character:WaitForChild("Humanoid").WalkSpeed = 0
	elseif mainframe.Visible == false then 
        player.Character:WaitForChild("Humanoid").WalkSpeed = 16 * player:GetAttribute("Speed")
	end
end)


mainbutton.MouseButton1Click:Connect(function()
	mainframe.Visible = not mainframe.Visible
	
	CheckInventory()
	for i,v in player:FindFirstChild("Inventory"):GetChildren() do 
		if Items[v.Name] then 
			
			local ItemImage = mainframe:FindFirstChild(v.Name)
			ItemImage.Visible = true
			
			ItemImage.MouseButton1Click:Connect(function()
				local itemdesc = mainframe:FindFirstChild(v.Name.." ")
				itemdesc.Visible = not itemdesc.Visible
				
				local itemequip = ItemImage:FindFirstChildWhichIsA("TextButton")
				itemequip.Visible = not itemequip.Visible 
				
				
				itemequip.MouseButton1Click:Connect(function()
					
					if itemequip.Text == "EQUIP" then 
						itemequip.Text = "Equipped"
						v.Value = "Equipped"
						
						
						updateattributes:Fire(1 ,StatTables[v.Name])
						
						
						
				
					elseif itemequip.Text == "Equipped" then 
						itemequip.Text = "EQUIP"
						v.Value = ""
						
						
						updateattributes:Fire(0 ,StatTables[v.Name])
						
					end
				
				local textlabel = ItemImage:FindFirstChildWhichIsA("TextLabel")
				if textlabel then 
					textlabel.Visible = not textlabel.Visible
				end
				end) 
			end)
			
		local sucess,response = pcall(function()
			datastore:SetAsync(player.UserId,Items)
		end)


			local sucess,response = pcall(function()
				datastore:UpdateAsync(player.UserId,UpdateValue(v))
			end)

		end
		end
	end)


additem.OnServerInvoke = function(player, num)
	if num == 1 then 
	
	local item1 = Instance.new("StringValue", player:FindFirstChild("Inventory"))
	item1.Name = "Item1"
	item1.Value = ""
		
	Notify("Eye of A")
	
	CheckInventory()
	return "Eye of A"
end
	
	if num == 2 then 
		
		Notify("Lucky Hat")
		
		local item2 = Instance.new("StringValue",player:FindFirstChild("Inventory"))
		item2.Name = "Item2"
		item2.Value = ""
		
		CheckInventory()
		return "Lucky Hat"
	end
	
	
	
end
