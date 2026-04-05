require "Libraries/Playermove"
require "Libraries/hurt"
spawntime=0
shadows={}
left={}
local curse=false
if Encounter.GetVar("IsCursed")==true then
	curse=true
end
shad_anim={{1, 0, 0}, {0.5, 0, 0},{0,0,0},{0.5,0,0}}
Arena.ResizeImmediate(120,120)
for i=1,200 do
	left[i]=CreateProjectile("empty",0,0)
	left[i].SetVar("color",none)
	left[i].SetVar("togo",false)
end
num=1

if Encounter.GetVar("diff")==34 or Encounter.GetVar("diff")==35 or Encounter.GetVar("diff")==36 then
	Encounter.SetVar("SavedProg", Encounter.GetVar("SavedProg")+1)
end

function SendShadow(name, position, speed, istrue)
	local knife=CreateProjectile("Knife"..name,position[1],position[2],"Top")
	knife.SetVar("speed",speed)
	knife.SetVar("name","Shadow"..name)
	knife.SetVar("time",0)
	knife.sprite.alpha=0
	knife.SetVar("istrue",istrue)
	knife.SetVar("color","knife")
	table.insert(shadows,knife)
	time=0
end
		

function Update()
HurtUpd(690)
Moving()
spawntime=spawntime+1
if spawntime%80==40 then
	local rand=math.random(2)
	if rand1==1 then
		rand2=rand2+1
		elseif rand1==2 then
		if rand2==2 then
			rand2=rand2+1
		end
	end
	for i=1,2 do
		local x=-72+48*i
		local s=false
		if i==rand then
			s=true
		end
		SendShadow("Down",{x,310},{0,-4},s)
	end
	elseif spawntime%80==0 then
	for i=1,3 do
		local x=-96+48*i
		local s=false
		SendShadow("Down",{x,310},{0,-4},s)
	end
end
for i=1,#shadows do
	local s=shadows[i]
	if s.isactive then
		local time=s.GetVar("time")+1
		s.SetVar("time",time)
		local speed=s.GetVar("speed")
		s.Move(speed[1],speed[2])
		if time<21 then
			s.sprite.alpha=math.sin(time*math.pi/40)
			elseif (time-31)%7==0 and s.GetVar("istrue")==true then
			left[num].sprite.Set(s.GetVar("name"))
			left[num].MoveTo(s.x,s.y)
			left[num].SetVar("time",0)
			left[num].SetVar("color","knife")
			left[num].SetVar("togo",true)
			num=num+1
			if num==201 then
				num=1
			end
		end
		if s.x>400 or s.x<-400 or s.y<-300 then
			s.Remove()
		end
	end
end

for i=1,#left do
	local s=left[i]
	if s.GetVar("togo")==true then
		local time=s.GetVar("time")+1
		s.SetVar("time",time)
		if time<41 then
			local sin=0.75*math.cos(time*math.pi/80)
			s.sprite.color={1,1,1}
			s.sprite.alpha=sin
			if time==30 then
				s.SetVar("color","none")
			end
			else
			s.SetVar("togo",false)
		end
	end
end




end

function OnHit(ingo)
local c=ingo.GetVar("color")
if c=="knife" then
	local x=ingo.x
	local y=ingo.y
	local w=ingo.sprite.width/2+4
	local h=ingo.sprite.height/2+4
	local px=Player.x
	local py=Player.y
	if px+w>x and px-w<x and py+h>y and py-h<y then
		KnifeHurt(1)
		if curse==true then
			Effects("curse",1)
		end
	end
end
end