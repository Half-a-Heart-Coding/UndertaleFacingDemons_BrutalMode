Arena.Resize(120,120)
kniferight={}
knifeup={}
bonewall={}
away1={}
away2={}
away3={}
ghost={}
speedup1={}
speedup2={}
speedup3={}
speed1=10
speed2=20
spawntime=1
bonetime=0
amount=2
bones={}
up={}
right={}

require "Libraries/Playermove"
require "Libraries/hurt"
DoGhost("Paps_Sprite",1,600)

function Update()
HurtUpd(600)
Moving()
spawntime=spawntime+1
bonetime=bonetime+1
if spawntime%60==20 then
  local bone = CreateProjectile("Bonev",-200,0)
  h=math.random(2)
  if h==1 then
    bone.sprite.color={0/255, 168/255, 242/255}
    bone.SetVar("color","blue")
    else bone.sprite.color={255/255, 154/255, 34/255}
    bone.SetVar("color","orange")
  end
  table.insert(bonewall,bone)
end
for i=1,#bonewall do
  local bone = bonewall[i]
  if bone.x>60 then
    away3[i]=true
    bone.Remove()
    elseif bone.x>-60 then
    speedup3[i]=speed2
    else speedup3[i]=speed2/5
  end
  if not away3[i] then
    bone.MoveTo(bone.x+speedup3[i],bone.y)
  end
end
if spawntime%60==0 then
  if amount<12 then
    amount=amount+1
  end
  for i=1,((amount/4)-(amount/4%1)+(amount/2%2)) do
    up[i]= math.random(6)
    for g=1,20 do
      for n=1,(i-1) do
        if up[i]==up[n] then
          up[i]= math.random(6)
        end
      end
    end 
    local knife1 = CreateProjectile("KnifeLeft",300,-70+20*up[i])
    knife1.SetVar("color","white")
    knife1.sprite.alpha=0
	knife1.SetVar("time",0)
    table.insert(kniferight,knife1)
  end
  for i=1,((amount/4)-(amount/4%1)) do
    right[i]= math.random(6)
    for g=1,20 do
      for n=1,(i-1) do
        if right[i]==right[n] then
          right[i]= math.random(6)
        end
      end
    end 
    local knife = CreateProjectile("KnifeDown",-70+20*right[i],300) 
    knife.SetVar("color","white")
    knife.sprite.alpha=0
	knife.SetVar("time",0)
    table.insert(knifeup,knife)
  end
end
for i=1,#kniferight do
  local knife = kniferight[i]
	if knife.isactive then
	local t=knife.GetVar("time")+1
	knife.SetVar("time",t)
	if t<31 then
		knife.sprite.alpha=math.sin(t*math.pi/60)
	end
  if knife.x<-92 then
	if knife.x>-182 then
		local l=-92-knife.x
		knife.sprite.alpha=1-math.sin(l*math.pi/180)
		else
	 	   away1[i]=true
	  	  knife.Remove()
	end
    elseif knife.x<92 then 
    speedup1[i]=speed1
    else speedup1[i]=speed1/5
  end
	if knife.isactive then
	    knife.MoveTo(knife.x-speedup1[i],knife.y)
	end
	end
end
for i=1,#knifeup do
  local knife = knifeup[i]
	if knife.isactive then
	local t=knife.GetVar("time")+1
	knife.SetVar("time",t)
	if t<31 then
		knife.sprite.alpha=math.sin(t*math.pi/60)
	end
  if knife.y<-92 then
	if knife.y>-182 then
		local l=-92-knife.y
		knife.sprite.alpha=1-math.sin(l*math.pi/180)
		else
	 	   away1[i]=true
	  	  knife.Remove()
	end
    elseif knife.y<92 then 
    speedup2[i]=speed1
    else speedup2[i]=speed1/5
  end
	if knife.isactive then
    knife.MoveTo(knife.x,knife.y-speedup2[i])
  end
  end
end
end
function OnHit(bullet)
  if bullet.GetVar("color") == "orange" and isMoving()==false then
	LongHurt(10,90)
    elseif bullet.GetVar("color") == "blue" and isMoving()==true then
	LongHurt(10,90)
    elseif bullet.GetVar("color") == "white" then
	KnifeHurt(1)
  end
end