
require "Libraries/Playermove"
require "Libraries/hurt"
Arena.ResizeImmediate(200,100)
Player.MoveTo(0,0,false)
spawntime=0
lining=false
lines={}
holes={}
sided=1
spears={}
bullets={}
bombs={}
overPlayer=CreateProjectile("purpleyellow",-400,0)
overPlayer.SetVar("type","cover")
speedx=2
gun=0
if Encounter.GetVar("speedfast") then
	speedx=3
end
local ghosts=Encounter.GetVar("ghostsappeared")
if not ghosts then
	ghosts={}
end
local Alph=ghosts[1]
local Muff=ghosts[2]
local Undy=ghosts[3]
function Update()

spawntime=spawntime+1
if spawntime==100 then
	if not Alph then
		else	
		Alph.SetVar("time",61)
	end
	elseif spawntime==450 then
	if not Muff then
		else
		Muff.SetVar("time",61)
	end
	elseif spawntime==800 then
	if not Undy then
		else
		Undy.SetVar("time",61)
	end
end
if spawntime==1 then
	spider={}
	for i=1,3 do
		spider[i]=CreateProjectile("spider",88-176*(i%2),-50+25*i)
		spider[i].SetVar("time",0)
		spider[i].SetVar("side",-spider[i].x/88)
		spider[i].SetVar("px",0)
		spider[i].SetVar("type","spider")
		lines[i]=CreateProjectile("purplepoint",100-200*(i%2),-50+25*i)
		lines[i].sprite.Scale(0,0)
		lines[i].SetVar("type","line")
	end
	elseif spawntime<102 then
	for i=1,3 do
		spider[i].Move(2*spider[i].GetVar("side"),0)
		local wall=-spider[i].GetVar("side")*100
		local spiderbutt=spider[i].x-12*spider[i].GetVar("side")
		lines[i].MoveTo((wall+spiderbutt)/2,spider[i].y)
		lines[i].sprite.Scale((spawntime-1)*2,2)
	end
	elseif spawntime<151 then
	for i=1,3 do
		spider[i].Move(5*spider[i].GetVar("side"),0)
		if spawntime==150 then
			spider[i].Remove()
		end
	end
	elseif spawntime==151 then
	spider={}
	lining=true
	Player.sprite.rotation=180--purpleyellow
	HeartChange({1,1,0},purpleyellow)
	if Player.y<-12.5 then
		line=1
		elseif Player.y>12.5 then
		line=3
		else
		line=2
	end
end

if spawntime>150 and (spawntime-150)%45==0 then
	local liner=math.random(#lines)
	local spid=CreateProjectile("spider",330*sided,(liner-2)*25)
	sided=-sided
	table.insert(spider,spid)
	spid.SetVar("type","spider")
	spid.SetVar("px",4*sided)
end
if spawntime>150 and (spawntime-150)%150==90 then
	local random=math.random(200-23)-101
	local spear=CreateProjectile("green/arrow",random,300)
	spear.SetVar("level",0)
	spear.SetVar("type","spear")
	table.insert(spears,spear)
end
if spawntime>150 and (spawntime-150)%210==0 and #lines>1 then
	local random=math.random(150-23)-76
	local bomb=CreateProjectile("bomb0",random,460)
	table.insert(bombs,bomb)
	bomb.SetVar("time",0)
end
HurtUpd(1200)
if gun>0 then
	gun=gun-1
end

for i=1,#bombs do
	local b=bombs[i]
	if b.isactive then
		local time=b.GetVar("time")
		if time==0 then
			b.Move(0,-2.5)
			if (b.y<41 and #lines==3) or (b.y<17 and #lines==2) then
				b.SetVar("time",1)
			end
			else
			b.SetVar("time",time+1)
			if time<20 then
				if time==1 then
					Audio.PlaySound("plusexplode")
				end
				if time%2==0 then
					b.sprite.Set("bomb"..(time/2)%2)
				end
				elseif time==20 then
				if b.y<41 and #lines==3 then
					EraseLine(3)
					elseif b.y<17 and #lines==2 then
					EraseLine(2)
				end
				local laser=CreateProjectile("mylaser/laserv2",b.x,b.y)
				b.sprite.Set("mylaser/laserh2")
				b.SetVar("laser",laser)
				b.SetVar("type","bomb")
				laser.SetVar("type","bomb")
				DoHole(b.x,3)
				DoHole(b.x,2)
				DoHole(b.x,1)
				elseif time<31 then
				b.sprite.alpha=1-math.sin((time-20)*math.pi/20)
				local l=b.GetVar("laser")
				l.sprite.alpha=b.sprite.alpha
				elseif time==31 then
				b.Remove()
				local l=b.GetVar("laser")
				l.Remove()
			end
		end
	end
end
if lining==true then
	OnLines()
	if Input.Confirm==1 and gun==0 then
		gun=30
		local bul=CreateProjectile("shot",Player.x,Player.y)
		table.insert(bullets,bul)
		Audio.PlaySound("pew")
	end
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


for i=1,#spears do
	local s=spears[i]
	if s.isactive then
		s.Move(0,-8)
		local l=s.GetVar("level")
		if l==0 and s.y<32 then
			s.SetVar("level",1)
			DoHole(s.x,3)
			elseif s.y<7 and l==1 then
			s.SetVar("level",2)
			DoHole(s.x,2)
			elseif s.y<-18 and l==2 then
			s.SetVar("level",3)
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
	if Input.Up==1 and line<3 then
		line=line+1
		elseif Input.Down==1 and line>1 then
		line=line-1
	end
	CheckPosition({Player.x,(line-2)*25},{Player.x,Player.y})
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
		local Hole=CreateProjectile("purplepoint",px,(lin-2)*25)
		Hole.sprite.color={0,0,0}
		Hole.sprite.Scale(14,2)
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
	overPlayer.MoveTo(Player.x,Player.y)
end
function OnHit(ingo)
local t=ingo.GetVar("type")
if t=="spider" then
	LongHurt(5,10)
	elseif t=="spear" then
	LongHurt(10,10)
	elseif t=="bomb" and ingo.sprite.alpha>0.5 then
	LongHurt(20,30)
end
end