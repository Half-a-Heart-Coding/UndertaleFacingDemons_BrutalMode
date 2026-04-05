Arena.ResizeImmediate(128,200)
require "Libraries/Playermove"
require "Libraries/hurt"
collision = require "Libraries/rotational_collision"
spawntime=0
pellets={}
pellets2={}
right={}
left={}
up={}
down={}
ul={}
ur={}
dr={}
dl={}
rank=20
BR=0
boom={}
fires={}


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
upin=false
downin=false
blue2=false
orange2=false
swingleft=0
swingright=0
changingleft=-1
changingright=-1

function DoFire(ugol)
	local x=172*math.cos(ugol*math.pi/180)
	local y=172*math.sin(ugol*math.pi/180)
	local fire=CreateProjectile("bullet",x,y)
	fire.SetVar("ugol",ugol)
	fire.SetVar("time",0)
	fire.SetVar("color","fire")
	table.insert(fires,fire)
end

function Update()
HurtUpd(3600)
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
	if spawntime == 900 then
		BR=CreateProjectileAbs("system/chaos/burn",550,70)
		boom={}
	end
spawntime=spawntime+1
if spawntime==1 then
	orange=CreateProjectile("Bonev",-75.5,0)
	orange.sprite.alpha=0
	orange.sprite.color={1,0.5,0}
	--Audio.PlaySound(
end
if spawntime==90 then
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
			if spawntime > 900 then
				Effects("burn",0.25)
			end
		end
	end
end
if spawntime==180 then
	swingleft=true
	elseif spawntime==181 then
	swingright=true
end
if swingleft==true then
	for i=1,#left do
		left[i].Move(5,0)
		if left[i].x==150 then
			swingleft=false
			Switch("right")
		end
	end
	for i=1,#down do
		down[i].Move(0,5)
		if down[i].y==150 then
			swingleft=false
			Switch2("up")
		end
	end
end
if swingright==true then
	for i=1,#right do
		right[i].Move(-5,0)
		if right[i].x==-150 then
			swingright=false
			Switch("left")
		end
	end
	for i=1,#up do
		up[i].Move(0,-5)
		if up[i].y==-150 then
			swingright=false
			Switch2("down")
		end
	end
end
if spawntime>360 then
	local t=(spawntime-360)
	orange.MoveTo(240*math.cos(t*math.pi/150),240*math.cos(t*math.pi/150))
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
if spawntime>360 then
	local t=(spawntime-360)
	orange.MoveTo(240*math.cos(t*math.pi/150),-240*math.cos(t*math.pi/150))
	if orange.x>-150 and orange.x<150 and leftin==false then
		leftin=true
	end
	if leftin==true then
		for i=1,29 do
			down[i].MoveTo(down[i].x,orange.x)
		end
		if orange.x>150 then
			leftin=false
			for i=1,29 do
				down[i].MoveTo(down[i].x,150)
			end
			if spawntime<900 then
				Switch2("down")
			end
			elseif orange.x<-150 then
			leftin=false
			for i=1,29 do
				down[i].MoveTo(down[i].x,-150)
			end
			Switch2("down")
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
if blue==false then
	elseif collision.CheckCollision(Player,blue) and isMoving()==true and blue.sprite.alpha>0.25 then
	LongHurt(10,30)
	if spawntime > 900 then
		Effects("burn",0.5)
	end
end
if orange==false then
	elseif collision.CheckCollision(Player,orange) and isMoving()==false and orange.sprite.alpha>0.25 then
	LongHurt(10,30)
	if spawntime > 900 then
		Effects("burn",0.5)
	end
end

if spawntime>435 then
	local t=(spawntime-435)
	blue.MoveTo(-240*math.cos(t*math.pi/150),-240*math.cos(t*math.pi/150))
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
			--if spawntime<930 then
				Switch("right")
			--end
		end
	end
end
if spawntime>435 then
	local t=(spawntime-435)
	if rightin==true then
		for i=1,29 do
			up[i].MoveTo(up[i].x,blue.x)
		end
		if blue.x>150 then
			rightin=false
			for i=1,29 do
				up[i].MoveTo(up[i].x,150)
			end
			Switch2("up")
			elseif blue.x<-150 then
			rightin=false
			for i=1,29 do
				up[i].MoveTo(up[i].x,150)
			end
			--if spawntime<930 then
				Switch2("up")
			--end
		end
	end
end
if spawntime>410 then
	local t=(spawntime-410)
	--if rightin==true then
		for i=1,29 do
			ur[i].MoveTo(up[i].y*0.9,right[i].x*0.9)
		end
	--end
end
if spawntime>410 then
	local t=(spawntime-410)
	--if rightin==true then
		for i=1,29 do
			ul[i].MoveTo(up[i].y*0.9,left[i].x*0.9)
		end
	--end
end
if spawntime>410 then
	local t=(spawntime-410)
	--if rightin==true then
		for i=1,29 do
			dr[i].MoveTo(down[i].y*0.9,right[i].x*0.9)
		end
	--end
end
if spawntime>410 then
	local t=(spawntime-410)
	--if rightin==true then
		for i=1,29 do
			dl[i].MoveTo(down[i].y*0.9,left[i].x*0.9)
		end
	--end
end
if spawntime==31 then
	blue=CreateProjectile("Bonev",75.5,0)
	blue.sprite.alpha=0
	blue.sprite.color={0/255, 168/255, 242/255}
end
if changingleft>-1 then
	changingleft=Change(changingleft,left)
	changingleft=Change2(changingleft,down)
end
if changingright>-1 then
	changingright=Change(changingright,right)
	changingright=Change2(changingright,up)
end

--EndWave()

if spawntime==90 then
	local place=DoPlaces2(true)
	for i=1,29 do
		local p=CreateProjectile("pellet",place[i],150)
		table.insert(pellets,p)
		up[i]=p
		p.SetVar("time",0)
		p.SetVar("now",place[i])
	end
	for i=1,29 do
		local p=CreateProjectile("pellet",place[i],-150)
		table.insert(pellets,p)
		down[i]=p
		p.SetVar("time",0)
		p.SetVar("now",place[i])
	end
	blue.sprite.SendToTop()
	orange.sprite.SendToTop()
end

if spawntime==120 then
	local place=DoPlaces3(true)
	for i=1,29 do
		local p=CreateProjectile("pellet",-place[i],place[i])
		table.insert(pellets,p)
		ul[i]=p
		p.SetVar("time",0)
		p.SetVar("now",place[i])
	end
	for i=1,29 do
		local p=CreateProjectile("pellet",place[i],place[i])
		table.insert(pellets,p)
		ur[i]=p
		p.SetVar("time",0)
		p.SetVar("now",place[i])
	end
	local place=DoPlaces3(true)
	for i=1,29 do
		local p=CreateProjectile("pellet",-place[i],-place[i])
		table.insert(pellets,p)
		dl[i]=p
		p.SetVar("time",0)
		p.SetVar("now",place[i])
	end
	for i=1,29 do
		local p=CreateProjectile("pellet",place[i],-place[i])
		table.insert(pellets,p)
		dr[i]=p
		p.SetVar("time",0)
		p.SetVar("now",place[i])
	end
	blue.sprite.SendToTop()
	orange.sprite.SendToTop()
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

function Change2(ingo,pel)
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
		if old==nil then
			old=1
		end
		p.MoveTo(sin*now+rest*old,p.y)
	end
	if time==40 then
		time=-1
	end
	return time
end
function Switch2(ingo)
	local pel=none
	if ingo=="up" then
		pel=up
		else pel=down
	end
	local places=DoPlaces()
	for i=1,29 do
		local p=pel[i]
		p.SetVar("old",p.x)
		p.SetVar("now",places[i])
	end
end
function DoPlaces2(ingo)
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

function Change3(ingo,pel)
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
		if old==nil then
			old=1
		end
		p.MoveTo(sin*now+rest*old,sin*now+rest*old)
	end
	if time==40 then
		time=-1
	end
	return time
end
function Switch3(ingo)
	local pel=none
	if ingo=="ul" then
		pel=ul
		elseif ingo=="ur" then
		pel=ur
		elseif ingo=="dr" then
		pel=dr
		else
		pel=dl
	end
	local places=DoPlaces()
	for i=1,29 do
		local p=pel[i]
		p.SetVar("old",p.y)
		p.SetVar("now",places[i])
	end
end
function DoPlaces3(ingo)
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
function OnHit(g)
--Effects("curse",1)
if g.GetVar("color")=="fire" then
	--LongHurt(1,5)
	Effects("burn",0.5)
end	
--KnifeHurt(1)
end