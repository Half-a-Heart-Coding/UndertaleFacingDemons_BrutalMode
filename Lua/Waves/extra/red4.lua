spearup1 = CreateProjectile('spear', -20, -110)
--spearup1.sprite.color = {0/255, 162/255, 232/255}
spearup1.sprite.color = {255/255, 154/255, 34/255}
spearup2 = CreateProjectile('spear', 0, -110)
spearup2.sprite.color = {255/255, 154/255, 34/255}
spearup3 = CreateProjectile('spear', 20, -110)
spearup3.sprite.color = {255/255, 154/255, 34/255}
timer = 0
spearmoving1 = false
spearmoving2 = false
spearmoving3 = false
spear1colour = "orange"
spear2colour = "orange"
spear3colour = "orange"
Arena.Resize(60, 90)

function Update()
	timer = timer + 1
	if timer == 15 then
		spearmoving1 = true
		spearmoving2 = true
		spearmoving3 = true
	end
	if timer == 55 then
		spearmoving1 = false
		spearup1.sprite.color = {255/255, 255/255, 255/255}
		spearup1.MoveTo(-20,-110)
		spear1colour = "white"
	end
	if timer == 65 then
		spearmoving1 = true
	end
	if timer == 95 then
		spearmoving2 = false
		spearup2.sprite.color = {255/255, 255/255, 255/255}
		spearup2.MoveTo(0,-110)
		spear2colour = "white"
	end
	if timer == 105 then
		spearmoving2 = true
	end
	if timer == 135 then
		spearmoving3 = false
		spearup3.sprite.color = {255/255, 255/255, 255/255}
		spearup3.MoveTo(20,-110)
		spear3colour = "white"
	end
	if timer == 145 then
		spearmoving3 = true
	end
	if timer == 175 then
		spearmoving3 = false
		spearup3.MoveTo(20,-110)
	end
	if timer == 185 then
		spearmoving3 = true
	end
	if timer == 205 then
		spearmoving2 = false
		spearup2.MoveTo(0,-110)
	end
	if timer == 215 then
		spearmoving2 = true
	end
	if timer == 235 then
		spearmoving1 = false
		spearup1.MoveTo(-20,-110)
	end
	if timer == 245 then
		spearmoving1 = true
	end
	if timer == 275 then
		spearmoving2 = false
		spearup2.MoveTo(0,-110)
	end
	if timer == 285 then
		spearmoving2 = true
	end
	if timer == 325 then
		spearmoving1 = false
		spearup1.MoveTo(-20,-110)
		spearmoving3 = false
		spearup3.MoveTo(20,-110)
	end
	if timer == 335 then
		spearmoving1 = true
		spearmoving3 = true
	end
	if timer == 365 then
		spearmoving1 = false
		spearup1.MoveTo(-20,-110)
		spearup1.sprite.color = {0/255, 162/255, 232/255}
		spearmoving2 = false
		spearup2.MoveTo(0,-110)
		spearup2.sprite.color = {0/255, 162/255, 232/255}
		spearmoving3 = false
		spearup3.MoveTo(20,-110)
		spearup3.sprite.color = {0/255, 162/255, 232/255}
		spear1colour = "cyan"
		spear2colour = "cyan"
		spear3colour = "cyan"
	end
	if timer == 375 then
		spearmoving1 = true
		spearmoving2 = true
		spearmoving3 = true
	end
	
	if timer == 410 then
		EndWave()
	end

	if spearmoving1 == true then
		spearup1.Move(0,7)
	end
	if spearmoving2 == true then
		spearup2.Move(0,7)
	end
	if spearmoving3 == true then
		spearup3.Move(0,7)
	end
	if spearmoving1 == false then
		spearup1.Move(0,0)
	end
	if spearmoving2 == false then
		spearup2.Move(0,0)
	end
	if spearmoving3 == false then
		spearup3.Move(0,0)
	end
end

function OnHit(spearup1)
	if spear1colour == "cyan" then
		if Player.isMoving then
        			Player.Hurt(10)
    	end
	end
	if spear1colour == "orange" then
		if not Player.isMoving then
        			Player.Hurt(10)
    	end
	end
	if spear1colour == "white" then
		Player.Hurt(10)
	end
end

function OnHit(spearup2)
	if spear2colour == "cyan" then
		if Player.isMoving then
        			Player.Hurt(10)
    	end
	end
	if spear2colour == "orange" then
		if not Player.isMoving then
        			Player.Hurt(10)
    	end
	end
	if spear2colour == "white" then
		Player.Hurt(10)
	end
end

function OnHit(spearup3)
	if spear3colour == "cyan" then
		if Player.isMoving then
        			Player.Hurt(10)
    	end
	end
	if spear3colour == "orange" then
		if not Player.isMoving then
        			Player.Hurt(10)
    	end
	end
	if spear3colour == "white" then
		Player.Hurt(10)
	end
end