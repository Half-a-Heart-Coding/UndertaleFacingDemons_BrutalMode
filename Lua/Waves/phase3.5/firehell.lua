
require "Libraries/Playermove"
require "Libraries/hurt"
downspears={}
upspears={}
fires={}
circles={}
sidespears={}
spawntime=480
spawntime2=0
Arena.Resize(180,120)
Player.MoveTo(0,0)
local ghosts=Encounter.GetVar("ghostsappeared")
if not ghosts then
	ghosts={}
end
local Tori=ghosts[1]
local Asgi=ghosts[2]

burnt=-1
Random=math.random(2)
BR=CreateProjectileAbs("system/chaos/burn",550,70)
function Update()
if burnt>-1 then
	burnt=burnt+1
end
if burnt<60 then
	BR.sprite.alpha=math.sin(burnt*math.pi/120)
end
hue=0.90-0.1*math.sin(math.pi*burnt/30)
--BR.sprite.color ={1*hue,0.5*hue,0.15234375*hue}
spawntime=spawntime+1
spawntime2=spawntime2+1
if spawntime==30 then
	for i=1,10 do
		local spear=CreateProjectile("ToriSpear",i*18-99,-105)
		spear.sprite.color={1,0,0}
		spear.sprite.rotation=180
		spear.sprite.alpha=1
		downspears[i]=spear
		spear.SetVar("color","lethal")
		spear.SetVar("damage",15)
		spear.SetVar("hurttime",30)
	end
end
if spawntime==400 then
	if not Asgi then
		else
		Asgi.SetVar("time",61)
	end
	elseif spawntime==800 then
	if not Tori then
		else
		Tori.SetVar("time",61)
	end
end
if spawntime==110 then
	for i=1,10 do
		local spear=CreateProjectile("ToriSpear",i*18-99,105)
		spear.sprite.color={1,0,0}
		spear.sprite.alpha=1
		upspears[i]=spear
		spear.SetVar("color","lethal")
		spear.SetVar("damage",15)
		spear.SetVar("hurttime",30)
	end
end

for i=1,#sidespears do
	local s=sidespears[i]
	if s.isactive then
		local time=s.GetVar("time")+1
		s.SetVar("time",time)
		if time<46 then
			s.sprite.alpha=math.sin(time*math.pi/90)
		elseif time==60 then
			--if i==1 then
				Audio.PlaySound("ding")
			--end
			if math.random(3)==1 then
				s.sprite.color={0,0,1}
				if s.GetVar("color")=="blue" then
					s.SetVar("color", "orange")
				elseif s.GetVar("color")=="orange" then
					s.SetVar("color", "blue")
				end
			else
				s.sprite.color={1,0,0}
			end
		elseif time>60 then
			s.Move(s.GetVar("x")*1.5,0)
		end
		if s.x>400 or s.x<-400 then
			s.Remove()
		end
	end
end
for i=1,#fires do
	local f=fires[i]
	if f.isactive then
		local time=f.GetVar("time")+1
		f.SetVar("time",time)
		if time<31 then
			f.sprite.alpha=math.sin(time*math.pi/60)
		end
		f.Move(f.GetVar("x"),f.GetVar("y"))
		if f.x>400 or f.x<-400 or f.y>300 or f.y<-300 then
			f.Remove()
		end
	end
end
if spawntime>209 and (spawntime-210)%3==0 and spawntime<223 then
	local i=(spawntime-210)/3
	SendFire({300,52-16*i},{-6,0},"ToriSpear1",180)
	SendFire({-300,52-16*i},{6,0},"ToriSpear1")
	elseif spawntime>214 and (spawntime-215)%2==0 and spawntime<225 then
	local i=(spawntime-215)/3
	SendFire({0+16*i,200},{0,-6},"ToriSpear")
	SendFire({0-16*i,200},{0,-6},"ToriSpear")
end
for i=1,#upspears do
	local s=upspears[i]
	if spawntime<130 then
		s.sprite.alpha=math.sin((spawntime-115)*math.pi/30)
		elseif spawntime<170 then
		s.MoveTo(s.x,60+45*math.cos((spawntime-130)*math.pi/40))
		elseif spawntime==170 then
		if i==1 then
			Audio.PlaySound("ding")
		end
		if (i+Random)%2==1 then
			s.sprite.color={0/255, 168/255, 242/255}
			s.SetVar("color","blue")
			else
			s.sprite.color={1,0.4,0}
			s.SetVar("color","orange")
		end
		elseif spawntime>190 and spawntime<221 then
		s.MoveTo(s.x,15-30*math.sin((spawntime-190)*math.pi/60))
		elseif spawntime>225 and spawntime<230 then
		local sin=1-math.sin((spawntime-225)*math.pi/10)
		s.sprite.alpha=sin
		if sin<0.5 then
			s.SetVar("color","none")
		end
		elseif spawntime==230 then
		s.Remove()
		if i==#upspears then
			upspears={}
		end
	end
end
if spawntime==330 then
	Arena.Resize(140,140)
	burnt=0
end
if spawntime>9999 and ((spawntime-640)%3)==0 and spawntime<679 then
	local a=(spawntime-340)/3*2
	for i=1,4 do
		local angle=a+90*i-90
		local fire=CreateProjectile("bullet",150*math.cos(angle*math.pi/180),150*math.sin(angle*math.pi/180))
		fire.SetVar("time",-90)
		fire.SetVar("color","orange")
		fire.sprite.color={1,0.5,0}
		fire.SetVar("isfire",true)
		fire.SetVar("timeUp",1)
		fire.SetVar("damage",1)
		fire.SetVar("hurttime",5)
		fire.SetVar("cos",math.cos(angle*math.pi/180))
		fire.SetVar("sin",math.sin(angle*math.pi/180))
		table.insert(circles,fire)
	end
end
if (spawntime-500)%150==0 then
	if spawntime==500 then
		Random=math.random(2)*2-3
	end
	if (spawntime-500)%150==0 then
		SendWall(1*Random)
		else
		SendWall(-1*Random)
	end
end

for i=1,#circles do
	local c=circles[i]
	if c.isactive then
		local time=c.GetVar("time")+c.GetVar("timeUp")
		if time==9999 then
			c.SetVar("color","white")
			c.sprite.SendToBottom()
			c.sprite.color={1,1,1}
		end
		c.SetVar("time",time)
		local range=150
		if time==1 then
			--c.sprite.color={1,0.4,0}
			--c.SetVar("color","orange")
			c.sprite.SendToBottom()
		end
		if time==361 and i==#circles then
			for t=1,(#circles/4) do
				local n=(t-1)*4
				circles[n+1].SetVar("time",691-t*1.5)
				circles[n+2].SetVar("time",691-t*1.5)
				circles[n+3].SetVar("time",691-t*1.5)
				circles[n+4].SetVar("time",691-t*1.5)
			end
		end
		if (spawntime)==630 then
			if i==1 then
				Audio.PlaySound("ding")
			end
			c.SetVar("color","orange")
			c.sprite.color={1,0.5,0}
			c.SetVar("time",0)
		end

		if (spawntime-i)==900 then
			if i==1 then
				Audio.PlaySound("ding")
			end
			c.SetVar("color","blue")
			c.sprite.color={0/255, 168/255, 242/255}
		end

		if time<0 then
			range=150-300*math.sin((time+90)*math.pi/180)

			--if time>=0 then
				--c.SetVar("timeUp",c.GetVar("timeUp")*-1)
			--end
			--if time<=-90 then
			--	c.SetVar("timeUp",-c.GetVar("timeUp"))
			--end
		else
			range=-150*math.cos(time*math.pi/90)
		--elseif time>690 then
			--if time<720 then
			--	range=150+30*math.sin((time-690)*math.pi/60)
			--elseif time<750 then
			--	range=150+60*math.sin((time-690)*math.pi/60)
			--else
			--	range=150-5*(time-750)
			--end
			--range=-range
		end
		local sin=c.GetVar("sin")
		local cos=c.GetVar("cos")
		c.MoveTo(range*cos,range*sin)
	end
end

for i=1,#downspears do
	local s=downspears[i]
	if spawntime<46 then
		s.sprite.alpha=math.sin((spawntime-30)*math.pi/30)
		elseif spawntime<76 then
		s.MoveTo(s.x,-60-45*math.cos((spawntime-45)*math.pi/30))
		elseif spawntime==76 then
		if i==1 then
			Audio.PlaySound("ding")
		end
		if (i+Random)%2==1 then
			s.sprite.color={0/255, 168/255, 242/255}
			s.SetVar("color","blue")
			else
			s.sprite.color={1,0.4,0}
			s.SetVar("color","orange")
		end
		elseif spawntime>120 and spawntime<151 then
		s.MoveTo(s.x,-15+30*math.sin((spawntime-120)*math.pi/60))
		elseif spawntime>155 and spawntime<161 then
		local sin=1-math.sin((spawntime-155)*math.pi/10)
		s.sprite.alpha=sin
		if sin<0.5 then
			s.SetVar("color","none")
		end
		elseif spawntime==161 then
		s.Remove()
		if i==#downspears then
			downspears={}
		end
	end
end
HurtUpd(1300)
Moving()
end

function SendWall(side)
	local hole=math.random(9)+1
	local hole2=math.random(9)+1
	while hole2==hole do
		hole2=math.random(9)+1
	end
	local hole3=math.random(9)+1
	while hole3==hole or hole3==hole2 do
		hole3=math.random(9)+1
	end
	local hole4=math.random(9)+1
	while hole4==hole or hole4==hole2 or hole4==hole3 do
		hole4=math.random(9)+1
	end
	local hole5=math.random(9)+1
	while hole5==hole or hole5==hole2 or hole5==hole3 or hole5==hole4 do
		hole5=math.random(9)+1
	end
	local hole6=math.random(9)+1
	while hole6==hole or hole6==hole2 or hole6==hole3 or hole6==hole4 or hole6==hole5 do
		hole6=math.random(9)+1
	end
	local hole7=math.random(9)+1
	while hole7==hole or hole7==hole2 or hole7==hole3 or hole7==hole4 or hole7==hole5 or hole7==hole6 do
		hole7=math.random(9)+1
	end
	local hole8=math.random(9)+1
	while hole8==hole or hole8==hole2 or hole8==hole3 or hole8==hole4 or hole8==hole5 or hole8==hole6 or hole8==hole7 do
		hole8=math.random(9)+1
	end
	local hole9=math.random(9)+1
	while hole9==hole or hole9==hole2 or hole9==hole3 or hole9==hole4 or hole9==hole5 or hole9==hole6 or hole9==hole7 or hole9==hole8 do
		hole9=math.random(9)+1
	end
	if spawntime2>150 then
		hole9=0
	end
	if spawntime2>300 then
		hole8=0
	end
	if spawntime2>450 then
		hole7=0
	end
	if spawntime2>600 then
		hole6=0
	end
	if spawntime2>750 then
		hole5=0
	end
	if spawntime2>900 then
		hole4=0
	end
	if spawntime2>1050 then
		hole3=0
	end
	if spawntime2>1200 then
		hole2=0
	end
	for i=2,9 do
		if i~=hole and i~=hole2 and i~=hole3 and i~=hole4 and i~=hole5 and i~=hole6 and i~=hole7 and i~=hole8 and i~=hole9 then
			local spear=CreateProjectile("ToriSpear1",side*240,-77+i*14)
			if side==1 then
				spear.sprite.rotation=180
			end
			spear.sprite.alpha=0
			spear.SetVar("time",0)
			spear.SetVar("color","white")
			spear.SetVar("damage",15)
			spear.SetVar("hurttime",30)
			spear.SetVar("x",-3*side)
			table.insert(sidespears,spear)
		elseif math.random(2)==1 then
			local spear=CreateProjectile("ToriSpear1",side*240,-77+i*14)
			if side==1 then
				spear.sprite.rotation=180
			end
			spear.sprite.alpha=0
			spear.SetVar("time",0)
			spear.sprite.color={1, 0.5, 0}
			spear.SetVar("color","orange")
			spear.SetVar("damage",15)
			spear.SetVar("hurttime",30)
			spear.SetVar("x",-3*side)
			table.insert(sidespears,spear)
		else
			local spear=CreateProjectile("ToriSpear1",side*240,-77+i*14)
			if side==1 then
				spear.sprite.rotation=180
			end
			spear.sprite.alpha=0
			spear.sprite.color={0/255, 168/255, 242/255}
			spear.SetVar("time",0)
			spear.SetVar("color","blue")
			spear.SetVar("damage",15)
			spear.SetVar("hurttime",30)
			spear.SetVar("x",-3*side)
			table.insert(sidespears,spear)
		end
	end
end
function SendFire(point,speed,spr,rot)
	local fire=CreateProjectile(spr,point[1],point[2])
	fire.SetVar("x",speed[1])
	fire.SetVar("y",speed[2])
	if not rot then
		else
		fire.sprite.rotation=rot
	end
	fire.sprite.alpha=0
	fire.SetVar("time",0)
	fire.SetVar("damage",15)
	fire.SetVar("hurttime",30)
	fire.SetVar("color","white")
	table.insert(fires,fire)
end
function DeadEnd()
	Encounter.Call("SetMusic","none")
	death=0
	spawntime=-1
	NewAudio.Play("Hits")
  	deadscreen = CreateProjectileAbs("999999", 320, 240)
end
function OnHit(s)
if s.GetVar("color")=="white" or (s.GetVar("color")=="blue" and isMoving())  or (s.GetVar("color")=="orange" and not isMoving()) then
	LongHurt(s.GetVar("damage"),s.GetVar("hurttime"))
	if s.GetVar("isfire")==true then
		Effects("burn",1)
	end
elseif s.GetVar("color") == "lethal" then
	if GetGlobal("KnifeProtection") == true then
		if Player.hp > 25 and Encounter.GetVar("diff") == 17 then
			LongHurt(25,60)
		elseif Player.hp > 33 then
			LongHurt(33,60)
		else
			--DeadEnd()
			LongHurt(99999,60)
		end
	else
		--DeadEnd()
		LongHurt(99999,60)
	end
end
end