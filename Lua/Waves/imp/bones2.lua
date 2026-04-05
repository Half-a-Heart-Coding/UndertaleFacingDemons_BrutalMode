Arena.Resize(300,80)
collision = require "Libraries/rotational_collision"
require "Libraries/colortoys"
require "Libraries/Playermove"
require "Libraries/hurt"
require "Monsters/chara"
knifetime=700
rain={}
timing=0
deadtime=0
slay={}
breek=1
away1={}
away2={}
timer={}
beam={}
await1={}
await2={}
angle1=0
speed1=4
speed2=4
bone_right={}
bone_left={}
sign={}
name2=""
if GetGlobal("DifficultyPoints") >= 621 then
	name2="Fatal"
end
block={}
bone_anim = {"bonebreak/bonehsmall", "bonebreak/break1", "bonebreak/break2" , "bonebreak/break3"}
vzmah_anim = {"chara/att1", "chara/att2", "chara/att3", "chara/att4", "chara/att5","chara/att6"}
warning_green= Gradient.new({{0,1,0},{1,1,1},{0,1,0}})
warning_red= Gradient.new({{1,0,0},{1,1,1},{1,0,0}})
warn={}
spawntime=0
nohittingtimer=0
knifes={}

await={}
shadows={}
knifeup={}
timer2={}
numup=1
for i=1, 60 do
	local shad = CreateProjectile("ShadowDown"..name2,300,300)
	shad.SetVar("color","none")
	await[i]=true
	shad.sprite.alpha=0
	table.insert(shadows,shad)
	shad.sprite.alpha=0
end
for i=1,10 do
	local knife=CreateProjectile("KnifeDownDeadly"..name2,340,300)
	knife.SetVar("color","gold")
	knife.SetVar("right",0)
	knife.SetVar("height",0)
	table.insert(knifeup,knife)
	timer2[i]=true
	knife.sprite.SendToTop()
end
num=1
require "Libraries/Playermove"
require "Libraries/hurt"
collision = require "Libraries/rotational_collision"
shad_anim={{1, 0, 0}, {0.5, 0, 0},{0,0,0},{0.5,0,0}}--красный,черный,красный
knivetime=0
walltime=6
angle2=45
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
knifes2=true

DoGhost("Paps_Sprite",1,600)

function DoRow(side)
	local rand=math.random(5)-3
	for i=-2,2 do
		local x=25*i
		local y=160
		local knife
		if side==1 then
			knife=CreateProjectile("KnifeDown"..name2,x,y)
			knife.SetVar("speed",{0,-1})
			elseif side==2 then
			knife=CreateProjectile("KnifeRight"..name2,-y,x)
			knife.SetVar("speed",{1,0})
			elseif side==3 then
			knife=CreateProjectile("KnifeUp"..name2,x,-y)
			knife.SetVar("speed",{0,1})
			elseif side==4 then
			knife=CreateProjectile("KnifeLeft"..name2,y,x)
			knife.SetVar("speed",{-1,0})
		end
		if rand==i then
            if math.random(2) == 1 then
			    knife.SetVar("color","blue")
            else
                knife.SetVar("color","orange")
            end
		else
			knife.SetVar("color", "white")
		end
        knife.SetVar("time",0)
		knife.SetVar("stime",0)
		knife.SetVar("firing",false)
		knife.sprite.alpha=0
		table.insert(knifes,knife)
	end
end

function Update()
HurtUpd(1000)
Moving()
if nohittingtimer>0 then
	nohittingtimer=nohittingtimer-1
end
if spawntime==1 then  
  rand=math.random(10)
end
spawntime=spawntime+1
if spawntime > 1000 then
    knivetime=knivetime+1
    --spawntime=spawntime+1
    walltime=walltime+1
    if knivetime%60 ==0 then
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
	    timer2[numup]=0
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
      if timer2[q] == nil or timer2[q] == true or timer2[q] == false then
 	    elseif timer2[q]<45 or timer2[q]==45 then
 	    timer2[q]=timer2[q]+1
	    if timer2[q]<31 then
		    bullet.sprite.alpha=math.sin(timer2[q]*math.pi/60)
	    end
 	    bullet.SetVar("angle2", timer2[q])
    	    bullet.sprite.rotation = timer2[q]*right
    	    bullet.MoveTo(Player.x-135*right+timer2[q]*right,Player.y+90+45*heigh-heigh*timer2[q])
  	    elseif timer2[q]>45 then
    	    timer2[q]=timer2[q]+1
    	    bullet.MoveTo(bullet.x-1*right+(right*(timer2[q]-45)/5),bullet.y+1-(timer2[q]-45)/5)
    	    if timer2[q]%7==0 then
      		    local shadow = shadows[num]
      		    shadow.sprite.rotation=bullet.GetVar("angle2")*right
		    shadow.MoveTo(bullet.x,bullet.y)
      		    shadow.SetVar("color","gold")
      		    await[num]=0
		    if num==60 then
			    num=1
			    else
			    num=num+1
		    end
	    end
      end
	    --if (Player.x+34>bullet.x and Player.x-34<bullet.x) and (Player.y+34>bullet.y and Player.y-34<bullet.y) then
	    --	if collision.CheckCollision(Player, bullet) then
	    --		KnifeHurt(1)
	    --	end
	    --end
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
if spawntime%28==0 and spawntime<(knifetime-52) then
  i=math.random(5)
  local bone = CreateProjectile("bone",320,-44+i*16)
  bone.SetVar("color","bone")
  table.insert(bone_right,bone)
end
if spawntime%28==5 and spawntime<(knifetime-52) then
  i=math.random(5)
  local bone = CreateProjectile("bone",-320,-44+i*16)
  bone.SetVar("color","bone")
  table.insert(bone_left,bone)
end
for i=1,#bone_right do
  angle1=8
  local bone = bone_right[i]
  bone.SetVar("angle",angle1)
  bone.sprite.rotation=  bone.sprite.rotation+angle1
  bone.MoveTo(bone.x-speed1,bone.y)
end
for i=1,#bone_left do
  angle1=-8
  local bone = bone_left[i]
  bone.SetVar("angle",angle1)
  bone.sprite.rotation=  bone.sprite.rotation+angle1
  bone.MoveTo(bone.x+3,bone.y)
end
if spawntime>knifetime-207 and spawntime<knifetime-158 and spawntime%100<13 then
    local i = spawntime%100
  local warner = CreateProjectile ("bolt_warning_big",-150+25*i,-15)
  if i-1==rand or i==rand or i+1==rand then
    if i==rand then
      warner.SetVar("safe","safe")
      else  warner.SetVar("safe","almost")
    end
  end
  table.insert (sign , warner)
end
if (spawntime-knifetime)%80<17 and spawntime<knifetime+79 and spawntime>knifetime-1 then
    local knife = CreateProjectile("KnifeDownDeadly"..name2,-155+20*((spawntime-knifetime)%80),168-4*((spawntime-knifetime)%80))
    knife.SetVar("color","gold")
    table.insert(rain,knife)
end
if spawntime==knifetime-5 then
  local bone = CreateProjectile("Bonehsmall",-150+25*rand,50)
  bone.SetVar("color","none")
  table.insert(block,bone)
end  
for i=1,#rain do
  local knife = rain[i]
  if not away2[i] then
    knife.MoveTo(knife.x,knife.y-speed2)
  end
  if (knife.x+30>block[1].x and knife.x-30<block[1].x) and (knife.y+43.5>block[1].y and knife.y-43.5<block[1].y)  then
    away2[i]=true
    knife.Remove()
    if not audio then
      Audio.PlaySound("reflect")
      audio=true
    end
  end
end
if spawntime==205 then
   Suprise1()
end
if spawntime==260 then
   head4()
end
if spawntime==310 then
   head()
   --Encounter.SetVar("nextwaves", {"kniferain"})
end
for i=1,#sign do
  local warn= sign[i]
  if timer[i] == nil then
    timer[i] = 0
    elseif timer[i]<100 then
    warn.sprite.color=warning_red:getColorAt(spawntime/10%3+1)
    timer[i]=timer[i]+1  
    if warn.GetVar("safe")=="safe" and timer[i]%5==0 then  
      Audio.PlaySound("blip")
    end
    elseif timer[i]<200 then
    if warn.GetVar("safe")=="almost" then
      warn.Remove()
      elseif warn.GetVar("safe")=="safe" then
      if timer[i]%20==0 then
        Audio.PlaySound("ding")
      end
      warn.sprite.color=warning_green:getColorAt(spawntime/10%3+1)
      else warn.sprite.color=warning_red:getColorAt(spawntime/10%3+1)
    end
    timer[i]=timer[i]+1
    else warn.Remove()
  end
end
if spawntime==knifetime+40 then
  local hit = CreateProjectile("chara/att0",-150+25*rand+12.5,50)
  table.insert(slay,hit)
  Audio.PlaySound("slice2")
end
if spawntime==knifetime+64 then
  local slice = CreateProjectile("laser0/laserv1me",-150+25*rand+12.5,50)
  Audio.PlaySound("bolt")
  table.insert(beam,slice)
  slice.SetVar("color","dead")
  breek=breek+1
end
if spawntime==knifetime+64 then
  local hit = CreateProjectile("chara/att0",-150+25*rand-12.5,50)
  table.insert(slay,hit)
  angle=180
  hit.SetVar("angle",angle)
  hit.sprite.rotation=angle
  Audio.PlaySound("slice2")
end
if spawntime==knifetime+88 then
  local slice = CreateProjectile("laser0/laserv1me",-150+25*rand-12.5,50)
  Audio.PlaySound("bolt")
  table.insert(beam,slice)
  slice.SetVar("color","dead")
  breek=breek+1
end
if death then
  deadtime=deadtime+1
  speed=1000
  speed2=1000
  speed3=1000
  Encounter.Call("SetMusic","none")
  Player.SetControlOverride(true)
  deadscreen = CreateProjectile("999999", 0, 105)
  if deadtime==60 then
	SetGlobal("Playerisdead",true)
	EndWave()
	SetGlobal("nocomment",true)
  end
end
for i=1,#slay do
  local hit = slay[i]
  if not await2[i] then
    await2[i]=0
    elseif await2[i]<21 then
    if await2[i]%4==0 then
      hit.sprite.Set(vzmah_anim[await2[i]/4+1])
    end
    await2[i]=await2[i]+1
    elseif await2[i]==21 then 
    hit.Remove()
  end
end
if spawntime == knifetime +150 then
  breek=breek+1
end
for i=1,#block do
  local bone = block[i]
  if not breek then
    breek=1
    elseif breek<4 then
    bone.sprite.Set(bone_anim[breek])
    elseif breek==4 then
    bone.sprite.Set(bone_anim[breek])
    if timing==0 then
      Audio.PlaySound("bonebreaker")
      timing=timing+1
      elseif timing<60 then
      timing=timing+1
      elseif timing==60 then
      Audio.PlaySound("bonedust")
      timing=timing+1
      elseif timing<100 then
      timing=timing+1
      bone.sprite.alpha=bone.sprite.alpha-0.025
      elseif timing==100 then
      bone.Remove()
    end
  end
end
for i=1,#beam do
  local slice = beam[i]
  if not await1[i] then
    await1[i]=0
    slice.sprite.alpha=1
    elseif await1[i]<7 then
    await1[i]=await1[i]+1
    slice.sprite.alpha = slice.sprite.alpha-0.1
    elseif await1[i]<10 then
    slice.SetVar("color","none")
    await1[i]=await1[i]+1
    slice.sprite.alpha = slice.sprite.alpha-0.1
  end
end  
end
function OnHit(attack)
if attack.GetVar ("color")=="dead" then
    if GetGlobal("KnifeProtection") == true then
	    if Player.hp > 25 and Encounter.GetVar("diff") == 17 then
		    LongHurt(25,60)
	    elseif Player.hp > 33 then
		    LongHurt(33,60)
	    else
		    death = true
            Player.Hurt(0,10)
	    end
    else
	    death = true
        Player.Hurt(0,10)
    end
  elseif attack.GetVar ("color")=="bone" and collision.CheckCollision(attack,Player) and attack.sprite.alpha then
	LongHurt(5,30)
  elseif attack.GetVar ("color")=="white" then
	KnifeHurt(1)
  elseif attack.GetVar ("color")=="gold" then
	KnifeHurt(2)
  elseif attack.GetVar ("color") == "blue" and isMoving()==true then
	KnifeHurt(1)
  elseif attack.GetVar ("color") == "orange" and not isMoving()==true then
	KnifeHurt(1)
end
end
