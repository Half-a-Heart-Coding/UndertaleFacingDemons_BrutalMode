ball={}
timer={}
fires={}
flight={}
place={}
n={}
collision = require "Libraries/rotational_collision"
l=0
i=0
require "Libraries/Playermove"
require "Libraries/hurt"
DoGhost("Asgore_Sprite",1,600)

timer={}
spawntime=0
speed1=5
speed2=7
movetime=0
height=1
speedx=0
speedy=0
hue=0

Player.MoveTo(0,0,true)
Arena.ResizeImmediate(100,100)
knife = CreateProjectile("KnifeLeft",210,64)
nohittingtimer=0
BR=CreateProjectileAbs("system/BR",550,70)
function Update()
if spawntime<60 then
	BR.sprite.alpha=math.sin(spawntime*math.pi/120)
end
hue=0.90-0.1*math.sin(math.pi*spawntime/30)
BR.sprite.color ={1*hue,0.5*hue,0.15234375*hue}
HurtUpd(600)
Moving()
if nohittingtimer>0 then
	nohittingtimer=nohittingtimer-1
end
if spawntime%150==0 then
   rand=math.random(360)
   for i=1,60 do
      if rand<65 then
         if (6*i)<rand+70 and (6*i)>rand then
            local knife1 = CreateProjectile("bullet",150*math.cos(6*i*math.pi/180),150*math.sin(6*i*math.pi/180))
            knife1.sprite.color={0/255, 168/255, 242/255}
            angle=i*6
            knife1.SetVar("i",angle)
            knife1.SetVar("angle",angle)
            knife1.sprite.rotation= angle+90
            knife1.SetVar("color","blue")
            table.insert(ball,knife1)
            else local knife2 = CreateProjectile("bullet",150*math.cos(6*i*math.pi/180),150*math.sin(6*i*math.pi/180))
            angle=i*6
            knife2.SetVar("i",angle)
            knife2.SetVar("angle",angle)
            knife2.sprite.rotation=angle+90
            knife2.SetVar("color","white")
            table.insert(ball,knife2)
         end
      else 
         if (6*i)<rand and (6*i)>rand-70 then
            local knife1 = CreateProjectile("bullet",150*math.cos(6*i*math.pi/180),150*math.sin(6*i*math.pi/180))
            knife1.sprite.color={0/255, 168/255, 242/255}
            angle=i*6
            knife1.SetVar("i",angle)
            knife1.SetVar("angle",angle)
            knife1.sprite.rotation= angle+90
            knife1.SetVar("color","blue")
            table.insert(ball,knife1)
            else local knife2 = CreateProjectile("bullet",150*math.cos(6*i*math.pi/180),150*math.sin(6*i*math.pi/180))
            angle=i*6
            knife2.SetVar("i",angle)
            knife2.SetVar("angle",angle)
            knife2.sprite.rotation=angle+90
            knife2.SetVar("color","white")
            table.insert(ball,knife2)
         end
      end
   end
end
if spawntime%150==10 and spawntime>10 then
   height=-height
end
if knife.y==64*height then
   else
   knife.MoveTo(knife.x,knife.y+8*height)
end
if spawntime%150==140 then
   safe=math.random(5)+1
end
if spawntime%150>142 then 
   local fire = CreateProjectile("bullet",210,48-(spawntime%150-143)*16)
   table.insert(fires,fire)
   if spawntime%150-142==safe+1 or spawntime%150-142==safe-1 or spawntime%150-142==safe then
      fire.SetVar("color","blue")
      fire.sprite.color={0/255, 168/255, 242/255}
      else 
      fire.SetVar("color","white")
   end
end
for i=1,#fires do
   local fire = fires[i]
   fire.SendToBottom()
   if fire.y==knife.y then
      fire.sprite.color={1,0,0}
   end
   if spawntime%150==70 then
      flight[i]=true
   end
   if  not place[i] then
      elseif place[i]<-50 and fire.GetVar("color")=="blue" then
	if place[i]<-80 then
		fire.sprite.color={0/255, 168/255, 242/255}
		else
		local old=(80+place[i])/30
		now=1-old
		fire.sprite.color={1*old,168/255*now,242/255*now}
	end
      elseif place[i]<-50 then
	if place[i]<-80 then
		fire.sprite.color={1,1,1}
		else
		local old=(80+place[i])/30
		now=1-old
		fire.sprite.color={1,1*now,1*now}
	end
   end
   if flight[i] then
      if fire.x>100 then
         fire.MoveTo(fire.x-4,fire.y)
      elseif not place[i] then
         place[i]=fire.x
         else fire.MoveTo(place[i],fire.y)
         place[i]=place[i]-2
      end
   end
end
for g=1,#ball do
   local knife = ball[g]
   if not timer[g] then
      timer[g]=0 
      elseif timer[g]<82 then
      timer[g]=timer[g]+1
      elseif timer[g]==82 then 
      timer[g]=timer[g]+1
      knife.Remove()
      else move=true
   end
   local ugol = knife.GetVar("i")*math.pi/180
   if knife.isactive and timer[g]>50 and timer[g]<81 then
      move=false
      knife.MoveTo(knife.x-5*math.cos(ugol),knife.y-5*math.sin(ugol))
   end
end
spawntime=spawntime+1
end
function OnHit(attack)
if attack.GetVar("color")=="white" and collision.CheckCollision(Player,attack) and attack.sprite.alpha then
	LongHurt(1,5)
	Effects("burn",1)
   elseif attack.GetVar("color")=="blue" and collision.CheckCollision(Player,attack) and attack.sprite.alpha and isMoving() then
	LongHurt(1,5)
	Effects("burn",1)
end
end
