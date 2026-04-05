Arena.ResizeImmediate(120,120)
Arena.Move(0,85,true,true)
require "Libraries/Playermove"
require "Libraries/hurt"
spawntime=0
knifes={}
local point=200/8
local startrot=math.random(2)
oldx=-3
oldy=-3

function DoKnifes()
	local rot=math.random(4)
	local rand=math.random(5)-3
	if startrot==2 then
		while rot%2==1 do
			rot=math.random(4)
		end
		while oldx==rand or oldx-rand>2 or oldx-rand<-2 do
			rand=math.random(5)-3
		end
		oldx=rand
		startrot=1
		else
		while rot%2==0 do
			rot=math.random(4)
		end
		while oldy==rand or oldy-rand>2 or oldy-rand<-2 do
			rand=math.random(5)-3
		end
		oldy=rand
		startrot=2
	end
	for i=-2,2 do
		local x=24*i
		if i==rand then
			else
			SendKnife(x,rot)
		end
	end
end

function SendKnife(x,side)
	local spr="KnifeDown"
	if side%2==1 then
		spr="KnifeLeft"
	end
	local knife=0
	if side%2==0 then
		knife=CreateProjectile(spr,x,200-200*(side-2))
		else
		knife=CreateProjectile(spr,200-200*(side-1),x)
	end
	if side>2 then
		knife.sprite.rotation=180
	end	
	knife.SetVar("i",i)
	knife.SetVar("time",0)
	knife.SetVar("side",side)	
	knife.SetVar("speed",speed)
	knife.sprite.alpha=0
	table.insert(knifes,knife)
end

function Update()
if spawntime%75==0 then
	DoKnifes()
end
HurtUpd(720)
Moving()
spawntime=spawntime+1
for i=1,#knifes do
	local k=knifes[i]
	if k.isactive then
		local time=k.GetVar("time")+1
		k.SetVar("time",time)
		local side=k.GetVar("side")
		if time>60 then
			if side%2==1 then
				local x=(200-336*math.sin((time-60)*math.pi/150))*(2-side)
				k.MoveTo(x,k.y)
				else
				local y=(200-336*math.sin((time-60)*math.pi/150))*(3-side)
				k.MoveTo(k.x,y)
			end
		end
		if time<31 then
			k.sprite.alpha=math.sin(time*math.pi/60)
			elseif time>180 and time<210 then
			k.sprite.alpha=math.sin((time-150)*math.pi/60)
			elseif time==210 then
			k.Remove()
		end
	end
end



end

function OnHit()
KnifeHurt(1)
Effects("curse",1)
end