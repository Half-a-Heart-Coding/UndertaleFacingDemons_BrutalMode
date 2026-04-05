Arena.ResizeImmediate(200,200)
require "Libraries/colortoys"
collision = require "Libraries/rotational_collision"
require "Libraries/Playermove"
require "Libraries/hurt"
stars={}
knifes={}
speedx={}
safe3={}
safe4={}
safety={}
speedy={}
warnings={}
timer={}
true_anim = Gradient.new ({{0,1,0},{1,1,1},{0,1,0}})
false_anim = Gradient.new ({{1,0,0},{1,1,1},{1,0,0}})
spawntime=0
DoGhost("Asriel_Sprite",1,1200)

function CreateArrow(side,real)
	local arrow=CreateProjectile("arrow",-200,200)
	arrow.sprite.rotation=-90+90*side+90*(real-1)
	table.insert(warnings,arrow)
	arrow.SetVar("side",side)
	arrow.SetVar("real",real)
	arrow.SetVar("time",-1)
end

function SendKnife(side)
	if side==1 or side==3 then
		local from=math.random(2)*2-3
		local knife=CreateProjectile("KnifeDown",-80+20*math.random(7),200*from)
		knife.SetVar("color","knife")
		knife.sprite.rotation=90*(from-1)
		knife.SetVar("speed",{0,-6*from})
		knife.SetVar("stars",{6*(side-2),0})
		knife.SetVar("time",0)
		table.insert(knifes,knife)
		elseif side==2 or side==4 then
		local from=math.random(2)*2-3
		local knife=CreateProjectile("KnifeLeft",200*from,-80+20*math.random(7))
		knife.SetVar("color","knife")
		knife.sprite.rotation=90*(from-1)
		knife.SetVar("speed",{-6*from,0})
		knife.SetVar("stars",{0,6*(side-3)})
		knife.SetVar("time",0)
		table.insert(knifes,knife)
	end
end

function SendToFly()
	for i=1,#stars do
		stars[i].SetVar("fly",true)
	end
end


function Update()
HurtUpd(1200)
Moving()
hue=1-0.5*math.sin(math.pi*spawntime/30)
if spawntime%150==0 then
	if spawntime>600 then
		local truth1=math.random(2)*2-3
		local truth2=math.random(2)*2-3
		local vert=math.random(2)*2-3
		local hor=math.random(2)*2-3
		CreateArrow(3-vert,truth1)
		CreateArrow(2-hor,truth2)
		else
		local side=math.random(4)
		local truth=math.random(2)*2-3
		CreateArrow(side,truth)
	end
end
for i=1,#warnings do
	local w=warnings[i]
	if w.isactive then
		local time=w.GetVar("time")+1
		w.SetVar("time",time)
		local real=w.GetVar("real")
		local side=w.GetVar("side")
		if time%3==0 then
			if time%6==0 then
				if real==1 then
					w.sprite.color={0,1,0}
					else
					w.sprite.color={1,0,0}
				end
				else
				w.sprite.color={1,1,1}
			end
		end
		if time==90 then
			SendKnife(side)
			w.Remove()
		end
	end
end
if spawntime%150==140 then
   SendToFly()
end
for i=1,#knifes do
	local k=knifes[i]
	if k.isactive then
		local speed=k.GetVar("speed")
		k.Move(speed[1],speed[2])
		local time=k.GetVar("time")+1
		k.SetVar("time",time)
		local stare=k.GetVar("stars")
		if k.x<100 and k.x>-100 and k.y<100 and k.y>-100 and time%2==1 then
			local star=CreateProjectile("star",k.x,k.y)
			star.SetVar("color","asriel")
			star.SetVar("speed",stare)
			table.insert(stars,star)
			star.SetVar("fly",false)
		end
		if time==50 then
			k.Remove()
		end
	end
end
for i=1,#stars do
	local s=stars[i]
	if s.isactive then
		s.sprite.color=color_multiply(hsv_to_rgb(hue, 1.0, 0.70), 1.0)
		if s.GetVar("fly")==true then
			local speed=s.GetVar("speed")
			s.Move(speed[1],speed[2])
			if s.x>600 or s.x<-600 or s.y>300 or s.y<-300 then
				s.Remove()
			end
		end
	end
end
if Input.Menu==1 then
	DEBUG(Encounter.GetVar("diff"))
end
spawntime=spawntime+1
end
function OnHit(attacks)
if attacks.GetVar("color") == "asriel" then
   if Player.hp<16 and Encounter.GetVar("diff")<4 then
      LongHurt(Player.hp-1,60)
      else LongHurt(15,60)
   end
   elseif attacks.GetVar("color") == "knife" then
   KnifeHurt(1)
end
end