Arena.ResizeImmediate(16,16)
spawntime=0
shottime=20
timer=0
brok={}
broken={}
boxs={}
turn={}
away={}
away=100
cover = CreateProjectile("green/cover1",0,0)
paps = CreateSprite("Undyne_Sprite")
paps.SendToBottom()
paps.x = 380
paps.y = 365
amount=2
paps.Scale(1.890625, 1.890625)
paps.alpha = 0.0
break_anim={"box/1","box/2","box/3","box/4","box/5"}
turned={}
spawn=false
shots={}
spears={}
angle1=180
Phase1=true
Phase2=false
Player.MoveTo(0,0,false)
Player.SetControlOverride(true)
Player.MoveTo(0,0,false)
green=CreateProjectile("green",0,away)
shield=CreateProjectile("green/shield",0,away)
shield.SetVar("angle",180)
function Update()
paps.alpha = 0.5*math.sin(spawntime*math.pi/580)
if spawntime<300 or spawntime==300  then
   paps.x = 330+90*math.sin(spawntime*math.pi/580)
   else paps.x = 510-90*math.sin(spawntime*math.pi/580)
end
spawntime=spawntime+1
if spawntime<9999 then
   Player.MoveTo(0,0,false)
   green.MoveTo(0,away)
   shield.MoveTo(0,away)
   if Input.Up>0 then
      green.sprite.rotation=0
      shield.sprite.rotation=0
      shield.SetVar("angle",180)
      angle1=180
      elseif Input.Right>0 then
      green.sprite.rotation=-90
      shield.sprite.rotation=-90
      shield.SetVar("angle",90)
      angle1=90
      elseif Input.Down>0 then
      green.sprite.rotation=180
      shield.sprite.rotation=180
      shield.SetVar("angle",360)
      angle1=0
      elseif Input.Left>0 then
      green.sprite.rotation=90
      shield.sprite.rotation=90
      shield.SetVar("angle",270)
      angle1=-90
   end
end
if Phase1 then
   if Input.Confirm >0 and spawn and shottime>20 then
      local shot=CreateProjectile("shot",green.x,green.y)
      shot.SetVar("angle",angle1)
      shot.sprite.rotation=angle1
      Audio.PlaySound("pew")
      table.insert(shots,shot)
      shottime=0
      spawn=false
   end
end
if Phase1 then
   if (spawntime%25==0 and amount%3>0 )   then
      rand=math.random(4)
      truth=math.random(3)
      amount=amount+1
      if rand%2==1 then
         local spear = CreateProjectile("green/arrow",400-400*(rand-1),away)
         spear.SetVar("dir",rand)
         spear.SetVar("color","undyne")
         if truth>1 then
            spear.sprite.color={1,1,0}
            spear.sprite.rotation=90*(rand)
            spear.SetVar("truth",1)
            else spear.sprite.rotation=90*(rand-2)
            spear.SetVar("truth",2)
         end
         table.insert(spears,spear)
         else local spear = CreateProjectile("green/arrow",0,400-400*(rand-2)+away)
         spear.SetVar("dir",rand)
         spear.SetVar("color","undyne")
         table.insert(spears,spear)
         if truth>1 then
            spear.sprite.color={1,1,0}
            spear.sprite.rotation=90*(rand)
            spear.SetVar("truth",1)
            else spear.sprite.rotation=90*(rand-2)
            spear.SetVar("truth",2)
         end
      end
      elseif spawntime%25==0 then
      amount=amount+1
   end
end
if timer>0 then
   if timer==5 then
      Audio.PlaySound("reflect")
   end
   timer=timer-1
   shield.sprite.set("green/shield_hit")
   else shield.sprite.set("green/shield")
end
for i=1,#spears do
   local spear=spears[i]
   if spear.x<8 and spear.x>-8 and  spear.y<8+away and spear.y>away-8 and spear.isactive then
      spear.Remove()
	if Player.hp>5 then
        	Player.Hurt(5,0.001)
		else  SetGlobal("Playerisdead",true)
		EndWave()
		paps.alpha = 0.0
		SetGlobal("nocomment",true)
	end
   end
   if spear.x==500 and spear.y==500 then
      spear.Remove()
   end
   local dir = spear.GetVar("dir")
   local truth = spear.GetVar("truth")
   if (shield.GetVar("angle"))%360==(dir*90-180*(truth-2))%360 and (spear.x>-50 and spear.x<50 and spear.y>50 and spear.y<150 ) and spear.isactive then
      timer=5
      spear.Remove()
   end
   if truth==2 and spear.isactive then
      if dir%2 == 1 then
         spear.MoveTo(spear.x+5*(dir-2),spear.y)
         else spear.MoveTo(spear.x,spear.y+5*(dir-3))
      end
   end
   if truth==1 and dir==1 then
      if spear.isactive then
         if spear.x>75 then
            spear.MoveTo(spear.x-9.285714,spear.y)
         end
         if (spear.x==75 or spear.x<75) and not turned[i] then
            if not turn[i] then
               turn[i]=0
               elseif turn[i]==30 then
               spear.MoveTo(-75,away)
               turned[i]=true
               else spear.MoveTo(75*math.cos(turn[i]*math.pi/30),75*math.sin(turn[i]*math.pi/30)+away)
               turn[i]=turn[i]+1
            end
         end
         if spear.x==-75 or spear.x>-75 and turned[i] then
            spear.MoveTo(spear.x+10,spear.y)
         end
      end
   end
   if truth==1 and dir==2 then
      if spear.isactive then
         if spear.y>175 then
            spear.MoveTo(spear.x,spear.y-9.285714)
         end
         if (spear.y==175 or spear.y<175) and not turned[i] then
            if not turn[i] then
               turn[i]=15
               elseif turn[i]==45 then
               spear.MoveTo(0,away-75)
               turned[i]=true
               else spear.MoveTo(75*math.cos(turn[i]*math.pi/30),75*math.sin(turn[i]*math.pi/30)+away)
               turn[i]=turn[i]+1
            end
         end
         if spear.y==25 or spear.y>25 and turned[i] then
            spear.MoveTo(spear.x,spear.y+5)
         end
      end
   end
   if truth==1 and dir==3 then
      if spear.isactive then
         if spear.x<-75 then
            spear.MoveTo(spear.x+9.285714,spear.y)
         end
         if (spear.x==-75 or spear.x>-75) and not turned[i] then
            if not turn[i] then
               turn[i]=30
               elseif turn[i]==60 then
               spear.MoveTo(75,away)
               turned[i]=true
               else spear.MoveTo(75*math.cos(turn[i]*math.pi/30),75*math.sin(turn[i]*math.pi/30)+away)
               turn[i]=turn[i]+1
            end
         end
         if spear.x==75 or spear.x<75 and turned[i] then
            spear.MoveTo(spear.x-5,spear.y)
         end
      end
   end
   if truth==1 and dir==4 then
      if spear.isactive then
         if spear.y<25 then
            spear.MoveTo(spear.x,spear.y+9.285714)
         end
         if (spear.y==25 or spear.y>25) and not turned[i] then
            if not turn[i] then
               turn[i]=45
               elseif turn[i]==75 then
               spear.MoveTo(0,75+away)
               turned[i]=true
               else spear.MoveTo(75*math.cos(turn[i]*math.pi/30),75*math.sin(turn[i]*math.pi/30)+away)
               turn[i]=turn[i]+1
            end
         end
         if spear.y==175 or spear.y<175 and turned[i] then
            spear.MoveTo(spear.x,spear.y-5)
         end
      end
   end
end
if Input.Confirm==0 then 
   spawn=true
end
shottime=shottime+1
for i=1,#shots do
   local shot = shots[i]
   local angle = shot.GetVar("angle")
   if shot.isactive then
      shot.MoveTo(shot.x-10*math.sin(angle*math.pi/180),shot.y+10*math.cos(angle*math.pi/180))
   end
end
if Phase1 then
   if spawntime%75==38 then
      ran=math.random(4)
      if ran%2==1 then
         local box = CreateProjectile("box/box",400-400*(ran-1),away)
         box.SetVar("dir",ran)
         box.SetVar("color","undyne")
         table.insert(boxs,box)
         else local box = CreateProjectile("box/box",0,400-400*(ran-2)+away)
         box.SetVar("dir",ran)
         box.SetVar("color","undyne")
         table.insert(boxs,box)
      end
   end
end
for i=1,#boxs do
   local box = boxs[i]
   if box.x<8 and box.x>-8 and  box.y<8+away and box.y>away-8 and box.isactive then
      box.Remove()
	if Player.hp>5 then
        	Player.Hurt(5,0.001)
		else  SetGlobal("Playerisdead",true)
		EndWave()
		paps.alpha = 0.0
		SetGlobal("nocomment",true)
	end
   end
   for n=1,#shots do
      local shot = shots[n]
      if (shot.x-10<box.x and shot.x+10>box.x) and (shot.y-10<box.y and shot.y+10>box.y) and box.isactive and shot.isactive then
         Audio.PlaySound("hit")
         broken[i]=true
         shot.Remove()
         broken[i]=true
      end
   end
   if broken[i] then
      if not brok[i] then
         brok[i]=2
         elseif brok[i]<10 then
         brok[i]=brok[i]+1
         elseif brok[i]==10 then
         box.Remove()
      end
      box.sprite.alpha=box.sprite.alpha-0.1
      if brok[i]%2==0 then
         box.sprite.Set(break_anim[brok[i]/2])
      end
   end
   local box = boxs[i]
   local dir = box.GetVar("dir")
   if box.isactive and not broken[i] then
      if dir%2 == 1 then
         box.MoveTo(box.x+4*(dir-2),box.y)
         else box.MoveTo(box.x,box.y+4*(dir-3))
      end
   end
end
end
function OnHit(attack)
end