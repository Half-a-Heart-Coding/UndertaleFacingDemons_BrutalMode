Arena.Resize(300,80)
collision = require "Libraries/rotational_collision"
require "Libraries/colortoys"
require "Libraries/Playermove"
require "Libraries/hurt"
require "Monsters/chara"
knifetime=300
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
sign={}
block={}
bone_anim = {"bonebreak/bonehsmall", "bonebreak/break1", "bonebreak/break2" , "bonebreak/break3"}
vzmah_anim = {"chara/att1", "chara/att2", "chara/att3", "chara/att4", "chara/att5","chara/att6"}
warning_green= Gradient.new({{0,1,0},{1,1,1},{0,1,0}})
warning_red= Gradient.new({{1,0,0},{1,1,1},{1,0,0}})
warn={}
spawntime=0
nohittingtimer=0

DoGhost("Paps_Sprite",1,600)

function Update()
HurtUpd(600)
Moving()
if nohittingtimer>0 then
	nohittingtimer=nohittingtimer-1
end
if spawntime==1 then  
  rand=math.random(10)
end
spawntime=spawntime+1
if spawntime%15==0 and spawntime<(knifetime-52) then
  i=math.random(10)
  local bone = CreateProjectile("bone",320,-44+i*8)
  bone.SetVar("color","bone")
  table.insert(bone_right,bone)
end
for i=1,#bone_right do
  angle1=8
  local bone = bone_right[i]
  bone.SetVar("angle",angle1)
  bone.sprite.rotation=  bone.sprite.rotation+angle1
  bone.MoveTo(bone.x-speed1,bone.y)
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
    local knife = CreateProjectile("KnifeDown",-155+20*((spawntime-300)%80),168-4*((spawntime-300)%80))
    knife.SetVar("color","white")
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
   Encounter.SetVar("nextwaves", {"kniferain"})
end
for i=1,#sign do
  local warn= sign[i]
  if not timer[i] then
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
	LongHurt(10,90)
  elseif attack.GetVar ("color")=="white" then
	KnifeHurt(1)
end
end
