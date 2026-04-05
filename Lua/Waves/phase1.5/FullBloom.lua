Arena.ResizeImmediate(128,200)
require "Libraries/Playermove"
require "Libraries/hurt"
collision = require "Libraries/rotational_collision"
spawntime=0
pellets={}
right={}
left={}
rank=20

local ghosts=Encounter.GetVar("ghostsappeared")
local paps
local sans
local buggy
if not ghosts then
	else
	paps=ghosts[1]
	sans=ghosts[2]
	buggy=ghosts[3]
end
leftin=false
rightin=false
blue=false
orange=false
swingleft=0
swingright=0
changingleft=-1
changingright=-1
function Update()
HurtUpd(1200)
Moving()
if spawntime==200 then
	if not paps then
		else
		paps.SetVar("time",61)
	end
	elseif spawntime==500 then
	if not sans then
		else
		sans.SetVar("time",61)
	end
	elseif spawntime==800 then
	if not buggy then
		else
		buggy.SetVar("time",61)
	end
end
	
	
	
spawntime=spawntime+1
if spawntime==1 then
	orange=CreateProjectile("Bonev",-75.5,0)
	orange.sprite.alpha=0
	orange.sprite.color={1,0.4,0}
	--Audio.PlaySound(
end
if spawntime>1 and spawntime<31 then
	if spawntime<16 then
		orange.sprite.alpha=math.sin(math.pi*spawntime/30)
	end
	orange.MoveTo(-75.5*math.cos(spawntime*math.pi/60),0)
	elseif spawntime>31 and spawntime<61 then
	if spawntime<46 then
		blue.sprite.alpha=math.sin(math.pi*(spawntime-30)/30)
	end
	blue.MoveTo(75.5*math.cos((spawntime-30)*math.pi/60),0)
	elseif spawntime>60 and spawntime<91 then
	blue.MoveTo(0,100*math.sin(math.pi*(spawntime-60)/60))
	orange.MoveTo(0,-100*math.sin(math.pi*(spawntime-60)/60))
	orange.sprite.rotation=180
	elseif spawntime>90 and spawntime<211 then
	local sin=6
	if blue.sprite.rotation<180 and not done then
		sin=1+5*math.sin(blue.sprite.rotation*math.pi/360)
		else done=true
	end
	blue.sprite.rotation=blue.sprite.rotation+sin
	orange.sprite.rotation=orange.sprite.rotation+sin
	local ugol=blue.sprite.rotation+90
	blue.MoveTo(100*math.cos(ugol*math.pi/180),100*math.sin(ugol*math.pi/180))
	ugol=ugol+180
	orange.MoveTo(100*math.cos(ugol*math.pi/180),100*math.sin(ugol*math.pi/180))
	elseif spawntime>210 and spawntime<241 then
	if 180-(blue.sprite.rotation%180)<180 then
		local sin=1+6*math.sin((360-blue.sprite.rotation)*math.pi/720)
		blue.sprite.rotation=blue.sprite.rotation+sin
		orange.sprite.rotation=orange.sprite.rotation+sin
	end
	orange.Move(6,0)
	blue.Move(-6,0)
	savioy=blue.y
	saviox=blue.x
	elseif spawntime>240 and spawntime<271 then
	if 180-(blue.sprite.rotation%180)<180 then
		local sin=1+6*math.sin((360-blue.sprite.rotation)*math.pi/720)
		if sin<0 then
			sin=blue.sprite.rotation%180
		end
		blue.sprite.rotation=blue.sprite.rotation+sin
		orange.sprite.rotation=orange.sprite.rotation+sin
	end
	if spawntime==270 then
		blue.sprite.rotation=0
		orange.sprite.rotation=0
	end
	blue.MoveTo(saviox-(240+saviox)*math.sin((spawntime-240)*math.pi/60),savioy*math.sin((spawntime-210)*math.pi/60))
	orange.MoveTo(-saviox+(240+saviox)*math.sin((spawntime-240)*math.pi/60),-savioy*math.sin((spawntime-210)*math.pi/60))
end
if spawntime==150 then
	local place=DoPlaces(true)
	for i=1,29 do
		local p=CreateProjectile("pellet",-150,place[i])
		table.insert(pellets,p)
		left[i]=p
		p.SetVar("time",0)
		p.SetVar("now",place[i])
	end
	for i=1,29 do
		local p=CreateProjectile("pellet",150,place[i])
		table.insert(pellets,p)
		right[i]=p
		p.SetVar("time",0)
		p.SetVar("now",place[i])
	end
	blue.sprite.SendToTop()
	orange.sprite.SendToTop()
end
for i=1,#pellets do
	local p=pellets[i]
	if p.isactive then
		local time=p.GetVar("time")+1
		p.SetVar("time",time)
		if time%4==0 then
			p.sprite.rotation=90*((time/4)%2)
		end
		local px=Player.x
		local py=Player.y
		local x=p.x
		local y=p.y
		if px+9>x and px-9<x and py+9>y and py-9<y then
			KnifeHurt(1)
		end
	end
end
if spawntime==260 then
	swingleft=true
	elseif spawntime==261 then
	swingright=true
end
if swingleft==true then
	for i=1,#left do
		left[i].Move(4,0)
		if left[i].x==150 then
			swingleft=false
			Switch("right")
		end
	end
end
if swingright==true then
	for i=1,#right do
		right[i].Move(-4,0)
		if right[i].x==-150 then
			swingright=false
			Switch("left")
		end
	end
end
if spawntime>360 and spawntime<960 then
	local t=(spawntime-360)
	orange.MoveTo(240*math.cos(t*math.pi/150),0)
	if orange.x>-150 and orange.x<150 and leftin==false then
		leftin=true
	end
	if leftin==true then
		for i=1,29 do
			left[i].MoveTo(orange.x,left[i].y)
		end
		if orange.x>150 then
			leftin=false
			for i=1,29 do
				left[i].MoveTo(150,left[i].y)
			end
			if spawntime<900 then
				Switch("left")
			end
			elseif orange.x<-150 then
			leftin=false
			for i=1,29 do
				left[i].MoveTo(-150,left[i].y)
			end
			Switch("left")
		end
	end
	elseif spawntime>960 and spawntime<990 then
	orange.MoveTo(240-150*math.sin(math.pi*(spawntime-960)/60),0)
	elseif spawntime>989 then
	orange.MoveTo(90*math.cos((spawntime-989)*math.pi/60),0)
	if spawntime>1170 then
		orange.sprite.alpha=1-math.sin((spawntime-1170)*math.pi/60)
	end
end
if spawntime>910 and leftin==false then
	for i=1,29 do
		left[i].Move(5,0)
	end
end
if blue==false then
	elseif collision.CheckCollision(Player,blue) and isMoving()==true and blue.sprite.alpha>0.25 then
	LongHurt(10,30)
end
if orange==false then
	elseif collision.CheckCollision(Player,orange) and isMoving()==false and orange.sprite.alpha>0.25 then
	LongHurt(10,30)
end

if spawntime>435 and spawntime<1035 then
	local t=(spawntime-435)
	blue.MoveTo(-240*math.cos(t*math.pi/150),0)
	if blue.x>-150 and blue.x<150 and rightin==false then
		rightin=true
	end
	if rightin==true then
		for i=1,29 do
			right[i].MoveTo(blue.x,right[i].y)
		end
		if blue.x>150 then
			rightin=false
			for i=1,29 do
				right[i].MoveTo(150,right[i].y)
			end
			Switch("right")
			elseif blue.x<-150 then
			rightin=false
			for i=1,29 do
				right[i].MoveTo(-150,right[i].y)
			end
			if spawntime<930 then
				Switch("right")
			end
		end
	end
	elseif spawntime>1035 and spawntime<1065 then
	blue.MoveTo(-240+150*math.sin(math.pi*(spawntime-1035)/60),0)
	elseif spawntime>1080 then
	blue.MoveTo(-90*math.cos((spawntime-1080)*math.pi/60),0)
	if spawntime>1170 then
		blue.sprite.alpha=1-math.sin((spawntime-1170)*math.pi/60)
	end
end
if spawntime>960 and rightin==false then
	for i=1,29 do
		right[i].Move(-5,0)
	end
end
if spawntime==31 then
	blue=CreateProjectile("Bonev",75.5,0)
	blue.sprite.alpha=0
	blue.sprite.color={0/255, 168/255, 242/255}
end
if changingleft>-1 then
	changingleft=Change(changingleft,left)
end
if changingright>-1 then
	changingright=Change(changingright,right)
end

end
function Change(ingo,pel)
	local time=ingo+1
	local sin=0
	local rest=1
	if time>20 then
		sin=math.sin(math.pi*(time-20)/40)
		rest=1-sin
	end
	for i=1,29 do
		local p=pel[i]
		local now=p.GetVar("now")
		local old=p.GetVar("old")
		p.MoveTo(p.x,sin*now+rest*old)
	end
	if time==40 then
		time=-1
	end
	return time
end
function Switch(ingo)
	local pel=none
	if ingo=="left" then
		pel=left
		changingleft=0
		else pel=right
		changingright=0
	end
	local places=DoPlaces()
	for i=1,29 do
		local p=pel[i]
		p.SetVar("old",p.y)
		p.SetVar("now",places[i])
	end
end
function DoPlaces(ingo)
	local outgo={}
	local randpoint=math.random(32)+4
	if ingo==true then
		randpoint=4+16
	end
	while (math.abs(randpoint-rank)>16) do
		randpoint=math.random(32)+4
	end
	rank=randpoint
	local extra=0
	for i=1,29 do
		--if randpoint-5<i+extra and randpoint+5>i+extra then
		if randpoint-5<i then
			extra=10
		end
		outgo[i]=i+extra
	end
	for i=1,29 do
		outgo[i]=outgo[i]*5-100
	end
	return outgo
end
function OnHit()
--Effects("curse",1)
--KnifeHurt(1)
end