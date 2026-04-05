Arena.ResizeImmediate(200,64)
spawntime=0
paps = CreateSprite("smile")
paps.SendToBottom()
paps.x = 315
paps.y = 375
paps.Scale(1.3, 1.3)
paps.alpha = 0.0
knifes1={}
speed1={}
speed2={}
knifesrain={}
knifesfly={}
timer1={}
timer2={}
falltim=0
require "Libraries/Playermove"
require "Libraries/hurt"

function Update()
HurtUpd()
Moving()
falltim=falltim+1
paps.alpha=math.sin(spawntime*math.pi/580)
spawntime=spawntime+1
if (Player.x/2+falltim)>50 then
   falltim=falltim-50
   local knife = CreateProjectile("KnifeDown",Player.x,64)
   knife.SetVar("color","white")
   table.insert(knifesrain,knife)
end
--[[if spawntime%150==25 then
   rand2=-1
   local knife = CreateProjectile("KnifeLeft",182*rand2,Player.y)
   table.insert(knifesfly,knife)
   knife.SetVar("color","white")
   knife.sprite.rotation=90-rand2*90
end]]
if spawntime%50==0 or spawntime%50==25  then
   rand1=1
   local knife = CreateProjectile("speardown",150,0)
   knife.sprite.rotation=180
   knife.SetVar("dir",-4)
   if spawntime%50>1 then
      knife.sprite.color={255/256,183/256,0}
      knife.SetVar("color","orange")
      else
      knife.sprite.color={0,1,1}
      knife.SetVar("color","blue")
   end
   table.insert(knifes1,knife)
end
for i=1,#knifes1 do
   local knife=knifes1[i]
   if not speed1[i] then
      speed1[i]=-knife.x/75
      else knife.MoveTo(knife.x+speed1[i],knife.y)
   end
end
for i = 1,#knifesrain do
   local knife = knifesrain[i]
   if not timer1[i] then
      timer1[i]=50
      elseif timer1[i]>0 then
      timer1[i]=timer1[i]-1
      elseif knife.isactive==true then
	knife.MoveTo(knife.x,knife.y-8)
	if knife.y<-150 then
		knife.Remove()
	end
   end
end
for i = 1,#knifesfly do
   local knife = knifesfly[i]
   if not speed2[i] then
      speed2[i]=-knife.x/182*15
   end
   if not timer2[i] then
      timer2[i] = 75
      elseif timer2[i]>0 then
      timer2[i]=timer2[i]-1
      else knife.MoveTo(knife.x+8,knife.y)
   end
end
--[[if spawntime==600 then
	Arena.ResizeImmediate(535,130)
	EndWave()
end]]
end
function OnHit(attacks)
if attacks.GetVar("color")=="blue" and isMoving() then
		KnifeHurt(1)
   elseif attacks.GetVar("color")=="orange" and not isMoving() then
		KnifeHurt(1)
   elseif attacks.GetVar("color")=="white" then
		KnifeHurt(1)
end
end