local updateattributes = game.ReplicatedStorage.UpdateAttributes

local DataStore = game:GetService("DataStoreService")
local BuffsTable = DataStore:GetDataStore("BuffsTable")
local Buffs = DataStore:GetDataStore("BuffsTable","Buffs")
local sucess,response

local function CreateBuffsTable()
	type AttributeSets<Attribute,Value> = {
		Attribute : Value | Attribute
	}
	local AttributeTable : AttributeSets<string,number?> = {
		["Luck"] = 1;
		["Attack"] = 1;
		["Health"] = 1;
		["Defense"] = 1;
		["Speed"] = 1;
	}
	return AttributeTable
end

local function UpdateAttributes(Table,str:string,amount:number)

	Table[1][str] *= amount

end

local function IncrementValue(attributetable,statstable)
	if attributetable[1].Health == statstable.Health then return end 
	
	attributetable[1].Luck *= statstable.Luck
	attributetable[1].Defense *= statstable.Defense
	attributetable[1].Health *= statstable.Health
	attributetable[1].Attack *= statstable.Attack
	attributetable[1].Speed *= statstable.Speed
end

local function DecrementValue(attributetable,statstable)
	
	attributetable[1].Luck /= statstable.Luck
	attributetable[1].Defense /= statstable.Defense
	attributetable[1].Health /= statstable.Health
	attributetable[1].Attack /= statstable.Attack
	attributetable[1].Speed /= statstable.Speed
end

local function ApplyStatChanges(player,attributetable)
	
	
	player:SetAttribute("Luck",attributetable[1].Luck)
	player:SetAttribute("Defense",attributetable[1].Defense)
	player:SetAttribute("Health",attributetable[1].Health)
	player:SetAttribute("Attack",attributetable[1].Attack)
	player:SetAttribute("Speed",attributetable[1].Speed)
	
	

	
end

game.Players.PlayerAdded:Connect(function(player)
	local playerid = player.UserId
	local attributetable = {}
	

	
	table.insert(attributetable,CreateBuffsTable())
	
	local sucess,response = pcall(function()
		Buffs:SetAsync(playerid,attributetable)
	end)



	updateattributes.Event:Connect(function(update,statsamount)
		if update == 1 then 
			local sucess,response = pcall(function()
				Buffs:UpdateAsync(playerid,IncrementValue(attributetable,statsamount))
			end)
			
			ApplyStatChanges(player,attributetable)
			
		elseif update == 0 then
			local sucess,response = pcall(function()
				Buffs:UpdateAsync(playerid,DecrementValue(attributetable,statsamount))
			end)
			ApplyStatChanges(player,attributetable)
			
		end
	end)
	

	
	end)
