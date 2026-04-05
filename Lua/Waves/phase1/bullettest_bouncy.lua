-- The bouncing bullets attack from the documentation example.
spawntimer = 0
bullets = {}
lasers = {}
Arena.Resize(200,130)
require "Libraries/Playermove"
require "Libraries/hurt"

DoGhost("Asriel_Sprite",1,600)

require "Libraries/colortoys"

function Update()
HurtUpd(600)
Moving()
	spawntimer = spawntimer + 1

    if spawntimer%100 == 0   then
        local bullet1 = CreateProjectile('star', -Arena.width/2+5, Arena.height/2-5)
        bullet1.SetVar('color', 'white')
        bullet1.SetVar('velx', 2*math.random())
	bullet1.SetVar("time",0)
        bullet1.SetVar('vely', 0)
        bullet1.SetVar('isBullet', true)
        bullet1.SetVar('hue', math.random())
        table.insert(bullets, bullet1)
    end
    if spawntimer%100 == 50   then
        local bullet2 = CreateProjectile('star', Arena.width/2-5, Arena.height/2-5)
        bullet2.SetVar('color', 'white')
	bullet2.SetVar("time",0)
        bullet2.SetVar('velx', -2*math.random())
        bullet2.SetVar('vely', 0)
        bullet2.SetVar('isBullet', true)
        bullet2.SetVar('hue', math.random())
        table.insert(bullets, bullet2)
    end

    if spawntimer == 160 then
        local posx = -320
        local posy = 110
        local laser = CreateProjectile('laser0/laserv0', posx, posy)
	 laser.SetVar('color', 'blue')
	laser.sprite.color={0/255, 168/255, 242/255}
            laser.SetVar('velx', 6.0)
            laser.SetVar('vely', 0)
	 laser.SetVar('isBullet', true)
            table.insert(lasers, laser)
        end

	for i=1,#lasers do
		local laser = lasers[i]
		local velx = laser.GetVar('velx')
		local vely = laser.GetVar('vely')
		if laser.x > 330 or laser.x < -330 then
			velx = -velx
			laser.SetVar('velx', velx)
		end
		local newposx = laser.x + velx
		local newposy = laser.y + vely
		laser.MoveTo(newposx, newposy)
		laser.SetVar('vely', vely)
	end

    
    for i=1,#bullets do
        local bullet = bullets[i]
	local time=bullet.GetVar("time")+1
	bullet.SetVar("time",time)
        local velx = bullet.GetVar('velx')
        local vely = bullet.GetVar('vely')
	if time<300 then
		velx=velx*math.cos(time*math.pi/600)
		else
		velx=0
	end
        if(bullet.x+5 >Arena.width/2 or bullet.x -5<-Arena.width/2) then
		velx=-velx
		bullet.SetVar("velx",-bullet.GetVar("velx"))
	end
        if(bullet.y < -Arena.height/2 + 8) then 
            newposy = -Arena.height/2 + 8
            vely = -vely*0.95
        end
        
        local newposx = bullet.x + velx
        local newposy = bullet.y + vely
        vely = vely - 0.03
        bullet.MoveTo(newposx, newposy)
        bullet.SetVar('vely', vely)
        local hue = bullet.GetVar('hue')
	hue = hue+2*math.pi / 180
	if hue > math.pi * 2 then
		hue = hue - math.pi * 2
	end
        bullet.sprite.color = color_multiply(hsv_to_rgb(hue, 1.0, 0.70), 1.0)
        bullet.SetVar('hue', hue)
    end
end

function OnHit(bullet)
	local isBullet = bullet.GetVar('isBullet')
	if isBullet == true then
		if bullet.getVar('color') == 'white' then
			LongHurt(10,60)
		elseif (bullet.getVar('color') == 'blue') and isMoving() then
			LongHurt(20,60)
		end
	end
end