Arena.Resize(200,160)
collision = require "Libraries/rotational_collision"
wavetime=0
Player.SetControlOverride(true)
knifetime=0
firespawn=0
hurttime=0
timespeed=1
speedy=0
knifes={}
rings={}
timer1={}
timer2={}
timer3={}
timer4={}
fires={}
leafs={}
lasers={}
death=false
deadtime=0
asgore=CreateSprite("Asgore_Sprite")
asgore.SendToBottom()
asgore.x=330
asgore.y=376
asgore.Scale(2,2)
asgore.alpha=0
tori=CreateSprite("Toriel_Sprite")
tori.SendToBottom()
tori.x=330
tori.y=367
tori.Scale(2,2)
tori.alpha=0
pairtime=0
battlesprites={}
table.insert(battlesprites,asgore)
table.insert(battlesprites,tori)
spritetime=0
blues={}
slashs={}
slashtime=0
function CreateRing(away)
	for i=1,12 do
		local knife = CreateProjectile("KnifeLeft",math.cos(i*30*math.pi/180)*away,math.sin(i*30*math.pi/180)*away)
		table.insert(rings,knife)
		knife.SetVar("away",away)
		knife.SetVar("i",i)
		knife.sprite.rotation=i*30
		if away==225 then
			knife.SetVar("rotation",1)
			else knife.SetVar("rotation",-1)
		end
	end
end
function CreatePair()
		local left_right = math.random(0,1)
		if left_right == 1 then
			left_right = "leaf_l"
			else
			left_right = "leaf_r"
		end
		local leaf = CreateProjectile(left_right, math.random() * Arena.width - Arena.width / 2, 0 + Arena.height / 2 + 16)
		leaf.SetVar("xspeed", Time.time)
		leaf.SetVar("yspeed", 0)
		leaf.SetVar("angle", 0)
		leaf.SetVar("orient", left_right)
		leaf.SetVar('color', "asgore")
		table.insert(leafs, leaf)
		local dir=math.random(2)*2-3
		local height = math.random(80)-81
		local fire=CreateProjectile("bullet",dir*300,height)
		fire.SetVar("dir",-dir)
		table.insert(fires,fire)
		fire.SetVar("color","tori")
end
function FIVE()
	for i=0,4 do
		local knife= CreateProjectile("KnifeLeft",math.cos((i*72+90)*math.pi/180)*160,math.sin((i*72+90)*math.pi/180)*160)
		table.insert(knifes,knife)
		knife.SetVar("i",i)
		knife.sprite.rotation=i*72+100
		knife.SetVar("color","knife")
	end
end
function Hurt(damage,timer)
	if death==false then
		if hurttime>0 then
			else Audio.PlaySound("hurtsound")
			if Player.hp>damage then
				Player.Hurt(damage,0)
				hurttime=timer
				else Player.hp=1
				hurttime=99999
				SetGlobal("Playerisdead",true)
				EndWave()
				SetGlobal("nocomment",true)
			end
		end
	end
end
function Update()
if death==true then
  knifetime=1
  pairtime=1
  deadtime=deadtime+1
  if  deadtime<60 then
     deadscreen = CreateProjectile("999999", 0,145-Arena.height/2)
     deadscreen.sprite.rotation=0
     deadtime=60
     Audio.Stop()
     else
     deadscreen.MoveTo(5*math.sin(deadtime*math.pi/5),145-Arena.height/2)
     deadscreen.sprite.rotation=0
	deadscreen.sprite.SendToTop()
  end
  if deadtime==120 then
	SetGlobal("Playerisdead",true)
	EndWave()
	SetGlobal("nocomment",true)
	asgore.alpha=0
	tori.alpha=0
  end
end
if wavetime<520 then
	timespeed=1
	elseif wavetime<691 then
	if wavetime==532 then
		Audio.PlaySound("timeslow")
		elseif wavetime==592 then
		Audio.PlaySound("OMAE")
	end
	timespeed=0.2+0.8*math.cos((wavetime-520)*math.pi/360)
	elseif wavetime==720 then
	local slash=CreateProjectile("chara/att0",Player.x+4,Player.y)
	Audio.PlaySound("sliceslow")
	table.insert(slashs,slash)
	elseif death==false then
	slashtime=slashtime+1
end
for i=1,#slashs do
	local slash=slashs[i]
	if slashtime==140 then
		local laser = CreateProjectile('laser0/laserv0', Player.x, Player.y)
	end
	if slashtime%20==1 then
		if slashtime==141 then
			death=true
			slashtime=1
			Audio.PlaySound("bolt")
			else slash.sprite.Set("chara/att"..((slashtime-1)/20))
		end
	end
	slash.MoveTo(Player.x+4,Player.y)
end
for i=1,#leafs do
	local bullet = leafs[i]
	local velx = bullet.GetVar('xspeed')
	local vely = bullet.GetVar('yspeed')
	local orientation = bullet.GetVar('orient')
	velx = velx + timespeed 
	bullet.SetVar("xspeed", velx)
	vely = math.cos(2*velx*math.pi/180)*math.cos(2*velx*math.pi/180)
	bullet.SetVar("yspeed", vely+2)
	bullet.Move(math.sin(2*velx*math.pi/180), -vely)
	if orientation == "leaf_l" then
		bullet.sprite.rotation = 20+20*math.sin(2*velx*math.pi/180)
	else
		bullet.sprite.rotation = -20+20*math.sin(2*velx*math.pi/180)
	end
end
for i=1,#fires do
	local fire=fires[i]
	local dir=fire.GetVar("dir")
	if fire.isactive then
		fire.Move(3*dir*timespeed,0)
		if dir==1 then
			if fire.x>300 then
				fire.Remove()
			end
			else
			if fire.x<-300 then
				fire.Remove()
			end
		end
	end
end
if Input.Cancel>0 then
	speedy=1
	else speedy=2
end
if death==false then
if Input.Up>0 and Input.Down==0 then
	Player.MoveTo(Player.x,Player.y+speedy*timespeed,false)
	if bluelaser==true then
		Hurt(5,30)
	end
	elseif Input.Up==0 and Input.Down>0 then
	Player.MoveTo(Player.x,Player.y-speedy*timespeed,false)
	if bluelaser==true then
		Hurt(5,30)
	end
end
if Input.Right>0 and Input.Left==0 then
	Player.MoveTo(Player.x+speedy*timespeed,Player.y,false)
	if bluelaser==true then
		Hurt(5,30)
	end
	elseif Input.Right==0 and Input.Left>0 then
	Player.MoveTo(Player.x-speedy*timespeed,Player.y,false)
	if bluelaser==true then
		Hurt(5,30)
	end
end
end
if hurttime>0 then
	if hurttime%20>10 then
		Player.sprite.alpha=0.5
		else Player.sprite.alpha=1
	end
	hurttime=hurttime-timespeed
end
wavetime=wavetime+1
if wavetime>210 then
	knifetime=knifetime+timespeed
end
if wavetime>389 then
	pairtime=pairtime+timespeed
	spritetime=spritetime+timespeed
end
if spritetime<300 then
	local time=spritetime
	asgore.alpha=0.5*math.sin(time*math.pi/600)
	tori.alpha=0.5*math.sin(time*math.pi/600)
	asgore.x=320+140*math.sin(time*math.pi/600)
	tori.x=320-140*math.sin(time*math.pi/600)
end
if pairtime>11 then
	pairtime=pairtime-10
	CreatePair()
end
if wavetime==330 then
	local laser1 = CreateProjectile("blaster",-180,180)
	laser1.sprite.rotation=-45
	laser1.SetVar("side",1)
	local laser2 = CreateProjectile("blaster",180,180)
	laser2.sprite.rotation=45
	laser2.SetVar("side",-1)
	laser1.sprite.alpha=0
	laser2.sprite.alpha=0
	table.insert(lasers,laser1)
	table.insert(lasers,laser2)
	Audio.PlaySound("sfx_BlasterEntry")
end
for i=1,#lasers do
	local bl=lasers[i]
	local side=bl.GetVar("side")
	local dist = math.sqrt((Player.x-bl.x)*(Player.x-bl.x)+(Player.y-bl.y)*(Player.y-bl.y))
	bl.sprite.rotation = math.asin ((Player.x-bl.x)/(dist))*180/math.pi
	if not timer3[i] then
		timer3[i]=0
		else timer3[i]=timer3[i]+1
	end
	if timer3[i]<61 then
		bl.sprite.alpha=timer3[i]/60
		else
		if timer3[i]==61 then
			local blaster=CreateProjectile("laser0/blue",bl.x-(530.3*side),bl.y-530.3)
			Audio.PlaySound("lasershot")
			bluelaser=true
			blaster.sprite.alpha=0.05
			blaster.SetVar("i",i)
			table.insert(blues,blaster)
			bl.sprite.SendToTop()
			blaster.sprite.SendToBottom()
			bl.sprite.Set("blaster2")
		end
	end
end
for i=1,#blues do
	local bl=blues[i]
	local number=bl.GetVar("i")
	local blaster=lasers[number]
	if not timer4[i] then
		timer4[i]=0
		else timer4[i]=timer4[i]+1
	end
	if timer4[i]<10 then
		bl.sprite.alpha=0.05+0.05*timer4[i]
	end
	bl.MoveTo(blaster.x-700*math.cos((blaster.sprite.rotation+90)*math.pi/180),blaster.y-700*math.sin((blaster.sprite.rotation+90)*math.pi/180))
	--bl.MoveTo(0,0)
	bl.sprite.rotation=blaster.sprite.rotation
end
if wavetime<500 then
	CreateRing(161)
	elseif wavetime==90 then
	CreateRing(225)
	elseif wavetime==150 then
	CreateRing(289)
end	
if knifetime>25 then
	knifetime=knifetime-25
	FIVE()
end
for i=1,#rings do
	local knife=rings[i]
	if not timer1[i] then
		timer1[i]=0
		else timer1[i]=timer1[i]+timespeed
	end
	if timer1[i] <60 then
		knife.sprite.alpha=timer1[i]/60
		elseif timer1[i]==60 then
		knife.sprite.alpha=1
	end
	local away=knife.GetVar("away")
	local number=knife.GetVar("i")
	if knife.GetVar("rotation")==1 then
		knife.sprite.rotation=number*30+timer1[i]
		knife.MoveTo(away*math.cos((timer1[i]+number*30)*math.pi/180),away*math.sin((timer1[i]+number*30)*math.pi/180))
		else 
		knife.sprite.rotation=number*30-timer1[i]
		knife.MoveTo(away*math.cos((number*30-timer1[i])*math.pi/180),away*math.sin((number*30-timer1[i])*math.pi/180))
	end
end
for i=1,#knifes do
	local bullet=knifes[i]
	local rotation=bullet.GetVar("rotation")
	if not timer2[i] then
		timer2[i]=0
		else timer2[i]=timer2[i]+timespeed
	end
	if bullet.isactive then
		bullet.sprite.rotation=bullet.sprite.rotation-timespeed*2/3
		bullet.Move(-4*timespeed*math.cos(bullet.sprite.rotation*math.pi/180),-4*timespeed*math.sin(bullet.sprite.rotation*math.pi/180))
	end
	if timer2[i]>40 and bullet.isactive then
		bullet.Remove()
	end
end
end
function OnHit(attack)
local color=attack.GetVar("color")
if color=="knife" and collision.CheckCollision(Player, attack) and attack.sprite.alpha then
	Hurt(1,1)
	elseif color=="asgore" then
	Hurt(10,60)
	elseif color=="tori" then
	Hurt(1,8)
	if not GetGlobal("burn") then
		else
		SetGlobal("burn",GetGlobal("burn")+1)
	end
end
end
