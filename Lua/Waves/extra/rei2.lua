Arena.ResizeImmediate(200,200)
require "Libraries/colortoys"
collision = require "Libraries/rotational_collision"
require "Libraries/Playermove"
require "Libraries/hurt"
stars1={}
stars2={}
knifes={}
speedx={}
safe3={}
safe4={}
safety={}
speedy={}
warnings={}
timer={}
true_anim = Gradient.new ({{0,1,0},{1,1,1},{0,1,0}})
false_anim = Gradient.new ({{1,0,0},{1,1,1},{1,0,0}})
spawntime=0
paps = CreateSprite("Asriel_Sprite")
paps.SendToBottom()
paps.x = 380
paps.y = 365
paps.Scale(2, 2)
paps.alpha = 0.0
battlesprites={}
table.insert(battlesprites,paps)
function Update()
HurtUpd(600)
Moving()
paps.alpha = 0.5*math.sin(spawntime*math.pi/580)
if spawntime<300 or spawntime==300  then
   paps.x = 330+90*math.sin(spawntime*math.pi/580)
   elseif spawntime==380 then
   paps.SendToTop()
   else paps.x = 510-90*math.sin(spawntime*math.pi/580)
end
hue=1-0.5*math.sin(math.pi*spawntime/30)
if spawntime%150==0 then
   truth1=math.random(2)*2-3
   truth2=math.random(2)*2-3
   flight=false
   right1=math.random(2)*2-3
   height1=math.random(2)*2-3
   safe1=math.random(2)*2-3--по ширине
   safe2=math.random(2)*2-3--по высоте
   local warn1=CreateProjectile("arrow",-200,200)
   local warn2=CreateProjectile("arrow",-200,200)
   table.insert(warnings,warn1)
   table.insert(warnings,warn2)
   warn1.sprite.rotation=90-90*safe1-90*(truth1-1)--право лево
   warn2.sprite.rotation=-(90*safe2)-90*(truth2-1)--вверх вниз
   if truth1==1 then
      warn1.sprite.color={0,1,0}
      warn1.SetVar("true","true")
      else warn1.sprite.color={1,0,0}
      warn1.SetVar("true","false")
   end
   if truth2==1 then
      warn2.sprite.color={0,1,0}
      warn2.SetVar("true","true")
      else warn2.sprite.color={1,0,0}
      warn2.SetVar("true","false")
   end
end
if spawntime%150==131 then
   flight=true
end
if spawntime%150==91 then
   randx=math.random(7)
   randy=math.random(7)
   flight=false
   local knife1=CreateProjectile("KnifeDown",200*right1,-80+20*randy)--летит направо или влево
   local knife2=CreateProjectile("KnifeDown",-80+20*randx,200*height1)--летит вверх или вниз
   knife1.SetVar("color","white")
   knife2.SetVar("color","white")
   knife1.SetVar("Number",1)
   knife2.SetVar("Number",2)
   knife1.sprite.rotation=-right1*90
   knife2.sprite.rotation=90-height1*90
   knife1.SetVar("right",right1)
   knife2.SetVar("right",0)
   knife1.SetVar("height",0)
   knife2.SetVar("height",height1)
   knife1.SetVar("safe",safe2)
   knife2.SetVar("safe",safe1)
   table.insert(knifes,knife1)
   table.insert(knifes,knife2)
end
for i=1,#knifes do
   local knife = knifes[i]
   speedx[i]=knife.GetVar("right")
   speedy[i]=knife.GetVar("height")
   safety[i]=knife.GetVar("safe")
   local numb=knife.GetVar("Number")
   if knife.isactive then
	if (Player.x+40>knife.x and Player.x-40<knife.x) and (Player.y+40>knife.y and Player.y-40<knife.y) then
		if collision.CheckCollision(Player, knife) then
			KnifeHurt(1)
		end
	end
      knife.MoveTo(knife.x-8*speedx[i],knife.y-8*speedy[i])
      if (knife.x<100 and knife.x>-100) and (knife.y<100  and knife.y>-100 ) and (spawntime%4==0 or spawntime%4==2)  then
         local star = CreateProjectile("star",knife.x,knife.y)
         star.SetVar("color","asriel")
         star.SetVar("safe",safety[i])
         if numb==1 then
           table.insert(stars1,star)
           else table.insert(stars2,star)
         end
         star.SetVar("right",speedx[i])
         star.SetVar("height",speedy[i])
      end
   end
   if (knife.x*speedx[i]<-110 and speedy[i]==0) or (knife.y*speedy[i]<-110  and speedx[i]==0 ) and knife.isactive then
      knife.Remove()
   end
end
for i=1,#stars1 do--летят вверх или вниз
   local star = stars1[i]
   if not safe3[i] then
      safe3[i]=star.GetVar("safe")
   end
   if spawntime%4==0 then
      star.sprite.color = color_multiply(hsv_to_rgb(hue, 1.0, 0.70), 1.0)
   end
   if flight and star.isactive then
      star.MoveTo(star.x,star.y+safe3[i]*15)
   end
   if spawntime%150==92 then
      star.Remove()
   end
end   
for i=1,#stars2 do--летят вправо или влево
   local star = stars2[i]
   if not safe4[i] then
      safe4[i]=star.GetVar("safe")
   end
   if spawntime%4==0 then
      star.sprite.color = color_multiply(hsv_to_rgb(hue, 1.0, 0.70), 1.0)
   end
   if flight and star.isactive then
      star.MoveTo(star.x-safe4[i]*15,star.y)
   end
   if spawntime%150==92 then
      star.Remove()
   end
end   
spawntime=spawntime+1
for i=1,#warnings do
   local warn=warnings[i]
   if not timer[i] then
      timer[i]=0
      elseif timer[i]<90 then
      if warn.GetVar("true")=="true" then
         warn.sprite.color=true_anim:getColorAt(timer[i]/3%3)
         else warn.sprite.color=false_anim:getColorAt(timer[i]/3%3)
      end
      timer[i]=timer[i]+1
      elseif timer[i]==90 then
      warn.Remove()
   end
end
end
function OnHit(attacks)
if attacks.GetVar("color") == "asriel" and collision.CheckCollision(Player, attacks) and attacks.sprite.alpha then
   if Player.hp<16 then
      LongHurt(Player.hp-1,60)
      else LongHurt(15,60)
   end
end
end