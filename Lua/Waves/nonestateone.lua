Arena.Resize(565,130)
Player.MoveTo(-260,40,true)
Player.SetControlOverride(true)
function Update()
if Input.Cancel==1 then
	EndWave()
end
end