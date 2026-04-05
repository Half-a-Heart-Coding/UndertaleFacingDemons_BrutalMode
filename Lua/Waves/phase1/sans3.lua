
spawntime=0
Player.MoveTo(0,0,false)
Arena.ResizeImmediate(128,150)
gravity="Down"
flyspeed=0
jumpspeed=0
phase=1
movi=false
bones1={}
rand1 = math.random(2)
blasters={}
require "Libraries/Playermove"
require "Libraries/hurt"
DoGhost("Sans_Sprite",1,600)
lasers={}
easybul={}
bones2={}
timer1={}
timer2={}
speed1={}
speed2={}
right={}
left={}
knifes1={}
knifes2={}
beam_anim={"laser1/laserh0","laser1/laserh1","laser1/laserh2","laser1/laserh4","laser1/laserh5","laser1/laserh6"}
flytime=0
jumptime=0
spawn=false
Player.SetControlOverride(true)
nohittingtimer=0
HeartChange({0,0,1})
function Update()
spawntime=spawntime+1
HurtUpd(98999)
if Input.Right>0 and Input.Left==0 then
   speedx=2
   elseif Input.Right==0 and Input.Left>0 then
   speedx=-2
   else speedx=0
end

if spawntime==82 and phase==2 then
	HeartChange({1,0,1})
	gravity="None"
	elseif spawntime==220 and phase==2 then
	EndWave()
	elseif spawntime>71 and spawntime<82 and spawntime%3==0 and phase==2 then
	local i=(spawntime-69)/3
	local knife=CreateProjectile("KnifeLeft",150,-85+20*i)
	local knife1=CreateProjectile("KnifeRight",-150,-85+20*i)
	knife.SetVar("speedy",0)
	knife.SetVar("speedx",-6)
	knife.SetVar("color","white")
	knife1.SetVar("speedy",0)
	knife1.SetVar("speedx",6)
	knife1.SetVar("color","white")
	table.insert(left,knife1)
	table.insert(right,knife)
end
for i=1,#right do
	local k=right[i]
	k.SetVar("speedy",k.GetVar("speedy")+1)
	if k.GetVar("speedy")<31 then
		k.sprite.alpha=math.sin(k.GetVar("speedy")*math.pi/60)
	end
	if k.GetVar("speedy")>81 then
		k.sprite.alpha=math.sin((k.GetVar("speedy")-51)*math.pi/60)
	end
	k.MoveTo(150-118*math.sin(k.GetVar("speedy")*math.pi/90),k.y)
end
for i=1,#left do
	local k=left[i]
	k.SetVar("speedy",k.GetVar("speedy")+1)
	if k.GetVar("speedy")<31 then
		k.sprite.alpha=math.sin(k.GetVar("speedy")*math.pi/60)
	end
	if k.GetVar("speedy")>81 then
		k.sprite.alpha=math.sin((k.GetVar("speedy")-51)*math.pi/60)
	end
	k.MoveTo(-150+118*math.sin(k.GetVar("speedy")*math.pi/90),k.y)
end
if phase==1 then
	if spawntime%90==67 and spawntime<550 then
		Blue()
	end
	if spawntime%5==0 and spawntime%90>45 and spawntime<560 then
		Little(1,1/2)
	end
	if spawntime==630 then
		Little(1.5,1.5)
		Little(-1.5,-1.5)
		phase=2
		spawntime=0
	end
end
if phase==2 and spawntime<51 and spawntime>29 and spawntime%4==0 then
	Create(134-3*(spawntime-30))
end
if gravity=="Down" then
	BlueMode()
	else
	Moving()
end

for i=1,#easybul do
	local b=easybul[i]
	if b.isactive then
		b.Move(b.GetVar("speedx"),b.GetVar("speedy"))
		if b.x>330 or b.x<-330 then
			b.Remove()
		end
	end
end

end
function OnHit(attacks)
   if attacks.GetVar("color")=="bone" or (attacks.GetVar("color")=="blue" and movi==true) then
	LongHurt(15,90)
      elseif attacks.GetVar("color")=="white" then
	KnifeHurt(1)
   end
end


function Create(size)
	local big=size-34
	local top=CreateProjectile("Bone/top",150,Arena.height/2-6)
	local top1=CreateProjectile("Bone/top",-150,Arena.height/2-6)
	local else0=CreateProjectile("Bone/bon",150,Arena.height/2-12-big/2)
	local else1=CreateProjectile("Bone/bon",-150,Arena.height/2-12-big/2)
	local bot=CreateProjectile("Bone/bot",150,Arena.height/2-18-big)
	local bot1=CreateProjectile("Bone/bot",-150,Arena.height/2-18-big)
	top.sprite.Scale(0.5,1)
	top1.sprite.Scale(0.5,1)
	else0.sprite.Scale(0.5,big)
	else1.sprite.Scale(0.5,big)
	bot.sprite.Scale(0.5,1)
	bot1.sprite.Scale(0.5,1)
	top.SetVar("speedy",0)
	top.SetVar("speedx",-5)
	top.SetVar("color","bone")
	else0.SetVar("speedy",0)
	else0.SetVar("speedx",-5)
	else0.SetVar("color","bone")
	bot.SetVar("speedy",0)
	bot.SetVar("speedx",-5)
	bot.SetVar("color","bone")
	top1.SetVar("speedy",0)
	top1.SetVar("speedx",5)
	top1.SetVar("color","bone")
	else1.SetVar("speedy",0)
	else1.SetVar("speedx",5)
	else1.SetVar("color","bone")
	bot1.SetVar("speedy",0)
	bot1.SetVar("speedx",5)
	bot1.SetVar("color","bone")
	table.insert(easybul,top)
	table.insert(easybul,top1)
	table.insert(easybul,else0)
	table.insert(easybul,else1)
	table.insert(easybul,bot)
	table.insert(easybul,bot1)
end
function Little(s,sp)
	local big=96
	local top1=CreateProjectile("Bone/top",150*s,-Arena.height/2+24)
	local else1=CreateProjectile("Bone/bon",150*s,-Arena.height/2+15)
	local bot1=CreateProjectile("Bone/bot",150*s,-Arena.height/2+6)
	top1.sprite.Scale(0.5,1)
	else1.sprite.Scale(0.5,6)
	bot1.sprite.Scale(0.5,1)
	top1.SetVar("speedy",0)
	top1.SetVar("speedx",-4*sp)
	top1.SetVar("color","bone")
	else1.SetVar("speedy",0)
	else1.SetVar("speedx",-4*sp)
	else1.SetVar("color","bone")
	bot1.SetVar("speedy",0)
	bot1.SetVar("speedx",-4*sp)
	bot1.SetVar("color","bone")
	table.insert(easybul,top1)
	table.insert(easybul,else1)
	table.insert(easybul,bot1)
end
	
function Blue()
	local big=96
	local top=CreateProjectile("Bone/top",-150,Arena.height/2-6)
	local top1=CreateProjectile("Bone/top",-150,-Arena.height/2+24)
	local else0=CreateProjectile("Bone/bon",-150,Arena.height/2-12-big/2)
	local else1=CreateProjectile("Bone/bon",-150,-Arena.height/2+15)
	local bot=CreateProjectile("Bone/bot",-150,Arena.height/2-18-big)
	local bot1=CreateProjectile("Bone/bot",-150,-Arena.height/2+6)
	top1.sprite.color={0/255, 168/255, 242/255}
	else1.sprite.color={0/255, 168/255, 242/255}
	bot1.sprite.color={0/255, 168/255, 242/255}
	top.sprite.Scale(0.5,1)
	top1.sprite.Scale(0.5,1)
	else0.sprite.Scale(0.5,big)
	else1.sprite.Scale(0.5,6)
	bot.sprite.Scale(0.5,1)
	bot1.sprite.Scale(0.5,1)
	local sp=5
	top.SetVar("speedy",0)
	top.SetVar("speedx",sp)
	top.SetVar("color","bone")
	else0.SetVar("speedy",0)
	else0.SetVar("speedx",sp)
	else0.SetVar("color","bone")
	bot.SetVar("speedy",0)
	bot.SetVar("speedx",sp)
	bot.SetVar("color","bone")
	top1.SetVar("speedy",0)
	top1.SetVar("speedx",sp)
	top1.SetVar("color","blue")
	else1.SetVar("speedy",0)
	else1.SetVar("speedx",sp)
	else1.SetVar("color","blue")
	bot1.SetVar("speedy",0)
	bot1.SetVar("speedx",sp)
	bot1.SetVar("color","blue")
	table.insert(easybul,top)
	table.insert(easybul,top1)
	table.insert(easybul,else0)
	table.insert(easybul,else1)
	table.insert(easybul,bot)
	table.insert(easybul,bot1)
end

function BlueMode()
	movi=false
	local sx=Player.x
	local sy=Player.y
   Player.sprite.rotation=0
   Player.MoveTo(Player.x+speedx,Player.y-flyspeed+jumpspeed,false)
   if Player.y==-(Arena.height/2-8) then 
      flytime=0
   end
   if Player.y>-(Arena.height/2-8) and jumptime==0 then
      if flytime<5 then
         flytime=flytime+0.12
      end
   end
   if flytime>0 then
      flyspeed=5*math.sin(flytime*math.pi/10)*math.sin(flytime*math.pi/10)*math.sin(flytime*math.pi/10)
      else flyspeed=0   
   end
   if Player.y==-(Arena.height/2-8) and  Input.Up>0 then
      jumptime=3
   end
   if jumptime>0 and Player.y>-(Arena.height/2-8) then
      if Input.Up==0 then
         jumptime=0
         else jumptime=jumptime-0.12
      end
      if jumptime<0 then
         jumptime=0
      end
   end
   if jumptime>0 then
      jumpspeed = 5*jumptime/3
      else jumpspeed=0
   end
	if sx==Player.x and sy==Player.y then
		else
		movi=true
	end
end