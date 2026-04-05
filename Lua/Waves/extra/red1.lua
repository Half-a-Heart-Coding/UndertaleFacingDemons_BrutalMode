spearup1 = CreateProjectile('spear', 0, -110)
speardown1 = CreateProjectile('speardown', 0, 110)
spearleft1 = CreateProjectile('spearleft', 130, 0)
spearright1 = CreateProjectile('spearright', -130, 0)
timer = 0
spearmoving = false
Arena.Resize(155, 130)

function Update()
	timer = timer + 1
	if timer == 30 then
		spearup1.MoveTo(0, -110)
		speardown1.MoveTo(0, 110)
		spearleft1.MoveTo(130, 0)
		spearright1.MoveTo(-130, 0)
		spearmoving = true
	end
	if timer == 70 then
		spearup1.MoveTo(50, -110)
		speardown1.MoveTo(-50, 110)
		spearleft1.MoveTo(130, -30)
		spearright1.MoveTo(-130, 30)
		spearmoving = false
	end
	if timer == 80 then
		spearmoving = true
	end
	if timer == 120 then
		spearup1.MoveTo(0, -110)
		speardown1.MoveTo(0, 110)
		spearleft1.MoveTo(130, 0)
		spearright1.MoveTo(-130, 0)
		spearmoving = false
	end
	if timer == 130 then
		spearmoving = true
	end

	if spearmoving == true then
		spearup1.Move(0, 7)
		speardown1.Move(0, -7)
		spearleft1.Move(-7, 0)
		spearright1.Move(7, 0)
	end
	if spearmoving == false then
		spearup1.Move(0, 0)
	end
      if timer == 210 then 
            EndWave() 
      end
end