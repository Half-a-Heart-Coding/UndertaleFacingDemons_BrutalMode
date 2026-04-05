Arena.Resize(128,128)
Arena.Move(0,60,true,true)
require "Libraries/Playermove"
require "Libraries/hurt"
spawntime=0
knifes={}
Player.SetControlOverride(true)
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
function SendKnife(pos,speed,name,time)
	local knife=CreateProjectile(name,pos[1],pos[2])
	knife.SetVar("time",0)
	knife.SetVar("top",time)
	knife.SetVar("speed",speed)
	knife.SetVar("color","red")
	knife.sprite.alpha=0
	table.insert(knifes,knife)
end

if Encounter.GetVar("diff")~= 30 and Encounter.GetVar("diff")~= 28 and Encounter.GetVar("diff")~= 27 then
	Encounter.SetVar("SavedProg",63)
end

flytime=0
jumptime=0
gravity="Down"
flyspeed=0
jumpspeed=0
HeartChange({0,0,1})
speedx=0
speedy=0

function BlueMode()
	movi=false
	local sx=Player.x
	local sy=Player.y
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
	  if Input.Confirm>0 then
		flyspeed=15
	  end
      else flyspeed=0   
   end
   if Player.y==-(Arena.height/2-8) and  Input.Up>0 then
      jumptime=3
   end
   if jumptime>0 and Player.y>-(Arena.height/2-8) then
      if Input.Up==0 then
         jumptime=0
         else jumptime=jumptime-0.12
		 if Input.Confirm>0 then
			jumptime=0
		 end
      end
      if jumptime<0 then
         jumptime=0
      end
   end
   if jumptime>0 then
      jumpspeed = 6*jumptime/3
      else jumpspeed=0
   end
	if sx==Player.x and sy==Player.y then
		else
		movi=true
	end
end

function Update()
if spawntime%65==0 then
	local rand1=math.random(2)
	local rand2=math.random(2)*2-3
	local r=180
	--if rand1==1 then
		SendKnife({r*rand2,32},{-2*rand2,0},"KnifeDown"..name4,r)
		SendKnife({-r*rand2,-32},{2*rand2,0},"KnifeUp"..name4,r)
		--else
		--SendKnife({32,r*rand2},{0,-2*rand2},"KnifeLeftDeadly",r)
		--SendKnife({-32,-r*rand2},{0,2*rand2},"KnifeRightDeadly",r)
	--end
end
HurtUpd(1200)
--Moving()
BlueMode()
if Input.Right>0 and Input.Left==0 then
   speedx=2
   elseif Input.Right==0 and Input.Left>0 then
   speedx=-2
   else speedx=0
end
spawntime=spawntime+1
for i=1,#knifes do
	local k=knifes[i]
	if k.isactive then
		local time=k.GetVar("time")+1
		k.SetVar("time",time)
		local speed=k.GetVar("speed")
		k.Move(speed[1],speed[2])
		local top=k.GetVar("top")
		if time<31 then	
			k.sprite.alpha=math.sin(time*math.pi/60)
			elseif time>top-30 and time<top then
			k.sprite.alpha=math.sin((time-top+60)*math.pi/60)
			elseif time==top then
			k.Remove()
		end
		if k.x>600 or k.x<-600 or k.y>400 or k.y<-400 then
			k.Remove()
		end
	end
end



end

function OnHit(k)
	if k.GetVar("color")=="red" then
		KnifeHurt(5)
	end
end