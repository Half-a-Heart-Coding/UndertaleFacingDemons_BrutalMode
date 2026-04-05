-- Sets a bullet's color as a string, then checks it in OnHit to achieve different types of bullet effects in one wave.
spawntimer = 0
bullets = {}
knifes = {}
require "Libraries/Playermove"
require "Libraries/hurt"
colors = {"orange", "cyan"}
sprites = {"bone_orange", "bone_cyan"}

Arena.ResizeImmediate(150,60)
Player.MoveTo(0,0,true)

function Update()
HurtUpd(900)
Moving()
    spawntimer = spawntimer + 1
	
	if spawntimer%45 == 0 then
		local knife = CreateProjectile('KnifeDownLethal', -330, 40)
		knife.SetVar('color', "white")
		knife.SetVar("speed",{3,0})
		table.insert(knifes, knife)
	end
	
	if spawntimer%45 == 0 then
		local knife = CreateProjectile('KnifeUpLethal', -510, -30)
		knife.SetVar('color', "white")
		knife.SetVar("speed",{6,0})
		table.insert(knifes, knife)
	end
	
	for j=1,#knifes do
		local nozhik = knifes[j]
		local s=nozhik.GetVar("speed")
		nozhik.MoveTo(nozhik.x+s[1], nozhik.y+s[2])
	end
end


function OnHit(bullet) 
    local color = bullet.GetVar("color")
    local damage = 10
    if color == "white" then
		KnifeHurt(3)
    end
end