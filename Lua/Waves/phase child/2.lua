Arena.ResizeImmediate(200,150)
shottime=20
spawntime=0
require "Libraries/Playermove"
require "Libraries/control"
bolt_anim={"bolt_left","bolt_right"}
spawn=false
rain={}
bolts={}
function Update()
TimeUpd(600)
Moving()
spawntime=spawntime+1
for i=1,#rain do
	local r=rain[i]
	if r.isactive then
		r.MoveTo(r.x,r.y-3)
		if r.y==Arena.height/2+r.sprite.height/2 then
			local bolt=CreateProjectile(bolt_anim[math.random(2)],r.x,r.y)
			bolt.MoveTo(bolt.x,-Arena.height/2+bolt.sprite.height/2)
			bolt.SetVar("time",0)
			bolt.sprite.color={1,1,0}
			r.Remove()
			table.insert(bolts,bolt)
		end
	end
end
for i=1,#bolts do
	local b=bolts[i]
	if b.isactive then
		local time=b.GetVar("time")+1
		b.SetVar("time",time)
		if time<15 then
			local sin=2*math.sin(time*math.pi/30)
			local DT=math.floor(1+5*(1-sin/2))
			b.sprite.Scale(1+sin,1)
			local w=b.sprite.width/2*(1+sin)
			b.sprite.alpha=1-sin/2
			if Player.x>b.x-w and Player.x<b.x+w then
				Flower(DT)
			end
			else
			b.Remove()
		end
	end
end

if spawntime==1 then
	local r=CreateProjectile("zap1",math.random(-70,70),Arena.height/2+14.5+3*50)
	r.sprite.color={1,1,0}
	table.insert(rain,r)
end
if spawntime%60==1 then
	local r=CreateProjectile("zap1",math.random(-70,70),Arena.height/2+14.5+3*110)
	r.sprite.color={1,1,0}
	table.insert(rain,r)
end

end
function OnHit(attacks)
end