spawntime=0
n=150
timer={}
inbox={}
knifes={}
flight={}
function Update()
spawntime=spawntime+1
if spawntime%50==0 then
   ranx=math.random(2)*2-3
   local knife=CreateProjectile("KnifeRight",(n+30)*ranx,n+30)
   table.insert(knifes,knife)
   if ranx==1 then
      knife.SetVar("x",1)
      else knife.SetVar("x",-1)
   end
   knife.SetVar("y",1)
   n=n+10
end
for i=1,#knifes do
   local knife = knifes[i]
   local speedx = knife.GetVar("x")
   local speedy = knife.GetVar("y")
   if not timer[i] then
      timer[i]=60
      elseif timer[i]>5 then
      timer[i]=timer[i]-1
      local dist = math.sqrt((Player.x-knife.x)*(Player.x-knife.x)+(Player.y-knife.y)*(Player.y-knife.y))
      knife.sprite.rotation = math.asin ((Player.x-knife.x)/(dist))*180/math.pi-90
      if knife.x> 0 then
         knife.SetVar("angle",knife.sprite.rotation)
         else knife.SetVar("angle",knife.sprite.rotation+270)
      end
      elseif timer[i]>0 then
      timer[i]=timer[i]-1
      else flight[i]=true
   end
   if flight[i] then
      local angle = knife.GetVar("angle")
      knife.MoveTo(knife.x+4*math.cos(angle*math.pi/180)*speedx,knife.y+3*math.sin(angle*math.pi/180)*speedy)
   end
   if knife.x<n/4 and knife.x>-n/4 and  knife.y<n/4 and knife.y>-n/4 then
      inbox[i]=true
   end
   if inbox[i] then
         local angle = knife.GetVar("angle")
      if not angle then
         else
         if (knife.x+32*math.cos(angle*math.pi/180)+10 * math.sin(angle*math.pi/180)) > n/2 and speedx==1 and inbox[i] then
            knife.SetVar("x",-1)
            elseif (knife.x+32*math.cos(angle*math.pi/180)+10 * math.sin(angle*math.pi/180)) <-n/2 and speedx==-1 and inbox[i] then
            knife.SetVar("y",1)
            elseif (knife.x+32*math.sin(angle*math.pi/180)+10 * math.cos(angle*math.pi/180)) > n/2 and speedy==1 and inbox[i] then
            knife.SetVar("y",-1)
            elseif (knife.x+32*math.sin(angle*math.pi/180)+10 * math.cos(angle*math.pi/180)) < -n/2 and speedy==-1 and inbox[i] then
            knife.SetVar("y",1)
         end
      end
   end
end
Arena.Resize(n,n)
end
