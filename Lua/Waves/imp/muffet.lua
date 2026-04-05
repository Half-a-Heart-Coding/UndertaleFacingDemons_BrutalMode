Arena.ResizeImmediate(600,100)
spawntime=0
amount={}
work={}
if GetGlobal("evasion")==2 then
	spaway=-95
	else spaway=0
end
require "Libraries/hurt"
collision = require "Libraries/rotational_collision"
DoGhost("Muffet_Sprite",1,600)
Player.SetControlOverride(true)
Player.MoveTo(-290,0,true)
Player.sprite.color={213/256,53/256,217/256}
spawn=false
speed_x=3
speed_all=3
if Encounter.GetVar("movefast")==true then
	speed_all=4.5
end
name2=""
if GetGlobal("DifficultyPoints") >= 621 then
	name2="Fatal"
end
name3="Deadly"
if GetGlobal("DifficultyPoints") >= 621 then
	name3="Fatal"
end
name4="Lethal"
if GetGlobal("DifficultyPoints") >= 621 then
	name4="Fatal"
end
endtimer=20
spawntime=0
height=0
trapdir={}
traptype={}
traping={}
traps={}
timer={}
knifes={}
ready={}
bombs={}
rand={}
dir={}
ready={}
spiders={}
speedy=0
knifes2={}
flee=false
line1 = CreateProjectile("web",0,25)
line2 = CreateProjectile("web",0,0)
line3 = CreateProjectile("web",0,-25)
line1.SetVar("color","line")
line2.SetVar("color","line")
line3.SetVar("color","line")
function Update()
HurtUpd(780)
N=math.random(200)+8
if spawntime<250 and spawntime%25<3 then
   local spider = CreateProjectile("spider",290,-25+spawntime%25*25)
   spider.SetVar("color","spider")
   table.insert(spiders,spider)
end
spawntime=spawntime+1
for i=1,#spiders do
   amount[i]=2
   if not rand[i] then
      rand[i]=0
   end
   if not timer[i]then
      timer[i]=0
   end
   if not ready[i] and work[i] then
      timer[i]=timer[i]+1
   end
   if timer[i]==25 and traping[i]==false then
      timer[i]=0
      work[i]=false
   end
   if timer[i]==50 then
      traping[i]=false
      work[i]=false
      timer[i]=0
   end
   local spider = spiders[i]
   if not work[i] and not ready[i]  then
      rand[i]=math.random(N)
   end
   if rand[i]==N then
      ready[i]=true
      rand[i]=0
      traptype[i]=math.random(5)
   end
   if ready[i]  then
      for n=1,#bombs do
         local bom=bombs[n]
         if spider.x==bom.x then
            if spider.y == bom.y then
               amount[i]=0 
               else amount[i]=amount[i]-1
            end
         end
      end
      for n=1,#traps do
         local trap=traps[n]
         if spider.x==trap.x then
            amount[i]=0
         end
      end
      if amount[i]>0 and spider.x<261 and spider.x%40 == 0 and traptype[i]<5 then
         local bomb = CreateProjectile("bomb",spider.x,spider.y)
         ready[i]=false
         table.insert(bombs,bomb)
         bomb.SetVar("color","spider")
         work[i] = true
      end
      if amount[i]==2 and spider.x<261 and spider.x%40 == 0 and traptype[i]==5 then
         work[i]=true
         local mark=CreateProjectile("empty",spider.x,spider.y)
         table.insert(traps,mark)
         ready[i]=false
         traping[i]=true
         trapdir[i]=math.random(2)*2-3
	 if spider.y>10 then
            trapdir[i]=-1
            elseif spider.y<-10 then
	    trapdir[i]=1
         end
      end
   end
   if work[i] then
      traptype[i]=false
   end
   if not dir[i] then
      dir[i]=-1
      elseif spider.x==-150 then
      dir[i]=1
      elseif spider.x==290 then
      dir[i]=-1
   end
   if not flee and not work[i]  then
      spider.MoveTo(spider.x+5*dir[i],spider.y)
      elseif not work[i] and spider.isactive then
      spider.MoveTo(spider.x+5,spider.y)
   end
   if spider.x== 330 then
      spider.Remove()
   end
   if traping[i]==true then
      spider.sprite.rotation=90
      spider.Move (0,0.5*trapdir[i])
      if timer[i]==25 then
         local trap=CreateProjectile("trap",spider.x,spider.y)
         trap.SetVar("color","trap")
      end
      else spider.sprite.rotation=0
   end
end
   
if spawntime<250 then
   Player.MoveTo(-290,height*25,false)
   else flee=true
end
if  Input.Up==0 and Input.Down==0 then
   spawn=true
end
if Input.Up>0 and spawn and height<1 then
   height=height+1
   spawn=false
end
if Input.Down>0 and spawn and height>-1 then
   height=height-1
   spawn=false
end
if height*25>Player.y then
   speedy=6.25
   elseif height*25<Player.y then
   speedy=-6.25
   else speedy=0
end
if  Input.Left==0 and Input.Right>0 then
   if Input.Cancel>0 then
      speedx=speed_all*math.sin(speed_x*math.pi/8)*0.5
   else
      speedx=speed_all*math.sin(speed_x*math.pi/8)
   end
   elseif Input.Left>0 and Input.Right==0 then
   if Input.Cancel>0 then
      speedx=-speed_all*math.sin(speed_x*math.pi/8)*0.5
   else
      speedx=-speed_all*math.sin(speed_x*math.pi/8)
   end
   else speedx=0
end
if spawntime>250 and (spawntime-250)%11==0 and spawntime<559 then
   local knife= CreateProjectile("KnifeDown"..name3,-310+20*((spawntime-250)/11),82)
   knife.SetVar("color","white")
   knife.SetVar("extraTime", (spawntime-250)/11)
   table.insert(knifes,knife)
end
if spawntime==300 then
    for i=1,30 do
   local knife= CreateProjectile("KnifeUpFake",-310+20*(i),-82)
   knife.SetVar("color","warn")
   knife.SetVar("extraTime", i*5)
   table.insert(knifes2,knife)
   end
end
Player.MoveTo(Player.x+speedx,Player.y+speedy,false)
for i=1,#knifes do
   local knife = knifes[i]
   if spawntime>500+knife.GetVar("extraTime")*2 and knife.y>0 then
      knife.MoveTo(knife.x,knife.y-10.25)
   end
   if knife.y>0 or spawntime<600 then
	else ending=true
   end
end
for i=1,#knifes2 do
   local knife = knifes2[i]
   if spawntime>300+knife.GetVar("extraTime") and knife.y<0 then
      knife.MoveTo(knife.x,knife.y+10.25)
   end
end
if ending==true then
	endtimer=endtimer+1
	if endtimer==40 then
		EndWave()
	end
end
end
function OnHit(attacks)
if attacks.GetVar("color")=="spider" then
   KnifeHurt(5,true)
   attacks.Remove()
   if speed_x>0.5 then
      speed_x=speed_x-0.5
   end
   elseif attacks.GetVar("color")=="white" then
   KnifeHurt(2)
   elseif attacks.GetVar("color")=="purple" then
   SetGlobal("purpleSpeed",1)
   SetGlobal("purpleSpeedTimer",30)
   if speed_x>0.9 then
      speed_x=0.9
      --else speed_x=0
   end
   --attacks.Remove()
   elseif attacks.GetVar("color")=="line" then
   elseif attacks.GetVar("color")=="trap" then
   KnifeHurt(10,true)
   if speed_x>0.75 then
      speed_x=speed_x-0.75
      else speed_x=0
   end
   attacks.Remove()
end
end