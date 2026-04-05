Arena.ResizeImmediate(160, 160)
collision = require "Libraries/rotational_collision"
require "Libraries/hurt"
numwebs = 3
side = 1
spawntimer = 0
bulletpos = 1
bullets = {}
warnings = {}
knives = {}


webs = {} --array that stores the webs
gaps = {} --array that stores the coordinates of the webs
orient = 1
libactive = false
movingup = false
movingdown = false
movingleft = false
movingright = false
previnput = false
playerpos = 0
xspeed = 0
yspeed = 0
inputdelay = 0


muffet = CreateSprite("Muffet_Sprite")
muffet.SendToBottom()
muffet.x = 390
muffet.y = 375
muffet.Scale(2, 2)
muffet.alpha = 0.0
HeartChange({0.81,0.21,0.85})
-------------------------------------------------------------------------------------------------------------------
	numlines = 3
	Player.SetControlOverride(true)
	Player.sprite.color = {0.81,0.21,0.85}
	webs = {}
	gaps = {}
	xsc = 0.025
	ysc = Arena.height/40
	xoff = Arena.width/(4)
	yoff = 0
	--orient = 1
	playerpos = math.ceil(3/2)
	for i=1,3 do
		web = CreateProjectile("purpleweb",-Arena.width/2+i*xoff,-Arena.height/2+i*yoff)
		web.sprite.SetAnchor(0,0)
		web.sprite.SetPivot(0,0)
		--web.sprite.xscale = xsc
		--web.sprite.yscale = ysc
		web.MoveTo(math.ceil(-Arena.width/2-1+i*xoff),math.ceil(-Arena.height/2-1+i*yoff))
		table.insert(webs,web)
		table.insert(gaps,web.x)
	end
	Player.MoveTo(gaps[playerpos],Player.y,false)
-------------------------------------------------------------------------------------------------------------------

function Create_knives(posx, posy)
	local centerx = posx
	local centery = posy
	local knife1 = CreateProjectile("KnifeRight", centerx+200, centery+200)
	knife1.sprite.rotation=-135
	local knife2 = CreateProjectile("KnifeRight", centerx+200, centery-200)
	knife2.sprite.rotation=135
	local knife3 = CreateProjectile("KnifeRight", centerx-200, centery-200)
	knife3.sprite.rotation=45
	local knife4 = CreateProjectile("KnifeRight", centerx-200, centery+200)
	knife4.sprite.rotation=-45
	knife1.SetVar("speed",10)
	knife2.SetVar("speed",10)
	knife3.SetVar("speed",10)
	knife4.SetVar("speed",10)
	table.insert(knives, knife1)
	table.insert(knives, knife2)
	table.insert(knives, knife3)
	table.insert(knives, knife4)
end
function Create_More_Knives(px,py)
	local knife1=CreateProjectile("KnifeRight",px+400,py)
	knife1.sprite.rotation=180
	local knife2=CreateProjectile("KnifeRight",px,py+400)
	knife2.sprite.rotation=-90
	local knife3=CreateProjectile("KnifeRight",px-400,py)
	knife3.sprite.rotation=0
	local knife4=CreateProjectile("KnifeRight",px,py-400)
	knife4.sprite.rotation=90
	knife1.SetVar("speed",6)
	knife2.SetVar("speed",6)
	knife3.SetVar("speed",6)
	knife4.SetVar("speed",6)
	table.insert(knives,knife1)
	table.insert(knives,knife2)
	table.insert(knives,knife3)
	table.insert(knives,knife4)
end
	


function Update()
HurtUpd(700)
-------------------------------------------------------------------------------------------------------------------
	if Input.Up > 0 then
		if movingup == false then
			if orient == 0 then
				if previnput == false then
					movingup = true
					if playerpos < #webs then
						playerpos = playerpos + 1
						--DEBUG("playerpos: ".. playerpos .. "!")
					end
				end
			else
				yspeed = 2
			end
		end
		previnput = true
	end
	
	if Input.Down > 0 then
		if movingdown == false then
			if orient == 0 then
				if previnput == false then
				movingdown = true
					if playerpos > 1 then
						playerpos = playerpos - 1
						--DEBUG("playerpos: ".. playerpos .. "!")
					end
				end
			else
				yspeed = -2
			end
		end
		previnput = true
	end	
	
	if Input.Left > 0 then
		if movingleft == false then
			if orient == 1 then
				if previnput == false then
				movingleft = true
					if playerpos > 1 then
						playerpos = playerpos - 1
						--DEBUG("playerpos: ".. playerpos .. "!")
					end
				end
			else
				xspeed = -2
			end
		end
		previnput = true
	end
	
	if Input.Right > 0 then
		if movingright == false then
			if orient == 1 then
				if previnput == false then
				movingright = true
					if playerpos < #webs then
						playerpos = playerpos + 1
						--DEBUG("playerpos: ".. playerpos .. "!")
					end
				end
			else
				xspeed = 2
			end
		end
		previnput = true
	end
	if Input.Up == 0 and Input.Down == 0 and Input.Left == 0 and Input.Right == 0 then
		xspeed = 0
		yspeed = 0
		previnput = false
	end
	
	if movingup == true then
		if Player.y < gaps[playerpos] then
			yspeed = math.floor(Arena.height/#webs/4)
		else
			yspeed = 0
			Player.MoveTo(Player.x,gaps[playerpos],false)
			movingup = false
		end
	end
	if movingdown == true then
		if Player.y > gaps[playerpos] then
			yspeed = math.ceil(-Arena.height/#webs/4)
		else
			yspeed = 0
			Player.MoveTo(Player.x,gaps[playerpos],false)
			movingdown = false
		end
	end
	if movingleft == true then
		if Player.x > gaps[playerpos] then
			xspeed = math.ceil(-Arena.height/#webs/4)
		else
			xspeed = 0
			Player.MoveTo(gaps[playerpos],Player.y,false)
			movingleft = false
		end
	end
	if movingright == true then
		if Player.x < gaps[playerpos] then
			xspeed = math.ceil(Arena.height/#webs/4)
		else
			xspeed = 0
			Player.MoveTo(gaps[playerpos],Player.y,false)
			movingright = false
		end
	end
	Player.MoveTo(Player.x+xspeed,Player.y+yspeed,false)
-------------------------------------------------------------------------------------------------------------------
	spawntimer = spawntimer + 1
	muffet.alpha = 0.5*math.sin(spawntimer*math.pi/580)
	if spawntimer<305 or spawntimer==305  then
	  	muffet.x = 330+90*math.sin(spawntimer*math.pi/580)
	  	else muffet.x = 510-90*math.sin(spawntimer*math.pi/580)
	end
	if spawntimer%60 == 0 then
		bullet = CreateProjectile("spider",gaps[bulletpos], Arena.height/2)
		bullet.SetVar('bullet_type', 1)
		table.insert(bullets,bullet)
		if bulletpos < numwebs then
			bulletpos = math.random(1, 3)
		else
			bulletpos = 1
		end
	end

	if spawntimer % 150 == 0 then
		local shiftx = math.random(0, 2) - 1
		local shifty = math.random(0, 2) - 1
		local warnx = shiftx*Arena.width/4
		local warny = shifty*Arena.height/4
		local warning = CreateProjectile('bolt_warning', warnx, warny)
		--warning.sprite.Scale(0.85, 0.85)
		warning.sprite.color = {0.85, 0.51, 0.21}
		--warning.sprite.SendToBottom()
		warning.SetVar('bullet_type', 0) --warning light type bullet
		warning.SetVar('lifetime', 45)
		table.insert(warnings, warning)
	end


	for i=1,#bullets do
		if side == 0 then
			bullets[i].Move(1,0)
		else
			bullets[i].Move(0,-1)
		end
		if bullets[i].x >= Arena.width/2 or bullets[i].y <= -Arena.height/2 then
			bullets[i].sprite.alpha = 0
		end
	end

	for j=1,#warnings do
		local warn = warnings[j]
		local life_left = warn.GetVar('lifetime')
		if life_left > 0 then
		warn.SetVar('lifetime', life_left - 1)
		elseif life_left == 0 then
			Create_knives(warn.x, warn.y)
			Create_More_Knives(warn.x,warn.y)
			warn.sprite.alpha = 0--warn.Remove()
			warn.SetVar('lifetime', -1)
		end
	end

	for k=1, #knives do
		local knife = knives[k]
		local ugol = knife.sprite.rotation
		local speed=knife.GetVar("speed")
		local dx = speed*math.cos(math.pi*ugol/180)
		local dy = speed*math.sin(math.pi*ugol/180)
		local new_x = knife.x+dx
		local new_y = knife.y+dy
		knife.MoveTo(new_x, new_y)
		if knife.x+34>Player.x and knife.x-34<Player.x and knife.x+34>Player.x and knife.x-34<Player.x then
			if collision.CheckCollision(Player, knife) and knife.sprite.alpha then
				KnifeHurt(1)
			end
		end
	end

end

function OnHit(bullet)
	local bullet_type = bullet.GetVar('bullet_type')
	if bullet_type == 1 then
		LongHurt(15,90)
	end
end