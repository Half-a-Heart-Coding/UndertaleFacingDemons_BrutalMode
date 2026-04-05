
require "Libraries/Playermove"
require "Libraries/hurt"
Arena.ResizeImmediate(200,160)
Player.MoveTo(0,0,false)
spawntime=0
lining=false
lines={}
holes={}
sided=1
spears={}
bullets={}
bombs={}
traps={}
--overPlayer=CreateProjectile("purpleyellow",-400,0)
--overPlayer.SetVar("type","cover")
speedx=2
--gun=0
if Encounter.GetVar("speedfast") then
	speedx=3
end
--local ghosts=Encounter.GetVar("ghostsappeared")
if not ghosts then
	ghosts={}
end
if Encounter.GetVar("diff")~= 30 and Encounter.GetVar("diff")~= 28 and Encounter.GetVar("diff")~= 27 then
	Encounter.SetVar("SavedProg",65)
end
--local Alph=ghosts[1]
--local Muff=ghosts[2]
--local Undy=ghosts[3]
donuts={}
local range=210
oldrot=false
spid=CreateProjectile("spiderdonut0",0,-130,"BelowBullet")
spid.sprite.alpha=0
spid.SetVar("time",0)
function Update()

spawntime=spawntime+1
if spawntime==1 then
	spider={}
	for i=1,6 do
		spider[i]=CreateProjectile("spider",88-176*(i%2),-85+25*i)
		spider[i].SetVar("time",0)
		spider[i].SetVar("side",-spider[i].x/88)
		spider[i].SetVar("px",0)
		spider[i].SetVar("type","spider")
		lines[i]=CreateProjectile("purplepoint",100-200*(i%2),-85+25*i)
		lines[i].sprite.Scale(0,0)
		lines[i].SetVar("type","line")
	end
	elseif spawntime<102 then
	for i=1,6 do
		spider[i].Move(2*spider[i].GetVar("side"),0)
		local wall=-spider[i].GetVar("side")*100
		local spiderbutt=spider[i].x-12*spider[i].GetVar("side")
		lines[i].MoveTo((wall+spiderbutt)/2,spider[i].y)
		lines[i].sprite.Scale((spawntime-1)*2,2)
	end
	elseif spawntime<151 then
	for i=1,6 do
		spider[i].Move(5*spider[i].GetVar("side"),0)
		if spawntime==150 then
			spider[i].Remove()
		end
	end
	elseif spawntime==151 then
	spider={}
	lining=true
	--Player.sprite.rotation=180--purpleyellow
	Player.sprite.color={1,0,1}
	--HeartChange({1,1,0})
	if Player.y<-5 then
		line=1
		elseif Player.y>25 then
		line=4
		elseif Player.y>12.5 then
		line=3
		else
		line=2
	end
end

if spawntime>150 and (spawntime-150)%120==0 then
	local x=-51+math.random(101)
	local side=math.random(2)*2-3
	local d=CreateProjectile("donut",x,-130)
	--d.sprite.color={1,1,0}
	local ugol=44+math.random(91)
	local xs=4*math.cos(ugol*math.pi/180)
	local ys=4*math.sin(ugol*math.pi/180)
	d.SetVar("speed",{xs,ys})
	d.SetVar("type","donut")
	d.SetVar("time",0)
	table.insert(donuts,d)
end

if spawntime>150 and (spawntime-150)%40==0 then
	local liner=math.random(#lines)
	local spid=CreateProjectile("spider",330*sided,((liner-2)*25)-37.5)
	sided=-sided
	table.insert(spider,spid)
	spid.SetVar("type","spider")
	spid.SetVar("px",6*sided)
end
if spawntime>150 and (spawntime-150)%145==90 then
	local random=math.random(200-23)-101
	local spear=CreateProjectile("green/arrow",random,300)
	spear.SetVar("level",0)
	spear.SetVar("type","spear")
	table.insert(spears,spear)
end
HurtUpd(1800)

if lining==true then
	OnLines()
	else
	Moving()
end

for i=1,#bullets do
	local b=bullets[i]
	if b.isactive then
		b.Move(0,6)
		for t=1,#bombs do
			local o=bombs[t]
			if b.x+15>o.x and b.x-15<o.x and b.y+18>o.y and b.y-18<o.y and o.isactive then
				if o.GetVar("time")==0 then
					o.SetVar("time",1)
					b.Remove()
				end
			end
		end
		if b.y>500 then
			b.Remove()
		end
	end
end
for i=1,#spider do
	local s=spider[i]
	if s.isactive then
		s.Move(s.GetVar("px"),0)
		if #holes>0 then
			local count=0
			for t=1,#holes do
				if holes[t].isactive then
					if s.y==holes[t].y then
						if holes[t].x+19>s.x and holes[t].x-19<s.x then
							holes[t].Remove()
						end
					end
					else
					count=count+1
				end
			end
			if count==#holes then
				holes={}
			end
		end		
		if s.x>400 or s.x<-400 then
			s.Remove()
		end
	end
end

for i=1,#donuts do
	local d=donuts[i]
	if d.isactive then
		local s=d.GetVar("speed")
		d.SetVar("time",d.GetVar("time")+1)
		d.Move(s[1],s[2])
		local w=d.sprite.width/2
		local h=d.sprite.height/2
		if (d.x+w>100 and s[1]>0) or (d.x-w<-100 and s[1]<0) then
			s[1]=-s[1]
		end
		if (d.y+h>75 and s[2]>0) or (d.y-h<-75 and s[2]<0) then
			s[2]=-s[2]
		end
		if d.GetVar("time")>180 then
			local d2=CreateProjectile("trap",d.x,-85+25*math.floor((d.y)%6),"AboveBullet")
			d2.sprite.Scale(1,0.25)
			d2.SetVar("type","trap")
			d2.SetVar("time",0)
			table.insert(traps,d2)
			d.Remove()
		end
	end
end

for i=1,#spears do
	local s=spears[i]
	if s.isactive then
		s.Move(0,-10)
		local l=s.GetVar("level")
		if l==0 and s.y<57+37.5 then
			s.SetVar("level",1)
			DoHole(s.x,6)
			elseif s.y<32+37.5 and l==1 then
			s.SetVar("level",2)
			DoHole(s.x,5)
			elseif s.y<7+37.5 and l==2 then
			s.SetVar("level",3)
			DoHole(s.x,4)
			elseif s.y<-18+37.5 and l==3 then
			s.SetVar("level",4)
			DoHole(s.x,3)
			elseif s.y<-18+12.5 and l==4 then
			s.SetVar("level",5)
			DoHole(s.x,2)
			elseif s.y<-18-12.5 and l==5 then
			s.SetVar("level",6)
			DoHole(s.x,1)
		end
		if s.y<-400 then
			s.Remove()
		end
	end
end

end

function EraseLine(ingo)
	lines[ingo].Remove()
	local lin=lines
	lines={}
	for i=1,#lin-1 do
		table.insert(lines,lin[i])
	end
	if line==ingo then
		KnifeHurt(30)
		line=line-1
		CheckPosition({Player.x,Player.y-25},{Player.x-15,Player.y-25})
	end
	for i=1,#spider do
		if spider[i].isactive and spider[i].y==(ingo-2)*25 then
			spider[i].Remove()
		end
	end
end
function OnLines()
	local oldline=line
	if Input.Up==1 and line<6 then
		if Input.Confirm>0 and line<5 then
			line=line+2
		else
			line=line+1
		end
		elseif Input.Down==1 and line>1 then
		if Input.Confirm>0 and line>2 then
			line=line-2
		else
			line=line-1
		end
	end
	CheckPosition({Player.x,((line-2)*25)-37.5},{Player.x,Player.y})
	local px=0
	if Input.Right>0 and Input.Left==0 then
		px=speedx
		if Input.Cancel>0 then
			px=px*2
		end
		CheckPosition({Player.x+px,Player.y},{Player.x,Player.y})
		elseif Input.Left>0 and Input.Right==0 then
		px=-speedx
		if Input.Cancel>0 then
			px=px*2
		end
		CheckPosition({Player.x+px,Player.y},{Player.x,Player.y})
	end
end

function DoHole(px,lin)
	if lin<#lines+1 then
		local Hole=CreateProjectile("purplepoint",px,((lin-2)*25)-37.5)
		Hole.sprite.color={0,0,0}
		Hole.sprite.Scale(14,10)
		if Player.x+15>Hole.x and Player.x-15<Hole.x and Player.y==Hole.y then
			KnifeHurt(15)
			if Player.x<Hole.x then
				CheckPosition({Hole.x-15,Player.y}, {Hole.x+15,Player.y})
				else
				CheckPosition({Hole.x+15,Player.y}, {Hole.x-15,Player.y})
			end
		end
		table.insert(holes,Hole)
	end
end
function CheckPosition(new, old)
	local can=true
	for i=1,#holes do
		if holes[i].isactive then
			if holes[i].y==new[2] then
				if new[1]+15>holes[i].x and new[1]-15<holes[i].x then
					can=false
				end
			end
		end
	end
	if (new[2]/25)+2>#lines then
		can=false
	end
	if can==true then
		Player.MoveTo(new[1],new[2],false)
	end
	--overPlayer.MoveTo(Player.x,Player.y)
end
function OnHit(ingo)
local t=ingo.GetVar("type")
if t=="spider" then
	LongHurt(5,10)
	elseif t=="spear" then
	LongHurt(10,10)
	elseif t=="donut" then
	LongHurt(12,30)
	elseif t=="trap" then
	LongHurt(15,45)
	ingo.Remove()
	elseif t=="bomb" and ingo.sprite.alpha>0.5 then
	LongHurt(20,30)
end
end