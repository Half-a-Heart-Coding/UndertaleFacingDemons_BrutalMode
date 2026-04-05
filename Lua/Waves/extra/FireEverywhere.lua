
require "Libraries/Playermove"
require "Libraries/hurt"
knifes={}
sidespears={}
spawntime=0
random=math.random(2)*2-3
ManyKnifes=1
Arena.ResizeImmediate(176,224)
Player.MoveTo(0,0)
function Update()
spawntime=spawntime+1
for i=1,#knifes do
	local k=knifes[i]
	if k.isactive then
		local time=k.GetVar("time")+1
		k.SetVar("time",time)
		if time<31 then
			k.sprite.alpha=math.sin(time*math.pi/60)
		end
		--[[if time<46 then
			k.Move(k.GetVar("x")*2,0)
			else
			k.Move(k.GetVar("x"),0)
		end]]
		k.Move(k.GetVar("x"),0)
		if k.x>400 or k.x<-400 then
			--k.Remove()
		end
	end
end
if spawntime%120==1 then
	local n=(((((spawntime-1)/120)%2)+1)*2-3)*random
	SendWall(n,ManyKnifes)
	ManyKnifes=ManyKnifes+1
end
for i=1,#sidespears do
	local s=sidespears[i]
	if s.isactive then
		local time=s.GetVar("time")+1
		s.SetVar("time",time)
		if time<46 then
			s.sprite.alpha=math.sin(time*math.pi/90)
			elseif time<91 then
			s.Move(s.GetVar("x"),0)
			elseif time>110 and time<120 then
			local sin=math.sin((time-100)*math.pi/20)
			s.sprite.alpha=sin
			if sin<0.5 then
				s.SetVar("color","none")
			end
			elseif time==120 then
			s.Remove()
		end
	end
end
HurtUpd(600)
Moving()
end

function SendWall(side,ammount)
	local Rand=math.random(2)
	for i=1,8 do
		local spear=CreateProjectile("ToriSpear1",side*176,-126+i*28,"Top")
		spear.sprite.Scale(2,2)
		if side==1 then
			spear.sprite.rotation=180
		end
		if (i+Rand)%2==1 then
			spear.SetVar("color","blue")
			spear.sprite.color={0.5,0.5,1}
			else
			spear.SetVar("color","orange")
			spear.sprite.color={1,0.4,0}
		end
		spear.sprite.alpha=0
		spear.SetVar("time",0)
		spear.SetVar("damage",15)
		spear.SetVar("hurttime",30)
		spear.SetVar("x",-4*side)
		table.insert(sidespears,spear)
	end
	local pos={}
	local amm=0
	while amm<ammount do
		amm=amm+1
		pos[amm]=math.random(8)
		for i=1,amm-1 do
			if pos[i]==pos[amm] then
				amm=amm-1
			end
		end
	end
	for i=1,ammount do
		local knife=CreateProjectile("KnifeRight",356*side,-126+pos[i]*28)
		knife.SetVar("time",0)
		knife.sprite.alpha=1
		knife.SetVar("color","knife")
		if side==1 then
			knife.sprite.rotation=180
		end
		knife.SetVar("x",-4*side)
		table.insert(knifes,knife)
	end
end
function OnHit(s)
if s.GetVar("color")=="white" or (s.GetVar("color")=="blue" and isMoving())  or (s.GetVar("color")=="orange" and not isMoving()) then
	LongHurt(s.GetVar("damage"),s.GetVar("hurttime"))
	elseif s.GetVar("color")=="knife" then
	KnifeHurt(1)
end
end