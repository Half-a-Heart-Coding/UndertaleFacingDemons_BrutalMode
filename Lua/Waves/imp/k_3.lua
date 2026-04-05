num_knives = 0
spawntimer = 0
knives1 = {}
knives2 = {}
knives3 = {}
knives4 = {}
Arena.Resize(120, 120)
require "Libraries/Playermove"
require "Libraries/hurt"
collision = require "Libraries/rotational_collision"
 
DoGhost("smile",0,600)
sm = CreateSprite("smile")
sm.SendToBottom()
sm.x = 320
sm.y = 370
sm.Scale(1.4, 1.4)
sm.alpha = 0.0

name2=""
if GetGlobal("DifficultyPoints") >= 621 then
	name2="Fatal"
end
name3="Deadly"
if GetGlobal("DifficultyPoints") >= 621 then
	name3="Fatal"
end
name4="Lethal"
if GetGlobal("DifficultyPoints") >= 621 then
	name4="Fatal"
end

function SwitchKnife(dir,x,y)
	if dir == 1 then
		local bullet = CreateProjectile ("KnifeRight"..name4, x, y)
		bullet.SetVar("color", "gold")
		table.insert(knives1, bullet)
	end
	if dir == 2 then
		local bullet = CreateProjectile ("KnifeLeft"..name4, x, y)
		bullet.SetVar("color", "gold")
		table.insert(knives2, bullet)
	end
	if dir == 3 then
		local bullet = CreateProjectile ("KnifeDown"..name4, x, y)
		bullet.SetVar("color", "gold")
		table.insert(knives3, bullet)
	end
	if dir == 4 then
		local bullet = CreateProjectile ("KnifeUp"..name4, x, y)
		bullet.SetVar("color", "gold")
		table.insert(knives4, bullet)
	end
end

function Update()
HurtUpd(1200)
Moving()
    spawntimer = spawntimer + 1
	
    if spawntimer%180 == 60 then
		local knive1 = math.random(6)
			if knive1 == 1 then 
				local bullet = CreateProjectile ("KnifeRight"..name3, -400, 50)
				table.insert(knives1, bullet)
			elseif knive1 == 2 then 
				local bullet = CreateProjectile ("KnifeRight"..name3, -400, 30)
				table.insert(knives1, bullet)
			elseif knive1 == 3 then 
				local bullet = CreateProjectile ("KnifeRight"..name3, -400, 10)
				table.insert(knives1, bullet)
			elseif knive1 == 4 then 
				local bullet = CreateProjectile ("KnifeRight"..name3, -400, -10)
				table.insert(knives1, bullet)
			elseif knive1 == 5 then 
				local bullet = CreateProjectile ("KnifeRight"..name3, -400, -30)
				table.insert(knives1, bullet)
			elseif knive1 == 6 then 
				local bullet = CreateProjectile ("KnifeRight"..name3, -400, -50)
				table.insert(knives1, bullet)
			end
    end
	
	if spawntimer%180 == 60 then
		local knive2 = math.random(6)
			if knive2 == 1 then 
				local bullet = CreateProjectile ("KnifeLeft"..name3, 400, 50)
				table.insert(knives2, bullet)
			elseif knive2 == 2 then 
				local bullet = CreateProjectile ("KnifeLeft"..name3, 400, 30)
				table.insert(knives2, bullet)
			elseif knive2 == 3 then 
				local bullet = CreateProjectile ("KnifeLeft"..name3, 400, 10)
				table.insert(knives2, bullet)
			elseif knive2 == 4 then 
				local bullet = CreateProjectile ("KnifeLeft"..name3, 400, -10)
				table.insert(knives2, bullet)
			elseif knive2 == 5 then 
				local bullet = CreateProjectile ("KnifeLeft"..name3, 400, -30)
				table.insert(knives2, bullet)
			elseif knive2 == 6 then 
				local bullet = CreateProjectile ("KnifeLeft"..name3, 400, -50)
				table.insert(knives2, bullet)
			end
    end
	
	if spawntimer%180 == 60 then
		local knive3 = math.random(6)
			if knive3 == 1 then 
				local bullet = CreateProjectile ("KnifeDown"..name3, -50, 500)
				table.insert(knives3, bullet)
			elseif knive3 == 2 then 
				local bullet = CreateProjectile ("KnifeDown"..name3, -30, 500)
				table.insert(knives3, bullet)
			elseif knive3 == 3 then 
				local bullet = CreateProjectile ("KnifeDown"..name3, 10, 500)
				table.insert(knives3, bullet)
			elseif knive3 == 4 then 
				local bullet = CreateProjectile ("KnifeDown"..name3, -10, 500)
				table.insert(knives3, bullet)
			elseif knive3 == 5 then 
				local bullet = CreateProjectile ("KnifeDown"..name3, 30, 500)
				table.insert(knives3, bullet)
			elseif knive3 == 6 then 
				local bullet = CreateProjectile ("KnifeDown"..name3, 50, 500)
				table.insert(knives3, bullet)
			end
    end

	if spawntimer%185 == 60 then
		local knive4 = math.random(6)
			if knive4 == 1 then 
				local bullet = CreateProjectile ("KnifeUp"..name3, -50, -500)
				table.insert(knives4, bullet)
			elseif knive4 == 2 then 
				local bullet = CreateProjectile ("KnifeUp"..name3, -30, -500)
				table.insert(knives4, bullet)
			elseif knive4 == 3 then 
				local bullet = CreateProjectile ("KnifeUp"..name3, 10, -500)
				table.insert(knives4, bullet)
			elseif knive4 == 4 then 
				local bullet = CreateProjectile ("KnifeUp"..name3, -10, -500)
				table.insert(knives4, bullet)
			elseif knive4 == 5 then 
				local bullet = CreateProjectile ("KnifeUp"..name3, 30, -500)
				table.insert(knives4, bullet)
			elseif knive4 == 6 then 
				local bullet = CreateProjectile ("KnifeUp"..name3, 50, -500)
				table.insert(knives4, bullet)
			end
    end

	if spawntimer%300 == 60 then
		local knive1 = math.random(6)
			if knive1 == 1 then 
				local bullet = CreateProjectile ("KnifeRightPurple", -400, 50)
				bullet.SetVar("color", "purple")
				table.insert(knives1, bullet)
			elseif knive1 == 2 then 
				local bullet = CreateProjectile ("KnifeRightPurple", -400, 30)
				bullet.SetVar("color", "purple")
				table.insert(knives1, bullet)
			elseif knive1 == 3 then 
				local bullet = CreateProjectile ("KnifeRightPurple", -400, 10)
				bullet.SetVar("color", "purple")
				table.insert(knives1, bullet)
			elseif knive1 == 4 then 
				local bullet = CreateProjectile ("KnifeRightPurple", -400, -10)
				bullet.SetVar("color", "purple")
				table.insert(knives1, bullet)
			elseif knive1 == 5 then 
				local bullet = CreateProjectile ("KnifeRightPurple", -400, -30)
				bullet.SetVar("color", "purple")
				table.insert(knives1, bullet)
			elseif knive1 == 6 then 
				local bullet = CreateProjectile ("KnifeRightPurple", -400, -50)
				bullet.SetVar("color", "purple")
				table.insert(knives1, bullet)
			end
    end
	
	if spawntimer%300 == 60 then
		local knive2 = math.random(6)
			if knive2 == 1 then 
				local bullet = CreateProjectile ("KnifeLeftPurple", 400, 50)
				bullet.SetVar("color", "purple")
				table.insert(knives2, bullet)
			elseif knive2 == 2 then 
				local bullet = CreateProjectile ("KnifeLeftPurple", 400, 30)
				bullet.SetVar("color", "purple")
				table.insert(knives2, bullet)
			elseif knive2 == 3 then 
				local bullet = CreateProjectile ("KnifeLeftPurple", 400, 10)
				bullet.SetVar("color", "purple")
				table.insert(knives2, bullet)
			elseif knive2 == 4 then 
				local bullet = CreateProjectile ("KnifeLeftPurple", 400, -10)
				bullet.SetVar("color", "purple")
				table.insert(knives2, bullet)
			elseif knive2 == 5 then 
				local bullet = CreateProjectile ("KnifeLeftPurple", 400, -30)
				bullet.SetVar("color", "purple")
				table.insert(knives2, bullet)
			elseif knive2 == 6 then 
				local bullet = CreateProjectile ("KnifeLeftPurple", 400, -50)
				bullet.SetVar("color", "purple")
				table.insert(knives2, bullet)
			end
    end
	
	if spawntimer%300 == 60 then
		local knive3 = math.random(6)
			if knive3 == 1 then 
				local bullet = CreateProjectile ("KnifeDownPurple", -50, 500)
				bullet.SetVar("color", "purple")
				table.insert(knives3, bullet)
			elseif knive3 == 2 then 
				local bullet = CreateProjectile ("KnifeDownPurple", -30, 500)
				bullet.SetVar("color", "purple")
				table.insert(knives3, bullet)
			elseif knive3 == 3 then 
				local bullet = CreateProjectile ("KnifeDownPurple", 10, 500)
				bullet.SetVar("color", "purple")
				table.insert(knives3, bullet)
			elseif knive3 == 4 then 
				local bullet = CreateProjectile ("KnifeDownPurple", -10, 500)
				bullet.SetVar("color", "purple")
				table.insert(knives3, bullet)
			elseif knive3 == 5 then 
				local bullet = CreateProjectile ("KnifeDownPurple", 30, 500)
				bullet.SetVar("color", "purple")
				table.insert(knives3, bullet)
			elseif knive3 == 6 then 
				local bullet = CreateProjectile ("KnifeDownPurple", 50, 500)
				bullet.SetVar("color", "purple")
				table.insert(knives3, bullet)
			end
    end

	if spawntimer%300 == 60 then
		local knive4 = math.random(6)
			if knive4 == 1 then 
				local bullet = CreateProjectile ("KnifeUpPurple", -50, -500)
				bullet.SetVar("color", "purple")
				table.insert(knives4, bullet)
			elseif knive4 == 2 then 
				local bullet = CreateProjectile ("KnifeUpPurple", -30, -500)
				bullet.SetVar("color", "purple")
				table.insert(knives4, bullet)
			elseif knive4 == 3 then 
				local bullet = CreateProjectile ("KnifeUpPurple", 10, -500)
				bullet.SetVar("color", "purple")
				table.insert(knives4, bullet)
			elseif knive4 == 4 then 
				local bullet = CreateProjectile ("KnifeUpPurple", -10, -500)
				bullet.SetVar("color", "purple")
				table.insert(knives4, bullet)
			elseif knive4 == 5 then 
				local bullet = CreateProjectile ("KnifeUpPurple", 30, -500)
				bullet.SetVar("color", "purple")
				table.insert(knives4, bullet)
			elseif knive4 == 6 then 
				local bullet = CreateProjectile ("KnifeUpPurple", 50, -500)
				bullet.SetVar("color", "purple")
				table.insert(knives4, bullet)
			end
    end

	if spawntimer%180 == 90 then
		local knive1 = math.random(6)
			if knive1 == 1 then 
				local bullet = CreateProjectile ("KnifeRightFake", 400, 50)
				bullet.SetVar("color", "warn")
				bullet.SetVar("hasShot", false)
				table.insert(knives2, bullet)
			elseif knive1 == 2 then 
				local bullet = CreateProjectile ("KnifeRightFake", 400, 30)
				bullet.SetVar("color", "warn")
				bullet.SetVar("hasShot", false)
				table.insert(knives2, bullet)
			elseif knive1 == 3 then 
				local bullet = CreateProjectile ("KnifeRightFake", 400, 10)
				bullet.SetVar("color", "warn")
				bullet.SetVar("hasShot", false)
				table.insert(knives2, bullet)
			elseif knive1 == 4 then 
				local bullet = CreateProjectile ("KnifeRightFake", 400, -10)
				bullet.SetVar("color", "warn")
				bullet.SetVar("hasShot", false)
				table.insert(knives2, bullet)
			elseif knive1 == 5 then 
				local bullet = CreateProjectile ("KnifeRightFake", 400, -30)
				bullet.SetVar("color", "warn")
				bullet.SetVar("hasShot", false)
				table.insert(knives2, bullet)
			elseif knive1 == 6 then 
				local bullet = CreateProjectile ("KnifeRightFake", 400, -50)
				bullet.SetVar("color", "warn")
				bullet.SetVar("hasShot", false)
				table.insert(knives2, bullet)
			end
    end
	
	if spawntimer%180 == 90 then
		local knive2 = math.random(6)
			if knive2 == 1 then 
				local bullet = CreateProjectile ("KnifeLeftFake", -400, 50)
				bullet.SetVar("color", "warn")
				bullet.SetVar("hasShot", false)
				table.insert(knives1, bullet)
			elseif knive2 == 2 then 
				local bullet = CreateProjectile ("KnifeLeftFake", -400, 30)
				bullet.SetVar("color", "warn")
				bullet.SetVar("hasShot", false)
				table.insert(knives1, bullet)
			elseif knive2 == 3 then 
				local bullet = CreateProjectile ("KnifeLeftFake", -400, 10)
				bullet.SetVar("color", "warn")
				bullet.SetVar("hasShot", false)
				table.insert(knives1, bullet)
			elseif knive2 == 4 then 
				local bullet = CreateProjectile ("KnifeLeftFake", -400, -10)
				bullet.SetVar("color", "warn")
				bullet.SetVar("hasShot", false)
				table.insert(knives1, bullet)
			elseif knive2 == 5 then 
				local bullet = CreateProjectile ("KnifeLeftFake", -400, -30)
				bullet.SetVar("color", "warn")
				bullet.SetVar("hasShot", false)
				table.insert(knives1, bullet)
			elseif knive2 == 6 then 
				local bullet = CreateProjectile ("KnifeLeftFake", -400, -50)
				bullet.SetVar("color", "warn")
				bullet.SetVar("hasShot", false)
				table.insert(knives1, bullet)
			end
    end
	
	if spawntimer%180 == 90 then
		local knive3 = math.random(6)
			if knive3 == 1 then 
				local bullet = CreateProjectile ("KnifeDownFake", -50, -500)
				bullet.SetVar("color", "warn")
				bullet.SetVar("hasShot", false)
				table.insert(knives4, bullet)
			elseif knive3 == 2 then 
				local bullet = CreateProjectile ("KnifeDownFake", -30, -500)
				bullet.SetVar("color", "warn")
				bullet.SetVar("hasShot", false)
				table.insert(knives4, bullet)
			elseif knive3 == 3 then 
				local bullet = CreateProjectile ("KnifeDownFake", 10, -500)
				bullet.SetVar("color", "warn")
				bullet.SetVar("hasShot", false)
				table.insert(knives4, bullet)
			elseif knive3 == 4 then 
				local bullet = CreateProjectile ("KnifeDownFake", -10, -500)
				bullet.SetVar("color", "warn")
				bullet.SetVar("hasShot", false)
				table.insert(knives4, bullet)
			elseif knive3 == 5 then 
				local bullet = CreateProjectile ("KnifeDownFake", 30, -500)
				bullet.SetVar("color", "warn")
				bullet.SetVar("hasShot", false)
				table.insert(knives4, bullet)
			elseif knive3 == 6 then 
				local bullet = CreateProjectile ("KnifeDownFake", 50, -500)
				bullet.SetVar("color", "warn")
				bullet.SetVar("hasShot", false)
				table.insert(knives4, bullet)
			end
    end

	if spawntimer%185 == 95 then
		local knive4 = math.random(6)
			if knive4 == 1 then 
				local bullet = CreateProjectile ("KnifeUpFake", -50, 500)
				bullet.SetVar("color", "warn")
				bullet.SetVar("hasShot", false)
				table.insert(knives3, bullet)
			elseif knive4 == 2 then 
				local bullet = CreateProjectile ("KnifeUpFake", -30, 500)
				bullet.SetVar("color", "warn")
				bullet.SetVar("hasShot", false)
				table.insert(knives3, bullet)
			elseif knive4 == 3 then 
				local bullet = CreateProjectile ("KnifeUpFake", 10, 500)
				bullet.SetVar("color", "warn")
				bullet.SetVar("hasShot", false)
				table.insert(knives3, bullet)
			elseif knive4 == 4 then 
				local bullet = CreateProjectile ("KnifeUpFake", -10, 500)
				bullet.SetVar("color", "warn")
				bullet.SetVar("hasShot", false)
				table.insert(knives3, bullet)
			elseif knive4 == 5 then 
				local bullet = CreateProjectile ("KnifeUpFake", 30, 500)
				bullet.SetVar("color", "warn")
				bullet.SetVar("hasShot", false)
				table.insert(knives3, bullet)
			elseif knive4 == 6 then 
				local bullet = CreateProjectile ("KnifeUpFake", 50, 500)
				bullet.SetVar("color", "warn")
				bullet.SetVar("hasShot", false)
				table.insert(knives3, bullet)
			end
    end
	
for i=1,#knives1 do
        local bullet = knives1[i]
        bullet.MoveTo(bullet.x+7, bullet.y)
		if bullet.GetVar("color") == "gold" then
			bullet.MoveTo(bullet.x+3, bullet.y)
		end
		--bullet.SetVar("color", "white")
		if bullet.x>200 and bullet.GetVar("color") == "warn" and bullet.GetVar("hasShot") ~= true then
			SwitchKnife(2,bullet.x,bullet.y)
			bullet.SetVar("hasShot", true)
			--bullet.active = false
			bullet.sprite.alpha = 0
			--bullet.Remove()
		end
    end
	
for g=1,#knives2 do
        local bullet = knives2[g]
        bullet.MoveTo(bullet.x-7, bullet.y)
		if bullet.GetVar("color") == "gold" then
			bullet.MoveTo(bullet.x-3, bullet.y)
		end
		--bullet.SetVar("color", "white")
		if bullet.x<-200 and bullet.GetVar("color") == "warn" and bullet.GetVar("hasShot") ~= true then
			SwitchKnife(1,bullet.x,bullet.y)
			bullet.SetVar("hasShot", true)
			--bullet.active = false
			bullet.sprite.alpha = 0
			--bullet.Remove()
		end
    end
	
for j=1,#knives3 do
        local bullet = knives3[j]
        bullet.MoveTo(bullet.x, bullet.y-6)
		if bullet.GetVar("color") == "gold" then
			 bullet.MoveTo(bullet.x, bullet.y-4)
		end
		--bullet.SetVar("color", "white")
		if bullet.y<-200 and bullet.GetVar("color") == "warn" and bullet.GetVar("hasShot") ~= true then
			SwitchKnife(4,bullet.x,bullet.y)
			bullet.SetVar("hasShot", true)
			--bullet.active = false
			bullet.sprite.alpha = 0
			--bullet.Remove()
		end
    end

for k=1,#knives4 do
        local bullet = knives4[k]
        bullet.MoveTo(bullet.x, bullet.y+5)
		if bullet.GetVar("color") == "gold" then
			 bullet.MoveTo(bullet.x, bullet.y+5)
		end
		--bullet.SetVar("color", "white")
		if bullet.y>200 and bullet.GetVar("color") == "warn" and bullet.GetVar("hasShot") ~= true then
			SwitchKnife(3,bullet.x,bullet.y)
			bullet.SetVar("hasShot", true)
			--bullet.active = false
			bullet.sprite.alpha = 0
			--bullet.Remove()
		end
end
	
	if spawntimer == 600 then
	
	end
end
 
function OnHit(bullet)
local color = bullet.GetVar("color")	
	if color == "gold" then
		KnifeHurt(3)
	elseif color == "purple" then
		SetGlobal("purpleSpeed",1)
		SetGlobal("purpleSpeedTimer",60)
    elseif color ~= "warn" then
		KnifeHurt(2)
	end
end