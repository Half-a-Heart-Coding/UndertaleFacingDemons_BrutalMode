Arena.Resize(270,150)
spawntime=0
paps = CreateSprite("Asriel_Sprite")
paps.SendToBottom()
paps.x = 380
paps.y = 365
paps.Scale(2, 2)
paps.alpha = 0.0
battlesprites={}
table.insert(battlesprites,paps)
ugol={}
knifesleft={}
knifesright={}
require "Libraries/Playermove"
require "Libraries/hurt"
lasers={}
timer1={}
timer2={}
stars={}
beams={}
nohittingtimer=0
function Update()
HurtUpd(600)
Moving()
if nohittingtimer>0 then
	nohittingtimer=nohittingtimer-1
end
paps.alpha = 0.5*math.sin(spawntime*math.pi/580)
if spawntime<300 or spawntime==300  then
   paps.x = 330+90*math.sin(spawntime*math.pi/580)
   elseif spawntime==380 then
   paps.SendToTop()
   else paps.x = 510-90*math.sin(spawntime*math.pi/580)
end
hue1=0.3+0.4*math.sin(spawntime*math.pi/60)
hue2=0.4+0.6*math.sin(spawntime*math.pi/50)
hue3=0.5+0.5*math.sin(spawntime*math.pi/40)
if not death then
	spawntime=spawntime+1
	else spawntime=1
end
if spawntime%120==0 then
	rand=(math.random(6)*45-22.5-135)
	local laser=CreateProjectile("blaster1",rand,230)
	laser.sprite.alpha=0
	table.insert(lasers,laser)
	if not death then
		Audio.PlaySound("sfx_BlasterEntry")
	end
end
for i=1,#lasers do
	local laser = lasers[i]
	if not timer1[i] then
		timer1[i]=0
		ugol[i]=6
		else timer1[i]=timer1[i]+1
	end
	if timer1[i]<40 then
		laser.sprite.alpha=laser.sprite.alpha+0.025
		elseif timer1[i]==40 then
		laser.sprite.Set("blaster2")
		local beam=CreateProjectile("laser0/laserv2",laser.x,laser.y-660)
		table.insert(beams,beam)
		beam.SetVar("color","beam")
		beam.sprite.alpha=0
		if not death then
			Audio.PlaySound("lasershot")
		end
		elseif timer1[i]>40 and timer1[i]<67 and timer1[i]%3==1 then
		local star1=CreateProjectile("star",laser.x,laser.y)
		star1.SetVar("angle",270+ugol[i])
		star1.SetVar("color","star")
		table.insert(stars,star1)
		local star2=CreateProjectile("star",laser.x,laser.y)
		star2.SetVar("angle",270-ugol[i])
		star2.SetVar("color","star")
		table.insert(stars,star2)
		ugol[i]=ugol[i]+3
	end
	if timer1[i]>120 and timer1[i]<130 then
		laser.sprite.alpha=math.sin((timer1[i]-110)*math.pi/20)
	end
	if timer1[i]==130 then
		laser.Remove()
	end
end
for i=1,#stars do
	local star = stars[i]
	local angle = star.GetVar("angle")
	if star.isactive then
		star.sprite.color={hue1,hue2,hue3}
		star.MoveTo(star.x+8*math.cos(angle*math.pi/180),star.y+8*math.sin(angle*math.pi/180))
		star.sprite.rotation=star.sprite.rotation+5
	end
	if star.y<-90 then
		star.Remove()
	end
end
for i=1,#beams do
	local beam=beams[i]
	if not timer2[i] then
		timer2[i]=0
		else timer2[i]=timer2[i]+1
	end
	if timer2[i]<20 then
		beam.sprite.alpha=math.sin(timer2[i]*math.pi/40)
		elseif timer2[i]>50 and timer2[i]<90 then
		beam.sprite.alpha=math.sin((timer2[i]-10)*math.pi/80)
	end
	if timer2[i]==90 then
		beam.Remove()
	end
end
for i=1,#knifesleft do
	local knife = knifesleft[i]
	if knife.isactive then
		knife.Move(5,0)
	end
	if knife.x>115 then
		knife.Remove()
	end
end
for i=1,#knifesright do
	local knife = knifesright[i]
	if knife.isactive then
		knife.Move(-5,0)
	end
	if knife.x<-115 then
		knife.Remove()
	end
end
if spawntime%50==0 then
	rand2=Arena.height/15-1
	rand2=(math.random(rand2)*15)-Arena.height/2
	local knife = CreateProjectile("KnifeRight",-300,rand2)
	knife.SetVar("color","white")
        table.insert(knifesleft,knife)
end
if spawntime%50==25 then
	rand2=Arena.height/15-1
	rand2=(math.random(rand2)*15)-Arena.height/2
	local knife = CreateProjectile("KnifeLeft",300,rand2)
	knife.SetVar("color","white")
        table.insert(knifesright,knife)
end
end
function OnHit(attack)
	if attack.GetVar("color")=="beam" and not death then
	if Player.hp>3 then
        	Player.Hurt(3,0.001)
		else  SetGlobal("Playerisdead",true)
		EndWave()
		paps.alpha = 0.0
		SetGlobal("nocomment",true)
	end
		elseif attack.GetVar("color")=="white"  and not death then
	if Player.hp>1 then
        	Player.Hurt(1,0.001)
		else  SetGlobal("Playerisdead",true)
		EndWave()
		paps.alpha = 0.0
		SetGlobal("nocomment",true)
	end
		SetGlobal("curse",GetGlobal("curse")+1)
		elseif attack.GetVar("color")=="star"  and not death then
	if Player.hp>10 then
        	Player.Hurt(10,0.3)
		nohittingtimer=18
		elseif nohittingtimer==0  then
		  SetGlobal("Playerisdead",true)
		EndWave()
		paps.alpha = 0.0
		SetGlobal("nocomment",true)
	end
	end
end