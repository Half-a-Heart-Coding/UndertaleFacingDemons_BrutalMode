Arena.Resize(300,64)
require "Libraries/Playermove"
require "Libraries/hurt"
Player.SetControlOverride(true)
spawntime=0
knifes={}
speed={}
function Update()
HurtUpd(600)
Moving()
spawntime=spawntime+1
if spawntime%50==0 or spawntime%50==25 then
   rand=math.random(2)
   if spawntime%50==25 then
      local knife = CreateProjectile("speardown",-300,0)
      knife.SetVar("dir",4)
      if rand==1 then
         knife.sprite.color={255/256,183/256,0}
         knife.SetVar("color","orange")
         else
         knife.sprite.color={0,1,1}
         knife.SetVar("color","blue") 
      end
      table.insert(knifes,knife)
      else local knife = CreateProjectile("speardown",300,0)
      knife.sprite.rotation=180
      knife.SetVar("dir",-4)
      if rand==1 then
         knife.sprite.color={255/256,183/256,0}
         knife.SetVar("color","orange")
         else
         knife.sprite.color={0,1,1}
         knife.SetVar("color","blue")
      end
      table.insert(knifes,knife)
   end
end
for i=1,#knifes do
   local knife=knifes[i]
   if not speed[i] then
      speed[i]=-knife.x/300*4
      else knife.MoveTo(knife.x+speed[i],knife.y)
   end
end
end
function OnHit(attacks)
if attacks.GetVar("color")=="blue" and isMoving()==true then
	KnifeHurt(1)
   elseif attacks.GetVar("color")=="orange" and isMoving()==false then
	KnifeHurt(1)
end
end