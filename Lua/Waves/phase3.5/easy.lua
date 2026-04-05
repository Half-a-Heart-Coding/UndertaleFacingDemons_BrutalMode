Arena.ResizeImmediate(120,16)
spawntime = 0
moving={}
bullets={}
require "Libraries/Playermove"
require "Libraries/hurt"
Player.SetControlOverride(true)
alltimer=0
death=false
beam={}
await={}
t=-1
deadtime=0
norm=6
r=0
spr={"laser0/laserh0"}
vzmah_anim = {"chara/att1", "chara/att2", "chara/att3", "chara/att4", "chara/att5","chara/att6"}
attacks={}
timer = 0
speed1=8
speed2=10
speed3=5
Phase1=true
Phase2=false
Phase3=false
beg=200
slay={}
h=0
i=0
g=1
n=0
Player.hp = 135

function knife(x,y,color,spr,mov,rotation)
	local knife=CreateProjectile(spr,x,y)
	if spr=="speardown" or spr=="spear" then
		if color == "orange" then
			knife.sprite.color={1, 0.5, 0}
		else
			knife.sprite.color={0/255, 168/255, 242/255}
		end
	else
		knife.sprite.color={1,1,1}
	end
	knife.SetVar("color",color)
	table.insert(bullets,knife)
	if not rotation then
		knife.sprite.rotation=0
		else knife.sprite.rotation=rotation
	end
	knife.SetVar("mov",mov)
end


function Update()
for g=1,#bullets do
	local delx=16
	local dely=38
      local bullet = bullets[g]
	local mov=bullet.GetVar("mov")
		if mov==1 then
		      bullet.Move(0,-speed1)
			elseif mov==2 then
 			  bullet.Move(speed2,0)
			elseif mov==3 then
			   bullet.Move(speed3,0)
		end
	if (Player.x+delx)>bullet.x and (Player.x-delx)<bullet.x and (Player.y+dely)>bullet.y and (Player.y-dely)<bullet.y and death==false then
		if bullet.GetVar("color")=="white" then
			KnifeHurt(2)
			elseif bullet.GetVar("color")=="blue" and isMoving() then
			KnifeHurt(1)
			elseif bullet.GetVar("color")=="orange" and not isMoving() then
			KnifeHurt(1)
		end
	end
end
HurtUpd(20000)
Moving()
alltimer=alltimer+1
  if (spawntime % 75 == 60 or spawntime % 75 == 65) and Phase1  then 
	if spawntime % 75 == 60 then
		knife(40*t,beg,"blue","speardown",1)
		else
		i=i+1
		knife(50*t,beg,"blue","speardown",1)
		t=-t   
	end
  end
  if (spawntime%75)<57 and spawntime%5==0 and Phase1 then
	knife((20*(40-spawntime%75))*-t/90*8,beg,"white","KnifeDownDeadly",1)
end
if death==false then
  spawntime=spawntime+1
  else spawntime=5
end
if i==norm   then
  timer=timer+1
  Phase1=false
end
if n==28 or n>28   then
  timer=timer+1
  Phase3=false 
end
if timer==35 and not Phase3 and n==0 and not Phase4 then
  Phase2=true
end
if Phase2 and not Phase3 then 
  Arena.Resize(200,72)
  spawntime=70
  i=0
  timer=0
  n=0
  Phase3=true
  Phase2=false
end
if Phase3 and n<5 then
if (spawntime%80>77 or spawntime%80<3) then
	knife(-300,32,"blue","speardown",2)
	knife(-300,-32,"blue","spear",2)
     r=math.random(2)*2-3
	elseif spawntime%80==3 then
	n=n+1
     elseif spawntime%80<29 and spawntime%80>21  then
	knife(-300,-36*r,"white","KnifeUpDeadly",2,(r-1)*90)
     elseif spawntime%80<59 and spawntime%80>51 then
	knife(-300,36*r,"white","KnifeDownDeadly",2,(r-1)*90)
end
if (spawntime%80>40 and spawntime%80<45) then
	knife(-300,32,"orange","speardown",2)
	knife(-300,-32,"orange","spear",2)
end
end
if n==5 and Phase3 and spawntime%80==43 then
  Phase4=true
  spawntime=90
  Phase3=false
  timer=0
  n=0
  Arena.Resize(200,80)
end
if Phase4 and death==false then
  if spawntime%120==95 then
    r=math.random(2)*2-3
    elseif spawntime%120>97 and spawntime%120<103 then
	knife(-320,-36*r,"white","KnifeUpDeadly",3,(r-1)*90)
    elseif spawntime%120==20 then
    local hit = CreateProjectile ("att0",0,10*r)
    angle=90
    hit.SetVar("angle")
    hit.sprite.rotation=angle
    hit.SetVar("color","none")
    Audio.PlaySound("slice2")
    table.insert(slay,hit)
    elseif spawntime%120==40 then
    local hit = CreateProjectile ("att0",0,30*r)
    angle=-90
    hit.SetVar("angle")
    hit.sprite.rotation=angle
    hit.SetVar("color","none")
    Audio.PlaySound("slice2")
    table.insert(slay,hit)
    elseif spawntime%120 == 35 then
    local knife = CreateProjectile ("laser0/laserh0",0,10*r)
    Audio.PlaySound("bolt")
    table.insert(beam,knife)
    elseif spawntime%120 == 55 then
    local knife = CreateProjectile ("laser0/laserh0",0,30*r)
    Audio.PlaySound("bolt")
    table.insert(beam,knife)
    elseif spawntime%120==80 then
	n=n+1
	if n==4 then
		EndWave()
	end
  end
end
if Encounter.GetVar("diff")==24 then
	EndWave()
end
for i=1,#beam do
  local hit = beam[i]
  local await=hit.GetVar("time")
  if not await then
    hit.SetVar("time",1)
    await=0
	hit.SetVar("color","death")
   end
  await=await+1
  hit.SetVar("time",await)
   if await==10 then
	hit.SetVar("color","none")
   end
	if await>5 then
		hit.sprite.alpha=1-math.sin(await*math.pi/40)
	end
	if await==20 then
		hit.Remove()
  end
end    
for b=1,#slay do
  local hit = slay[b]
  if not await[b] then
    await[b]=0
    elseif await[b]<6 then
    await[b]=await[b]+1
    hit.sprite.Set(vzmah_anim[await[b]])
    elseif await[b]==6 then 
    hit.Remove()
  end
end
if death then
  deadtime=deadtime+1
  if  deadtime==1 then
	Audio.PlaySound("hurtsound")
  end
  Player.SetControlOverride(true)
  deadscreen = CreateProjectile("999999", 0, 105)
  if deadtime==60 then
	SetGlobal("Playerisdead",true)
	EndWave()
	SetGlobal("nocomment",true)
  end
end
end
function OnHit(bullet)
if not death then
   local color = bullet.GetVar("color")
     if color == "death" then
	if GetGlobal("KnifeProtection") == true then
		if Player.hp > 25 and Encounter.GetVar("diff") == 17 then
			LongHurt(25,60)
		elseif Player.hp > 33 then
			LongHurt(33,60)
		else
			death = true
		end
	else
		death = true
	end
 	Encounter.Call("SetMusic","none")
     end
end
end