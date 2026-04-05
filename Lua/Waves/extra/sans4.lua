movi=false
flytime=0
jumptime=0
flyspeed=0
jumpspeed=0
spawntime=0
flyers={}
down={}
blasters={}
bones={}
Player.SetControlOverride(true)
if Encounter.GetVar("speedfast")==true then
	speedx=3
	else
	speedx=2
end
require "Libraries/hurt"
HeartChange({0,0,1})
Arena.ResizeImmediate(180,56)
bonecover=CreateProjectile("arenacover",0,68)
function CreateBlaster()
	local blaster=CreateProjectile("empty",300,0)
	blaster.SetVar("speed",3)
	if math.random(2)==1 then
		blaster.sprite.Set("bone_cyan")
		blaster.SetVar("color","blue")
		else
		blaster.sprite.Set("bone_orange")
		blaster.SetVar("color","orange")
	end
	table.insert(blasters,blaster)
end
		
function DoUpperKnife()
	local rand1=math.random(2)-1
	local rand2=math.random(2)*2-3
	local knife=CreateProjectile("KnifeLeft",rand2*300,-2+rand1*20,"Top")
	knife.SetVar("side",-rand2)
	knife.sprite.rotation=90-90*rand2
	table.insert(flyers,knife)
end
function DoBones(ingo)
	local bone=CreateProjectile("arenabone",ingo,56,"BelowBullet")
	bone.SetVar("time",0)
	table.insert(bones,bone)
	bone=CreateProjectile("arenabone",-ingo,56,"BelowBullet")
	bone.SetVar("time",0)
	table.insert(bones,bone)
	--bonecover.sprite.SendToTop()
end
function DownKnife(ingo1, ingo2,ingo3)
	local knife=CreateProjectile("KnifeUp",ingo1*300,-48)
	knife.SetVar("time",0)
	local rand=math.random(Arena.width-20+1)-Arena.width/2-1+10
	if not ingo2 then
		else
		rand=ingo2
	end
	if not ingo3 then
		knife.SetVar("special",false)
		else
		knife.SetVar("special",true)
	end
	knife.SetVar("point",rand)
	knife.SetVar("side",-ingo1)
	table.insert(down,knife)
end


function Update()
BlueMode()
HurtUpd(1100)
spawntime=spawntime+1
if spawntime%50==1 and spawntime<540 then
	DoUpperKnife()
end
if spawntime%250==1  and spawntime<500 then
	DownKnife(1)
	elseif spawntime%250==126 and spawntime<500 then
	DownKnife(-1)
end
if spawntime>499 and spawntime<651 and spawntime%50==0 then
	DownKnife(-1,80-20*(spawntime-500)/50,true)
	DownKnife(1,-80+20*(spawntime-500)/50,true)
end
if spawntime>859 and spawntime<1011 and (spawntime-860)%30==0 then
	None((spawntime-860)/30*20)
end
	
if spawntime%90==0 then
	--CreateBlaster()
end

for i=1,#down do
	local k=down[i]
	if k.isactive then
		local time=k.GetVar("time")+1
		local x=k.x
		local y=k.y
		local px=Player.x
		local py=Player.y
		if px+16>x and px-16<x and py+38>y and py-38<y then
			KnifeHurt(1)
		end
		if time==1 or time==101 then
			k.Move(2*k.GetVar("side"),0)
			local p=k.GetVar("point")
			if k.x+4>p and k.x-4<p and time==1 then
				k.SetVar("time",1)
				k.MoveTo(p,-48)
			end
			if k.x>400 and k.x<400 then
				k.Remove()
			end
			elseif time==200 then
			k.Move(0,-4)
			elseif time>0 then
			k.SetVar("time",time)
			if time<30 then
				elseif time<51 then
				k.MoveTo(k.x,-48+52*math.sin((time-30)*math.pi/40))
				elseif time==51 and k.GetVar("special")==true then
				k.SetVar("time",-1)
				elseif time>80 and time<100 then
				k.MoveTo(k.x,4-52*math.sin((time-80)*math.pi/40))
				elseif time==100 then
				k.MoveTo(k.x,-48)
				if k.GetVar("special")==true then	
					k.SetVar("time",199)
				end
			end
		end
	end
end

for i=1,#flyers do
	local k=flyers[i]
	if k.isactive then
		k.Move(4*k.GetVar("side"),0)
		local x=k.x
		local y=k.y
		local px=Player.x
		local py=Player.y
		if py+16>y and py-16<y and px+38>x and px-38<x then
			KnifeHurt(1)
		end
		if k.x>400 or k.x<-400 then
			k.Remove()
		end
	end
end
for i=1,#blasters do
	local b=blasters[i]
	if b.isactive then
		b.Move(-b.GetVar("speed"),0)
		
		local x=b.x
		local y=b.y
		local px=Player.x
		local py=Player.y
		if px-6<x and px+69>x then
			local c=b.GetVar("color")
			b.SetVar("speed",5)
			if (c=="blue" and movi==true) or (c=="orange" and movi==false) then
				LongHurt(10,30)
			end
		end
		if b.x<-400 then
			b.Remove()
		end
	end
end

for i=1,#bones do
	local b=bones[i]
	local x=b.x
	local y=b.y
	local px=Player.x
	local py=Player.y
	if px-17<x and px+17>x and py-34<y and py+34>y then
		LongHurt(10,30)
	end
	if b.GetVar("time")<300 then
		local time=b.GetVar("time")+1
		b.SetVar("time",time)
		if time<60 then
			else
			b.Move(0,-(time-60)/10)
			if b.y<0 then
				b.MoveTo(b.x,0)
				b.SetVar("time",300)
			end
		end
	end
end
			
end



function None(x)
	if x<70 then
		DoBones(x)
	end
	for i=1,#down do
		if down[i].isactive then
			if down[i].x==x or down[i].x==-x then
				down[i].SetVar("time",199)
				down[i].sprite.SendToTop()
			end
		end
	end
end
function BlueMode()
	movi=false
	local sx=Player.x
	local sy=Player.y
   Player.sprite.rotation=0
	local spx=speedx
	if Input.Cancel>0 then
		spx=speedx/2
	end
	if Input.Right==0 and Input.Left>0 then
		spx=-spx
		elseif Input.Right>0 and Input.Left==0 then
		spx=spx
		else
		spx=0
	end
   Player.MoveTo(Player.x+spx,Player.y-flyspeed+jumpspeed,false)
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
	if sx==Player.x and Player.y==(-Arena.height/2+8) then
		else
		movi=true
	end
end


function OnHit()
end