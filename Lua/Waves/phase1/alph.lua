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
away={}
speedup=1
speed1={}
speed2={}
spawn=false
DoGhost("Alphys_Sprite",1,600)
Player.sprite.color={1,1,0}
Player.sprite.rotation=(180)
nohittingtimer=0
function Update()
HurtUpd(600)
Moving()
spawntime=spawntime+1
if Input.Confirm ==0 then
   spawn=true
end
if Input.Confirm >0 and (shottime>15 or shottime==15 ) and spawn then
   local shot = CreateProjectile("shot",Player.x,Player.y)
   shot.SetVar("color","none")
   shot.SetVar("ready","true")
   table.insert(bullets,shot)
   shottime=0
   Audio.PlaySound("pew")
   spawn=false
end
if spawntime==30 then
   local line = CreateProjectile("line1",0,203)
   line.sprite.color={1,1,0}
end
if spawntime%50==0 then
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
      moln.Move(direction[i]*4,0)
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
         away[n]=true
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
      shot.MoveTo(shot.x,shot.y+10) 
      elseif not vanish[i] then
      shot.Remove()
   end
   for h=1,#rain do
      local knife = rain[h]
      if (shot.x+11>knife.x and shot.x-11<knife.x) and (shot.y+30>knife.y and shot.y-40<knife.y) and shot.GetVar("ready")=="true" and knife.GetVar("ready")=="true" and knife.isactive and knife.sprite.alpha>0.5 then
         if knife.GetVar("break")=="true" then
            knife.Remove()
            Audio.PlaySound("hitsound")
            else Audio.PlaySound("reflect")
         end
         shot.SetVar("ready","false")
         away[i]=true
      end
   end
end
shottime=shottime+1
if spawntime%140==0 then
   rand1=math.random(7)+1
   for i=1,10 do           
      if i+2>rand1 and i-2<rand1 then
         local knife = CreateProjectile("KnifeDownwhite",-110+i*20,360)        
         knife.sprite.color={1,1,0}
         knife.SetVar("break","true")
         knife.SetVar("color","white")
         knife.SetVar("ready","true")
	knife.sprite.alpha=0
	knife.SetVar("time",0)
         table.insert(rain,knife)     
         else local knife = CreateProjectile("KnifeDown",-110+i*20,360)
         knife.SetVar("color","white")
         table.insert(rain,knife)
	knife.sprite.alpha=0
	knife.SetVar("time",0)
         knife.SetVar("ready","true")
      end
   end
end
for i=1,#rain do
   local knife = rain[i]
	if knife.isactive then
		local t=knife.GetVar("time")+1
		knife.SetVar("time",t)
	   if not speed1[i] then
	      speed1[i]=1
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
	LongHurt(20,90,true)
   elseif  attacks.GetVar("color") == "white" and attacks.sprite.alpha>0.25 then 
	KnifeHurt(1)
end
end