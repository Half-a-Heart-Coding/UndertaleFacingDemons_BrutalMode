Arena.ResizeImmediate(160,16)
spawntime=0
require "Libraries/Playermove"
require "Libraries/hurt"
dir=0
rain={}
timer={}
preRandom = -1
colorknife={}
name2=""
if GetGlobal("DifficultyPoints") >= 621 then
	name2="Fatal"
end
name3="Deadly"
if GetGlobal("DifficultyPoints") >= 621 then
	name3="Fatal"
end
name4="Lethal"
if GetGlobal("DifficultyPoints") >= 621 then
	name4="Fatal"
end
function Update()
HurtUpd(720)
Moving()
spawntime=spawntime+1
if spawntime%12==0 then
   rand2=math.random(8)
   if preRandom > -1 and (rand2 == preRandom + 1 or rand2 == preRandom - 1) then
    rand2=((math.random(5)-3) * 2)
    if rand2 < -3 then
        rand2 = -3
    end
    if rand2 > 3 then
        rand2 = 3
    end
    rand2 = preRandom + rand2

    if rand2 <= 0 then
        rand2=(math.random(3)-2) * 2
        rand2 = preRandom + rand2
    end
    if rand2 >= 9 then
       rand2=(math.random(3)-2) * 2
        rand2 = preRandom + rand2
    end

    if rand2 <= 0 then
        rand2=3
        rand2 = preRandom + rand2
    end
    if rand2 >= 9 then
        rand2=5
        rand2 = preRandom + rand2
    end
   end
   local knife = CreateProjectile("KnifeDown"..name3,-90+20*rand2,400)
   knife.SetVar("color","white")
   table.insert(rain,knife)
end
for i=1,#rain do
   local knife = rain[i]
   if knife.isactive and not timer[i] then
      knife.Move(0,-6)
   end
   if knife.y<24 and not timer[i] then
      timer[i]=0
   end
   if not timer[i] then
      elseif timer[i]<20 then
      timer[i]=timer[i]+1
      knife.sprite.alpha=1-0.05*timer[i]
      if timer[i]> 12 then
         knife.SetVar("color","none")
      end
      if timer[i]==20 then
         knife.Remove()
      end
   end
end
if spawntime%40==0 then
   rand1=math.random(2)
   if dir==0 then
      if rand1==1 then
        local knife = CreateProjectile("KnifeUpBlue"..name3,230,0)
        knife.SetVar("x",-5)
        table.insert(colorknife,knife)
	    knife.sprite.alpha=0
         knife.SetVar("color","blue")
         --knife.sprite.color={0/255, 168/255, 242/255}
         knife.sprite.Scale(-1,1)
      dir=1
      else 
      local knife = CreateProjectile("KnifeUpOrange"..name3,230,0)
        knife.SetVar("x",-5)
        table.insert(colorknife,knife)
	    knife.sprite.alpha=0
         knife.SetVar("color","orange")
         --knife.sprite.color={0/255, 168/255, 242/255}
         knife.sprite.Scale(-1,1)
      end
      else
     if rand1==1 then
        local knife = CreateProjectile("KnifeUpBlue"..name3,-230,0)
        knife.SetVar("x",5)
        table.insert(colorknife,knife)
	    knife.sprite.alpha=0
         knife.SetVar("color","blue")
         --knife.sprite.color={0/255, 168/255, 242/255}
         knife.sprite.Scale(1,1)
      dir=1
      else 
      local knife = CreateProjectile("KnifeUpOrange"..name3,-230,0)
        knife.SetVar("x",5)
        table.insert(colorknife,knife)
	    knife.sprite.alpha=0
         knife.SetVar("color","orange")
         --knife.sprite.color={0/255, 168/255, 242/255}
         knife.sprite.Scale(1,1)
      end
   end
end
for i=1,#colorknife do
   local knife = colorknife[i]
   local dir = knife.GetVar("x")
   if knife.isactive then
      knife.Move(dir,0)
   end
   local dist=math.abs(knife.x)
   if dist<200 then
	if dist>80 then
		local t=dist-80
		knife.sprite.alpha=math.cos(t*math.pi/240)
	end
	elseif dist>240 then
	knife.Remove()
   end
end
end
function OnHit(attack)
if ((attack.GetVar("color")=="orange" and not isMoving()) or (attack.GetVar("color")=="blue" and isMoving()) or attack.GetVar("color")=="white") and attack.isactive then
	KnifeHurt(2)
end
end