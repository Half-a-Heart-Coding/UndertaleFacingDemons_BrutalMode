Arena.Resize(300,64)
spawntime=0
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
DoGhost("smile",0,600)
function Update()
HurtUpd(600)
Moving()
spawntime=spawntime+1
if spawntime%50==0 then
   local knife = CreateProjectile("KnifeDown",Player.x,64)
   knife.SetVar("color","white")
   table.insert(knifesrain,knife)
	knife.sprite.alpha=0
	knife.SetVar("time",0)
end
if spawntime%100==25 then
   rand2=math.random(2)*2-3
   local knife = CreateProjectile("knifeLeft",182*rand2,Player.y)
   table.insert(knifesfly,knife)
   knife.SetVar("color","white")
	knife.SetVar("time",0)
   knife.sprite.rotation=90-rand2*90
end
if spawntime%100==0 or spawntime%100==50 or spawntime%100==4 or spawntime%100==54 then
   if spawntime%100<10 then
      local knife = CreateProjectile("speardown",-350,0)
      knife.SetVar("dir",4)
      knife.sprite.color={0/255, 168/255, 242/255}
      knife.SetVar("color","blue") 
      knife.SetVar("speed",4)
	knife.SetVar("time",0)
      table.insert(knifes1,knife)
      else local knife = CreateProjectile("speardown",350,0)
      knife.sprite.rotation=180
      knife.SetVar("dir",-4)
      knife.sprite.color={0/255, 168/255, 242/255}
      knife.SetVar("color","blue")
      knife.SetVar("speed",-4)
	knife.SetVar("time",0)
      table.insert(knifes1,knife)
   end
end
for i=1,#knifes1 do
   local knife=knifes1[i]
	if knife.isactive then
	local t=knife.GetVar("time")+1
	knife.SetVar("time",t)
	if t<31 then
		knife.sprite.alpha=math.sin(t*math.pi/60)
	end
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
end
for i = 1,#knifesrain do
   local knife = knifesrain[i]
	if knife.isactive then
	local t=knife.GetVar("time")+1
	knife.SetVar("time",t)
	if t<31 then
		knife.sprite.alpha=math.sin(t*math.pi/60)
	end
   if not timer1[i] then
      timer1[i]=45
      elseif timer1[i]>0 then
      timer1[i]=timer1[i]-1
      else knife.MoveTo(knife.x,knife.y-8)
   end
	end
end
for i = 1,#knifesfly do
   local knife = knifesfly[i]
	if knife.isactive then
	local t=knife.GetVar("time")+1
	knife.SetVar("time",t)
	if t<31 then
		knife.sprite.alpha=math.sin(t*math.pi/60)
	end
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