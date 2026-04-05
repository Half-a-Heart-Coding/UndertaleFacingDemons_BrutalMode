Arena.Resize(150,150)
spawntime=0
pellets={}
timer={}
speedx={}
speedy={}
require "Libraries/Playermove"
require "Libraries/hurt"
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
if spawntime%60 == 0 then
   rand1=math.random(3)
   rand3=math.random(2)
   rand2=math.random(11)+1.5-7
   if rand1%2==0 then
      for i=-7,7 do
         local pellet = CreateProjectile("pellet",i*10,300)
         table.insert(pellets,pellet)
         pellet.SetVar("dir",0)
         if i-2<rand2 and i+2>rand2 then
            pellet.SetVar("safe","safe"..rand3)
            else pellet.SetVar("safe","not")
         end
      end
      else 
      for i=-7,7 do
         local pellet = CreateProjectile("pellet",300*(rand1-2),i*10)
         table.insert(pellets,pellet)
         pellet.SetVar("dir",-rand1+2)
         if i-2<rand2 and i+2>rand2 then
            pellet.SetVar("safe","safe"..rand3)
            else pellet.SetVar("safe","not")
         end
      end
   end
end
for i=1,#pellets do
   local pellet = pellets[i]
   speedx[i]=pellet.GetVar("dir")
   if speedx[i]==0 then
      speedy[i]=-1 
      else speedy[i]=0
   end
   if not timer[i] then
      timer[i]=0
      else timer[i]=timer[i]+1
      if timer[i]%15 == 0 then
          pellet.sprite.rotation=pellet.sprite.rotation+90
      end
   end
   local safe = pellet.GetVar("safe")
   if safe == "safe1" then
      pellet.MoveTo(pellet.x+speedx[i]*4.4,pellet.y+speedy[i]*4.4)
      elseif safe == "safe2" then 
      pellet.MoveTo(pellet.x+speedx[i]*2.6,pellet.y+speedy[i]*2.6)
      else pellet.MoveTo(pellet.x+speedx[i]*3.5,pellet.y+speedy[i]*3.5)
   end
end
end
function OnHit()
	LongHurt(10,60)
end
