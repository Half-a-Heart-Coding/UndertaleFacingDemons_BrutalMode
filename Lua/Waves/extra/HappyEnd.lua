spawntime=-180
number=1
lang=Encounter.GetVar("lang")
misters={"horse","nickel","me","dok","lom","psycho"}
titrs={}
called={}
lock=CreateProjectile("empty",0,0)
function Titr()
	if number<(#misters+1) then
		local sprite=CreateProjectile(lang.."titr/"..misters[number],320-lock.absx,-50-lock.absy)
		table.insert(titrs,sprite)
		number=number+1
		else Audio.PlaySound("reflect")
	end
end
function Update()
if spawntime<1 then
	spawntime=spawntime+1
end
for i=1,#titrs do
	local titr=titrs[i]
	if titr.isactive then
		titr.Move(0,1)
	end
	if titr.absy>840 and titr.isactive then
		titr.Remove()
	end
	if titr.absy>320 and not called[i] then
		Titr()
		called[i]=true
	end
end
if spawntime==0 then
	local sprite = CreateProjectile(lang.."titr/igni",320-lock.absx,-50-lock.absy)
	table.insert(titrs,sprite)
end
end
function OnHit()
end