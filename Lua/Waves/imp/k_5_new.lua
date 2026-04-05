Arena.ResizeImmediate(174, 104)
spawntimer = 0
k1 = {}
k2 = {}
require "Libraries/Playermove"
require "Libraries/hurt"


function SendKnife(name,pos,speed)
	if GetGlobal("DifficultyPoints") >= 621 then
		name=name.."Fatal"
	end
	local k=CreateProjectile(name,pos[1],pos[2])
	k.SetVar("speed",speed)
	k.SetVar("time",0)
	k.sprite.alpha=0
	k.SetVar("color","knife")
	table.insert(k1,k)
end

function SendKnife2(name,pos,speed)
	if GetGlobal("DifficultyPoints") >= 621 then
		name=name.."Fatal"
	end
	local k=CreateProjectile(name,pos[1],pos[2])
	k.SetVar("speed",speed)
	k.SetVar("time",0)
	k.sprite.alpha=0
	--k.sprite.color={0,0,1}
	k.SetVar("color","blue")
	table.insert(k1,k)
end

function SendKnife3(name,pos,speed)
	if GetGlobal("DifficultyPoints") >= 621 then
		name=name.."Fatal"
	end
	local k=CreateProjectile(name,pos[1],pos[2])
	k.SetVar("speed",speed)
	k.SetVar("time",0)
	k.sprite.alpha=0
	--k.sprite.color={1,0.5,0}
	k.SetVar("color","orange")
	table.insert(k1,k)
end

function Update() 

	HurtUpd(900)
	Moving()
	spawntimer = spawntimer + 1
	
	if spawntimer % 60 == 0 and spawntimer < 450 then
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

	if spawntimer % 46 == 0 and spawntimer > 450 then
		if (spawntimer/46)%6<3 then
			SendKnife("KnifeDown",{201,32},{-2.5,0})
			SendKnife("KnifeUp",{-201,-32},{2.5,0})
			if (spawntimer/46)%6==2 then
				spawntimer=spawntimer+25
			end
			else
			SendKnife("KnifeUp",{201,-32},{-2.5,0})
			SendKnife("KnifeDown",{-201,32},{2.5,0})
			if (spawntimer/46)%6==5 then
				spawntimer=spawntimer+25
			end
		end
	end

	if spawntimer % 90 == 0 and spawntimer < 450 then
		if (spawntimer/90)%6<2 then
			if (spawntimer/90)%6 <= 1 and math.random(4) ~= 1 then
				SendKnife2("KnifeDownblue",{201,32},{-3.5,0})
			else
				SendKnife3("KnifeDownOrange",{201,32},{-3.5,0})
			end
			if (spawntimer/90)%6==2 then
				spawntimer=spawntimer+25
			end
		else
			if (spawntimer/90)%6 <= 3 and math.random(4) ~= 1 then
				SendKnife2("KnifeUpblue",{201,-32},{-3.5,0})
			else
				SendKnife3("KnifeUpOrange",{201,-32},{-3.5,0})
			end
			if (spawntimer/90)%6==5 then
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
	elseif color == "orange" and not isMoving() then
		KnifeHurt(1)
	elseif color == "blue" and isMoving() then
		KnifeHurt(1)
	end
end