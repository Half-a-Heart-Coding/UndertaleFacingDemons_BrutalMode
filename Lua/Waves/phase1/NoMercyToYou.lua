shadealpha=0
knifes={}
require "Libraries/Playermove"
require "Libraries/hurt"
spawntime=100
poses={}
Arena.MoveToAndResize(320,210,220,60,true,true)
for i=1,10 do
	local k=CreateProjectile("KnifeDown",-110+(220/10)*(i-0.5),150)
	k.sprite.alpha=0
	k.SetVar("time",-60)
	k.SetVar("color","knife")
	knifes[i]=k
end

DoGhost("smile",0,600)
function Update()
spawntime=spawntime+1
if spawntime==1 then
	choises={}
	choises[1]=math.random(10)
	choises[2]=choises[1]
	while choises[1]==choises[2] do
		choises[2]=math.random(10)
	end
	choises[3]=math.random(10)
	while choises[3]==choises[2] or choises[1]==choises[3] do
		choises[3]=math.random(10)
	end
	
	knifes[choises[1]].SetVar("time",knifes[choises[1]].GetVar("time")+1)
	knifes[choises[2]].SetVar("time",knifes[choises[2]].GetVar("time")+1)
	knifes[choises[3]].SetVar("time",knifes[choises[3]].GetVar("time")+1)
	knifes[choises[1]].SetVar("side",math.random(2)*2-3)
	knifes[choises[2]].SetVar("side",math.random(2)*2-3)
	knifes[choises[3]].SetVar("side",math.random(2)*2-3)
	elseif spawntime==16 then
	for i=1,10 do
		if i==choises[1] or i==choises[2] then
			else
			knifes[i].SetVar("time",knifes[i].GetVar("time")+1)
			knifes[i].SetVar("side",math.random(2)*2-3)
		end
	end
end
HurtUpd(600)
Moving()
local count=0
for i=1,#knifes do
	local k=knifes[i]
	if k.isactive then
		local time=k.GetVar("time")
		local side=k.GetVar("side")
		if time<0 then
			time=time+1
			k.sprite.alpha=math.sin((60+time)*math.pi/120)
			elseif time%210==0 then
			count=count+1
			elseif time%210==105 then
			count=count+1
			elseif time%210>90 and time%210<105 then
			time=time+1
			k.sprite.rotation=(90-90*math.cos((time%210-90)*math.pi/15))*side
			elseif time%210>195 and time%210<210 then
			time=time+1
			k.sprite.rotation=(90+90*math.cos((time%210-195)*math.pi/15))*side
			else
			time=time+1
			local t=time%210
			if t>100 then
				t=t-15
			end
			local cos=math.abs(math.cos(t*math.pi/90))
			cos=math.sqrt(cos)
			if t>45 and t<135 then
				cos=-cos
			end
			k.MoveTo(k.x,150*cos)
		end
		k.SetVar("time",time)
	end
end
if count==10 and spawntime>40 then
	spawntime=0
end
end

function OnHit(b)
	if b.GetVar("color")=="knife" then
		KnifeHurt(1)
	end
end