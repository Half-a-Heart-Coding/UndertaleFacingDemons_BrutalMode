require "Libraries/hurt"
Player.sprite.color = {0.0, 0.0, 0.7}
spawntimer = 0
flytime=0
flyspeed=0
speedx=2
jumptime=0
jumpspeed=0
Playerspeed=2
Player.SetControlOverride(true)
if Encounter.GetVar("movefast")==true then
	Playerspeed=3
end
lasers = {}
olasers = {}
missiles = {}
Arena.Resize (250, 72)
bones = {} 
bones1 = {}
blasters={}
HeartChange({0.0, 0.0, 1.0})
DoGhost("Sans_Sprite",1,610)

--gb = CreateProjectile('gb1', 400, -30)
--gb1 = CreateProjectile('gb1', -400, -30) 

las1 = 1 
las2 = 1


function NewBlaster(side)
	local blaster=CreateProjectile("GasterBlaster/ingo",side*400,0)
	Audio.PlaySound("sfx_BlasterEntry")
	blaster.sprite.Scale(1.5,1.5)
	blaster.sprite.rotation=side*-90
	blaster.SetVar("side",side)
	blaster.SetVar("time",0)
	table.insert(blasters,blaster)
end
function Update()
HurtUpd(610)

    spawntimer = spawntimer + 1
    BlueMode()
	
	if spawntimer%150==60 then
		NewBlaster(math.random(2)*2-3)
	end
	for i=1,#blasters do
		local bl=blasters[i]
		if bl.isactive then
			local time=bl.GetVar("time")+1
			local side=bl.GetVar("side")
			local la=bl.GetVar("laser")
			bl.SetVar("time",time)
			if time<70 then
				bl.MoveTo(side*(168+232*(1-math.sin(time*math.pi/140))),bl.y)
				if time==65 then
					bl.sprite.Set("GasterBlaster/almost")
				end
				elseif time==70 then
				local las=CreateProjectile('GasterBlaster/laser', 0, 0)
				bl.SetVar("laser",las)
				bl.sprite.SendToTop()
				bl.SetVar("speed",0)
				bl.sprite.Set("GasterBlaster/0")
				las.sprite.Scale(1,0.3)
				las.sprite.alpha=0.5
				las.MoveTo(bl.x-(las.sprite.width/2-20)*side,bl.y)
				Audio.PlaySound("sfx_Blaster")
				la=las
				elseif time>70 and time<141 then
				if time%5==0 then
					bl.sprite.Set("GasterBlaster/"..(time/5)%2)
				end
				local sp=bl.GetVar("speed")
				bl.SetVar("speed",sp+0.1)
				bl.Move(sp*side,0)
				la.MoveTo(bl.x-(la.sprite.width/2-20)*side,bl.y)
				--la.sprite.Scale(1,0.4+0.4*math.sin((time-40)*math.pi/100))
				if time>70 and time<80 then
					local delta=math.sin((time-70)*math.pi/20)
					la.sprite.alpha=0.5+0.5*delta
					la.sprite.Scale(1,0.3+delta*0.7)
					elseif time>90 and time<100 then
					local delta=math.sin((time-90)*math.pi/20)
					la.sprite.alpha=1-0.2*delta
					la.sprite.Scale(1,1-delta*0.2)
					elseif time>100 and time<120 then
					local delta=math.sin((time-100)*math.pi/40)
					la.sprite.alpha=0.8-0.4*delta
					la.sprite.Scale(1,0.8-delta*0.4)
					elseif time>120 then
					local delta=math.sin((time-120)*math.pi/40)
					la.sprite.alpha=0.4-0.4*delta
					la.sprite.Scale(1,0.4-delta*0.4)
				end
				elseif time==141 then
				la.Remove()
				bl.Remove()
			end
			if time>69 and time<130 then
				if la.y+((la.sprite.height/2)*la.sprite.yscale)>Player.y and la.y-((la.sprite.height/2)*la.sprite.yscale)<Player.y then
					local dam=0
					if la.sprite.alpha<0.5 then
						dam=0
						elseif la.sprite.alpha<0.7 then
						dam=1
						elseif la.sprite.alpha<1 then
						dam=2
						elseif dam==1 then
						dam=3
					end
					if dam>0 then
						KnifeHurt(dam)
					end
				end
			end
		end
	end
		
	if spawntimer % 55 == 0 then 
		bone = CreateProjectile('bone', 128, 30) 
		table.insert(bones, bone) 
	end
	if spawntimer % 55 == 0 then 
		bone1 = CreateProjectile('bone', -128, -30) 
		table.insert(bones1, bone1) 
	end 	
	
	for b=1,#bones do
		local b1 = bones[b]
		if b1.isactive then
			b1.MoveTo(b1.x-1.5, b1.y)
			b1.SetVar("color", "white")
			if b1.x<-126 then
				b1.Remove()
			end
		end
		
	end	
	for h=1,#bones1 do
		local b2 = bones1[h]
		if b2.isactive then
			b2.MoveTo(b2.x+1.5, b2.y)
			b2.SetVar("color", "white")
			if b2.x>126 then
				b2.Remove()
			end
		end
	end	
	
end 

function OnHit(bullet)
	local color = bullet.GetVar("color")
	if color == "white" then
		LongHurt(5, 20) 
	end
end


function BlueMode()
	if Input.Right>0 and Input.Left==0 then
		speedx=Playerspeed
		elseif Input.Right==0 and Input.Left>0 then
		speedx=-Playerspeed
		else
		speedx=0
	end
   Player.sprite.rotation=0
   Player.MoveTo(Player.x+speedx,Player.y-flyspeed+jumpspeed,false)
   if Player.y==-(Arena.height/2-8) then 
      flytime=0
   end
   if Player.y>-(Arena.height/2-8) and jumptime==0 then
      if flytime<5 then
         flytime=flytime+0.12
      end
   end
   if flytime>0 then
      flyspeed=5*math.sin(flytime*math.pi/10)*math.sin(flytime*math.pi/10)*math.sin(flytime*math.pi/10)
      else flyspeed=0   
   end
   if Player.y==-(Arena.height/2-8) and  Input.Up>0 then
      jumptime=3
   end
   if jumptime>0 and Player.y>-(Arena.height/2-8) then
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
      else jumpspeed=0
   end
end