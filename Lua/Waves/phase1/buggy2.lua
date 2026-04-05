Arena.Resize(150,150)
require "Libraries/Playermove"
require "Libraries/hurt"
spawntime=0
pellets={}
timer={}
slow={}
knifes={}
safe=7
speedx={}
speedy={}
DoGhost("Flowey_Sprite",1,600)
nohittingtimer=0
function Update()
HurtUpd(600)
Moving()
if nohittingtimer>0 then
	nohittingtimer=nohittingtimer-1
end
spawntime=spawntime+1
if spawntime==600 then
   EndWave()
end
if spawntime%10==0 then
   if safe==3 then
      rand2=1
      elseif safe==11 then
      rand2=-1
      else   rand2=math.random(2)*2-3
   end
   safe=safe+rand2
end
if spawntime%40==0 then
   local knife = CreateProjectile("KnifeDown",Player.x,150)
   knife.SetVar("color","white")
	knife.sprite.alpha=0
	knife.SetVar("time",0)
   table.insert(knifes,knife)
end
if spawntime%10 == 1 then
   rand1=math.random(3)
   rand3=math.random(2)
   for i=1,15 do
      if i-3<safe and i+4>safe then
         else
         local pellet = CreateProjectile("pellet",-78,i*10-75)
         table.insert(pellets,pellet)
         pellet.SetVar("dir",0)
      end
   end
end
for i=1,#pellets do
   local pellet = pellets[i]
   speedx[i]=pellet.GetVar("dir")
   if not timer[i] then
      timer[i]=0
      elseif pellet.isactive then
      timer[i]=timer[i]+1
      if timer[i]%30 == 0 then
         if pellet.sprite.rotation==360 then
            pellet.sprite.rotation=0
            else pellet.sprite.rotation=pellet.sprite.rotation+90
         end
      end
   end
   if pellet.isactive then
      pellet.MoveTo(pellet.x+2.5,pellet.y)
   end
   if pellet.x>75 then
      pellet.Remove()
   end
end
for i=1,#knifes do
   local knife = knifes[i]
	if knife.isactive then
	   if not slow[i] then
	      slow[i]=0
	      elseif slow[i]>45 and knife.isactive then
		local y=-5
		if slow[i]<60 then
			y=-5*math.sin((slow[i]-45)*math.pi/30)
		end
	      knife.MoveTo(knife.x,knife.y+y)
		slow[i]=slow[i]+1
		
	      else
		slow[i]=slow[i]+1
		if slow[i]<31 then
			knife.sprite.alpha=math.sin(slow[i]*math.pi/60)
		end
	   end
	   if knife.y<-150 then
	      knife.Remove()
	   end
	end
end
end
function OnHit(attacks)
if attacks.GetVar("color")=="white" then
	KnifeHurt(1)
   else
	LongHurt(10,60)
end
end
