require "Libraries/colortoys"
warning_red = Gradient.new({{0.5, 0, 0}, {1, 1, 1},{1,0,0}})--красный,белый,красный
warning_blue = Gradient.new({{0, 0, 0.5}, {1, 1, 1}, {0, 0, 0.5}})--синий,белый,синий
warning_orange = Gradient.new({{0.5, 0.25, 0}, {1, 1, 0}, {0.5, 0.25, 0}})--синий,белый,синий
Arena.Resize(150,300)
require "Libraries/Playermove"
require "Libraries/hurt"
limit1=90
limit2=180
limit3=180
limit4=210
rain={}
speed={}
speedup=0
knifeleft={}
kniferight={}
warn_red={}
warn_blue={}
bluetimer={}
warn_orange={}
orangetimer={}
redtimer={}
spawntime1=1
spawntime2=1
spawntime3=1
spawntime4=1
spawntime5=1
insanityLevel=1
insanityLevel2=1
name=""
if GetGlobal("DifficultyPoints") >= 621 then
	name="Fatal"
end
function Update()
HurtUpd(900)
Moving()
spawntime1=spawntime1+1
spawntime2=spawntime2+1
spawntime3=spawntime3+1
spawntime4=spawntime4+1
if spawntime5 >= 600 then
    insanityLevel = insanityLevel + 1
    insanityLevel2 = 400 - insanityLevel
    if insanityLevel > 400 or spawntime5%insanityLevel2 == 0 then
        spawntime1=spawntime1+1
        spawntime2=spawntime2+1
        spawntime3=spawntime3+1
        spawntime4=spawntime4+1
    end
end
if spawntime1%limit1==0  then
  spawntime1=0
  if limit1>30 then
    limit1=limit1-5
  end
  speedup=math.random(3)+3
  local knife1 = CreateProjectile("KnifeLeft"..name,250,Player.y)
  local knife2 = CreateProjectile("KnifeRight"..name,-250,Player.y)
	knife1.sprite.alpha=0
	knife1.SetVar("time",0)
	knife2.sprite.alpha=0
	knife2.SetVar("time",0)
  knife1.SetVar("speed",-speedup)
  knife2.SetVar("speed",speedup)
  knife1.SetVar("color","white")
  knife2.SetVar("color","white")
  table.insert(knifeleft,knife2)
  table.insert(kniferight,knife1)
end
for i=1,#knifeleft do
  local knife = knifeleft[i]
  speed[i]=knife.GetVar("speed")
  knife.MoveTo (knife.x+speed[i],knife.y)
	local t=knife.GetVar("time")+1
	knife.SetVar("time",t)
	if t<31 then
		knife.sprite.alpha=math.sin(t*math.pi/60)
	end
end
for i=1,#kniferight do
  local knife = kniferight[i]
  speed[i]=knife.GetVar("speed")
  knife.MoveTo (knife.x+speed[i],knife.y)
	local t=knife.GetVar("time")+1
	knife.SetVar("time",t)
	if t<31 then
		knife.sprite.alpha=math.sin(t*math.pi/60)
	end
end
if spawntime2%limit2==(limit2/2-limit2%2*0.5) then
  spawntime2=0
  if limit2 > 80 then
    limit2=limit2-5
  end
  r=math.random(5)
  local warn = CreateProjectile ("bolt_warning_big",-75+r*25,-125)
  table.insert(warn_blue,warn)
end
if spawntime3%limit3==0 then
  spawntime3=0
  if limit3>60 then
    limit3=limit3-6
  end
  r=math.random(5)
  local warn = CreateProjectile ("bolt_warning_big",-75+r*25,-125)
  table.insert(warn_red,warn)
end
if spawntime4%(limit4)==0 then
  spawntime4=0
  if limit4>120 then
    limit4=limit4-7
  end
  r=math.random(5)
  local warn = CreateProjectile ("bolt_warning_big",-75+r*25,-125)
  table.insert(warn_orange,warn)
end
for i=1,#warn_red do
  local warn = warn_red[i]
  if not redtimer[i] then
    redtimer[i]=0
    elseif redtimer[i]<45 then
    warn.sprite.color=warning_red:getColorAt((redtimer[i])/5%3+1)
    redtimer[i]=redtimer[i]+1
    if redtimer[i]%10==1 then
      Audio.PlaySound("menuconfirm")
    end
    elseif redtimer[i]==45 then
    for n=0,2 do
      local knife = CreateProjectile("KnifeDown"..name,warn.x-15+15*n,300)
      table.insert(rain,knife)
      knife.SetVar("color","white")
    end 
    for n=0,2 do
      local knife = CreateProjectile("KnifeDown"..name,warn.x-15+15*n,270)
      table.insert(rain,knife)
      knife.SetVar("color","white")
    end 
    for n=0,2 do
      local knife = CreateProjectile("KnifeDown"..name,warn.x-15+15*n,330)
      table.insert(rain,knife)
      knife.SetVar("color","white")
    end 
    for n=0,2 do
      local knife = CreateProjectile("KnifeDown"..name,warn.x-15+15*n,360)
      table.insert(rain,knife)
      knife.SetVar("color","white")
    end 
    redtimer[i]=redtimer[i]+1
    else
    warn.Remove()
  end
end
for i=1,#warn_blue do
  local warn = warn_blue[i]
  if not bluetimer[i] then
    bluetimer[i]=0
    elseif bluetimer[i]<40 then
    warn.sprite.color=warning_blue:getColorAt((bluetimer[i])/5%3+1)
    bluetimer[i]=bluetimer[i]+1
    elseif bluetimer[i]==40 then
    for n=0,2 do
      local knife = CreateProjectile("speardown"..name,warn.x-15+15*n,270)
	knife.sprite.color={0/255, 168/255, 242/255}
      table.insert(rain,knife)
      knife.SetVar("color","blue")
    end 
    for n=0,2 do
      local knife = CreateProjectile("speardown"..name,warn.x-15+15*n,300)
	knife.sprite.color={0/255, 168/255, 242/255}
      table.insert(rain,knife)
      knife.SetVar("color","blue")
    end 
    for n=0,2 do
      local knife = CreateProjectile("speardown"..name,warn.x-15+15*n,210)
	knife.sprite.color={0/255, 168/255, 242/255}
      table.insert(rain,knife)
      knife.SetVar("color","blue")
    end 
    for n=0,2 do
      local knife = CreateProjectile("speardown"..name,warn.x-15+15*n,240)
	knife.sprite.color={0/255, 168/255, 242/255}
      table.insert(rain,knife)
      knife.SetVar("color","blue")
    end 
    bluetimer[i]=bluetimer[i]+1
    else
    warn.Remove()
  end
end

for i=1,#warn_orange do
  local warn = warn_orange[i]
  if not orangetimer[i] then
    orangetimer[i]=0
    elseif orangetimer[i]<35 then
    warn.sprite.color=warning_orange:getColorAt((orangetimer[i])/5%3+1)
    orangetimer[i]=orangetimer[i]+1
    elseif orangetimer[i]==35 then
    for n=0,2 do
      local knife = CreateProjectile("speardown"..name,warn.x-15+15*n,270)
	knife.sprite.color={1, 0.5, 0}
      table.insert(rain,knife)
      knife.SetVar("color","orange")
    end 
    for n=0,2 do
      local knife = CreateProjectile("speardown"..name,warn.x-15+15*n,300)
	knife.sprite.color={1, 0.5, 0}
      table.insert(rain,knife)
      knife.SetVar("color","orange")
    end 
    for n=0,2 do
      local knife = CreateProjectile("speardown"..name,warn.x-15+15*n,210)
	knife.sprite.color={1, 0.5, 0}
      table.insert(rain,knife)
      knife.SetVar("color","orange")
    end 
    for n=0,2 do
      local knife = CreateProjectile("speardown"..name,warn.x-15+15*n,240)
	knife.sprite.color={1, 0.5, 0}
      table.insert(rain,knife)
      knife.SetVar("color","orange")
    end 
    orangetimer[i]=orangetimer[i]+1
    else
    warn.Remove()
  end
end

for i=1,#rain do
  local knife = rain[i]
  if knife.GetVar("color")~="white" then
    knife.MoveTo(knife.x,knife.y-12)
    else knife.MoveTo(knife.x,knife.y-9)
  end
end
end
function OnHit(bullet)
local color = bullet.GetVar("color")
if color == "blue"  and isMoving()==true then
	KnifeHurt(1)
elseif color == "orange" and not isMoving()==true then
	KnifeHurt(1)
  elseif color == "white" then
	KnifeHurt(1)
end
end