Arena.ResizeImmediate(200,200)
require "Libraries/colortoys"
collision = require "Libraries/rotational_collision"
require "Libraries/Playermove"
require "Libraries/hurt"
stars={}
knifes={}
speedx={}
safe2={}
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
   paps.x = 235+90*math.sin(spawntime*math.pi/580)
   elseif spawntime==380 then
   paps.SendToTop()
   else paps.x = 415-90*math.sin(spawntime*math.pi/580)
end
hue=1-0.5*math.sin(math.pi*spawntime/30)
if spawntime%150==0 then
   flight=false
   truth=math.random(2)*2-3
   rand1=math.random(2)
   if rand1 ==1 then
      right1=math.random(2)*2-3
      height1=0
      else height1=math.random(2)*2-3
      right1=0
   end
   if height1==0 then
      safe1=math.random(2)*2
      else safe1=math.random(2)*2-1
   end
   local warn=CreateProjectile("arrow",-200,200)
   table.insert(warnings,warn)
   warn.sprite.rotation=90-(90*safe1)-90*(truth-1)
   if truth==1 then
      warn.sprite.color={0,1,0}
      warn.SetVar("true","true")
      else warn.sprite.color={1,0,0}
      warn.SetVar("true","false")
   end
end
if spawntime%150==131 then
   flight=true
end
if spawntime%150==91 then
   if right1== 0 then
      randx=math.random(7)
      randy=4-3*height1
      else 
      randy=math.random(7)
      randx=4-3*right1
   end
   flight=false
   local knife=CreateProjectile("KnifeDown",-80+20*randx+200*right1,-80+20*randy+200*height1)
   knife.SetVar("color","white")
   if height1==0 then
      knife.sprite.rotation=-right1*90
      else knife.sprite.rotation=90-height1*90
   end
   knife.SetVar("right",right1)
   knife.SetVar("height",height1)
   table.insert(knifes,knife)
end
for i=1,#knifes do
   local knife = knifes[i]
   speedx[i]=knife.GetVar("right")
   speedy[i]=knife.GetVar("height")
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
         table.insert(stars,star)
         star.SetVar("right",speedx[i])
         star.SetVar("height",speedy[i])
      end
   end
   if (knife.x*speedx[i]<-110 and speedy[i]==0) or (knife.y*speedy[i]<-110  and speedx[i]==0 ) and knife.isactive then
      knife.Remove()
   end
end
for i=1,#stars do
   if not safe2[i] then
      safe2[i]=safe1
   end
   local star = stars[i]
   if spawntime%4==0 then
      star.sprite.color = color_multiply(hsv_to_rgb(hue, 1.0, 0.70), 1.0)
   end
   if flight and star.isactive then
      if safe2[i]%2==1 then
         star.MoveTo(star.x+(safe2[i]-2)*15,star.y)
         else star.MoveTo(star.x,star.y-(safe2[i]-3)*15)
      end
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
if attacks.GetVar("color") == "asriel" then
   if Player.hp<16 then
      LongHurt(Player.hp-1,60)
      else LongHurt(15,60)
   end
end
end

   