Arena.Resize(200, 160)
attacktimer = 0

function CreateFirstRing()
	local knifex = 0
	local knifey = 0
	local angle = 0
	for n=1, 15 do
		angle = n*24
		knifex = 160*math.sin(angle * math.pi/180)
		knifey = 160*math.cos(angle * math.pi/180)
		local outerknife = CreateProjectile('KnifeLeft', knifex, knifey)
		outerknife.sprite.rotation = -angle
	end
end

function CreateSecondRing()
end



function CreateThirdRing()
end

function Update()
	attacktimer = attacktimer + 1
	if attacktimer == 30 then
		CreateFirstRing()
	end

	if attacktimer == 60 then
		CreateSecondRing()
	end

	if attacktimer == 90 then
		CreateThirdRing()
	end

end
