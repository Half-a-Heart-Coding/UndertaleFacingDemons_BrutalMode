collision = require "Libraries/rotational_collision"
require "Libraries/Playermove"
require "Libraries/hurt"
phase = 1
spawnTimer = -20
Arena.ResizeImmediate(350, 120)
bullets = {}
knives = {}
timer={}

redknife_u = CreateProjectile ("KnifeDown",-600,-600)
redknife_u.sprite.alpha = 0
redknife_u.SetVar('isBullet', true)

redknife_d = CreateProjectile ("KnifeUp",-600,-600)
redknife_d.SetVar('isBullet', true)

redknife_l = CreateProjectile ("KnifeRight",-600,-600)
redknife_l.SetVar('isBullet', true)

redknife_r = CreateProjectile ("KnifeLeft",-600,-600)
redknife_r.SetVar('isBullet', true)


undyne = CreateSprite("Undyne_Sprite")
undyne.SendToBottom()
undyne.x = 220
undyne.y = 370
undyne.Scale(2, 2)
undyne.alpha = 0.0
battlesprites={}
table.insert(battlesprites,undyne)


function Update()

HurtUpd(9999999)
if phase==1 or phase==3 then
	Moving()
end
	spawnTimer = spawnTimer + 1
	undyne.alpha = 0.5*math.sin(spawnTimer*math.pi/490)
	if spawnTimer<246   then
  		undyne.x = 330+90*math.sin(spawnTimer*math.pi/490)
  		else undyne.x = 510-90*math.sin(spawnTimer*math.pi/490)
	end
	if spawnTimer == 140 then
		phase = 2

		Arena.ResizeImmediate(75, 75)
		cover = CreateProjectile("green/cover",0,0)
		fakearena = CreateProjectile("green/fakearena",0,105)
		Player.MoveTo(0,0,true)
		shield = CreateProjectile("green/shield",0,105)
		hitTimer = -2
		shielddir = 1
		i = 0

		basespawn = 140 -- The time at which the first projectile spawns
		spawnIncrement = 15 -- The amount of time between projectile spawns
		maxbullets = 12 -- The total amaunt of bullets in the wave
		bulletdirs = {1,2,3,0,3,2,1,0,1,2,3,0} -- Can be used to set the directions of an entire wave
		bulletspeeds = {} -- Can be used to set varying speeds for an entire wave
		damage = 3 -- The damage of projectiles in this wave
		bulletTracking = true -- Determines weather or not the closest arrow will be red
	end

--	if spawnTimer == 450 then
--		phase = 3
--	end

	if spawnTimer == 490 then
		undyne.Remove()
		EndWave()
	end

	if phase == 1 then
		local time=spawnTimer+20
		if time % 10 == 0 and time < 100 then
			local greenknife_x = 180-20*(time/10)
			local greenknife_y = Arena.height / 2 + 37
			if greenknife_x == 0 then
				local mv_tp = math.random(2)
				local greenknife = CreateProjectile("speardown", greenknife_x, greenknife_y)
				if mv_tp == 1 then 
					greenknife.sprite.color = {0/255, 162/255, 232/255} 
					else greenknife.sprite.color = {255/255, 154/255, 34/255}
				end
				greenknife.sprite.alpha=0
				greenknife.SetVar('isBullet', true)
				greenknife.SetVar('type', mv_tp)
				table.insert(knives, greenknife)
				else
				local greenknife1 = CreateProjectile("speardown", greenknife_x, greenknife_y)
				local greenknife2 = CreateProjectile("speardown", -greenknife_x, greenknife_y)
				greenknife1.SetVar('isBullet', true)
				greenknife2.SetVar('isBullet', true)
				greenknife1.SetVar('type', 0)
				greenknife2.SetVar('type', 0)
				greenknife1.sprite.alpha=0
				greenknife2.sprite.alpha=0
				table.insert(knives, greenknife1)
				table.insert(knives, greenknife2)
			end
		end
	end

	for i=1,#knives do
		local knife= knives[i]
		if not timer[i] then
			timer[i]=0
		end
		if knife.isactive then
			knife.MoveTo(knife.x, knife.y-4)
			timer[i]=timer[i]+1
			if timer[i]<21 then
				knife.sprite.alpha=math.sin(timer[i]*math.pi/40)
			end
			if knife.x+14>Player.x and knife.x-14<Player.x and knife.y+36>Player.y and knife.y-36<Player.y then
				if (knife.GetVar("type")==1 and isMoving()) or (knife.GetVar("type")==2 and not isMoving()) or  knife.GetVar("type")==0 then
					KnifeHurt(1)
				end
			end
			if knife.y<-300 then
				knife.Remove()
			end
		end
	end
	
	if redknife_u.sprite.alpha == 1 then
		redknife_u.MoveTo(redknife_u.x, redknife_u.y-5)
		redknife_d.MoveTo(redknife_d.x, redknife_d.y+5)
		redknife_l.MoveTo(redknife_l.x+5, redknife_l.y)
		redknife_r.MoveTo(redknife_r.x-5, redknife_r.y)
		local knify={redknife_u,redknife_d,redknife_l,redknife_r}
		for i=1,#knify do
			local knife=knify[i]
			if knife.x+36>Player.x and knife.x-36<Player.x and knife.y+36>Player.y and knife.y-36<Player.y then
				if collision.CheckCollision(Player,knife) then
					KnifeHurt(1)
				end
			end
		end
	end

	--Bullet Creation
	if phase == 2 then
		if spawnTimer == basespawn then --Bullet Directions 0,Right 1,Down 2,Left 3,Up
			i = i + 1
			if i <= maxbullets then
				basespawn = basespawn + spawnIncrement
				bulletDirection = bulletdirs[i]
				bulletSpeed = 9 -- this is using a fixed speed
				CreateBullet()
			end
		end
	

	
	--Shield Inputs
	if Input.Left == 1 then
		shielddir = 0
		shield.sprite.rotation = 90
	elseif Input.Up == 1 then
		shielddir = 1
		shield.sprite.rotation = 0
	elseif Input.Right == 1 then
		shielddir = 2
		shield.sprite.rotation = -90
	elseif Input.Down == 1 then
		shielddir = 3
		shield.sprite.rotation = 180
	end
	
	--Hit Time
	if hitTimer == -1 then
		shield.sprite.Set("green/shield")
	end
	hitTimer = hitTimer -1
	
	--Bullet Management
	bulletDistance = math.huge
	for i=1,#bullets do
		local bullet = bullets[i]
		local dir = bullet.GetVar("dir")
		--Bullet Tracking
		if bulletTracking then
			local distanceFromCentre = math.pow(bullet.x,2)+math.pow(bullet.y-105,2)
			if distanceFromCentre <= bulletDistance then
				nearest = i
				bulletDistance = distanceFromCentre
			end
		end
		--Hit Detection
		if dir == 0 then
			if bullet.x < -30 and bullet.x > -40 and shielddir == 0 then
				Hit()
				bullet.MoveTo(400,400)
				bullet.SetVar("speed",0)
			elseif bullet.x >= -20  and bullet.x < -10 then
				KnifeHurt(damage)
				bullet.MoveTo(400,400)
				bullet.SetVar("speed",0)
			end
		elseif dir == 1 then
			if bullet.y > 135 and bullet.y < 145 and shielddir == 1 then
				Hit()
				bullet.MoveTo(400,400)
				bullet.SetVar("speed",0)
			elseif bullet.y <= 125  and bullet.y > 115 then
				KnifeHurt(damage)
				bullet.MoveTo(400,400)
				bullet.SetVar("speed",0)
			end
		elseif dir == 2 then
			if bullet.x > 30 and bullet.x < 40 and shielddir == 2 then
				Hit()
				bullet.MoveTo(400,400)
				bullet.SetVar("speed",0)
			elseif bullet.x <= 20  and bullet.x > 10 then
				KnifeHurt(damage)
				bullet.MoveTo(400,400)
				bullet.SetVar("speed",0)
			end
		elseif dir == 3 then
			if bullet.y < 75 and bullet.y > 65 and shielddir == 3 then
				Hit()
				bullet.MoveTo(400,400)
				bullet.SetVar("speed",0)
			elseif bullet.y >= 85  and bullet.y < 95 then
				KnifeHurt(damage)
				bullet.MoveTo(400,400)
				bullet.SetVar("speed",0)
			end
		end
		--Handle Movement
		local speed = bullet.GetVar("speed")
		if speed == 0 then
			--Nothing Here
		elseif dir == 0 then
			bullet.MoveTo(bullet.x+speed,bullet.y)
		elseif dir == 1 then
			bullet.MoveTo(bullet.x,bullet.y-speed)
		elseif dir == 2 then
			bullet.MoveTo(bullet.x-speed,bullet.y)
		elseif dir == 3 then
			bullet.MoveTo(bullet.x,bullet.y+speed)
		end
	end
	--Turn Arrow Red
	if #bullets > 0 then
		bullets[nearest].sprite.Set("green/arrownearest")
	end
	--Ending Management
	passed = 0
	if not checked then
		if #bullets > 1 then
			for i=1, #bullets do
				local bullet = bullets[i]
				if bullet.x == 400 and bullet.y == 400 then
					passed = passed + 1
				end
			end
			if passed == #bullets then
				phase = 3
				cover.Remove()
				fakearena.Remove()
				shield.Remove()
				redknife_u.MoveTo(0,200)
				redknife_d.MoveTo(0,-200)
				redknife_l.MoveTo(-200,0)
				redknife_r.MoveTo(200,0)
				redknife_u.sprite.alpha = 1
				Player.MoveTo(0,0,false)
			end
		end
	end
	end



end

function OnHit(bullet)
end

--Bullet Creation
function CreateBullet ()
	if bulletDirection == 0 then
		bulletRotation = 90
		arrow = CreateProjectile ("green/arrow",-300,105)
	elseif bulletDirection == 1 then
		bulletRotation = 0
		arrow = CreateProjectile ("green/arrow",0,405)
	elseif bulletDirection == 2 then
		bulletRotation = -90
		arrow = CreateProjectile ("green/arrow",300,105)
	elseif bulletDirection == 3 then
		bulletRotation = 180
		arrow = CreateProjectile ("green/arrow",0,-195)
	end
	arrow.SetVar("speed", bulletSpeed)
	arrow.SetVar("dir", bulletDirection)
	arrow.sprite.rotation = bulletRotation
	table.insert(bullets,arrow)
end

function Hit()
	Audio.PlaySound("ding")
	shield.sprite.Set("green/shield_hit")
	hitTimer = 15
end