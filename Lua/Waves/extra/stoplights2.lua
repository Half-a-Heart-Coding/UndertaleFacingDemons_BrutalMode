Arena.Resize(300,64)
spawntime=0
paps = CreateSprite("smile")
paps.SendToBottom()
paps.x = 315
paps.y = 375
paps.Scale(1.3, 1.3)
paps.alpha = 0.0
knifes1={}
pos={}
speed1={}
speed2={}
knifesrain={}
knifesfly={}
timer1={}
timer2={}
require "Libraries/Playermove"
require "Libraries/hurt"
function Update()
HurtUpd(600)
Moving()
paps.alpha=math.sin(spawntime*math.pi/580)
spawntime=spawntime+1
if spawntime%50==0 then
   local knife = CreateProjectile("KnifeDown",Player.x,64)
   knife.SetVar("color","white")
   table.insert(knifesrain,knife)
end
if spawntime%100==25 then
   rand2=math.random(2)*2-3
   local knife = CreateProjectile("knifeLeft",182*rand2,Player.y)
   table.insert(knifesfly,knife)
   knife.SetVar("color","white")
   knife.sprite.rotation=90-rand2*90
end
if spawntime%100==0 or spawntime%100==50 or spawntime%100==4 or spawntime%100==54 then
   rand1=1
   if spawntime%100<10 then
      local knife = CreateProjectile("speardown",-350,0)
      knife.SetVar("dir",4)
      if rand1>1 then
         knife.sprite.color={255/256,183/256,0}
         knife.SetVar("color","orange")
         else
         knife.sprite.color={0,1,1}
         knife.SetVar("color","blue") 
      end
      knife.GetVar("speed",4)
      table.insert(knifes1,knife)
      else local knife = CreateProjectile("speardown",350,0)
      knife.sprite.rotation=180
      knife.SetVar("dir",-4)
      if rand1>1 then
         knife.sprite.color={255/256,183/256,0}
         knife.SetVar("color","orange")
         else
         knife.sprite.color={0,1,1}
         knife.SetVar("color","blue")
      end
      knife.SetVar("speed",-4)
      table.insert(knifes1,knife)
   end
end
for i=1,#knifes1 do
   local knife=knifes1[i]
   if not speed1[i] then
	pos[i]=knife.x
      speed1[i]=-knife.x/350*6
      elseif knife.isactive then
	pos[i]=pos[i]+speed1[i]
	if (speed1[i]>0 and (Player.x+pos[i])>knife.x) or (speed1[i]<0 and (Player.x+pos[i])<knife.x) then
		knife.MoveTo(MovingTo(knife.x+speed1[i],Player.x+pos[i]),knife.y)
	end
	if pos[i]>400 or pos[i]<-400 then
		knife.Remove()
	end
   end
end
for i = 1,#knifesrain do
   local knife = knifesrain[i]
   if not timer1[i] then
      timer1[i]=45
      elseif timer1[i]>0 then
      timer1[i]=timer1[i]-1
      else knife.MoveTo(knife.x,knife.y-8)
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
      else knife.MoveTo(knife.x+speed2[i],knife.y)
   end
end
end

function MovingTo(firstx,lastx)
	local outgo=firstx+((lastx-firstx)/10)
	local n=(lastx-firstx)/10
	if n>2.5 or n<-2.5 then
		if n<-2.5 then
			n=-2.5
			else n=2.5
		end
		outgo=firstx+n
	end
		
	return outgo
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