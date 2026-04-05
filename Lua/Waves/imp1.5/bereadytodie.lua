require "Libraries/Playermove"
require "Libraries/hurt"
collision = require "Libraries/rotational_collision"
Arena.MoveToAndResize(320,105,110,110,true,true)
Player.MoveTo(0,0,true)
slices={}
knifes={}
beams={}
throw={}
warns={}
spawntime=-30
death=false
require "Libraries/colortoys"

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

function Update()
if death==false then
	spawntime=spawntime+1
	HurtUpd(1200)
	Moving()
	else
	death=death+1
	slices={}
	beams={}
	throw={}
	knife={}
	if death<60 then
		deadscreen.MoveToAbs(320+5*math.sin(death*math.pi/5),240)
		else
		FakeDeath()
	end
end
if spawntime==-29 then
	DoWarn(0,0,0)
	DoWarn(0,0,90)
end
if spawntime==30 then
	for i=1,4 do
		local knife=CreateProjectile("KnifeRight"..name4,300,300)
		knife.sprite.rotation=135+90*i
		knife.SetVar("rot",knife.sprite.rotation+180)
		knife.SetVar("time",0)
		knife.sprite.alpha=0
		table.insert(knifes,knife)
	end
end
for i=1,#throw do
	local knife=throw[i]
	if knife.isactive then
		local t=knife.GetVar("time")+1
		knife.SetVar("time",t)
		if t<31 then
			knife.sprite.alpha=math.sin(t*math.pi/60)
		end
		knife.Move(knife.GetVar("sx"),knife.GetVar("sy"))
		if (Player.x+34>knife.x and Player.x-34<knife.x) and (Player.y+34>knife.y and Player.y-34<knife.y) then
			if collision.CheckCollision(Player,knife) then
				KnifeHurt(2)
			end
		end
	end
end
for i=1,#knifes do
	local knife=knifes[i]
	if knife.isactive then
		local time=knife.GetVar("time")+1
		knife.SetVar("time",time)
		local rot=knife.GetVar("rot")
		if time<31 then
			knife.sprite.alpha=math.sin(time*math.pi/60)
		end
		if time<151 then
			local range=60
			if time<61 then
				range=60+240*(1-math.sin(time*math.pi/120))
			end
			local rotation=-360*5*(1-math.sin(time*math.pi/300))+rot
			knife.MoveTo(range*math.cos(rotation*math.pi/180),range*math.sin(rotation*math.pi/180))
			knife.sprite.rotation=rotation+180
			elseif time<211 then
			local range=60*math.sin((time-120)*math.pi/60)
			knife.MoveTo(range*math.cos(rot*math.pi/180),range*math.sin(rot*math.pi/180))
		end
		if (Player.x+34>knife.x and Player.x-34<knife.x) and (Player.y+34>knife.y and Player.y-34<knife.y) then
			if collision.CheckCollision(Player,knife) then
				KnifeHurt(1)
			end
		end
	end
end
if spawntime==180 then
	ThrowKnifes(0)
	elseif spawntime==240 then 
	ThrowKnifes(1)
	elseif spawntime==300 then
	ThrowKnifes(0)
	elseif spawntime==360 then
	ThrowKnifes(1)
	elseif spawntime==370 then
	DoWarn(0,0,0)
	elseif spawntime==430 then
	DoWarn(0,0,90)
	elseif spawntime==480 then
	DoWarn(0,0,0)
	elseif spawntime==540 then
	local rand=math.random(2)*2-3
	DoWarn(-35*rand,0,0,"strong")
	DoWarn(0,-35*rand,90,"strong")
	DoWarn(35*rand,0,180,"strong")
	DoWarn(0,35*rand,270,"strong")
	elseif spawntime==600 then
	DoWarn(0,0,45)
	DoWarn(0,0,-45)
	elseif spawntime==661 then
	for i=1,4 do
		knifes[i].Remove()
	end
	elseif spawntime==640 then
	DoWarn(0,0,90,"strong")
	DoWarn(0,0,0,"strong")
end
if spawntime%90==30 and spawntime>800 then
	DoWarn(Player.x,Player.y,0)
	DoWarn(Player.x,Player.y,90)
end
for i=1,#slices do
	local s=slices[i]
	if s.isactive then
		local time=s.GetVar("time")+1
		s.SetVar("time",time)
		if time<31 and time%5==0 then
			s.sprite.Set("att"..time/5)
			elseif time==31 then
			s.sprite.Set("deadlyslice")
			Audio.PlaySound("bolt")
			elseif time<61 then
			s.sprite.alpha=math.cos((time-31)*math.pi/60)
			elseif time==61 then
			s.Remove()
		end
		if time>30 and time<36 then
			if collision.CheckCollision(Player,s)==true then
				if GetGlobal("KnifeProtection") == true then
				if Player.hp > 33 then
					LongHurt(33,33)
				else
					DeadEnd()
				end
		else
				DeadEnd()
		end
			end	
		end
	end
end
for i=1,#warns do
	local w=warns[i]
	if w.isactive then
		local time=w.GetVar("time")+1
		w.SetVar("time",time)
		if time<30 then
			if time%5==1 then
				if time%10==1 then
					w.sprite.color={1,0,0}
					else
					w.sprite.color={1,1,0}
				end
			end
			else
			DoSlice(w.x,w.y,w.sprite.rotation,w.GetVar("strong"))
			w.Remove()
		end
	end
end
for i=1,#beams do
	local b=beams[i]
	if b.isactive then
		local time=b.GetVar("time")+1
		b.SetVar("time",time)
		if time<31 then
			b.sprite.alpha=math.sin(time*math.pi/60)
		end
		if time<31 then
			local away=b.GetVar("away")+80*(1-math.sin(time*math.pi/60))
			local px=b.GetVar("px")
			local py=b.GetVar("py")
			local rotation=b.sprite.rotation+90
			b.MoveTo(px+away*math.cos(rotation*math.pi/180),py+away*math.sin(rotation*math.pi/180))
			if time==30 then
				b.SetVar("time",60)
			end
			elseif time==61 then
			local waittime=b.GetVar("awaittime")
			if waittime>0 then
				waittime=waittime-1
				b.SetVar("time",60)
			end
			b.SetVar("awaittime",waittime)
			elseif time<91 then
			local away=b.GetVar("away")
			local rotation=b.sprite.rotation+90
			local px=b.GetVar("px")+4*math.cos((rotation-90)*math.pi/180)*math.sin((time-60)*math.pi/6)
			local py=b.GetVar("py")+4*math.sin((rotation-90)*math.pi/180)*math.sin((time-60)*math.pi/6)
			b.MoveTo(px+away*math.cos(rotation*math.pi/180),py+away*math.sin(rotation*math.pi/180))
			elseif time==91 then
			Audio.PlaySound("lasershot")
			local away=b.GetVar("away")
			local px=b.GetVar("px")
			local py=b.GetVar("py")
			b.sprite.Set("blaster2")
			local rotation=b.sprite.rotation+90
			b.MoveTo(px+away*math.cos(rotation*math.pi/180),py+away*math.sin(rotation*math.pi/180))
			local laser=CreateProjectile("laser0/laserv2",0,0)
			laser.SetVar("time", math.random(30)/10)
			b.sprite.SendToTop()
			laser.sprite.rotation=b.sprite.rotation
			b.SetVar("laser",laser)
			elseif time<211 then
			b.sprite.alpha=math.cos((time-90)*math.pi/120)
			local rotation=b.sprite.rotation+90
			local speed=3*(1-math.cos((time-90)*math.pi/120))
			b.Move(speed*math.cos(rotation*math.pi/180),speed*math.sin(rotation*math.pi/180))
			elseif time==211 then
			b.Remove()
		end
		if time>90 and time<211 then
			local l=b.GetVar("laser")
			local hueshift=l.GetVar("time") + 8*math.pi / 180
			l.sprite.color = color_multiply(hsv_to_rgb(hueshift, 1.0, 0.70), 0.5)
			l.SetVar("time",hueshift)
			local rot=b.sprite.rotation-90
			local ht=l.sprite.height
			l.MoveTo(b.x+math.cos(rot*math.pi/180)*550,b.y+math.sin(rot*math.pi/180)*550)
			if time<106 then
				l.sprite.Scale(0.8+0.2*math.sin((time-90)*math.pi/30),1)
				elseif time<181 then
				l.sprite.Scale(1-0.5*(1-math.cos((time-105)*math.pi/150)),1)
				l.sprite.alpha=0.6+0.4*math.cos((time-105)*math.pi/150)
				elseif time<211 then
				l.sprite.Scale(0.5-0.2*math.sin((time-180)*math.pi/60),1)
				l.sprite.alpha=0.6*(1-math.sin((time-180)*math.pi/60))
			end
			if time<181 then
				if collision.CheckCollision(Player,l) then
					KnifeHurt(5)
				end
			end
		end
	end
end

end


function OnHit()
end





function ThrowKnifes(ingo)
	for i=1,2 do
		for j=0,1 do
			local x=0
			local y=0
			local speedx=0
			local speedy=0
			local rot=0
			if ingo==0 then
				x=-30+i*20
				y=240-480*j
				speedy=-6+12*j
				rot=-90-180*j
				else
				x=240-480*j
				y=-30+i*20
				speedx=-6+12*j
				rot=180-180*j
			end
			local knife=CreateProjectile("KnifeRight"..name3,x,y)
			knife.sprite.rotation=rot
			knife.SetVar("sx",speedx)
			knife.SetVar("sy",speedy)
			knife.sprite.alpha=0
			knife.SetVar("time",0)
			table.insert(throw,knife)
		end
	end
end
function DeadEnd()
	Encounter.Call("SetMusic","none")
	death=0
	spawntime=-1
	NewAudio.Play("Hits")
  	deadscreen = CreateProjectileAbs("999999", 320, 240)
end

function DoWarn(pointx,pointy,rot,strong)
	local warn=CreateProjectile("chara/warnline",pointx,pointy)
	table.insert(warns,warn)
	warn.SetVar("strong",strong)
	if strong=="strong" then
		warn.sprite.Scale(2,2)
	end
	warn.SetVar("time",0)
	warn.sprite.rotation=rot
end
function DoSlice(pointx,pointy,rotation,strong)
	local slice=CreateProjectile("empty",pointx,pointy)
	slice.sprite.rotation=rotation
	if strong=="strong" then
		slice.sprite.Scale(2,2)
	end
	slice.SetVar("time",0)
	Audio.PlaySound("slice2")
	table.insert(slices,slice)
end