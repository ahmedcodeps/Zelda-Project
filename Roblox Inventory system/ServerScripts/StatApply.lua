game.Players.PlayerAdded:Connect(function(plr)
	plr.CharacterAdded:Connect(function(char)
		local humanoid = char:WaitForChild("Humanoid")
		
		plr:GetAttributeChangedSignal("Health"):Connect(function()
			humanoid.MaxHealth = plr:GetAttribute("Health") * 100
		end)
		
		plr:GetAttributeChangedSignal("Speed"):Connect(function()
			while humanoid.MoveDirection.Magnitude == 0 do 
				task.wait(0.1)
			end
			humanoid.WalkSpeed = 16 * plr:GetAttribute("Speed")
		end)
		
	end)
end)
