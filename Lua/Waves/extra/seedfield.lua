-- Атака создаёт плотное поле из семян. Через 2 секунды после создания они начинают двигаться.
Arena.Resize(400, 200)

timer = 0
x_step = 35 --промежуток между пулями
y_step = 35
x_row = 10 -- количество столбцов
y_row = 10 -- рядов
bullets = {}
num_bullets = 0
angle = 0
posx = 0
posy = 0

flowey = CreateSprite("Flowey_Sprite")
flowey.SendToBottom()
flowey.x = 380
flowey.y = 370
flowey.Scale(2, 2)
flowey.alpha = 0.0

initialx = -Arena.width/2+x_step/2
initialy = -Arena.height/2-y_step/2
angleshift = math.random(360)

function CreateBullets(num_bullets)
	posx = (num_bullets%x_row)*x_step + initialx
	posy = math.ceil(num_bullets/y_row)*y_step + initialy
	angle = angleshift+timer*3--Time.time*360
	bullet = CreateProjectile('pellet', posx, posy)
	bullet.SetVar("angle", angle)
	table.insert(bullets, bullet)
	bullet.sprite.rotation = angle
end



function MoveBullets(bullet)
	local ugol = bullet.GetVar("angle")
	local dx = 0.006*timer*math.sin(math.pi*ugol/180)
	local dy = -0.006*timer*math.cos(math.pi*ugol/180)
	local new_x = bullet.x+dx
	local new_y = bullet.y+dy
	bullet.MoveTo(new_x, new_y)
end




function Update()
	if timer%2 == 0 and timer < 120 then --
		num_bullets = num_bullets+1
		CreateBullets(num_bullets)
	end

	if timer > 120 then
		for j=1, num_bullets do
			local bullet = bullets[j]
			MoveBullets(bullet)
		end
	end

	timer = timer + 1
	flowey.alpha = 0.5*math.sin(timer*math.pi/360)
	if timer == 420 then
		flowey.Remove()
		EndWave()
	end

end

function OnHit()
        Player.Hurt(1, 0.0001)
end