bullets = {}
knife1 = {}
knife2 = {}
spawntimer = 0
Arena.Resize(240, 52)
bones = {} 
bones1 = {}
blue = require "blue"
Player.sprite.color = {0.0, 0.0, 0.7}
blue.TurnBlue(true)
blue.WaveStart()

sans = CreateSprite("Sans_Sprite")
sans.SendToBottom()
sans.x = 250
sans.y = 365
sans.Scale(2.0, 2.0)
sans.alpha = 0.0


function Update()

spawntimer = 1 + spawntimer
sans.alpha = 0.5*math.sin(spawntimer*math.pi/420)
blue.HandleMovement()

	if spawntimer % 60 == 0 then 
		bone = CreateProjectile('bone', 150, 20) 
		bone3 = CreateProjectile('bone', 150, -20) 
		table.insert(bones, bone) 
		table.insert(bones, bone3)
	end
	
	if spawntimer % 60 == 0 then 
		bone1 = CreateProjectile('bone', -150, -20) 
		bone2 = CreateProjectile('bone', -150, 20)
		table.insert(bones1, bone1)
		table.insert(bones1, bone2)
	end 	
	
	if spawntimer % 120 == 0 then 
		k1 = CreateProjectile('KnifeRight', -400, 0) 
		k2 = CreateProjectile('KnifeLeft', 400, 0) 
		table.insert(knife1, k1) 
		table.insert(knife2, k2) 
	end 
	
	for j=1, #knife1 do 
		local j1 = knife1[j] 
		j1.MoveTo(j1.x+9, j1.y)
		j1.SetVar("color", "knife")
	end 
	
	for k=1, #knife2 do 
		local k1 = knife2[k] 
		k1.MoveTo(k1.x-9, k1.y)
		k1.SetVar("color", "knife")
	end 
	
	for b=1,#bones do
		local b1 = bones[b]
		b1.MoveTo(b1.x-2.2, b1.y)
		b1.SetVar("color", "white")
	end	
	
	for h=1,#bones1 do
		local b2 = bones1[h]
		b2.MoveTo(b2.x+2.2, b2.y)
		b2.SetVar("color", "white")
	end	
	
if spawntimer >= 600 then
	sans.Remove()
	EndWave()
	Player.sprite.color = {1, 0.0, 0.0}
end
end

function OnHit(bullet)
	local color = bullet.GetVar("color")
	if color == "knife" then 
		Player.Hurt(1, 0.001)
	elseif color == "white" then
		Player.Hurt(1, 0.1) 
	end
end 