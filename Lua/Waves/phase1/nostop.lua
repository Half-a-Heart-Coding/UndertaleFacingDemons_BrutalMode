Arena.Resize(200,80)
await={}
shadows={}
knifeup={}
timer={}
numup=1
for i=1, 60 do
	local shad = CreateProjectile("ShadowDown",300,300)
	shad.SetVar("color","none")
	await[i]=true
	shad.sprite.alpha=0
	table.insert(shadows,shad)
	shad.sprite.alpha=0
end
for i=1,10 do
	local knife=CreateProjectile("KnifeDown",340,300)
	knife.SetVar("color","white")
	knife.SetVar("right",0)
	knife.SetVar("height",0)
	table.insert(knifeup,knife)
	timer[i]=true
	knife.sprite.SendToTop()
end
num=1
require "Libraries/Playermove"
require "Libraries/hurt"
collision = require "Libraries/rotational_collision"
shad_anim={{1, 0, 0}, {0.5, 0, 0},{0,0,0},{0.5,0,0}}--красный,черный,красный
spawntime=5
knivetime=0
walltime=6
angle=45
attacks={}
right={}
heigh={}
loop1=90
loop2=15
n=1
height=0
left_right=0
k=right
bullets={}
knivewallleft={}
knivewallright={}
knifes=true
speed1=12
speedup=3
function Update()
HurtUpd(600)
Moving()
knivetime=knivetime+1
spawntime=spawntime+1
walltime=walltime+1
if knivetime%loop1 ==0 then
  knivetime=0
  if loop1>60 then 
    loop1=loop1-30
  end
  left_right=math.random(3)-2
  height=math.random(2)-1
  if left_right==0 then
    height=1
  end
	local knife=knifeup[numup]
	knife.MoveTo(Player.x+135*left_right,Player.y+90+45*height)
	knife.sprite.rotation=45*left_right
	knife.SetVar("right",left_right)
	knife.SetVar("height",height)
	knife.sprite.alpha=0
	timer[numup]=0
	if numup==10 then
		numup=1
		else numup=numup+1
	end
end
for q=1,#knifeup do
  local bullet = knifeup[q]
  bullet.sprite.SendToTop()
  local right=bullet.GetVar("right")
  local heigh=bullet.GetVar("height")
  if timer[q]==true then
 	elseif timer[q]<45 or timer[q]==45 then
 	timer[q]=timer[q]+1
	if timer[q]<31 then
		bullet.sprite.alpha=math.sin(timer[q]*math.pi/60)
	end
 	bullet.SetVar("angle", timer[q])
    	bullet.sprite.rotation = timer[q]*right
    	bullet.MoveTo(Player.x-135*right+timer[q]*right,Player.y+90+45*heigh-heigh*timer[q])
  	elseif timer[q]>45 then
    	timer[q]=timer[q]+1
    	bullet.MoveTo(bullet.x-speedup*right+(right*(timer[q]-45)/5),bullet.y+speedup-(timer[q]-45)/5)
    	if timer[q]%7==0 then
      		local shadow = shadows[num]
      		shadow.sprite.rotation=angle*right
		shadow.MoveTo(bullet.x,bullet.y)
      		shadow.SetVar("color","white")
      		await[num]=0
		if num==60 then
			num=1
			else
			num=num+1
		end
	end
  end
	if (Player.x+34>bullet.x and Player.x-34<bullet.x) and (Player.y+34>bullet.y and Player.y-34<bullet.y) then
		if collision.CheckCollision(Player, bullet) then
			KnifeHurt(1)
		end
	end
end  
for i=1,#shadows do
  local shadow = shadows[i]
  if not await[i] then
    elseif await[i]==true then
    elseif await[i]<101 then
	if (Player.x+34>shadow.x and Player.x-34<shadow.x) and (Player.y+34>shadow.y and Player.y-34<shadow.y) and await[i]<80 then
		if collision.CheckCollision(Player, shadow) then
			KnifeHurt(1)
		end
	end
    await[i]=await[i]+1
    if await[i]==100 then
      shadow.SetVar("color","none")
    end
      local num=await[i]%20
    shadow.sprite.alpha=0.75-0.0075*await[i]
    elseif await[i]==101 then
    await[i]=true
    shadow.sprite.alpha=0
  end
end  
end

function OnHit(attack)
  local color = attack.GetVar("color")
  if color == "blue" and isMoving()==true then
        KnifeHurt(1)
  end
end