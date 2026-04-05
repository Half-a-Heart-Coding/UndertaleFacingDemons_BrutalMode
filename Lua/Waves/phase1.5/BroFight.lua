require "Libraries/Playermove"
require "Libraries/hurt"
require "Libraries/colortoys"
collision = require "Libraries/rotational_collision"
spawntime=0
hue=0
shadows={}
left={}
blasters={}
broad={}
shad_anim={{1, 0, 0}, {0.5, 0, 0},{0,0,0},{0.5,0,0}}
local colorleft={}
for i=1,40 do
	colorleft[i]={0.75*math.cos(i*math.pi/80)}
end
local laserpar={}
for i=90,140 do
	if i<120 then
		laserpar[i]={1+math.sin(math.pi*(i-90)/40),1}
		else
		laserpar[i]={1+math.sqrt(2)/2+2*(1-math.cos((i-120)*math.pi/40)),1-math.sin((i-120)*math.pi/40)}
	end
end
		
Arena.ResizeImmediate(100,100)
Player.MoveTo(0,0)
for i=1,150 do
	left[i]=CreateProjectile("empty",0,0)
	left[i].SetVar("color",none)
	left[i].SetVar("togo",false)
end
num=1
local ghosts=Encounter.GetVar("ghostsappeared")
if not ghosts then
	ghosts={}
end
local Asriel=ghosts[1]


function DoBroad()
	local knife=CreateProjectile("KnifeDown",0,45)
	knife.sprite.SendToBottom()
	knife.SetVar("time",0)
	knife.SetVar("rot",1)
	knife.SetVar("color","knife")
	knife.sprite.alpha=0
	table.insert(broad,knife)
	knife=CreateProjectile("KnifeRight",-45,0)
	knife.sprite.SendToBottom()
	knife.SetVar("time",0)
	knife.SetVar("rot",2)
	knife.SetVar("color","knife")
	knife.sprite.alpha=0
	table.insert(broad,knife)
	knife=CreateProjectile("KnifeUp",0,-45)
	knife.sprite.SendToBottom()
	knife.SetVar("time",0)
	knife.SetVar("rot",3)
	knife.SetVar("color","knife")
	knife.sprite.alpha=0
	table.insert(broad,knife)
	knife=CreateProjectile("KnifeLeft",45,0)
	knife.sprite.SendToBottom()
	knife.SetVar("time",0)
	knife.SetVar("rot",0)
	knife.SetVar("color","knife")
	knife.sprite.alpha=0
	table.insert(broad,knife)
	local rand=math.random(4)
	for t=0,3 do
		local i=(t+rand)+1
		if i>4 then
			i=i-4
		end
		broad[i].SetVar("number",t-1)
	end
end

function SendShadow(name, position, speed, istrue, shadowtime)
	local knife=CreateProjectile("Knife"..name,position[1],position[2],"Top")
	knife.SetVar("speed",speed)
	knife.SetVar("name",name)
	knife.SetVar("time",0)
	knife.sprite.alpha=0
	if not shadowtime then
		knife.SetVar("shadowtime",8)
		else
		knife.SetVar("shadowtime",shadowtime)
	end
	knife.SetVar("istrue",istrue)
	knife.SetVar("color","knife")
	table.insert(shadows,knife)
	time=0
end

function SendBlaster(position,away,rotation,sound)
	local x=position[1]+(away+50)*math.cos(rotation*math.pi/180)
	local y=position[2]+(away+50)*math.sin(rotation*math.pi/180)
	local blaster=CreateProjectile("blaster",x,y,"Top")
	blaster.sprite.rotation=rotation-90
	table.insert(blasters,blaster)
	blaster.SetVar("time",0)
	blaster.SetVar("sound",sound)
	blaster.SetVar("pos",position)
	blaster.SetVar("away",away)
	blaster.SetVar("rot",rotation)
	if sound then
		Audio.PlaySound("sfx_BlasterEntry")
	end
end
function BorderShadows(ingo,istrue)
		SendShadow("Down",{ingo,300},{0,-6},istrue)
		SendShadow("Up",{ingo,-300},{0,6},istrue)
		SendShadow("Right",{-300,ingo},{6,0},istrue)
		SendShadow("Left",{300,ingo},{-6,0},istrue)
end
		

function Update()
	HurtUpd(810)
	Moving()
	hue = hue + 6*math.pi / 180
	if hue > math.pi * 2 then
		hue = hue - math.pi * 2
	end
	spawntime=spawntime+1
	if spawntime==570 then
		if not Asriel then
			else
			Asriel.SetVar("time",61)
		end
	end
	if spawntime==1 then
		--SendBlaster({0,0},100,180*math.random(2))
		SendBlaster({0,0},100,90,true)
		SendBlaster({0,0},100,180,false)
		SendBlaster({0,0},100,0,false)
		SendBlaster({0,0},100,270,false)
		elseif spawntime==90 then
		spawntime=119
		SendShadow("Right",{-300,40},{4,0},false)
		SendShadow("Left",{300,40},{-4,0},false)
		SendShadow("Right",{-300,-40},{4,0},false)
		SendShadow("Left",{300,-40},{-4,0},false)
		elseif spawntime==120 then
		SendBlaster({0,0},150,180,true)
		SendBlaster({0,0},150,0,false)
		elseif spawntime==200 then
		SendShadow("Down",{40,300},{0,-4},true)
		SendShadow("Up",{40,-300},{0,4},true)
		SendShadow("Down",{-40,300},{0,-4},true)
		SendShadow("Up",{-40,-300},{0,4},true)
		elseif spawntime==230 then
		SendBlaster({0,0},150,90,true)
		SendBlaster({0,0},150,270,false)
		elseif spawntime>309 and spawntime<321 and (spawntime-310)%10==0 then
		local pos=(spawntime-310)/10
		pos=pos*20
		SendShadow("Right",{-300,pos},{6,0},true)
		SendShadow("Left",{300,pos},{-6,0},true)
		SendShadow("Down",{pos,300},{0,-6},true)
		SendShadow("Up",{pos,-300},{0,6},true)
		pos=-pos
		SendShadow("Right",{-300,pos},{6,0},true)
		SendShadow("Left",{300,pos},{-6,0},true)
		SendShadow("Down",{pos,300},{0,-6},true)
		SendShadow("Up",{pos,-300},{0,6},true)
		elseif spawntime==340 then
		SendBlaster({0,40},150,0,true)
		SendBlaster({0,40},150,180,false)
		SendBlaster({0,-40},150,0,false)
		SendBlaster({0,-40},150,180,false)
		SendBlaster({40,0},150,90,true)
		SendBlaster({40,0},150,270,false)
		SendBlaster({-40,0},150,90,false)
		SendBlaster({-40,0},150,270,false)
		elseif spawntime==450 then
		DoBroad()
		elseif spawntime==510 then
		BorderShadows(40,true)
		BorderShadows(-40,true)
		elseif spawntime==580 then
		BorderShadows(20,false)
		BorderShadows(-20,false)
		elseif spawntime==640 then
		SendShadow("Right",{-45,360},{0,-4},true,4)
		SendShadow("Right",{-45,-360},{0,4},true,4)
		SendShadow("Left",{45,360},{0,-4},true,4)
		SendShadow("Left",{45,-360},{0,4},true,4)
		SendShadow("Down",{360,45},{-4,0},true,4)
		SendShadow("Down",{-360,45},{4,0},true,4)
		SendShadow("Up",{360,-45},{-4,0},true,4)
		SendShadow("Up",{-360,-45},{4,0},true,4)
	end
	
	for i=1,#blasters do
		local blaster=blasters[i]
		if blaster.isactive then
			local time=blaster.GetVar("time")+1
			blaster.SetVar("time",time)
			local sound=blaster.GetVar("sound")
			local angle=blaster.GetVar("rot")
			local position=blaster.GetVar("pos")
			local away=blaster.GetVar("away")
			if time<61 then
				blaster.sprite.alpha=math.sin(time*math.pi/120)
				local awayhere=away+50*(1-math.sin(time*math.pi/120))
				blaster.MoveTo(position[1]+awayhere*math.cos(angle*math.pi/180),position[2]+awayhere*math.sin(angle*math.pi/180))
				blaster.SetVar("oldpos",{blaster.x,blaster.y})
				elseif time<91 then
				if time%1==0 then
					local pos=blaster.GetVar("oldpos")
					local away=0
					if time<80 then
						away=2*math.sin(time*math.pi/4)
						else
						away=3*math.sin(time*math.pi/2)
					end
					blaster.MoveTo(pos[1]+away*math.cos((angle+90)*math.pi/180),pos[2]+away*math.sin((angle+90)*math.pi/180))
				end
				elseif time<121 then
				if time==91 then
					local ang=blaster.sprite.rotation
					local str="laser1/laserv3"
					if ang==90 or ang==270 then
						str="laser1/laserh3"
					end
					local laser=CreateProjectile(str,blaster.x+650*math.sin(ang*math.pi/180),blaster.y-650*math.cos(ang*math.pi/180))
					local beam=CreateProjectile(str,laser.x,laser.y)
					blaster.SetVar("beam",beam)
					laser.SetVar("color","laser")
					beam.SetVar("color","beam")
					blaster.SetVar("laser",laser)
					blaster.sprite.SendToTop()
					blaster.sprite.Set("blaster2")
					if sound then
						Audio.PlaySound("sfx_Blaster")
					end
					blaster.SetVar("hue",math.random(360))
				end
				local awayhere=away+80*math.sin((time-90)*math.pi/60)
				blaster.MoveTo(position[1]+awayhere*math.cos(angle*math.pi/180),position[2]+awayhere*math.sin(angle*math.pi/180))
				local laser=blaster.GetVar("laser")
				local beam=blaster.GetVar("beam")
				laser.SetVar("color","laser")
				beam.SetVar("color","beam")
				local ang=blaster.sprite.rotation
				laser.MoveTo(blaster.x+650*math.sin(ang*math.pi/180),blaster.y-650*math.cos(ang*math.pi/180))
				beam.MoveTo(laser.x,laser.y)
				elseif time<141 then
				blaster.sprite.alpha=math.cos((time-120)*math.pi/40)
			end
			if time>90 then
				local laser=blaster.GetVar("laser")
				local h=blaster.GetVar("hue")
				local beam=blaster.GetVar("beam")
				laser.sprite.color=color_multiply(hsv_to_rgb((hue+h*math.pi/180), 1.0, 0.70), 1.0)
				local size=laserpar[time]
				if blaster.sprite.rotation==0 or blaster.sprite.rotation==180 then
					laser.sprite.Scale(size[1],1)
					beam.sprite.scale(size[1]/4,1)
					else
					laser.sprite.Scale(1,size[1])
					beam.sprite.scale(1,size[1]/4)
				end
				beam.sprite.alpha=size[2]
				laser.sprite.alpha=size[2]
			end
			if time==140 then
				local laser=blaster.GetVar("laser")
				local beam=blaster.GetVar("beam")
				beam.Remove()
				laser.Remove()
				blaster.Remove()
			end
		end
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
				elseif (time-31)%s.GetVar("shadowtime")==0 and s.GetVar("istrue")==true then
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
			if s.x>600 or s.x<-600 or s.y>600 or s.y<-600 then
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
				local t=colorleft[time]
				s.sprite.color={1,1,1}
				s.sprite.alpha=t[1]
				if time==30 then
					s.SetVar("color","none")
				end
				else
				s.SetVar("togo",false)
				s.MoveToAbs(-100,0)
			end
		end
	end
	for i=1,#broad do
		local b=broad[i]
		if b.isactive then
			local time=b.GetVar("time")+1
			b.SetVar("time",time)
			local n=b.GetVar("number")*-20
			local angle=b.GetVar("rot")
			if time<31 then
				b.sprite.alpha=math.sin(time*math.pi/60)
				elseif time>40 and time<71 then
				local away=45+15*math.sin((time-40)*math.pi/60)
				b.MoveTo(away*math.cos(angle*math.pi/2),away*math.sin(angle*math.pi/2))
				elseif time>70 and time<90 then
				local away=60-48*math.sin((time-70)*math.pi/40)
				b.MoveTo(away*math.cos(angle*math.pi/2),away*math.sin(angle*math.pi/2))
				elseif time==140 then
				elseif time>230 and time<261 then
				local away=12+46*math.sin((time-230)*math.pi/60)
				b.MoveTo(away*math.cos(angle*math.pi/2),away*math.sin(angle*math.pi/2))
			end
		end
	end
				
end

function OnHit(ingo)
local c=ingo.GetVar("color")
if c=="knife" then
	KnifeHurt(1)
	elseif c=="laser" and ingo.sprite.alpha>0.75 then
	KnifeHurt(1)
	elseif c=="beam" and ingo.sprite.alpha>0.75 then
	KnifeHurt(3)
end
end