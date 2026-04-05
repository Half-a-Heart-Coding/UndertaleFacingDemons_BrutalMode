spawntimer = 0
bullets = {}
--colors = {"orange", "cyan"}

require "Libraries/Playermove"
require "Libraries/hurt"

Arena.Resize(300, 150)

DoGhost("Asgore_Sprite",1,600)
napr=math.random(2)*2-3
trident = CreateProjectile('trid', napr*-300, 0)
trident.sprite.color = {0/255, 168/255, 242/255}
trident.SetVar("napravlenie", napr)
trident.SetVar("color", "goluboy")

function Update()
	HurtUpd(900)
	Moving()
	spawntimer = spawntimer+1
	
	local napr = trident.GetVar("napravlenie")
	if trident.x > 350 or trident.x < -350 then 
		napr = -napr 
		trident.SetVar("napravlenie", napr)
	local newcolor = math.random(2) 
		if newcolor == 1 then
			trident.sprite.color ={0/255, 168/255, 242/255}
			trident.SetVar("color", "goluboy")
		else
			trident.sprite.color = {255/255, 154/255, 34/255}
			trident.SetVar("color", "orangeviy")
		end
	end
	trident.MoveTo(trident.x+5*napr, trident.y)
	if trident.x+25>Player.x and trident.x-25<Player.x then
		if trident.GetVar("color") == "goluboy" and isMoving() then
			LongHurt(20,90)
			elseif trident.GetVar("color") == "orangeviy" and not isMoving() then
			LongHurt(20,90)
		end
	end	
	if spawntimer % 25 == 0 then
		local side = math.random(2)*2-3
		local left_right=side
		if left_right == 1 then
			left_right = "leaf_l"
		else
			left_right = "leaf_r"
		end
		local leaf = CreateProjectile(left_right, math.random() * Arena.width - Arena.width / 2, 0 + Arena.height / 2 + 16)
		leaf.SetVar("xspeed", Time.time)
		leaf.SetVar("yspeed", 0)
		leaf.SetVar("side",side)
		leaf.SetVar("angle", 0)
		leaf.SetVar("orient", left_right)
		leaf.SetVar('color', "white")
		table.insert(bullets, leaf)
	end
	
	for i=1,#bullets do
		local bullet = bullets[i]
		local velx = bullet.GetVar('xspeed')
		local vely = bullet.GetVar('yspeed')
		local orientation = bullet.GetVar('orient')
		velx = velx + 1
		bullet.SetVar("xspeed", velx)
		vely = math.cos(2*velx*math.pi/180)*math.cos(2*velx*math.pi/180)
		bullet.SetVar("yspeed", vely+2)
		bullet.Move(math.sin(2*velx*math.pi/180)*bullet.GetVar("side"), -vely)
		if orientation == "leaf_l" then
			bullet.sprite.rotation = 20+20*math.sin(2*velx*math.pi/180)
		else
			bullet.sprite.rotation = -20-20*math.sin(2*velx*math.pi/180)
		end
	end

	if timer == 600 then
		asgore.Remove()
		EndWave()
	end

end

function OnHit(bullet)
	local color = bullet.GetVar("color")
	if color == "white" then
		LongHurt(20,60)
	end
end