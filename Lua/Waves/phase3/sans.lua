
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

DoGhost("Sans_Sprite",1,900)
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
HeartChange({0.0, 0.0,1})
function Update()
HurtUpd(990)
if nohittingtimer>0 then
	nohittingtimer=nohittingtimer-1
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
	elseif spawntime<300 then
	if spawntime%100 == 0 then
		local bone1 = CreateProjectile("Bonelowv",-150,50)
		bone1.SetVar("color","bone")
		local bone2 = CreateProjectile("Bonelowv",150,-50)
		bone2.SetVar("color","bone")
		table.insert(bones1,bone1)
		table.insert(bones2,bone2)
		bone1.sprite.alpha=0
		bone1.SetVar("time",0)
		bone2.sprite.alpha=0
		bone2.SetVar("time",0)
	end
	if spawntime%50==0  then
		rand1=math.random(2)
	end
	if spawntime%25==1 then
		if rand1 ==1 then
			local knife = CreateProjectile("KnifeDown",165,96)
			knife.SetVar("color","white")
			table.insert(knifes1,knife)
			knife.SetVar("time",0)
			else 
			local knife = CreateProjectile("KnifeUp",-165,-96)
			knife.SetVar("color","white")
			table.insert(knifes2,knife)
			knife.SetVar("time",0)
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
		bone1.sprite.alpha=0
		bone1.SetVar("time",0)
		bone2.sprite.alpha=0
		bone2.SetVar("time",0)
	end
	if spawntime%50==1 then
		rand1=math.random(2)
		if rand1 ==1 then
			local knife = CreateProjectile("KnifeDown",165,96)
			knife.SetVar("color","white")
			table.insert(knifes1,knife)
			knife.SetVar("time",0)
			else 
			local knife = CreateProjectile("KnifeUp",-165,-96)	
			knife.SetVar("color","white")
			table.insert(knifes2,knife)
			knife.SetVar("time",0)
		end
	end
	if spawntime%90 == 75  then
		rand2=math.random(2)
		rand3=math.random(2)*2-3
		if rand2==1 then
			local blaster = CreateProjectile("GasterBlaster/ingo",240*rand3,96,"Top")
			blaster.sprite.Scale(2,2)
			blaster.sprite.rotation=-rand3*90
			blaster.SetVar("dir",rand3)
			table.insert(blasters,blaster)
			blaster.sprite.alpha=0
			else local blaster = CreateProjectile("GasterBlaster/ingo",240*rand3,-96,"Top")
			blaster.sprite.Scale(2,2)
			blaster.sprite.rotation=-rand3*90
			blaster.SetVar("dir",rand3)
			table.insert(blasters,blaster)
			blaster.sprite.alpha=0
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
		local time=bone.GetVar("time")+1
		bone.SetVar("time",time)
		if time<30 then
			bone.sprite.SendToBottom()
			bone.sprite.alpha=math.sin(time*math.pi/60)
			elseif time>270 and time<300 then
			bone.sprite.alpha=math.sin((time-240)*math.pi/60)
			elseif time==300 then
			bone.Remove()
		end
	end
end
for i=1,#bones2 do
	local bone = bones2[i]
	if bone.isactive then
		bone.MoveTo(bone.x-1,bone.y)
		local time=bone.GetVar("time")+1
		bone.SetVar("time",time)
		if time<30 then
			bone.sprite.SendToBottom()
			bone.sprite.alpha=math.sin(time*math.pi/60)
			elseif time>270 and time<300 then
			bone.sprite.alpha=math.sin((time-240)*math.pi/60)
			elseif time==300 then
			bone.Remove()
		end
	end
end
for i=1,#knifes1 do
	local knife=knifes1[i]
	if knife.isactive then
		knife.MoveTo(knife.x-2,knife.y)
		local time=knife.GetVar("time")+1
		knife.SetVar("time",time)
		if time<21 then
			knife.sprite.alpha=math.sin(time*math.pi/40)
		end
		if time>145 and time<165 then
			knife.sprite.alpha=math.sin((time-125)*math.pi/40)
			elseif time==165 then
			knife.Remove()
		end
	end
end
for i=1,#knifes2 do
	local knife=knifes2[i]
	if knife.isactive then
		knife.MoveTo(knife.x+2,knife.y)
		local time=knife.GetVar("time")+1
		knife.SetVar("time",time)
		if time<21 then
			knife.sprite.alpha=math.sin(time*math.pi/40)
		end
		if time>145 and time<165 then
			knife.sprite.alpha=math.sin((time-125)*math.pi/40)
			elseif time==165 then
			knife.Remove()
		end
	end
end
for i=1,#blasters do
	local bl = blasters[i]
	local dir = bl.GetVar("dir")
	if not timer1[i] then
		timer1[i]=0
		speed1[i]=0
		Audio.PlaySound("sfx_BlasterEntry")
		elseif timer1[i]<45 then
		if timer1[i]<31 then
			bl.sprite.alpha=math.sin(timer1[i]*math.pi/60)
		end
		bl.MoveTo(bl.x-0.5*dir,bl.y)
		timer1[i]=timer1[i]+1
		if timer1[i]==42 then
			bl.sprite.Set("GasterBlaster/almost")
		end
		else
		if timer1[i]==45 then
			local beam = CreateProjectile("GasterBlaster/laser",bl.x-750*dir,bl.y)
			beam.SetVar("dir",dir)
			beam.SetVar("color","beam")
			table.insert(lasers,beam)
			Audio.PlaySound("lasershot")
			beam.sprite.Scale(1,0.2)
		end
		timer1[i]=timer1[i]+1
		if (timer1[i]-40)%6==0 then
			bl.sprite.Set("GasterBlaster/"..((timer1[i]-40)/6)%2)
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
		if timer2[i]>20 then
			beam.sprite.alpha=math.cos((timer2[i]-20)*math.pi/60)
			if beam.sprite.alpha<0.5 then
				beam.SetVar("color","none")
			end
		end
		if timer2[i]<21  then
			beam.sprite.Scale(1,0.2+0.8*math.sin(timer2[i]*math.pi/40))
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