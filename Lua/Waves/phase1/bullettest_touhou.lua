
require "Libraries/Playermove"
require "Libraries/hurt"
-- You've seen this one in the trailer (if you've seen the trailer).
spawntimer = 0
bullets = {}
knifes1 = {}
knifes2 = {}
Arena.Resize(256, 120)

DoGhost("Paps_Sprite",1,600)

function Update()
HurtUpd(600)
Moving()
    spawntimer = spawntimer + 1
	
    if(spawntimer % 150 == 0) then
        local bullet = CreateProjectile('wall', 0, 400)
		local newcolor = math.random(2) 
			if newcolor == 1 then
				bullet.sprite.color ={0/255, 168/255, 242/255}
				bullet.SetVar("color", "golub")
			else
				bullet.sprite.color = {255/255, 154/255, 34/255}
				bullet.SetVar("color", "oran")
			end
		table.insert(bullets, bullet)
    end
	
		
	if(spawntimer%70 == 45) then
		local knife1 = math.random(3)
			if knife1 == 1 then 
				local bullet1 = CreateProjectile ("KnifeRight", -400, 50)
				local bullet2 = CreateProjectile ("KnifeRight", -400, 30)
				table.insert(knifes1, bullet1)
				table.insert(knifes1, bullet2)
			elseif knife1 == 2 then 
				local bullet1 = CreateProjectile ("KnifeRight", -400, 50)
				local bullet2 = CreateProjectile ("KnifeRight", -400, 10)
				table.insert(knifes1, bullet1)
				table.insert(knifes1, bullet2)
			elseif knife1 == 3 then
				local bullet1 = CreateProjectile ("KnifeRight", -400, 30)
				local bullet2 = CreateProjectile ("KnifeRight", -400, 10)
				table.insert(knifes1, bullet1)
				table.insert(knifes1, bullet2)
			end
		local knife2 = math.random(3)
			if knife2 == 1 then 
				local bullet1 = CreateProjectile ("KnifeLeft", 400, -10)
				local bullet2 = CreateProjectile ("KnifeLeft", 400, -30)
				table.insert(knifes2, bullet1)
				table.insert(knifes2, bullet2)
			elseif knife2 == 2 then 
				local bullet1 = CreateProjectile ("KnifeLeft", 400, -10)
				local bullet2 = CreateProjectile ("KnifeLeft", 400, -50)
				table.insert(knifes2, bullet1)
				table.insert(knifes2, bullet2)
			elseif knife2 == 3 then
				local bullet1 = CreateProjectile ("KnifeLeft", 400, -30)
				local bullet2 = CreateProjectile ("KnifeLeft", 400, -50)
				table.insert(knifes2, bullet1)
				table.insert(knifes2, bullet2)
			end
	end
		

    for i=1,#bullets do
        local bullet = bullets[i]
        bullet.MoveTo(bullet.x, bullet.y-8)
    end
	
	for k=1,#knifes1 do
        local bullet = knifes1[k]
        bullet.MoveTo(bullet.x+5, bullet.y)
		bullet.SetVar("color", "white")
    end
	
	for h=1,#knifes2 do
        local bullet = knifes2[h]
        bullet.MoveTo(bullet.x-5, bullet.y)
		bullet.SetVar("color", "white")
    end
	
end

function OnHit(bullet)
local color = bullet.GetVar("color")
	if color == "golub" and isMoving() then
		LongHurt(10,60)
	elseif color == "oran" and not isMoving() then
		LongHurt(10,60)
	elseif color == "white" then
		KnifeHurt(1)
	end
end