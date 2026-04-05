shadealpha=0
knifes={}
require "Libraries/Playermove"
require "Libraries/hurt"
collision = require "Libraries/rotational_collision"
require "Libraries/colortoys"
spawntime=100
poses={}
Arena.MoveToAndResize(320,210,220,60,true,true)
Player.SetControlOverride(true)
Player.sprite.color={1,0.5,0}
name5="Fatal"
if Encounter.GetVar("diff")==30 then
	name5="Mutant"
end
for i=1,10 do
	local k=CreateProjectile("KnifeDown"..name5,-110+(220/10)*(i-0.5),150)
	k.sprite.alpha=0
	k.SetVar("time",-60)
	k.SetVar("color","fatal")
	knifes[i]=k
end

if Encounter.GetVar("diff")~= 30 and Encounter.GetVar("diff")~= 28 and Encounter.GetVar("diff")~= 27 then
	Encounter.SetVar("SavedProg",67)
end

chargeTime=0
charged=false
warns={}
beams={}
slices={}
spawntime2=0

DoGhost("smile",0,600)
function Update()
if endgame==false and isMoving() then
	spawntime=spawntime+1
	spawntime2=spawntime2+1
end
if spawntime==1 and isMoving() then
	choises={}
	choises[1]=math.random(10)
	--choises[2]=choises[1]
	--while choises[1]==choises[2] do
	--	choises[2]=math.random(10)
	--end
	--choises[3]=math.random(10)
	--while choises[3]==choises[2] or choises[1]==choises[3] do
	--	choises[3]=math.random(10)
	--end
	--if isMoving() then
		knifes[choises[1]].SetVar("time",knifes[choises[1]].GetVar("time")+1)
	--end
	--knifes[choises[2]].SetVar("time",knifes[choises[2]].GetVar("time")+1)
	--knifes[choises[3]].SetVar("time",knifes[choises[3]].GetVar("time")+1)
	knifes[choises[1]].SetVar("side",math.random(2)*2-3)
	--knifes[choises[2]].SetVar("side",math.random(2)*2-3)
	--knifes[choises[3]].SetVar("side",math.random(2)*2-3)
	elseif spawntime==15 then
	for i=1,10 do
		if i==choises[1] then
			DoWarn(knifes[choises[1]].x,0,0)
			else
			--if isMoving() then
				knifes[i].SetVar("time",knifes[i].GetVar("time")+1)
			--end
			knifes[i].SetVar("side",math.random(2)*2-3)
		end
	end
end
HurtUpd(999999999999999)
Moving()
SetGlobal("purpleSpeedTimer",60)
if spawntime2>=900 then
	EndWave()
end
if Input.Confirm>0 and charged ~= true and chargeTime>=0 then 
		SetGlobal("purpleSpeed",-0.5)
		chargeTime=-30
		charged=true
		--local force = CreateProjectile("green/force",0,0)
		--force.SetVar("scalex",0.5)
		--force.sprite.color={0.5,0.5,1}
		--force.SetVar("scaley",0.5)
		--table.insert(forces,force)
	else
		if chargeTime<0 then
			--if Input.Confirm<=0 then
				chargeTime=chargeTime+1
			--end
			if chargeTime<-25 then
				--Player.sprite.color={0, 0.35, 1}
				SetGlobal("purpleSpeed",-0.75)
			elseif chargeTime==-25 then
				--Player.sprite.color={0, 0.35, 1}
				SetGlobal("purpleSpeed",-0.5)
			else
				--Player.sprite.color={0, 0.5, 1}
				SetGlobal("purpleSpeed",-0.1)
			end
		else
			chargeTime=30
			SetGlobal("purpleSpeed",-0.1)
			--Player.sprite.color={0/255, 168/255, 242/255}
			charged=false
		end
	end
if endgame==true then
	  deadtime=deadtime+1
	  Encounter.Call("SetMusic","none")
	  Player.SetControlOverride(true)
	  if  deadtime<60 then
		 deadscreen = CreateProjectile("999999", 0,0)
		 deadtime=60
		 else
		 deadscreen.MoveTo(5*math.sin(deadtime*math.pi/5),0)
	  end
	  if deadtime==120 then
		FakeDeath()
	  end
	end
local count=0
for i=1,#knifes do
	local k=knifes[i]
	if k.isactive then
		local time=k.GetVar("time")
		local side=k.GetVar("side")
		if isMoving() then
			if time<0 then
				time=time+1
				k.sprite.alpha=math.sin((60+time)*math.pi/120)
				elseif time%210==0 then
				count=count+1
				elseif time%210==105 then
				count=count+1
				elseif time%210>90 and time%210<105 then
				time=time+1
				k.sprite.rotation=(90-90*math.cos((time%210-90)*math.pi/15))*side
				elseif time%210>195 and time%210<210 then
				time=time+1
				k.sprite.rotation=(90+90*math.cos((time%210-195)*math.pi/15))*side
				else
				time=time+1
				local t=time%210
				if t>100 then
					t=t-15
				end
				local cos=math.abs(math.cos(t*math.pi/90))
				cos=math.sqrt(cos)
				if t>45 and t<135 then
					cos=-cos
					--if (k==knifes[choises[1]] or (spawntime2>900 and (k==knifes[choises[1]+1] or k==knifes[choises[1]-1]))) and (k.y<=40 and k.y>=-40) then
						--DoWarn(k.x,0,0)
					--end
				end
				k.MoveTo(k.x,150*cos)
			end
		end
		k.SetVar("time",time)
	end
end
if count==10 and spawntime>1 then
	spawntime=0
	--DoWarn(Player.x,Player.y,90)
end

for i=1,#slices do
	local s=slices[i]
	if s.isactive then
		local time=s.GetVar("time")
		if isMoving() then
			time=time+1
		end
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
				if Player.hp > 25 and Encounter.GetVar("diff") == 17 then
					LongHurt(25,60)
				elseif Player.hp > 33 then
					LongHurt(33,60)
				else
					GameOver()
				end
			else
				GameOver()
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
		if time<60 then
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

vzmahi = {}
deadtime=0
blasts = {}

endgame = false
lastsecond = 0
sdvig = 1

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

function GameOver()
	Audio.Stop()
	Player.SetControlOverride(true)
	playerspeed_x = 0
	playerspeed_y = 0
	Player.sprite.rotation = 0
	endgame = true
	incontrol = false
	endwave=true
end 

function OnHit(knife)
	if knife.GetVar("color") == "fatal" then
		if GetGlobal("KnifeProtection") == true then
			if Player.hp > 25 and Encounter.GetVar("diff") == 17 then
				LongHurt(25,60)
			elseif Player.hp > 33 then
				LongHurt(33,60)
			else
				GameOver()
			end
		else
			GameOver()
		end
		--Effects("curse",2)
	elseif knife.GetVar("color") == "red" then
		KnifeHurt(5)
		--Effects("curse",2)
	elseif knife.GetVar("color") == "blue" and isMoving() then
		KnifeHurt(2)
		--Effects("curse",1)
	elseif knife.GetVar("color") == "orange" and not isMoving() then
		KnifeHurt(2)
		--Effects("curse",1)
	elseif knife.GetVar("color") == "purple" then
		--KnifeHurt(1)
		--SetGlobal("purpleSpeed",9)
		--Effects("curse",1)
	end
end