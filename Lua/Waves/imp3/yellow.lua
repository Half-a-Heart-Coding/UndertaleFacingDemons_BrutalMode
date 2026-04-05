Arena.Resize(200,16)
shottime=20
spawntime=0
require "Libraries/Playermove"
require "Libraries/hurt"
bullets={}
bol={}
bum={}
bolt_anim={"bolt_left","bolt_right"}
vanish={}
rain={}
rand1=0
rand2=0
timer={}
direction={}
electro={}
bombs={}
away={}
speedup=1
speed1={}
speed2={}
spawn=false
holdTime=0
--DoGhost("Alphys_Sprite",1,600)
Player.sprite.color={1,1,0}
Player.sprite.rotation=(180)
nohittingtimer=0
spears={}
nightmareSpeed=0.5
name2=""
if Encounter.GetVar("diff")==30 then
	name2="Fatal"
end
name3="Deadly"
if Encounter.GetVar("diff")==30 then
	name3="Fatal"
end
name4="Lethal"
if Encounter.GetVar("diff")==30 then
	name4="Fatal"
end
name5="Fatal"
if Encounter.GetVar("diff")==30 then
	name5="Mutant"
end
if Encounter.GetVar("diff")~= 30 and Encounter.GetVar("diff")~= 28 and Encounter.GetVar("diff")~= 27 then
	Encounter.SetVar("SavedProg",62)
end
function Update()
HurtUpd(1800)
Moving()
spawntime=spawntime+nightmareSpeed
if Input.Confirm ==0 then
   spawn=true
end
if Input.Confirm>0 and (shottime>15 or shottime==15 ) and spawn then
   holdTime=holdTime+1
   if holdTime==30 then
        Audio.PlaySound("ding")
   end
end
if Input.Confirm <=0 and (shottime>15 or shottime==15 ) and spawn and holdTime>0 then
    if holdTime>=30 then
       local shot = CreateProjectile("bigShot",Player.x,Player.y)
       shot.SetVar("color","strong")
       shot.SetVar("ready","true")
       table.insert(bullets,shot)
       shottime=0
       Audio.PlaySound("pew")
       spawn=false
   else
       local shot = CreateProjectile("shot",Player.x,Player.y)
       shot.SetVar("color","none")
       shot.SetVar("ready","true")
       table.insert(bullets,shot)
       shottime=0
       Audio.PlaySound("pew")
       spawn=false
   end
   holdTime=0
end
if spawntime==30 then
   local line = CreateProjectile("line1",0,203)
   line.sprite.color={1,1,0}
end
if (spawntime)%180==60 then
	local random=math.random(150-23)-76
	local bomb=CreateProjectile("bomb0",random,460)
    bomb.SetVar("color","bum")
	table.insert(bombs,bomb)
	bomb.SetVar("time",0)
end
if (spawntime)%60==45 then
	local random=math.random(150-23)-76
	local spear=CreateProjectile("green/arrow",random,460)
    spear.SetVar("color","spear")
	table.insert(spears,spear)
end
for i=1,#bombs do
	local b=bombs[i]
	if b.isactive then
		local time=b.GetVar("time")
		if time==0 then
			b.Move(0,-1*nightmareSpeed)
			if b.y<10 then
				b.SetVar("time",1)
		    end
		else
			b.SetVar("time",time+1)
            b.SetVar("color","bum")
			if time<20 then
				if time==1 then
					Audio.PlaySound("plusexplode")
				end
				if time%2==0 then
					b.sprite.Set("bomb"..(time/2)%2)
				end
				elseif time==20 then
				local laser=CreateProjectile("mylaser/laserv2",b.x,b.y)
				b.sprite.Set("mylaser/laserh2")
				b.SetVar("laser",laser)
				b.SetVar("type","bomb")
                laser.SetVar("color","bum")
				laser.SetVar("type","bomb")
				--DoHole(b.x,4)
				--DoHole(b.x,3)
				--DoHole(b.x,2)
				--DoHole(b.x,1)
				elseif time<31 then
				b.sprite.alpha=1-math.sin((time-20)*math.pi/20)
				local l=b.GetVar("laser")
				l.sprite.alpha=b.sprite.alpha
				elseif time==31 then
				b.Remove()
				local l=b.GetVar("laser")
				l.Remove()
			end
		end
	end
end
if spawntime%60==0 then
   rand2=math.random(19)
   rand3=math.random(5)
   napr=math.random(2)*2-3
   local moln = CreateProjectile("zap1",napr*320,10+10*rand2)
   moln.sprite.rotation=90
   table.insert(electro,moln)
   moln.SetVar("ready","true")
   moln.SetVar("napr",-napr)
end
for i=1,#bol do
   local bolt = bol[i]
   if bolt.isactive then
   if not timer[i] then
      timer[i]=0
      elseif timer[i]<3 then
      timer[i]=timer[i]+1
      elseif timer[i]==3 then
      rand5=math.random(2)
      Audio.PlaySound("bolt")
      bolt.sprite.Set(bolt_anim[rand5])
      bolt.MoveTo(bolt.x,92.5)
      timer[i]=timer[i]+1
      bolt.SetVar("color","bum")
      elseif timer[i]<13 then
      bolt.sprite.alpha=1-timer[i]*0.04
      timer[i]=timer[i]+1
      elseif timer[i]<18 then
      timer[i]=timer[i]+1
      bolt.SetVar("color","none")
      bolt.sprite.alpha=1-timer[i]*0.04
      elseif timer[i]==18 then
      bolt.Remove()
   end
   end
end
for i=1,#electro do
   local moln=electro[i]
   direction[i]=moln.GetVar("napr")
   if not bum[i] and moln.GetVar("ready")=="true"then
      moln.Move(direction[i]*4*nightmareSpeed,0)
      elseif moln.GetVar("ready")=="true" then
      local bolt=CreateProjectile("bolt_warning",moln.x,11) 
      moln.SetVar("ready","false")
      moln.Remove()
      table.insert(bol,bolt)
   end
   for n=1,#bullets do
      local shot=bullets[n]
      if (shot.x+17>moln.x and shot.x-17<moln.x) and (shot.y+10>moln.y and shot.y-5<moln.y) and shot.GetVar("ready")=="true" and moln.GetVar("ready")=="true" then
         shot.SetVar("ready","false")
         bum[i]=true
         if shot.GetVar("color")=="strong" then
            shot.SetVar("color","none")
         else
            away[n]=true
         end
      end
   end
end
for i=1,#bullets do
   local shot = bullets[i]
   if shot.y==360 then
      away[i]=true
      shot.SetVar("ready","false")
   end
   if not away[i] then
      if shot.GetVar("color")=="strong" then
        shot.MoveTo(shot.x,shot.y+12) 
      else
        shot.MoveTo(shot.x,shot.y+8) 
      end
      elseif not vanish[i] then
      shot.Remove()
   end
   for h=1,#rain do
      local knife = rain[h]
      if (shot.x+11>knife.x and shot.x-11<knife.x) and (shot.y+30>knife.y and shot.y-40<knife.y) and shot.GetVar("ready")=="true" and knife.GetVar("ready")=="true" and knife.isactive and knife.sprite.alpha>0.5 then
         if knife.GetVar("break")=="true" then
            knife.Remove()
            Audio.PlaySound("hitsound")
         elseif knife.GetVar("break")=="difficult" and shot.GetVar("color")=="strong" then
            knife.Remove()
            Audio.PlaySound("hitsound")
            else Audio.PlaySound("reflect")
         end
         if shot.GetVar("color")=="strong" then
            --shot.SetVar("color","none")
         else
            away[i]=true
            shot.SetVar("ready","false")
         end
      end
   end
   for l=1,#bombs do
      local knife = bombs[l]
      if (shot.x+15>knife.x and shot.x-15<knife.x) and (shot.y+15>knife.y and shot.y-15<knife.y) and shot.GetVar("ready")=="true" and knife.isactive and knife.sprite.alpha>0.5 then
         --if knife.GetVar("break")=="true" then
            knife.SetVar("time",1)
         --end
         if shot.GetVar("color")=="strong" then
            shot.SetVar("color","none")
         else
            away[i]=true
            shot.SetVar("ready","false")
         end
      end
   end
end
for i=1,#spears do
	local s=spears[i]
	if s.isactive then
		s.Move(0,-5*nightmareSpeed)
		if s.y<-400 then
			s.Remove()
		end
	end
end
shottime=shottime+1
if spawntime%360==60 or spawntime%360==60.25 then
   rand1=math.random(9)+1
   for i=1,10 do           
      if i==rand1 then
         local knife = CreateProjectile("KnifeDown"..name3,-110+i*20,360)        
         if name3=="Fatal" then
            knife.sprite.color={0,1,0}
         end
         knife.SetVar("break","difficult")
         knife.SetVar("color","white")
         knife.SetVar("ready","true")
	knife.sprite.alpha=0
	knife.SetVar("time",0)
         table.insert(rain,knife)     
         else local knife = CreateProjectile("KnifeDown"..name4,-110+i*20,360)
         knife.SetVar("color","gold")
         table.insert(rain,knife)
	knife.sprite.alpha=0
	knife.SetVar("time",0)
         knife.SetVar("ready","true")
      end
   end
end
if spawntime%360==0 then
   nightmareSpeed=nightmareSpeed+0.25
end
for i=1,#rain do
   local knife = rain[i]
	if knife.isactive then
		local t=knife.GetVar("time")+1
		knife.SetVar("time",t)
	   if not speed1[i] then
	      speed1[i]=0.35*nightmareSpeed
	      elseif speed1[i]>0 then
	      if knife.y<240 and t<1000 then
	        knife.SetVar("time",1000)
	      end
		if t<1000 then
		      knife.MoveTo(knife.x,knife.y-speed1[i]*speedup)
		end
	   end
		if t<31 then
			knife.sprite.alpha=math.sin(t*math.pi/60)
			elseif t>1000 then
			local l=t-1000
			if l<31 then
				knife.MoveTo(knife.x,132+108*math.cos(l*math.pi/30))
				else
				knife.sprite.alpha=1-math.sin((l-30)*math.pi/60)
				if l==61 then
					knife.Remove()
				end
			end
		end
	end
end
end
function OnHit(attacks)
if attacks.GetVar("color") == "bum" then
	LongHurt(20,30,true)
    elseif attacks.GetVar("color") == "spear" then
	LongHurt(5,10,true)
   elseif  attacks.GetVar("color") == "white" and attacks.sprite.alpha>0.25 then 
	KnifeHurt(2)
    elseif  attacks.GetVar("color") == "gold" and attacks.sprite.alpha>0.25 then 
	KnifeHurt(5)
end
end