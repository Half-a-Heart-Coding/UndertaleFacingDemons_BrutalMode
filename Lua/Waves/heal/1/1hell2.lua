Arena.Resize(200, 128)
spawntimer = 0
k1 = {}
k2 = {}

require "Libraries/Playermove"
require "Libraries/hurt"

if Encounter.GetVar("diff")==34 or Encounter.GetVar("diff")==35 or Encounter.GetVar("diff")==36 then
	Encounter.SetVar("SavedProg", Encounter.GetVar("SavedProg")+1)
end

function Update() 

HurtUpd(666)
Moving()

	spawntimer = spawntimer + 1
	
	if spawntimer % 44 == 0 and spawntimer < 160 then 
		kD = CreateProjectile ('KnifeDown', 200, 32)
		kU = CreateProjectile ('KnifeUp', -200, -32)
		kD.sprite.alpha=0
		kU.sprite.alpha=0
		kD.SetVar("time",0)
		kU.SetVar("time",0)
		kD.SetVar("fuckYou",0)
		kU.SetVar("fuckYou",0)
		kD.SetVar("fadetime",0)
		kU.SetVar("fadetime",0)
		table.insert (k1, kD)
		table.insert (k2, kU)
	end 
	if spawntimer % 44 == 22 and spawntimer > 140 then 
		kD = CreateProjectile ('KnifeDownDeadly', -200, 32)
		kU = CreateProjectile ('KnifeUpDeadly', 200, -32)
		kD.sprite.alpha=0
		kU.sprite.alpha=0
		kD.SetVar("time",0)
		kU.SetVar("time",0)
		kD.SetVar("fuckYou",1)
		kU.SetVar("fuckYou",1)
		kD.SetVar("fadetime",0)
		kU.SetVar("fadetime",0)
		table.insert (k2, kD)
		table.insert (k1, kU)
	end 
	if spawntimer % 44 == 0 and spawntimer > 600 then 
		kD = CreateProjectile ('KnifeDownDeadly', -200, 32)
		kU = CreateProjectile ('KnifeUpDeadly', 200, -32)
		kD.sprite.alpha=0
		kU.sprite.alpha=0
		kD.SetVar("time",0)
		kU.SetVar("time",0)
		kD.SetVar("fuckYou",1)
		kU.SetVar("fuckYou",1)
		kD.SetVar("fadetime",0)
		kU.SetVar("fadetime",0)
		table.insert (k2, kD)
		table.insert (k1, kU)
	end 
	
	for i=1,#k1 do
    		local k = k1[i]
		if k.isactive then
	    		k.Move(-3,0)
			local time=k.GetVar("time")+1
			k.SetVar("time",time)
			if time<46 then
				k.sprite.alpha=math.sin(time*math.pi/90)
			end
			if k.x<-100 then
				local fade=k.GetVar("fadetime")+1
				k.SetVar("fadetime",fade)
				if fade<60 then
					k.sprite.alpha=math.cos(fade*math.pi/120)
					else
					k.Remove()
				end
			end
		end
		
		local x=k.x
		if x>50 then
			x=x-50
			elseif x<-50 then
			x=x+50
			else
			x=0
		end
		k.sprite.alpha=math.cos(x*math.pi/300)
		
	end
	
	for i=1,#k2 do
    		local k = k2[i]
		if k.isactive then
	    		k.Move(3,0)
			local time=k.GetVar("time")+1
			k.SetVar("time",time)
			if time<46 then
				k.sprite.alpha=math.sin(time*math.pi/90)
			end
			if k.x>100 then
				local fade=k.GetVar("fadetime")+1
				k.SetVar("fadetime",fade)
				if fade<60 then
					k.sprite.alpha=math.cos(fade*math.pi/120)
					else
					k.Remove()
				end
			end
		end
		
		local x=k.x
		if x>50 then
			x=x-50
			elseif x<-50 then
			x=x+50
			else
			x=0
		end
		k.sprite.alpha=math.cos(x*math.pi/300)
		
	end

end 

function OnHit(bullet)
	if bullet.GetVar("fuckYou") ~= nil then
		KnifeHurt(1 + bullet.GetVar("fuckYou"))
	else
		KnifeHurt(1)
	end
end