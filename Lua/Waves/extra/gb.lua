-- Sets a bullet's color as a string, then checks it in OnHit to achieve different types of bullet effects in one wave.
spawntimer = 0
bullets = {}
knifes = {}
colors = {"orange", "cyan"}
sprites = {"bone_orange", "bone_cyan"}

Arena.resize(140,40)


sans = CreateSprite("Sans_Sprite")
sans.SendToBottom()
sans.x = 250
sans.y = 365
sans.Scale(2.0, 2.0)
sans.alpha = 0.0


function Update()
    spawntimer = spawntimer + 1
    sans.alpha = 0.5*math.sin(spawntimer*math.pi/420)
    if spawntimer%50 == 0 then
        local posx = 500
        local posy = 0
        local bulletTypeNumber = math.random(#colors)
        local bulletType = colors[bulletTypeNumber]
        local bulletSprite = sprites[bulletTypeNumber]
        local bullet = CreateProjectile(bulletSprite, posx, posy)
        bullet.SetVar('color', bulletType)
        bullet.SetVar('velx', -4)
        bullet.SetVar('vely', 0)
        table.insert(bullets, bullet)
    end
	
	if spawntimer%90 == 0 then --ножи сверху
		local knife = CreateProjectile('KnifeDown', -400, 40)
		knife.SetVar('color', "white")
		table.insert(knifes, knife)
	end
	
	if (spawntimer+45)%90 == 0 then -- ножи снизу
		
		local knife = CreateProjectile('KnifeUp', -400, -30)
		knife.SetVar('color', "white")
		table.insert(knifes, knife)
	end
	
	for j=1,#knifes do
		local nozhik = knifes[j]
		nozhik.MoveTo(nozhik.x+2, nozhik.y)
	end

    for i=1,#bullets do
        local bullet = bullets[i]
        local velx = bullet.GetVar('velx')
        local vely = bullet.GetVar('vely')
        local newposx = bullet.x + velx
        local newposy = bullet.y + vely
        bullet.MoveTo(newposx-4, newposy)
        bullet.SetVar('vely', vely)
    end
	if spawntimer >= 600 then
		sans.Remove()
		EndWave()
	end
end


function OnHit(bullet) 
    local color = bullet.GetVar("color")
    local damage = 10
    if color == "cyan" and Player.isMoving then
        Player.Hurt(10)
    elseif color == "orange" and not Player.isMoving then
        Player.Hurt(10)
	elseif color == "white" then
		Player.Hurt(1, 0.01)
    end
end