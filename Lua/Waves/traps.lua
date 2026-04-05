
require "Libraries/Playermove"
require "Libraries/hurt"
spawntime=0
trapstime=0
traps={}
knifes={}
trapspos={}
Arena.ResizeImmediate(300,64)
for i=1,15 do
	trapspos[i]=false
end
manyknifes=0

function DoTrap()
	local ingo=false
	local pos=0
	local usedpos=0
	for i=1,15 do
		if trapspos[i]==true then
			usedpos=usedpos+1
		end
	end
	if usedpos<15 then
		while ingo==false do
			ingo=true
			pos=math.random(15)
			if trapspos[pos]==false then
				trapspos[pos]=true
				else
				ingo=false
			end
		end
		local knife=CreateProjectile("KnifeDown",pos*20-160,96)
		knife.SetVar("time",0)
		knife.SetVar("pos",pos)
		knife.sprite.alpha=0
		table.insert(traps,knife)
		manyknifes=manyknifes+1
	end
end

function DoKnife(ingo)
	local y=math.random(65)-33
	local knife=CreateProjectile("KnifeRight",ingo*352,y)
	knife.sprite.rotation=90+90*ingo
	knife.SetVar("x",-ingo*6)
	table.insert(knifes,knife)
end

function Update()
HurtUpd(900)
Moving()
spawntime=spawntime+1
if spawntime%90==1 then
	DoKnife(-1)
	elseif spawntime%90==46 then
	DoKnife(1)
end
trapstime=trapstime+1
local limit=60
if spawntime<60 then
	limit=10
	elseif spawntime<120 then
	limit=20
	elseif spawntime<180 then
	limit=30
	elseif spawntime<300 then
	limit=45
end	

if trapstime>limit then
	DoTrap()
	trapstime=trapstime-limit
end
for i=1,#knifes do
	local k=knifes[i]
	if k.isactive then
		k.Move(k.GetVar("x"),0)
		if Player.x>k.x-36 and Player.x<k.x+36 and Player.y>k.y-14 and Player.y<k.y+14 then
			KnifeHurt(1)
		end
		if k.x>360 or k.x<-360 then
			k.Remove()
		end
	end
end
for i=1,#traps do
	local k=traps[i]
	if k.isactive then
		local time=k.GetVar("time")+1
		k.SetVar("time",time)
		if time==1 then
			local pix=CreateProjectile("bomb",k.x,k.y-250,"BelowPlayer")
			pix.sprite.Scale(2,100)
			k.SetVar("pix",pix)
			pix.sprite.alpha=0
			pix.sprite.color={0.25,0,0}
		end
		local pix=k.GetVar("pix")
		pix.MoveTo(k.x,k.y-250)
		if time<91 then
			k.MoveTo(k.x,128-64*math.sin(time*math.pi/180))
			k.sprite.alpha=math.sin(time*math.pi/180)
			if time>45 then
				pix.sprite.alpha=math.sin((time-45)*math.pi/90)
			end
			elseif time==91 then
			if Player.x>k.x-12 and Player.x<k.x+12 then
				Audio.PlaySound("ding")
				pix.sprite.color={0.75,0,0}
				else
				k.SetVar("time",90)
			end
			elseif time<121 then
			k.MoveTo(k.x,64+64*math.sin((time-90)*math.pi/60))
			pix.sprite.color={0.25+0.5*time%2,0,0}
			pix.sprite.alpha=0.5*(120-time)/30
			elseif time<136 then
			k.MoveTo(k.x,128-128*math.sin((time-120)*math.pi/30))
			elseif time>195 and time<226 then
			k.sprite.alpha=math.cos((time-195)*math.pi/60)
			elseif time==226 then
			pix.Remove()
			trapspos[k.GetVar("pos")]=false
			k.Remove()
			manyknifes=manyknifes-1
		end
		if time<195 then
			pix.MoveTo(k.x,k.y-250)
		end
		if time<205 then
			if Player.x>k.x-14 and Player.x<k.x+14 and Player.y>k.y-36 and Player.y<k.y+36 then
				KnifeHurt(1)
			end
		end
	end
end
end


function OnHit()
end