Player.sprite.color={0,0,1}
spawntime=0
Player.MoveTo(0,108,false)
Arena.ResizeImmediate(300,50)
gravity="Down"
bones1={}
bones2={}
n=0
paps = CreateSprite("Sans_Sprite")
paps.SendToBottom()
paps.x = 380
paps.y = 367
paps.Scale(2, 2)
paps.alpha = 0.0
flytime=0
jumptime=0
spawn=false
blackx=0
bl=CreateProjectile("bHole1",190,0)
Player.SetControlOverride(true)
nohittingtimer=0
function Update()
if nohittingtimer>0 then
	nohittingtimer=nohittingtimer-1
end
paps.alpha = 0.5*math.sin(spawntime*math.pi/580)
if spawntime<300 or spawntime==300  then
   paps.x = 235+90*math.sin(spawntime*math.pi/580)
   elseif spawntime==380 then
   paps.SendToTop()
   else paps.x = 415-90*math.sin(spawntime*math.pi/580)
end
if spawntime==600 then
   EndWave()
end 
if spawntime==60 then
   blackx=1,5
   Audio.PlaySound("sfx_BlasterEntry")
end
if spawntime%75==0 then   
   local bon1=CreateProjectile("Bonevsmall",138.5-n,0)
   bon1.SetVar("color","bone")
   n=n+23
end
if Input.Right>0 and Input.Left==0 then
   speedx=2
   elseif Input.Right==0 and Input.Left>0 then
   speedx=-2
   else speedx=0
end
spawntime=spawntime+1
if spawntime%60 == 0 then
   local bone1 = CreateProjectile("KnifeDown",-150,32)
   bone1.SetVar("color","white")
   local bone2 = CreateProjectile("KnifeUp",150,-32)
   bone2.SetVar("color","white")
   table.insert(bones1,bone1)
   table.insert(bones2,bone2)
end
if gravity == "Down" then
   Player.sprite.rotation=0
   Player.MoveTo(Player.x+speedx+blackx,Player.y-flytime+jumptime,false)
   if Player.y==-17 then 
      flytime=0
   end
   if Player.y>-17 and jumptime==0 then
      if flytime<5 then
         flytime=flytime+0.12
      end
   end
   if Player.y==-17 and  Input.Up>0 then
      jumptime=4
   end
   if jumptime>0 and Player.y>-17 then
      if Input.Up==0 then
         jumptime=0
         else jumptime=jumptime-0.12
      end
      if jumptime<0 then
         jumptime=0
      end
   end
end
if Input.Confirm==0 and not spawn and (( gravity=="Down" and Player.y==-17 ) or(gravity=="Up" and Player.y==17 )) then
   spawn=true
   Audio.PlaySound("slam")
end
if Input.Confirm>0 and spawn then
   if gravity=="Up" then
      gravity="Down"
      else gravity="Up"
   end
   flytime=10
   spawn=false
end
if gravity == "Up" then
   Player.sprite.rotation=180
   Player.MoveTo(Player.x+speedx+blackx,Player.y+flytime-jumptime,false)
   if Player.y==17 then 
      flytime=0
   end
   if Player.y<17 and jumptime==0 then
      if flytime<5 then
         flytime=flytime+0.12
      end
   end
   if Player.y==17 and  Input.Down>0 then
      jumptime=4
   end
   if jumptime>0 and Player.y<17 then
      if Input.Down==0 then
         jumptime=0
         else jumptime=jumptime-0.12
      end
      if jumptime<0 then
         jumptime=0
      end
   end
end
for i=1,#bones1 do
   local bone = bones1[i]
   if bone.isactive then
      bone.MoveTo(bone.x+2.5,bone.y)
   end
   if bone.x==150 then
      bone.Remove()
   end
end
for i=1,#bones2 do
   local bone = bones2[i]
   if bone.isactive then
      bone.MoveTo(bone.x-2.5,bone.y)
   end
   if bone.x==-150 then
      bone.Remove()
   end
end
end
function OnHit(attacks)
   if attacks.GetVar("color")=="bone" then
	if Player.hp>15 then
        	Player.Hurt(15)
		nohittingtimer=89
		elseif nohittingtimer==0  then
		  SetGlobal("Playerisdead",true)
		EndWave()
		paps.alpha = 0.0
		SetGlobal("nocomment",true)
	end
      elseif attacks.GetVar("color")=="white" then
	if Player.hp>1 then
        	Player.Hurt(1,0.001)
		else  SetGlobal("Playerisdead",true)
		EndWave()
		paps.alpha = 0.0
		SetGlobal("nocomment",true)
	end
   end
end