Arena.Resize(200,200)
require "Libraries/hurt"
move=false
flytime=0
flyspeed=0
jumptime=0
jumpspeed=0
Playerspeed=2

collision = require "Libraries/rotational_collision"
manyblues=0
Player.SetControlOverride(true)
if Encounter.GetVar("movefast")==true then
	Playerspeed=3
end
spawntime=0
HeartChange({0.0, 0.0,1})
dir=math.random(2)*2-3
bones={}
knifes={}
knifes2={}

Audio.PlaySound("enemyappear")
DoGhost("Paps_Sprite",1,720)
bone=CreateProjectile("Bone/BigOne",500,0)
bone.sprite.rotation=-90



function Update()
spawntime=spawntime+1
HurtUpd(730)
BlueMode()
if spawntime<51 then
	bone.MoveTo(500-10*spawntime,0)
end
if bone==false then
	else
	 bone.sprite.rotation=bone.sprite.rotation+2.5
	if collision.CheckCollision(Player,bone) and bone.sprite.alpha>0.5 then
		LongHurt(10,60)
	end
end
if spawntime%144==72 and spawntime<600 then
	local knife=CreateProjectile("KnifeLeft",68,100)
	table.insert(knifes,knife)
	elseif spawntime%144==114 and spawntime<600 then
	local knife=CreateProjectile("KnifeRight",-68,100)
	table.insert(knifes,knife)
end
if spawntime>549 and spawntime<651 then
	bone.sprite.alpha=math.cos((spawntime-550)*math.pi/200)
	if spawntime==620 then
		for i=1,5 do
			local knife1=CreateProjectile("KnifeUp",i*20-10-400,-68)
			knife1.SetVar("point",i*20-10)
			knife1.SetVar("side",-1)
			knife1.SetVar("time",0)
			table.insert(knifes2,knife1)
			local knife2=CreateProjectile("KnifeUp",i*-20+10+500,-68)
			knife2.SetVar("point",i*-20+10)
			knife2.SetVar("side",1)
			knife2.SetVar("time",0)
			table.insert(knifes2,knife2)
		end
	end
	elseif spawntime==651 then
	bone=false
end

for i=1,#knifes2 do
	local knife=knifes2[i]
	local side=knife.GetVar("side")
	local p=knife.GetVar("point")
	local time=knife.GetVar("time")+1
	knife.SetVar("time",time)
	if time<91 then
		knife.MoveTo(p+side*500*(1-math.sin(time*math.pi/180)),-68)
	end
	if knife.x+(knife.sprite.width/2+4)>Player.x and knife.x-(knife.sprite.width/2+4)<Player.x and knife.y+(knife.sprite.height/2+4)>Player.y and knife.y-(knife.sprite.height/2+4)<Player.y then
		KnifeHurt(1)
	end
end

for i=1,#knifes do
	local knife=knifes[i]
	if knife.isactive then
		knife.Move(0,-2)
		if knife.x+(knife.sprite.width/2+4)>Player.x and knife.x-(knife.sprite.width/2+4)<Player.x and knife.y+(knife.sprite.height/2+4)>Player.y and knife.y-(knife.sprite.height/2+4)<Player.y then
			KnifeHurt(1)
		end
		if knife.y<-100 and knife.y>-161 then
			local t=-100-knife.y
			knife.sprite.alpha=1-math.sin(t*math.pi/120)
		end
		if knife.y<-300 then
			knife.Remove()
		end
	end
end


end
function OnHit(bone)
end


function BlueMode()
	movi=false
	local sx=Player.x
	local sy=Player.y
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
         flytime=flytime+0.06
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
         else jumptime=jumptime-0.06
      end
      if jumptime<0 then
         jumptime=0
      end
   end
   if jumptime>0 then
        jumpspeed = 5*jumptime/3
	--jumpspeed=5*math.sin(jumptime*math.pi/6)
      else jumpspeed=0
   end
	if sx==Player.x and Player.y==(-Arena.height/2+8) then
		movi=false
		else
		movi=true
	end
end