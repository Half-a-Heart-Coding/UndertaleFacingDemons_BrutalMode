require "Libraries/Playermove"
require "Libraries/hurt"
spawntime=0
shadows={}
left={}
shad_anim={{1, 0, 0}, {0.5, 0, 0},{0,0,0},{0.5,0,0}}
Arena.ResizeImmediate(200,200)
for i=1,300 do
	left[i]=CreateProjectile("empty",0,0)
	left[i].SetVar("color",none)
	left[i].SetVar("togo",false)
end
num=1

function SendShadow(name, position, speed, istrue)
	local knife=CreateProjectile("Knife"..name,position[1],position[2],"Top")
	knife.SetVar("speed",speed)
	knife.SetVar("name",name)
	knife.SetVar("time",0)
	knife.sprite.alpha=0
	knife.SetVar("istrue",istrue)
	knife.SetVar("color","knife")
	table.insert(shadows,knife)
	time=0
end
function AllSides()
	local rand=math.random(2)*2-3
	local name=""
	if rand==-1 then
		name="Right"
		else
		name="Left"
	end
	for i=1,5 do
		SendShadow(name,{300*rand,-130+40*i},{-3*rand,0},true)
	end
	if rand==1 then
		name="Right"
		else
		name="Left"
	end
	for i=1,5 do
		SendShadow(name,{-300*rand,-110+40*i},{3*rand,0},true)
	end
end
		

function Update()
HurtUpd(690)
Moving()
spawntime=spawntime+1
if spawntime==1 or spawntime==151 then
	AllSides()
	elseif spawntime>279 and spawntime<361 and spawntime%10==0 then
	local pos=(spawntime-280)/10
	pos=90-20*pos
	SendShadow("Right",{-300,pos},{6,0},true)
	SendShadow("Left",{300,pos},{-6,0},true)
	elseif spawntime>409 and spawntime<520 and (spawntime-410)%25==0 then
	local pos=(spawntime-410)/25
	pos=pos*20+10
	if pos==10 then
		SendShadow("Down",{-pos,300},{0,-5},false)
		SendShadow("Down",{pos,300},{0,-5},false)
		else
		SendShadow("Down",{-pos,300},{0,-5},true)
		SendShadow("Down",{pos,300},{0,-5},true)
	end	
	elseif spawntime>530 and spawntime<561 and spawntime%10==0 then
	local pos=spawntime/10-54
	pos=10+20*pos
	SendShadow("Up",{-pos,-300},{0,6},true)
	SendShadow("Up",{pos,-300},{0,6},true)
end

for i=1,#shadows do
	local s=shadows[i]
	if s.isactive then
		local time=s.GetVar("time")+1
		s.SetVar("time",time)
		local speed=s.GetVar("speed")
		s.Move(speed[1],speed[2])
		if time<31 then
			s.sprite.alpha=math.sin(time*math.pi/60)
			elseif (time-31)%7==0 and s.GetVar("istrue")==true then
			left[num].sprite.Set("Knife"..s.GetVar("name"))
			left[num].MoveTo(s.x,s.y)
			left[num].SetVar("time",0)
			left[num].SetVar("color","knife")
			left[num].SetVar("togo",true)
			num=num+1
			if num==201 then
				num=1
			end
		end
		if s.x>400 or s.x<-400 then
			s.Remove()
		end
	end
end

for i=1,#left do
	local s=left[i]
	if s.GetVar("togo")==true then
		local time=s.GetVar("time")+1
		s.SetVar("time",time)
		if time<40 then
			local sin=0.75*math.cos(time*math.pi/80)
			s.sprite.color={0.625+0.375*math.cos(math.pi*time/10),0,0}
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
	end
end
end