Player.sprite.color={0,0,1}
spawntime=-90
Player.MoveTo(0,108,false)
Arena.ResizeImmediate(300,232)
gravity="Down"
flyspeed=0
jumpspeed=0
bones1={}
rand1 = math.random(2)
blasters={}
require "Libraries/hurt"
paps = CreateSprite("Sans_Sprite")
paps.SendToBottom()
paps.x = 380
paps.y = 367
paps.Scale(2, 2)
paps.alpha = 0.0
battlesprites={}
table.insert(battlesprites,paps)
caut=CreateProjectile(Encounter.GetVar("lang").."/Battle/inst",0,0,"BelowPlayer")
lasers={}
bones2={}
timer1={}
timer2={}
speed1={}
speed2={}
knifes1={}
knifes2={}
beam_anim={"laser1/laserh0","laser1/laserh1","laser1/laserh2","laser1/laserh4","laser1/laserh5","laser1/laserh6"}
flytime=0
jumptime=0
spawn=false
Player.SetControlOverride(true)
nohittingtimer=0
function Update()
HurtUpd(600)
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
if Input.Right>0 and Input.Left==0 then
   speedx=2
   elseif Input.Right==0 and Input.Left>0 then
   speedx=-2
   else speedx=0
end
spawntime=spawntime+1
if spawntime<0 then
	if spawntime>-31 then
		caut.sprite.alpha=math.cos((spawntime+30)*math.pi/60)
	end
	if spawntime==-1 then
		caut.Remove()
	end
	elseif spawntime<600 then
	if spawntime%100 == 0 then
		local bone1 = CreateProjectile("Bonelowv",-150,50)
		bone1.SetVar("color","bone")
		local bone2 = CreateProjectile("Bonelowv",150,-50)
		bone2.SetVar("color","bone")
		table.insert(bones1,bone1)
		table.insert(bones2,bone2)
	end
	if spawntime%50==0  then
		rand1=math.random(2)
	end
	if spawntime%25==1 then
		if rand1 ==1 then
			local knife = CreateProjectile("KnifeDown",165,96)
			knife.SetVar("color","white")
			table.insert(knifes1,knife)
			else 
			local knife = CreateProjectile("KnifeUp",-165,-96)
			knife.SetVar("color","white")
			table.insert(knifes2,knife)
		end
	end
	else
	if spawntime%100 == 0 then
		local bone1 = CreateProjectile("Bonelowv",-150,50)
		bone1.SetVar("color","bone")
		local bone2 = CreateProjectile("Bonelowv",150,-50)
		bone2.SetVar("color","bone")
		table.insert(bones1,bone1)
		table.insert(bones2,bone2)
	end
	if spawntime%50==1 then
		rand1=math.random(2)
		if rand1 ==1 then
			local knife = CreateProjectile("KnifeDown",165,96)
			knife.SetVar("color","white")
			table.insert(knifes1,knife)
			else 
			local knife = CreateProjectile("KnifeUp",-165,-96)	
			knife.SetVar("color","white")
			table.insert(knifes2,knife)
		end
	end
	if spawntime%150 == 0  then
		rand2=math.random(2)
		rand3=math.random(2)*2-3
		if rand2==1 then
			local blaster = CreateProjectile("gb1",240*rand3,96)
			blaster.sprite.rotation=(rand3-1)*90
			blaster.SetVar("dir",rand3)
			table.insert(blasters,blaster)
			else local blaster = CreateProjectile("gb1",240*rand3,-96)
			blaster.sprite.rotation=(rand3-1)*90
			blaster.SetVar("dir",rand3)
			table.insert(blasters,blaster)
		end
	end
end

if gravity == "Down" then
   Player.sprite.rotation=0
   Player.MoveTo(Player.x+speedx,Player.y-flyspeed+jumpspeed,false)
   if Player.y==-108 then 
      flytime=0
   end
   if Player.y>-108 and jumptime==0 then
      if flytime<5 then
         flytime=flytime+0.12
      end
   end
   if flytime>0 then
      flyspeed=5*math.sin(flytime*math.pi/10)*math.sin(flytime*math.pi/10)*math.sin(flytime*math.pi/10)
      else flyspeed=0   
   end
   if Player.y==-108 and  Input.Up>0 then
      jumptime=3
   end
   if jumptime>0 and Player.y>-108 then
      if Input.Up==0 then
         jumptime=0
         else jumptime=jumptime-0.12
      end
      if jumptime<0 then
         jumptime=0
      end
   end
   if jumptime>0 then
      jumpspeed = 5*jumptime/3
      elseif not spawn then
      jumpspeed=-10
      else jumpspeed=0
   end
end
if not spawn and (( gravity=="Down" and Player.y==-108 ) or(gravity=="Up" and Player.y==108 )) then
   spawn=true
   Audio.PlaySound("slam")
end
if Input.Confirm>0 and spawn then
   if gravity=="Up" then
      gravity="Down"
      else gravity="Up"
   end
   spawn=false
end
if gravity == "Up" then
   Player.sprite.rotation=180
   Player.MoveTo(Player.x+speedx,Player.y+flyspeed-jumpspeed,false)
   if Player.y==108 then 
      flytime=0
   end
   if flytime>0 then
      flyspeed=5*math.sin(flytime*math.pi/10)*math.sin(flytime*math.pi/10)*math.sin(flytime*math.pi/10)
      else flyspeed=0   
   end
   if Player.y<108 and jumptime==0 then
      if flytime<5 then
         flytime=flytime+0.12
      end
   end
   if Player.y==108 and  Input.Down>0 then
      jumptime=3
   end
   if jumptime>0 then
      jumpspeed = 5*jumptime/3
      elseif not spawn then
      jumpspeed=-10
      else jumpspeed=0
   end
   if jumptime>0 and Player.y<108 then
      if Input.Down==0 then
         jumptime=0
         else jumptime=jumptime-0.12
      end
      if jumptime<0 then
         jumptime=0
      end
   end
end
for i=1,#bones1 do
   local bone = bones1[i]
   if bone.isactive then
      bone.MoveTo(bone.x+1,bone.y)
   end
   if bone.x==150 then
      bone.Remove()
   end
end
for i=1,#bones2 do
   local bone = bones2[i]
   if bone.isactive then
      bone.MoveTo(bone.x-1,bone.y)
   end
   if bone.x==-150 then
      bone.Remove()
   end
end
for i=1,#knifes1 do
   local knife=knifes1[i]
   knife.MoveTo(knife.x-2,knife.y)
end
for i=1,#knifes2 do
   local knife=knifes2[i]
   knife.MoveTo(knife.x+2,knife.y)
end
for i=1,#blasters do
   local bl = blasters[i]
   local dir = bl.GetVar("dir")
   if not timer1[i] then
      timer1[i]=0
      speed1[i]=0
      Audio.PlaySound("sfx_BlasterEntry")
      elseif timer1[i]<45 then
      bl.MoveTo(bl.x-0.5*dir,bl.y)
      timer1[i]=timer1[i]+1
      else
      if timer1[i]==45 then
         local beam = CreateProjectile("laser1/laserh0",bl.x-660*dir,bl.y)
         timer1[i]=timer1[i]+1
         beam.SetVar("dir",dir)
         beam.SetVar("color","beam")
         table.insert(lasers,beam)
         Audio.PlaySound("lasershot")
      end
      bl.MoveTo(bl.x+dir*speed1[i],bl.y)
      speed1[i]=speed1[i]+0.25
   end
end
for i=1,#lasers do
   local beam = lasers[i]
   local dir = beam.GetVar("dir")
   if not timer2[i] then
      timer2[i]=0
      speed2[i] = 0
      elseif timer2[i]<60 then
      timer2[i]=timer2[i]+1
      if timer2[i]>40 then
         if timer2[i]==54 then
            beam.SetVar("color","none")
         end
         beam.sprite.alpha=beam.sprite.alpha-0.05
      end
      if timer2[i]<14 and timer2[i]%2==0 then
         beam.sprite.set(beam_anim[timer2[i]/2])
      end
      speed2[i]=speed2[i]+0.25
      beam.MoveTo(beam.x+speed2[i]*dir,beam.y)
      elseif timer2[i]>58 then
      beam.Remove()
   end
end
end
function OnHit(attacks)
   if attacks.GetVar("color")=="bone" then
	LongHurt(15,90)
      elseif attacks.GetVar("color")=="white" then
	KnifeHurt(1)
      elseif attacks.GetVar("color")=="beam" then
	KnifeHurt(3)
   end
end