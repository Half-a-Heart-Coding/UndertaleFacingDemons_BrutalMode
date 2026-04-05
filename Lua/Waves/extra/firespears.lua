num_spears = 0
spears = {}
bullets = {}
starttime = Time.time
spawntimer = 0

require "Libraries/hurt"
burn=0
burntime=0
Player.SetControlOverride(true)
Player_speedy=0.15
Player_speedx=0.15

Arena.Resize(300, 150)

toriel = CreateSprite("Toriel_Sprite")
toriel.SendToBottom()
toriel.x = 400
toriel.y = 360
toriel.Scale(2, 2)
toriel.alpha = 0.0
BR=CreateProjectile("system/BR",209.5,-125)

function SpawnSpear()
	spawny = 220
	starttime = Time.time
	for i=1, 3 do
		local spawnx = 30*i - 60 -- ух, вот это костыль!
		local spearpos = Player.x + spawnx
		local angle = -5*i + 10
		local borntime = Time.time+i*0.1
		spear = CreateProjectile('vert_spear', spearpos, spawny) -- свой спрайт нужно вставлять здесь.
		spear.SetVar("posx", spearpos)
		spear.SetVar("color","spear")
		spear.SetVar("posy", spawny)
		spear.SetVar("angle", angle)
		spear.SetVar("timeoflife", borntime)
		spear.sprite.rotation = angle
		num_spears = num_spears+1
		table.insert(spears, spear)
	end
end

function MoveSpear(spear)
	local ugol = spear.GetVar("angle")
	local vremya = spear.GetVar("timeoflife")
	local evaluatetime = Time.time - vremya
	if evaluatetime > 0.1 then
		local dx = 5.0*math.sin(math.pi*ugol/180)
		local dy = -5.0*math.cos(math.pi*ugol/180)
		local new_x = spear.x+dx
		local new_y = spear.y+dy
		spear.MoveTo(new_x, new_y)
	end
end


function CheckSpear(spear)
	local posx = spear.x
	local posy = spear.y
	if (posy < -Arena.height/2 + 8 and posy > -Arena.height/2 + 3) then
		spear.sprite.alpha = 0
		local bullet = CreateProjectile('bullet', posx, posy)
		bullet.SetVar("color","fire")
		bullet.SetVar('vely', 0)
		bullet.SetVar('velx', 1 - 2*math.random())
		table.insert(bullets, bullet)
	end
end


function Update()
HurtUpd(450)
hue=0.90-0.1*math.sin(math.pi*spawntimer/30)
BR.sprite.color ={1*hue,0.5*hue,0.15234375*hue}
	if Input.Up>0 then 
	   Player.MoveTo(Player.x,Player.y+Player_speedy,false)
	end
	if Input.Right>0  then
	   Player.MoveTo(Player.x+Player_speedx,Player.y,false)
	end
	if Input.Left>0   then
	   Player.MoveTo(Player.x-Player_speedx,Player.y,false)
	end 
	if Input.Down>0   then
	   Player.MoveTo(Player.x,Player.y-Player_speedy,false)
	end
	spawntimer = spawntimer + 1
	toriel.alpha = 0.5*math.sin(spawntimer*math.pi/410)

	attacktime = Time.time - starttime

	if attacktime > 0.73 then
		SpawnSpear()
	end

	for j=1, num_spears do
		local spear = spears[j]
		MoveSpear(spear)
		CheckSpear(spear)
   	end

    for i=1,#bullets do
        local bullet = bullets[i]
        local velx = bullet.GetVar('velx')
        local vely = bullet.GetVar('vely')
        local newposx = bullet.x + velx
        local newposy = bullet.y + vely
        if(bullet.x > -Arena.width/2 and bullet.x < Arena.width/2) then
            if(bullet.y < -Arena.height/2 + 8) then 
                newposy = -Arena.height/2 + 8
                vely = 2 + math.random()
            end
        end
	bullet.sprite.color={1*hue,0.5*hue,0.127*hue}
        vely = vely - 0.04
        bullet.MoveTo(newposx, newposy)
        bullet.SetVar('vely', vely)
    end
BR.MoveTo(BR.x,-Arena.height/2-25)
if GetGlobal("burn")<50 then
   Player_speedx=2+1.5*math.sin(GetGlobal("burn")*math.pi/100)
   Player_speedy=2+1.5*math.sin(GetGlobal("burn")*math.pi/100)
end
end
function OnHit(attack)
	local burn=GetGlobal("burn")
	if attack.GetVar("color")=="spear" then
		LongHurt(20,60)
		elseif attack.GetVar("color")=="fire" then
		LongHurt(1,5)
		Effects("burn",1)
	end
end