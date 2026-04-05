Arena.Resize(200,160)
collision = require "Libraries/rotational_collision"
wavetime=-90
require "Libraries/hurt"
Player.SetControlOverride(true)
knifetime=0
spawntime=0
firespawn=0
hurttime=0
timespeed=1
speedy=0
hurted=0

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
--DoGhost("Asgore_Sprite",1,600)
--DoGhost("Toriel_Sprite",-1,600)
pairtime=0
battlesprites={}
spritetime=0
blues={}
slashs={}
slashtime=0
SoulSpeakTime=0

function DoRings(away)
	local time=390
	for i=1,5 do
		local side=1
		if away==225 then
			side=1
			else 
			side=-1
		end
		local tim=time-away/4
		local angle=tim*side+i*72
		local knife = CreateProjectile("KnifeRight",math.cos(angle*math.pi/180)*away,math.sin(angle*math.pi/180)*away)
		table.insert(knifes,knife)
		knife.SetVar("away",away)
		knife.SetVar("time",0)
		knife.SetVar("angle",angle)
		knife.SetVar("limit",tim)
		knife.SetVar("rotationside",-side)
		knife.sprite.rotation=i*30
		if away==225 then
			knife.SetVar("rotation",1)
			else knife.SetVar("rotation",-1)
		end
		local dist = math.sqrt((knife.x)*(knife.x)+(knife.y)*(knife.y))
		if 0 < knife.y then
			angle = math.asin(knife.x/dist)*180/math.pi
			else
			angle = 180 - math.asin(knife.x/dist)*180/math.pi
		end
		knife.sprite.alpha=0
		knife.sprite.rotation=angle
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
	if timer==0 and hurted%2==0 then
		hurted=hurted+2
	end
	if death==false then
		if ((hurttime<0 or hurttime==0) and timer>0 ) or (hurted%2==0 and hurted<7 and timer==0) then
			Audio.PlaySound("hurtsound")
			if Player.hp>damage then
				Player.hp=Player.hp-damage
				Encounter.Call("PlayerHurted",damage)
				if timer!=0 then
					hurttime=timer
				end
				elseif SoulSpeakTime==0 then
				Player.hp=1
				Player.sprite.alpha=0
				SoulDead()
			end
		end
	end
end
function Update()
if hurted>1 then
	hurted=1
	else
	hurted=0
end
if SoulSpeakTime==0 then
spawntime=spawntime+timespeed
if death==true then
  knifetime=1
  spawntime=1
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
	SoulDead()
	deadscreen.Remove()
  end
end
if wavetime<520 then
	timespeed=1
	elseif wavetime<691 then
	if wavetime==532 then
		Audio.PlaySound("timeslow")
	end
	timespeed=0.2+0.8*math.cos((wavetime-520)*math.pi/360)
	elseif wavetime==720 then
	local slash=CreateProjectile("chara/att0",Player.x+4,Player.y)
	Audio.PlaySound("sliceslow")
	local laser=CreateProjectile("empty",6000,6000)
	slash.SetVar("laser",laser)
	table.insert(slashs,slash)
	elseif death==false then
	slashtime=slashtime+1
end
for i=1,#slashs do
	local slash=slashs[i]
	if slashtime==140 then
		local laser=slash.GetVar("laser")
		laser.MoveTo(Player.x,Player.y)
		laser.sprite.Set("laser0/laserv0")
	end
	if slashtime%20==1 then
		if slashtime==141 then
			death=true
			slashtime=1
			Audio.PlaySound("bolt")
			elseif slashtime==142 then
			slash.sprite.Remove()
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
	bullet.Move(math.sin(2*velx*math.pi/180)*timespeed, -vely*timespeed)
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
if spawntime%90==30 then
	DoRings(161)
	elseif spawntime%90==60 then
	DoRings(225)
	elseif spawntime%90==89 then
	DoRings(289)
end

for i=1,#knifes do
	local knife=knifes[i]
	local time=knife.GetVar("time")+timespeed
	knife.SetVar("time",time)
	local lim=knife.GetVar("limit")
	if knife.isactive then
		if time<60 then
			knife.sprite.alpha=math.sin(time*math.pi/120)
		end
		local angle=knife.GetVar("angle")
		local away=knife.GetVar("away")
		local extraangle=0
		if time<lim then
			angle=angle+1*knife.GetVar("rotationside")
			knife.SetVar("angle",angle)
			else
			if away<162 then
				angle=angle+2*math.cos(away*math.pi/162)*timespeed
				extraangle=40*math.sin((away-81)/2*math.pi/162)
			end
			away=away-4*timespeed
		end
		if (Player.x+34>knife.x and Player.x-34<knife.x) and (Player.y+34>knife.y and Player.y-34<knife.y) then
			if collision.CheckCollision(Player, knife) and knife.sprite.alpha then
				Hurt(1,0)
			end
		end
		knife.SetVar("angle",angle)
		knife.SetVar("away",away)
		--[[local dist = math.sqrt((knife.x)*(knife.x)+(knife.y)*(knife.y))
		if 0 > knife.y then
			angle = math.asin(knife.x/dist)*180/math.pi
			else
			angle = 180 - math.asin(knife.x/dist)*180/math.pi
		end]]
		knife.sprite.rotation=270-angle-extraangle
		angle=knife.GetVar("angle")
		knife.MoveTo(away*math.sin(angle*math.pi/180),away*math.cos(angle*math.pi/180))
		if (Player.x+34>knife.x and Player.x-34<knife.x) and (Player.y+34>knife.y and Player.y-34<knife.y) then
			if collision.CheckCollision(Player, knife) and knife.sprite.alpha then
				Hurt(1,0)
			end
		end
		if away<0 then	
			knife.Remove()
		end
	end
end



else

SoulSpeakTime=SoulSpeakTime+1
local s=SoulSpeakTime
if s==10 then
	for i=1,#knifes do
		if knifes[i].isactive then
			knifes[i].Remove()
		end
	end
	knifes={}
	for i=1,#leafs do
		if leafs[i].isactive then
			leafs[i].Remove()
		end
	end
	leafs={}
	for i=1,#slashs do
		if slashs[i].isactive then
			local laser=slashs[i].GetVar("laser")
			if laser.isactive then
				laser.Remove()
			end
			slashs[i].Remove()
		end
	end
	slashs={}
	for i=1,#fires do
		if fires[i].isactive then
			fires[i].Remove()
		end
	end
	fires={}
	for i=1,#lasers do
		if lasers[i].isactive then
			lasers[i].Remove()
		end
	end
	lasers={}
	fires={}
	for i=1,#blues do
		if blues[i].isactive then
			blues[i].Remove()
		end
	end
	blues={}
end
if s==40 then
	Audio.PlaySound("heartbeatbreaker")
	elseif s==45 then
	fPlayer.sprite.Set("ut-heart-broken")
	elseif s>90 and s<150 then
	local new=math.sin((s-90)*math.pi/120)
	local old=1-new
	fPlayer.sprite.color={1,0,1*old}
	elseif s==175 then
	Audio.PlaySound("heartbeatbreaker")
	elseif s==180 then
	fPlayer.sprite.Set("ut-heart")
	saviox=fPlayer.absx
	savioy=fPlayer.absy
	elseif s>240 and s<300 then
	local new=math.sin((s-240)*math.pi/120)
	local old=1-new
	fPlayer.MoveToAbs(new*320+saviox*old,new*240+savioy*old)
	elseif s==390 then
	Encounter.Call("SetMusic","Not Forget")
	elseif s==510 then
	local text={""}
	Cover.sprite.alpha=1
	Player.sprite.color={1,0,0}
	Player.MoveToAbs(320,240,true)
	Encounter.Call("FadingChara")
end

if s>600 and s<9810 and Encounter.GetVar("CHARA").isactive==false then
	Player.hp=1
	Player.sprite.color={1,0,0}
	SoulSpeakTime=9810
	Arena.MoveToAndResize(320,185,100,100,true,true)
	Player.MoveToAbs(320,240,true)
	SetGlobal("dying",true)
end


n=s-10000
if n>0 and n<90 then
	Cover.sprite.alpha=math.cos(n*math.pi/180)
	Player.MoveToAbs(320,240,true)
	Player.sprite.color={1,0,0}
	elseif n==90 then
	fPlayer.Remove()
	Cover.sprite.alpha=0
	elseif n>150 and n<270 then
	local old=270-n
	old=old/120
	new=1-old
	Arena.MoveTo(320,185*old+95*new,true,true)
	elseif n==330 then
	Encounter.SetVar("FadedChara",1)
	Player.MoveToAbs(45,25,true)
	Audio.PlaySound("menumove")
end






end
end
function OnHit(attack)
if SoulSpeakTime==0 then
	local color=attack.GetVar("color")
	if color=="asgore" then
		Hurt(10,60)
		elseif color=="tori" then
		Hurt(1,8)
		if not GetGlobal("burn") then
			else
			SetGlobal("burn",GetGlobal("burn")+1)
		end
	end
end
end

function SoulDead()
	SoulSpeakTime=1
	Cover=CreateProjectileAbs("overworld/cover",320,240,"Top")
	Cover.sprite.color={0,0,0}
	Cover.sprite.alpha=1
	fPlayer=CreateProjectileAbs("ut-heart",Player.absx,Player.absy,"Top")
	fPlayer.sprite.color={1,0,1}
end