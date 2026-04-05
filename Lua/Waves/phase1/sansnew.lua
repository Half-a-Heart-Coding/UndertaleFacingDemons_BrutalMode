--Player.sprite.color={0,0,1}
spawntime=0
Player.MoveTo(0,108,false)
Arena.ResizeImmediate(140,140)
gravity="Down"
flyspeed=0
jumpspeed=0
knifes={}
allspeed=2
if Encounter.GetVar("movefast")==true then
	allspeed=3
end
rand1 = math.random(2)
blasters={}
require "Libraries/hurt"
require "Libraries/Playermove"
battlesprites={}
DoGhost("Sans_Sprite",1,600)
table.insert(battlesprites,paps)
gravi=0
beam_anim={"laser1/laserh0","laser1/laserh1","laser1/laserh2","laser1/laserh4","laser1/laserh5","laser1/laserh6"}

function SendKnifeSide(ingo,speed)
	if ingo==1 then
		local k=CreateProjectile("KnifeDown",Player.x,300)
		k.SetVar("time",0)
		k.SetVar("speed",{0,-speed})
		table.insert(knifes,k)
		k.SetVar("color","knife")
		elseif ingo==2 then
		local k=CreateProjectile("KnifeLeft",300,Player.y)
		k.SetVar("time",0)
		k.SetVar("speed",{-speed,0})
		table.insert(knifes,k)
		k.SetVar("color","knife")
		elseif ingo==3 then
		local k=CreateProjectile("KnifeUp",Player.x,-300)
		k.SetVar("time",0)
		k.SetVar("speed",{0,speed})
		table.insert(knifes,k)
		k.SetVar("color","knife")
		else
		local k=CreateProjectile("KnifeRight",-300,Player.y)
		k.SetVar("time",0)
		k.SetVar("speed",{speed,0})
		table.insert(knifes,k)
		k.SetVar("color","knife")
	end
end
function DoSideRemember()
	local rand={}
	for i=1,4 do
		local ch=true
		while ch==true do
			rand[i]=math.random(4)
			ch=false
			for t=1,i-1 do
				if rand[t]==rand[i] then
					ch=true
				end
			end
		end
	end
	return rand
end
side=DoSideRemember()
phase=1

function DoBlasters(ingo)
	local away=45
	if ingo%2==1 then
		local b1=CreateProjectile("GasterBlaster/ingo",300,away-away*(ingo-1),"Top")
		b1.SetVar("spr","h")
		b1.SetVar("pos",{730,0})
		b1.SetVar("time",0)
		b1.sprite.Scale(1.5,1.5)
		b1.SetVar("To",{200,b1.y})
		b1.SetVar("from",{100,0})
		b1.sprite.rotation=-90
		local b2=CreateProjectile("GasterBlaster/ingo",-300,away-away*(ingo-1),"Top")
		b2.SetVar("spr","h")
		b2.SetVar("pos",{-730,0})
		b2.SetVar("time",0)
		b2.SetVar("To",{-200,b1.y})
		b2.SetVar("from",{-100,0})
		b2.sprite.Scale(1.5,1.5)
		b2.sprite.rotation=90
		table.insert(blasters,b1)
		table.insert(blasters,b2)
		else
		local b1=CreateProjectile("GasterBlaster/ingo",away-away*(ingo-2),300,"Top")
		b1.SetVar("spr","v")
		b1.SetVar("pos",{0,-730})
		b1.SetVar("time",0)
		b1.SetVar("To",{b1.x,200})
		b1.SetVar("from",{0,100})
		b1.sprite.Scale(1.5,1.5)
		b1.sprite.rotation=0
		local b2=CreateProjectile("GasterBlaster/ingo",away-away*(ingo-2),-300,"Top")
		b2.SetVar("spr","v")
		b2.SetVar("pos",{0,730})
		b2.SetVar("time",0)
		b2.SetVar("To",{b1.x,-200})
		b2.SetVar("from",{0,-100})
		b2.sprite.Scale(1.5,1.5)
		b2.sprite.rotation=180
		table.insert(blasters,b1)
		table.insert(blasters,b2)
	end
	Audio.PlaySound("sfx_BlasterEntry")
end
flytime=0
jumptime=0
spawn=false
Player.MoveTo(0,0,true)
Player.SetControlOverride(true)
nohittingtimer=0
function Update()
spawntime=spawntime+1
if spawntime==2 then
	side=DoSideRemember()
	elseif spawntime<211 and spawntime%60==30 then
	local i=(spawntime+30)/60
	DoBlasters(side[i])
	elseif spawntime>300 and spawntime<660 then
	local t=spawntime-300
	local num=math.floor(t/90)+1
	if t%90==1 then
		ChangeGravity(side[num])
		SendKnifeSide(side[num],4)
		SendKnifeSide((side[num]+2)%4,6)
		elseif t%90==40 then
		blasters[num*2].SetVar("time",64)
		blasters[num*2-1].SetVar("time",64)
	end
end

HurtUpd(660)
if nohittingtimer>0 then
	nohittingtimer=nohittingtimer-1
end
if Input.Up>0 and Input.Down==0 then
	speedy=allspeed
	elseif Input.Up==0 and Input.Down>0 then
	speedy=-allspeed
	else
	speedy=0
end
if Input.Right>0 and Input.Left==0 then
   speedx=allspeed
   elseif Input.Right==0 and Input.Left>0 then
   speedx=-allspeed
   else speedx=0
end

--[[if Input.Menu==1 then
	ChangeGravity((gravi%4)+1)
end]]
if gravi>0 then
	BlueSoul(gravi)
	else
	Moving()
end
for i=1,#blasters do
	local b = blasters[i]
	if b.isactive then
		local time=b.GetVar("time")
		if time!=60 then
			time=time+1
		end
		b.SetVar("time",time)
		if time<61 then
			local To=b.GetVar("To")
			local From=b.GetVar("from")
			local s=math.sin(time*math.pi/120)
			local old=1-s
			b.MoveTo(To[1]+From[1]*old,To[2]+From[2]*old)
			b.sprite.alpha=s
			elseif time==65 then
			b.sprite.Set("GasterBlaster/almost")
			elseif time==70 then
			local las=CreateProjectile("GasterBlaster/laser"..b.GetVar("spr"), 0, 0)
			b.SetVar("laser",las)
			b.sprite.SendToTop()
			Audio.PlaySound("sfx_Blaster")
			b.sprite.Set("GasterBlaster/0")
			las.sprite.Scale(1,0.3)
			las.sprite.alpha=0.5
			local pos=b.GetVar("pos")
			las.MoveTo(b.x+pos[1],b.y+pos[2])
			b.SetVar("speed",0)
			elseif time>70 and time<140 then
			if time%5==0 then
				b.sprite.Set("GasterBlaster/"..(time/5)%2)
			end
			local sp=b.GetVar("speed")+0.1
			b.SetVar("speed",sp)
			local from=b.GetVar("from")
			local la=b.GetVar("laser")
			b.Move(from[1]/100*sp,from[2]/100*sp)
			local pos=b.GetVar("pos")
			la.MoveTo(b.x-pos[1],b.y+pos[2])
			local spr=b.GetVar("spr")
			if time>70 and time<80 then
				local delta=math.sin((time-70)*math.pi/20)
				la.sprite.alpha=0.5+0.5*delta
				if spr=="h" then
					la.sprite.Scale(1,0.3+delta*0.7)
					else
					la.sprite.Scale(0.3+delta*0.7,1)
				end
				elseif time>90 and time<100 then
				local delta=math.sin((time-90)*math.pi/20)
				la.sprite.alpha=1-0.2*delta
				if spr=="h" then
					la.sprite.Scale(1,1-delta*0.2)
					else
					la.sprite.Scale(1-delta*0.2,1)
				end
				elseif time>100 and time<120 then
				local delta=math.sin((time-100)*math.pi/40)
				la.sprite.alpha=0.8-0.4*delta
				if spr=="h" then
					la.sprite.Scale(1,0.8-delta*0.4)
					else
					la.sprite.Scale(0.8-delta*0.4,1)
				end
				elseif time>120 then
				local delta=math.sin((time-120)*math.pi/40)
				la.sprite.alpha=0.4-0.4*delta
				if spr=="h" then
					la.sprite.Scale(1,0.4-delta*0.4)
					else
					la.sprite.Scale(0.4-delta*0.4,1)
				end
			end
		end
		if time>69 and time<130 then
			local la=b.GetVar("laser")
			if la.y+((la.sprite.height/2)*la.sprite.yscale)>Player.y and la.x-((la.sprite.width/2)*la.sprite.xscale)<Player.x and la.x+((la.sprite.width/2)*la.sprite.xscale)>Player.x and la.y-((la.sprite.height/2)*la.sprite.yscale)<Player.y then
				local dam=0
				if la.sprite.alpha<0.5 then
					dam=0
					elseif la.sprite.alpha<1 then
					dam=1
				end
				if dam>0 then
					KnifeHurt(dam,true)
				end
			end
		end
	end
end
for i=1,#knifes do
	local k=knifes[i]
	if k.isactive then
		local time=k.GetVar("time")+1
		k.SetVar("time",time)
		if time<31 then
			k.sprite.alpha=math.sin(time*math.pi/60)
		end
		local sp=k.GetVar("speed")
		k.Move(sp[1],sp[2])
	end
end
end

function OnHit(attacks)
   if attacks.GetVar("color")=="knife" then
	KnifeHurt(1)
      elseif attacks.GetVar("color")=="beam" then
	KnifeHurt(3)
   end
end



function BlueSoul(ingo)
local h=Arena.height/2-8
if ingo == 1 then
   Player.sprite.rotation=180
   Player.MoveTo(Player.x+speedx,Player.y+flyspeed-jumpspeed,false)
   if Player.y==h then 
      flytime=0
   end
   if flytime>0 then
	if flytime<5 then
	      flyspeed=5*math.sin(flytime*math.pi/10)*math.sin(flytime*math.pi/10)*math.sin(flytime*math.pi/10)
	end
      else flyspeed=0   
   end
   if Player.y<h and jumptime==0 then
      if flytime<5 then
         flytime=flytime+0.12
      end
   end
   if Player.y==h and  Input.Down>0 then
      jumptime=3
	flytime=0
	flyspeed=0
   end
   if jumptime>0 then
      jumpspeed = 5*jumptime/3
	else
	jumpspeed=0
   end
   if jumptime>0 and Player.y<h then
      if Input.Down==0 then
         jumptime=0
         else jumptime=jumptime-0.12
      end
      if jumptime<0 then
         jumptime=0
      end
   end
	elseif ingo==2 then
   Player.sprite.rotation=90
   Player.MoveTo(Player.x+flyspeed-jumpspeed,Player.y+speedy,false)
   if Player.x==h then 
      flytime=0
   end
   if flytime>0 then
	if flytime<5 then
	      flyspeed=5*math.sin(flytime*math.pi/10)*math.sin(flytime*math.pi/10)*math.sin(flytime*math.pi/10)
	end
      else flyspeed=0   
   end
   if Player.x<h and jumptime==0 then
      if flytime<5 then
         flytime=flytime+0.12
      end
   end
   if Player.x==h and  Input.Left>0 then
      jumptime=3
   end
   if jumptime>0 then
      jumpspeed = 5*jumptime/3
	else
	jumpspeed=0
   end
   if jumptime>0 and Player.x<h then
      if Input.Left==0 then
         jumptime=0
         else jumptime=jumptime-0.12
      end
      if jumptime<0 then
         jumptime=0
      end
   end
	elseif ingo==3 then
   Player.sprite.rotation=0
   Player.MoveTo(Player.x+speedx,Player.y-flyspeed+jumpspeed,false)
   if Player.y==-h then 
      flytime=0
   end
   if Player.y>-h and jumptime==0 then
      if flytime<5 then
         flytime=flytime+0.12
      end
   end
   if flytime>0 then
	if flytime<5 then
	      flyspeed=5*math.sin(flytime*math.pi/10)*math.sin(flytime*math.pi/10)*math.sin(flytime*math.pi/10)
	end
      else flyspeed=0   
   end
   if Player.y==-h and  Input.Up>0 then
      jumptime=3
   end
   if jumptime>0 and Player.y>-h then
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
      jumpspeed = 5*jumptime/3
	else
	jumpspeed=0
   end
	elseif ingo==4 then
   Player.sprite.rotation=270
   Player.MoveTo(Player.x-flyspeed+jumpspeed,Player.y+speedy,false)
   if Player.x==-h then 
      flytime=0
   end
   if Player.x>-h and jumptime==0 then
      if flytime<5 then
         flytime=flytime+0.12
      end
   end
   if flytime>0 then
	if flytime<5 then
	      flyspeed=5*math.sin(flytime*math.pi/10)*math.sin(flytime*math.pi/10)*math.sin(flytime*math.pi/10)
	end
      else flyspeed=0   
   end
   if Player.x==-h and  Input.Right>0 then
      jumptime=3
   end
   if jumptime>0 and Player.x>-h then
      if Input.Right==0 then
         jumptime=0
         else jumptime=jumptime-0.12
      end
      if jumptime<0 then
         jumptime=0
      end
   end
   if jumptime>0 then
      jumpspeed = 5*jumptime/3
	else
	jumpspeed=0
   end
end
end
function ChangeGravity(ingo)
Player.sprite.color={0,0,1}
flytime=5
jumpspeed=0
jumptime=0
flyspeed=10
gravi=ingo
Audio.PlaySound("ding")
end