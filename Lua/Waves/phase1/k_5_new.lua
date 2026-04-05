Arena.ResizeImmediate(200, 128)
spawntimer = 0
k1 = {}
k2 = {}
require "Libraries/Playermove"
require "Libraries/hurt"


function SendKnife(name,pos,speed)
	local k=CreateProjectile(name,pos[1],pos[2])
	k.SetVar("speed",speed)
	k.SetVar("time",0)
	k.sprite.alpha=0
	k.SetVar("color","knife")
	table.insert(k1,k)
end

function Update() 

	HurtUpd(660)
	Moving()
	spawntimer = spawntimer + 1
	
	if spawntimer % 60 == 0 then
		if (spawntimer/60)%6<3 then
			SendKnife("KnifeDown",{201,32},{-2.5,0})
			SendKnife("KnifeUp",{-201,-32},{2.5,0})
			if (spawntimer/60)%6==2 then
				spawntimer=spawntimer+25
			end
			else
			SendKnife("KnifeUp",{201,-32},{-2.5,0})
			SendKnife("KnifeDown",{-201,32},{2.5,0})
			if (spawntimer/60)%6==5 then
				spawntimer=spawntimer+25
			end
		end
	end
	for k=1,#k1 do
		local k = k1[k]
		if k.isactive then
			local time=k.GetVar("time")+1
			k.SetVar("time",time)
			local speed=k.GetVar("speed")
	    		k.Move(speed[1],speed[2])
			if time<31 then
				k.sprite.alpha=math.sin(time*math.pi/60)
				elseif time>130 and time<160 then
				k.sprite.alpha=math.sin((time-100)*math.pi/60)
				elseif time==160 then
				k.Remove()
			end
		end
	end

end 

function OnHit(bullet)
local color = bullet.GetVar("color")	
    if color == "knife" then
		KnifeHurt(1)
	end
end