shadealpha=0
knifes={}
shadows={}
require "Libraries/Playermove"
require "Libraries/hurt"
spawntime=0
left={}

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

function SendShadow(name, position, speed, istrue)
	local knife=CreateProjectile("Knife"..name..name3,position[1],position[2],"Top")
	knife.SetVar("speed",speed)
	knife.SetVar("name",name)
	knife.SetVar("time",0)
	knife.sprite.alpha=0
	knife.SetVar("istrue",istrue)
	knife.SetVar("color","knife")
	table.insert(shadows,knife)
	time=0
end


for i=1,150 do
	left[i]=CreateProjectile("bomb",0,0)
	left[i].sprite.alpha=0
	left[i].SetVar("color","none")
	left[i].SetVar("togo",false)
end
num=1

function DoKnifes()
	local rand1=math.random(7)
	local rand2=rand1
	while rand2==rand1 do
		rand2=math.random(7)
	end
	for i=1,7 do
		if rand1==i or rand2==i then
			else
			local k=CreateProjectile("KnifeDown"..name3,-80+(160/7)*(i-0.5),220,"Top")
			k.sprite.alpha=0
			k.SetVar("time",0)
			k.SetVar("speed",{0,-3})
			k.SetVar("top",220)
			k.SetVar("alph",1)
			k.SetVar("color","knife")
			table.insert(knifes,k)
		end
	end
end


Arena.ResizeImmediate(160,160)
function Update()
spawntime=spawntime+1
HurtUpd(900)
Moving()
if spawntime%100==60 then
	DoKnifes()
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
			left[num].sprite.Set("Shadow"..s.GetVar("name"))
			left[num].MoveTo(s.x,s.y)
			left[num].SetVar("time",0)
			left[num].SetVar("color","knife")
			left[num].SetVar("togo",true)
			num=num+1
			if num==151 then
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

if spawntime%27==0 then
	if spawntime%54==27 then

		local rand1=math.random(6)
		local y=-80+160/6*(-0.5+rand1)
		SendShadow("Left", {220,y}, {-4,0}, true)
		else
		local rand1=math.random(5)
		local y=-80+160/6*(-0.5+rand1)
		SendShadow("Right", {-220,y}, {4,0}, true)
	end
end
for i=1,#knifes do
	local k=knifes[i]
	if k.isactive then
		local speed=k.GetVar("speed")
		k.Move(speed[1],speed[2])
		local time=k.GetVar("time")+1
		local top=k.GetVar("top")
		k.SetVar("time",time)
		if time<31 then
			k.sprite.alpha=math.sin(time*math.pi/60)*k.GetVar("alph")
		end
		if time>top-30 and time<top then
			k.sprite.alpha=math.sin((time-top+60)*math.pi/60)*k.GetVar("alph")
			elseif time==top then
			k.Remove()
		end
	end
end
end

function OnHit(g)
	if g.GetVar("color")=="knife" then
		KnifeHurt(2)
		elseif g.GetVar("color")=="shadow" then
		KnifeHurt(1)
	end
end