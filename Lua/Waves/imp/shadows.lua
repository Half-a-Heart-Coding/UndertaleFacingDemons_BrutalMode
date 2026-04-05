require "Libraries/Playermove"
require "Libraries/hurt"
spawntime=0
shadows={}
left={}
chosenSafePath = 0
shad_anim={{1, 0, 0}, {0.5, 0, 0},{0,0,0},{0.5,0,0}}
name2=""
if GetGlobal("DifficultyPoints") >= 621 then
	name2="Fatal"
end
name3="Deadly"
if GetGlobal("DifficultyPoints") >= 621 then
	name3="Fatal"
end
name4="Lethal"
if GetGlobal("DifficultyPoints") >= 621 then
	name4="Fatal"
end
Arena.ResizeImmediate(200,200)
for i=1,200 do
	left[i]=CreateProjectile("KnifeRightDeadly",0,0)
	left[i].sprite.alpha=0
	left[i].SetVar("color",none)
	left[i].SetVar("togo",false)
end
num=1

function SendShadow(name, position, speed, istrue)
	local knife=CreateProjectile("Knife"..name..name3,position[1],position[2],"Top")
	knife.SetVar("speed",speed)
	knife.SetVar("name",name..name3)
	knife.SetVar("name2",name..name2)
	knife.SetVar("time",0)
	knife.sprite.alpha=0
	knife.SetVar("istrue",istrue)
	knife.SetVar("color","knife2")
	table.insert(shadows,knife)
	time=0
end
function AllSides()
	local rand=math.random(2)*2-3
	if chosenSafePath == 1 then
		rand=1
	elseif chosenSafePath ~= 0 then
		rand=-1
	end
	local name=""
	if rand==-1 then
		name="Right"
		else
		name="Left"
	end
	for i=1,4 do
		SendShadow(name,{300*rand,-137.5+50*i},{-3*rand,0},true)
	end
	if rand==1 then
		name="Right"
		else
		name="Left"
	end
	for i=1,4 do
		SendShadow(name,{-300*rand,-112.5+50*i},{3*rand,0},true)
	end
	rand=math.random(2)*2-3
	randomIgnore = 6
	for i=1,4 do
		if i ~= randomIgnore then
			SendShadow(name,{500*rand,-137.5+50*i},{-3*rand,0},true)
		end
	end
	if rand==1 then
		name="Right"
		else
		name="Left"
	end
	randomIgnore = 6
	for i=1,4 do
		if i ~= randomIgnore then
			SendShadow(name,{-500*rand,-112.5+50*i},{3*rand,0},true)
		end
	end
end
		

function Update()
HurtUpd(700)
Moving()
spawntime=spawntime+1
if spawntime==1 or spawntime==91 then
	AllSides()
	elseif spawntime>279-60 and spawntime<361-60 and spawntime%10==0 then
	local pos=(spawntime-280+60)/10
	pos=90-20*pos
	SendShadow("Right",{-300,pos},{6,0},true)
	SendShadow("Left",{300,pos},{-6,0},true)
	elseif spawntime>409-60 and spawntime<520-60 and (spawntime-410+60)%25==0 then
	local pos=(spawntime-410+60)/25
	pos=pos*20+10
	if pos==10 then
		SendShadow("Down",{-pos,300},{0,-5},false)
		SendShadow("Down",{pos,300},{0,-5},false)
		else
		SendShadow("Down",{-pos,300},{0,-5},true)
		SendShadow("Down",{pos,300},{0,-5},true)
	end	
	elseif spawntime>530-60 and spawntime<561-60 and spawntime%10==0 then
	local pos=spawntime/10-54+6
	pos=10+20*pos
	SendShadow("Up",{-pos,-300},{0,6},true)
	SendShadow("Up",{pos,-300},{0,6},true)
end

if spawntime==340 then
	SendShadow("Right",{-300,87.5},{6,0},true)
	SendShadow("Left",{300,87.5},{-6,0},true)

	SendShadow("Right",{-300,87.5-25},{6,0},true)
	SendShadow("Left",{300,87.5-25},{-6,0},true)

	SendShadow("Right",{-300,87.5-50},{6,0},true)
	SendShadow("Left",{300,87.5-50},{-6,0},true)

	SendShadow("Right",{-300,87.5-75},{6,0},true)
	SendShadow("Left",{300,87.5-75},{-6,0},true)

	SendShadow("Right",{-300,87.5-100},{6,0},true)
	SendShadow("Left",{300,87.5-100},{-6,0},true)

	chosenSafePath = math.random(2)
	--if chosenSafePath == 1 then
		--SendShadow("Up",{-25,-340+40},{0,5},false)
		--SendShadow("Up",{-50,-330+40},{0,5},false)
		SendShadow("Up",{75,-320+40},{0,5},true)
		SendShadow("Up",{100,-310+40},{0,5},true)
		SendShadow("Up",{125,-300+40},{0,5},true)
	--else
		--SendShadow("Up",{25,-340+40},{0,5},false)
		--SendShadow("Up",{50,-330+40},{0,5},false)
		SendShadow("Up",{-75,-320+40},{0,5},true)
		SendShadow("Up",{-100,-310+40},{0,5},true)
		SendShadow("Up",{-125,-300+40},{0,5},true)
	--end
end

if spawntime==505 then
	SendShadow("Right",{-300,87.5},{6,0},true)
	SendShadow("Left",{300,87.5},{-6,0},true)
end
if spawntime==505+15 then
	SendShadow("Right",{-300,87.5-25},{6,0},true)
	SendShadow("Left",{300,87.5-25},{-6,0},true)

	SendShadow("Right",{-300,87.5},{6,0},true)
	SendShadow("Left",{300,87.5},{-6,0},true)
end
if spawntime==505+15+14 then
	SendShadow("Right",{-300,87.5-50},{6,0},true)
	SendShadow("Left",{300,87.5-50},{-6,0},true)

	SendShadow("Right",{-300,87.5-25},{6,0},true)
	SendShadow("Left",{300,87.5-25},{-6,0},true)
end
if spawntime==505+15+14+13 then
	SendShadow("Right",{-300,87.5-75},{6,0},true)
	SendShadow("Left",{300,87.5-75},{-6,0},true)

	SendShadow("Right",{-300,87.5-50},{6,0},true)
	SendShadow("Left",{300,87.5-50},{-6,0},true)
end
if spawntime==505+15+14+13+12 then
	SendShadow("Right",{-300,87.5-100},{6,0},true)
	SendShadow("Left",{300,87.5-100},{-6,0},true)
	AllSides()
	SendShadow("Right",{-300,87.5-75},{6,0},true)
	SendShadow("Left",{300,87.5-75},{-6,0},true)
end
if spawntime==505+15+14+13+12+11 then
	SendShadow("Right",{-300,87.5-125},{6,0},true)
	SendShadow("Left",{300,87.5-125},{-6,0},true)

	SendShadow("Right",{-300,87.5-100},{6,0},true)
	SendShadow("Left",{300,87.5-100},{-6,0},true)
end
if spawntime==505+15+14+13+12+11+10 then
	SendShadow("Right",{-300,87.5-150},{6,0},true)
	SendShadow("Left",{300,87.5-150},{-6,0},true)

	SendShadow("Right",{-300,87.5-125},{6,0},true)
	SendShadow("Left",{300,87.5-125},{-6,0},true)
end

if spawntime==656 then
	SendShadow("Right",{-300,87.5-175},{6,0},true)
	SendShadow("Left",{300,87.5-175},{-6,0},true)
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
			elseif (time-31)%10==0 and s.GetVar("istrue")==true then
			left[num].sprite.Set("Shadow"..s.GetVar("name2"))
			left[num].MoveTo(s.x,s.y)
			left[num].SetVar("time",0)
			left[num].SetVar("color","knife")
			left[num].SetVar("togo",true)
			num=num+1
			if num==201 then
				num=1
			end
		end
		if s.x>400 or s.x<-400 or s.y>300 or s.y<-300 then
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
			if time==20 then
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
	KnifeHurt(1)
elseif c=="knife2" then
	KnifeHurt(2)
end
end