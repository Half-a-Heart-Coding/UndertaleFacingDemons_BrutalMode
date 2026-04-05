Knifecount = 0
slices = {}
Knifes = {}
Arena.Resize(200,Arena.height)
spawntimer = 0
istop = false
istop2 = true
Svar1 = nil
Svar2 = nil
Moving = false
Svar3 = nil
Timer = nil
require "Libraries/Playermove"
require "Libraries/hurt"

SetGlobal("ArenaMove", 1)


function SpawnKnife(Rotation,Position,Speed1,Speed2)
		local startposx = math.random(-400,400)
        local startposy = 400
        local Knife = CreateProjectile('Knife'..Rotation, startposx,startposy)
		Knife.SetVar('Position', Position)
		Knife.SetVar('Rotation', Rotation)
		Knife.SetVar('XVelo', Speed1)
		Knife.SetVar('IsBullet', true)
		Knife.SetVar('YVelo', Speed2)
		Knife.SetVar('InPosition', "False")
		Knife.SetVar('IsFiring', "False")
		Knife.SetVar('Frame', 0)
		Knife.SetVar('Startx', startposx)
		Knife.SetVar('Starty', startposy)
		Knife.SetVar('Played1', 0)
		Knife.SetVar('Played2', 0)
		Knife.sprite.alpha = 0
		Knife.sprite.rotation = math.random(0,360)
        table.insert(Knifes, Knife)
end

function Update()
HurtUpd(600)
Moving()
spawntimer = spawntimer + 1
	if spawntimer == 360 then
		EndWave()
	end
if spawntimer%10 == 0 then
if spawntimer <= 120 then
SpawnKnife("Down", "Player", 0, -18)
elseif spawntimer >= 180 then
spawntimer = 0
SpawnKnife("Left", "Player", -12, 0)
SpawnKnife("Right", "Player", 12, 0)
end
end

	if #Knifes > 0 then
    for i=1,#Knifes do
        local Knife = Knifes[i]
		if Knife.isactive then
			local SoundPlayed = false
			local SoundPlayed2 = false
			local Played1 = Knife.GetVar('Played1')
			local Played2 = Knife.GetVar('Played2')
			local Position = Knife.GetVar('Position')
			local SpeedX = Knife.GetVar('XVelo')
			local SpeedY = Knife.GetVar('YVelo')
			local Rotation = Knife.GetVar('Rotation')
			local InPosition = Knife.GetVar('InPosition')
			local Frame = Knife.GetVar('Frame')
			local startx = Knife.GetVar('Startx')
			local starty = Knife.GetVar('Starty')
			local IsFiring = Knife.GetVar('IsFiring')
			if InPosition == "False" and IsFiring == "False" then
				if Played1 == 0 then
					Knife.SetVar('Played1', 1)
				end
				if Rotation == "Down" then
					local Goalx = nil
					if Position == "Player" then
						Goalx = Player.x
						else
						Goalx = - Arena.width/2 + Position
					end
					local Goaly = Arena.height/2 + Knife.sprite.height/2 + Knife.sprite.height/4
					local currentx = Knife.x
					local currenty = Knife.y
					local RotGoal = 0
					local currentrot = Knife.sprite.rotation
					local movevarx = Goalx - currentx
					local movevary = Goaly - currenty
					local newposx = movevarx/10
					local newposy = movevary/10
					local rot = RotGoal - currentrot
					local newrot = Knife.sprite.rotation + rot/10
					Knife.sprite.rotation = newrot
					Knife.sprite.alpha = Knife.sprite.alpha + 1/30
					Knife.SetVar('Frame', Frame + 1)
					Knife.Move(newposx,newposy)
					if Frame == 40 then
						Knife.SetVar('Frame', 0)
						Knife.SetVar('InPosition', "True")
						Knife.SetVar('IsFiring', "True")
					end
					elseif Rotation == "Up" then
					local Goalx = nil
					if Position == "Player" then
						Goalx = Player.x
					else
						Goalx = - Arena.width/2 + Position
					end
					local Goaly = - Arena.height/2 - Knife.sprite.height/2 - Knife.sprite.height/4
					local RotGoal = 0
					local currentx = Knife.x
					local currenty = Knife.y
					local currentrot = Knife.sprite.rotation
					local movevarx = Goalx - currentx
					local movevary = Goaly - currenty
					local rot = RotGoal - currentrot
					local newposx = movevarx/10
					local newposy = movevary/10
					local newrot = Knife.sprite.rotation + rot/10
					Knife.sprite.rotation = newrot
					Knife.sprite.alpha = Knife.sprite.alpha + 1/30
					Knife.SetVar('Frame', Frame + 1)
					Knife.Move(newposx,newposy)
					if Frame == 40 then
						Knife.SetVar('InPosition', "True")
						Knife.SetVar('IsFiring', "True")
						Knife.SetVar('Frame', 0)
					end
					elseif Rotation == "Right" then
					local Goalx = - Arena.width/2 - Knife.sprite.width/2 - Knife.sprite.width/4
					local Goaly = nil
					if Position == "Player" then
						Goaly = Player.y
						else
						Goaly = -Arena.height/2 + Position
					end
					local RotGoal = 0
					local currentx = Knife.x
					local currenty = Knife.y
					local currentrot = Knife.sprite.rotation
					local movevarx = Goalx - currentx
					local movevary = Goaly - currenty
					local rot = RotGoal - currentrot
					local newposx = movevarx/10
					Knife.sprite.alpha = Knife.sprite.alpha + 1/30
					local newposy = movevary/10
					local newrot = Knife.sprite.rotation + rot/10
					Knife.sprite.rotation = newrot
					Knife.SetVar('Frame', Frame + 1)
					Knife.Move(newposx,newposy)
					if Frame == 40 then
						Knife.SetVar('InPosition', "True")
						Knife.SetVar('IsFiring', "True")
						Knife.SetVar('Frame', 0)
					end
					elseif Rotation == "Left" then
					local Goalx = Arena.width/2 + Knife.sprite.width/2 + Knife.sprite.width/4
					local Goaly = nil
					if Position == "Player" then
						Goaly = Player.y
						else
						Goaly = -Arena.height/2 + Position
					end
					local RotGoal = 0
					local currentx = Knife.x
					local currenty = Knife.y
					local currentrot = Knife.sprite.rotation
					local movevarx = Goalx - currentx
					local movevary = Goaly - currenty
					local rot = RotGoal - currentrot
					local newposx = movevarx/10
					Knife.sprite.alpha = Knife.sprite.alpha + 1/30
					local newposy = movevary/10
					local newrot = Knife.sprite.rotation + rot/10
					Knife.sprite.rotation = newrot
					Knife.SetVar('Frame', Frame + 1)
					Knife.Move(newposx,newposy)
					if Frame == 40 then
					Knife.SetVar('Frame', 0)
					Knife.SetVar('InPosition', "True")
					Knife.SetVar('IsFiring', "True")
				end
			end
		end
		
		if InPosition == "True" and IsFiring == "True" then
			if Rotation == "Down" then
				local Goalx = Knife.x
				local Goaly = Knife.y + 20
				local currentx = Knife.x
				local currenty = Knife.y
				local movevarx = Goalx - currentx
				local movevary = Goaly - currenty
				local newposx = movevarx/5
				local newposy = movevary/5
				Knife.SetVar('Frame', Frame + 1)
				Knife.Move(newposx,newposy)
				if Frame == 8 then
					Knife.SetVar('InPosition', "False")
					Knife.SetVar('IsFiring', "True")
				end
				elseif Rotation == "Up" then
		local Goalx = Knife.x
		local Goaly = Knife.y - 20
		local currentx = Knife.x
		local currenty = Knife.y
		local movevarx = Goalx - currentx
		local movevary = Goaly - currenty
		local newposx = movevarx/5
		local newposy = movevary/5
		Knife.SetVar('Frame', Frame + 1)
		Knife.Move(newposx,newposy)
		if Frame == 8 then
		Knife.SetVar('InPosition', "False")
		Knife.SetVar('IsFiring', "True")
		end
		elseif Rotation == "Right" then
		local Goalx = Knife.x - 20
		local Goaly = Knife.y
		local currentx = Knife.x
		local currenty = Knife.y
		local movevarx = Goalx - currentx
		local movevary = Goaly - currenty
		local newposx = movevarx/5
		local newposy = movevary/5
		Knife.SetVar('Frame', Frame + 1)
		Knife.Move(newposx,newposy)
		if Frame == 8 then
		Knife.SetVar('InPosition', "False")
		Knife.SetVar('IsFiring', "True")
		end
		elseif Rotation == "Left" then
		local Goalx = Knife.x + 20
		local Goaly = Knife.y
		local currentx = Knife.x
		local currenty = Knife.y
		local movevarx = Goalx - currentx
		local movevary = Goaly - currenty
		local newposx = movevarx/5
		local newposy = movevary/5
		Knife.SetVar('Frame', Frame + 1)
		Knife.Move(newposx,newposy)
		if Frame == 8 then
		Knife.SetVar('InPosition', "False")
		Knife.SetVar('IsFiring', "True")
		end
		end
		end
		
		if InPosition == "False" and IsFiring == "True" then
		if Rotation == "Down" then
		Knife.Move(SpeedX,SpeedY/2)
		if Knife.y - Knife.sprite.height/2 <= -Arena.height/2 then
		Knife.SetVar('XVelo', 0)
		Knife.SetVar('YVelo', 0)
		if Knife.sprite.alpha > 0 then
		Knife.sprite.alpha = Knife.sprite.alpha - 0.075
			if Knife.sprite.alpha<0.5 then
				Knife.SetVar('IsBullet', false)
			end
		else
		Knife:Remove()
		end
		end
		elseif Rotation == "Up" then
		Knife.Move(SpeedX,SpeedY)
		if Knife.y + Knife.sprite.height/2 >= -500 then
		Knife.SetVar('XVelo', 0)
		Knife.SetVar('YVelo', 0)
		if Knife.sprite.alpha > 0 then
		Knife.sprite.alpha = Knife.sprite.alpha - 0.075
			if Knife.sprite.alpha<0.5 then
				Knife.SetVar('IsBullet', false)
			end
		else
		Knife:Remove()
		end
		end
		elseif Rotation == "Right" then
		Knife.Move(SpeedX,SpeedY)
		if Knife.x + Knife.sprite.height/2 >= Arena.width/2 then
		Knife.SetVar('XVelo', 0)
		Knife.SetVar('YVelo', 0)
		if Knife.sprite.alpha > 0 then
			Knife.sprite.alpha = Knife.sprite.alpha - 0.075
			if Knife.sprite.alpha<0.5 then
				Knife.SetVar('IsBullet', false)
			end
			else
			Knife:Remove()
		end
		end
		elseif Rotation == "Left" then
		Knife.Move(SpeedX,SpeedY)
		if Knife.x - Knife.sprite.height/2 <= -Arena.width/2 then
		Knife.SetVar('XVelo', 0)
		Knife.SetVar('YVelo', 0)
		if Knife.sprite.alpha > 0 then
		Knife.sprite.alpha = Knife.sprite.alpha - 0.075
			if Knife.sprite.alpha<0.5 then
				Knife.SetVar('IsBullet', false)
			end
		else
		Knife:Remove()
		end
		end
		end
		end
		
		end
		end
		end
	
	
	end
	
function OnHit(blast)
    local damage = 1
	local timer = 0.0001
	if blast.GetVar('IsBullet') == true and blast.GetVar("IsFiring")=="True"  then
        KnifeHurt(1)
	Effects("curse",1)
		end
end