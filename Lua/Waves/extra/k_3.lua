num_knives = 0
spawntimer = 0
knives1 = {}
knives2 = {}
knives3 = {}
Arena.Resize(120, 120)
collision = require "Libraries/rotational_collision"
 
sm = CreateSprite("smile")
sm.SendToBottom()
sm.x = 320
sm.y = 370
sm.Scale(1.4, 1.4)
sm.alpha = 0.0

function Update()
    spawntimer = spawntimer + 1
	sm.alpha = 0.5*math.sin(spawntimer*math.pi/360)
	
    if spawntimer%45 == 0 then
		local knive1 = math.random(6)
			if knive1 == 1 then 
				local bullet = CreateProjectile ("KnifeRight", -400, 50)
				table.insert(knives1, bullet)
			elseif knive1 == 2 then 
				local bullet = CreateProjectile ("KnifeRight", -400, 30)
				table.insert(knives1, bullet)
			elseif knive1 == 3 then 
				local bullet = CreateProjectile ("KnifeRight", -400, 10)
				table.insert(knives1, bullet)
			elseif knive1 == 4 then 
				local bullet = CreateProjectile ("KnifeRight", -400, -10)
				table.insert(knives1, bullet)
			elseif knive1 == 5 then 
				local bullet = CreateProjectile ("KnifeRight", -400, -30)
				table.insert(knives1, bullet)
			elseif knive1 == 6 then 
				local bullet = CreateProjectile ("KnifeRight", -400, -50)
				table.insert(knives1, bullet)
			end
    end
	
	if spawntimer%45 == 0 then
		local knive2 = math.random(6)
			if knive2 == 1 then 
				local bullet = CreateProjectile ("KnifeLeft", 400, 50)
				table.insert(knives2, bullet)
			elseif knive2 == 2 then 
				local bullet = CreateProjectile ("KnifeLeft", 400, 30)
				table.insert(knives2, bullet)
			elseif knive2 == 3 then 
				local bullet = CreateProjectile ("KnifeLeft", 400, 10)
				table.insert(knives2, bullet)
			elseif knive2 == 4 then 
				local bullet = CreateProjectile ("KnifeLeft", 400, -10)
				table.insert(knives2, bullet)
			elseif knive2 == 5 then 
				local bullet = CreateProjectile ("KnifeLeft", 400, -30)
				table.insert(knives2, bullet)
			elseif knive2 == 6 then 
				local bullet = CreateProjectile ("KnifeLeft", 400, -50)
				table.insert(knives2, bullet)
			end
    end
	
	if spawntimer%50 == 0 then
		local knive3 = math.random(6)
			if knive3 == 1 then 
				local bullet = CreateProjectile ("KnifeDown", -50, 500)
				table.insert(knives3, bullet)
			elseif knive3 == 2 then 
				local bullet = CreateProjectile ("KnifeDown", -30, 500)
				table.insert(knives3, bullet)
			elseif knive3 == 3 then 
				local bullet = CreateProjectile ("KnifeDown", 10, 500)
				table.insert(knives3, bullet)
			elseif knive3 == 4 then 
				local bullet = CreateProjectile ("KnifeDown", -10, 500)
				table.insert(knives3, bullet)
			elseif knive3 == 5 then 
				local bullet = CreateProjectile ("KnifeDown", 30, 500)
				table.insert(knives3, bullet)
			elseif knive3 == 6 then 
				local bullet = CreateProjectile ("KnifeDown", 50, 500)
				table.insert(knives3, bullet)
			end
    end
	
for i=1,#knives1 do
        local bullet = knives1[i]
        bullet.MoveTo(bullet.x+7, bullet.y)
		bullet.SetVar("color", "white")
    end
	
for g=1,#knives2 do
        local bullet = knives2[g]
        bullet.MoveTo(bullet.x-7, bullet.y)
		bullet.SetVar("color", "white")
    end
	
for j=1,#knives3 do
        local bullet = knives3[j]
        bullet.MoveTo(bullet.x, bullet.y-6)
		bullet.SetVar("color", "white")
    end
	
	if spawntimer == 600 then
	
	end
end
 
function OnHit(bullet)
local color = bullet.GetVar("color")	
    if color == "white" then
		Player.Hurt(1, 0.001)
	end
end