Arena.ResizeImmediate(125,125)
require "Libraries/Playermove"
require "Libraries/hurt"
spawntime=0
knifes={}
amm=1
sides={}
Player.MoveTo(0,0,true)
rotated=0


function DoRow(side)
	local rand=math.random(5)-3
	for i=-2,2 do
		local x=25*i
		local y=160
		local knife
		if side==1 then
			knife=CreateProjectile("KnifeDown",x,y)
			knife.SetVar("speed",{0,-1})
			elseif side==2 then
			knife=CreateProjectile("KnifeRight",-y,x)
			knife.SetVar("speed",{1,0})
			elseif side==3 then
			knife=CreateProjectile("KnifeUp",x,-y)
			knife.SetVar("speed",{0,1})
			elseif side==4 then
			knife=CreateProjectile("KnifeLeft",y,x)
			knife.SetVar("speed",{-1,0})
		end
		if rand==i then
			knife.SetVar("time",0)
			knife.SetVar("stime",0)
			else
			knife.SetVar("time",-30)
			knife.SetVar("stime",30)
		end
		knife.SetVar("firing",false)
		knife.sprite.alpha=0
		table.insert(knifes,knife)
	end
end
function Update()
HurtUpd(780)
Moving()
spawntime=spawntime+1

if spawntime==30 then
	DoRow(1)
	elseif spawntime==120 then
	DoRow(2)
	elseif spawntime==210 then
	DoRow(3)
	elseif spawntime==300 then
	DoRow(4)
end
for i=1,#knifes do
	local k=knifes[i]
	if k.isactive then
		local time=k.GetVar("time")+1
		local st=k.GetVar("stime")
		k.SetVar("time",time)
		local s=k.GetVar("speed")
		if time>0 and time<31 then
			local sin=3*math.cos(time*math.pi/60)
			k.Move(s[1]*sin,s[2]*sin)
			k.sprite.alpha=math.sin(time*math.pi/60)
		end
		if time+st>300 then
			if time+st<360 then
				local sin=1.5*math.cos(((time+st)-300)*math.pi/120)
				k.Move(-s[1]*sin,-s[2]*sin)
				elseif time>360 then
				k.Move(s[1]*5,s[2]*5)
			end
		end
	end
end
end

function OnHit()
KnifeHurt(1)
end