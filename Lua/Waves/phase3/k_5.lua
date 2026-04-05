Arena.Resize(200, 128)
spawntimer = 0
k1 = {}
k2 = {}
require "Libraries/Playermove"
require "Libraries/hurt"

function Update() 

HurtUpd(600)
Moving()
	spawntimer = spawntimer + 1
	
	if spawntimer % 50 == 0 then 
		kD = CreateProjectile ('KnifeDown', 200, 32)
		kU = CreateProjectile ('KnifeUp', -200, -32)
		table.insert (k1, kD)
		table.insert (k2, kU)
	end 
	
	for k=1,#k1 do
    	    local kn1 = k1[k]
    	    kn1.MoveTo(kn1.x-3, kn1.y)
			kn1.SetVar("color", "white")
	end
	
	for d=1,#k2 do
    	    local kn2 = k2[d]
    	    kn2.MoveTo(kn2.x+3, kn2.y)
			kn2.SetVar("color", "white")
	end

end 

function OnHit(bullet)
local color = bullet.GetVar("color")	
    if color == "white" then
		KnifeHurt(1)
	end
end