flytime=0
flyspeed=0
jumptime=0
jumpspeed=0
require "Libraries/Playermove"
require "Libraries/control"
timer=0
bones={}
blue=false
Arena.ResizeImmediate(200,150)
Player.MoveTo(0,-68,true)
side=1
HeartChange({0,0,1})
rands={1,1,1,1}
for i=1,4 do
	rands[i]=-6+math.random(11)
end


function GiveRandom()
	for i=1,4 do
		rands[i]=-60+math.random(119)
	end
end

function ThrowColumn()
	local place=-44+math.random(87)
	local sid=math.random(2)*2-3
	for i=0,4 do
		local pos=place+i/4*math.sin((math.random(2)+1)*math.pi/2)*16
		ThrowBone({320+15*i,pos})
		sid=-sid
	end
end

function ThrowBone(pos)
	local bone=CreateProjectile("bone",pos[1],pos[2])
	bone.SetVar("color","good")
	bone.sprite.color={1,1,0}
	bone.sprite.rotation=math.random(180)
	bone.SetVar("side",side)
	table.insert(bones,bone)
end

function Update()
timer=timer+1
local all=60
if timer%all==20 then
	ThrowColumn()
end
for i=1,#bones do
	local b=bones[i]
	b.sprite.rotation=b.sprite.rotation+5
	if b.isactive then
		b.Move(-6*b.GetVar("side"),0)
		if b.isactive then
			if b.x>400 or b.x<-400 then
				b.Remove()
			end
		end
	end
end
TimeUpd(600)
BlueMode()

end

function OnHit(b)
if b.GetVar("color")=="good" then
	Flower(10)
	b.Remove()
end
end

function BlueMode()
	movi=false
	local sx=Player.x
	local sy=Player.y
	if Input.Right>0 and Input.Left==0 then
		speedx=2
		elseif Input.Right==0 and Input.Left>0 then
		speedx=-2
		else
		speedx=0
	end
   Player.sprite.rotation=0
   Player.MoveTo(Player.x+speedx,Player.y-flyspeed+jumpspeed,false)
   if Player.y==-(Arena.height/2-8) then 
      flytime=0
   end
   if Player.y>-(Arena.height/2-8) and jumptime==0 then
      if flytime<5 then
         flytime=flytime+0.06
      end
   end
   if flytime>0 then
      --flyspeed=5*math.sqrt(math.sin(flytime*math.pi/10))
      flyspeed=5*math.sin(flytime*math.pi/10)*math.sin(flytime*math.pi/10)
      else flyspeed=0   
   end
   if Player.y==-(Arena.height/2-8) and  Input.Up>0 then
      jumptime=3
   end
   if jumptime>0 and Player.y>-(Arena.height/2-8) then
      if Input.Up==0 then
         jumptime=0
         else jumptime=jumptime-0.06
      end
      if jumptime<0 then
         jumptime=0
      end
   end
   if jumptime>0 then
        jumpspeed = 5*jumptime/3
	--jumpspeed=5*math.sin(jumptime*math.pi/6)
      else jumpspeed=0
   end
	if sx==Player.x and Player.y==(-Arena.height/2+8) then
		movi=false
		else
		movi=true
	end
end