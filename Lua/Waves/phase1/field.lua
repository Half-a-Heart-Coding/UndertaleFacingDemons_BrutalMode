spawntimer = 0

require "Libraries/Playermove"
require "Libraries/hurt"
Arena.Resize (140, 140)
knives1 = {}
knives2 = {}
knives3 = {}
seeds = {}
radius = 150
varcol = {255/255, 0/255, 255/255}
varstring = "none"

DoGhost("Flowey_Sprite",1,600)


function Update()
	HurtUpd(605)
	Moving()
	
	spawntimer = spawntimer + 1

	if spawntimer%45 == 0 then
		local knive1 = math.random(7)
		local knive2 = math.random(7)
		local bullet1y = 20 * knive1 - 80
		local bullet2y = 20 * knive2 - 80
		local bullet1 = CreateProjectile ("KnifeRight", -400, bullet1y)
		bullet1.SetVar("color", "knife")
		local bullet2 = CreateProjectile ("KnifeLeft", 400, bullet2y)
		bullet2.SetVar("color", "knife")
		table.insert(knives1, bullet1)
		table.insert(knives2, bullet2)
	end

	if spawntimer%130 == 0 then 
		CreateSeedRing()
	end
	
	for g=1,#knives2 do
    	    local bullet = knives2[g]
    	    bullet.MoveTo(bullet.x-7, bullet.y)
	end
	
	for i=1,#knives1 do
    	    local bullet = knives1[i]
    	    bullet.MoveTo(bullet.x+7, bullet.y)
	end

	for j=1,#seeds do
		local pellet = seeds[j]
		local num = pellet.GetVar("number")
		local rad = pellet.GetVar("radius")
		rad = rad-3
		local px=pellet.GetVar("px")
		local py=pellet.GetVar("py")
		local dx = rad*math.sin(num*math.pi/180)
		local dy = rad*math.cos(num*math.pi/180)
		pellet.MoveTo(dx+px, dy+py)
		pellet.SetVar("radius", rad)
		if rad < 6 then
			pellet.sprite.alpha = 0
			pellet.SetVar("color", "none")
		end
	end

end 

function CreateSeedRing() 
	local colors = math.random(2)
	if colors == 1 then
		varcol = {0/255, 168/255, 242/255}
		varstring = "blue"
	else
		varcol = {255/255, 154/255, 34/255}
		varstring = "orange"
	end
	for n=1, 20 do 
		local angle = n*18
		local seedx = radius*math.sin(angle*math.pi/180)
		local seedy = radius*math.cos(angle*math.pi/180)
		local outerseed = CreateProjectile("pellet", Player.x+seedx, Player.y+seedy)
		outerseed.sprite.color = varcol
		outerseed.SetVar("px",Player.x)
		outerseed.SetVar("py",Player.y)
		outerseed.sprite.rotation = -angle
		outerseed.SetVar("color", varstring)
		outerseed.SetVar("radius", radius)
		outerseed.SetVar("number", angle)
		table.insert(seeds, outerseed)
	end
	Audio.PlaySound('seed')
end 



function OnHit(bullet)
	local color = bullet.GetVar("color")	
	if color == "knife" then
		KnifeHurt(1)
	elseif color == "blue" and isMoving() then
		LongHurt(15,60)
	elseif color == "orange" and not isMoving() then
		LongHurt(15,60)
	end
end