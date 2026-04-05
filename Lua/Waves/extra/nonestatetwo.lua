Arena.Resize(565,130)
Player.MoveTo(-260,40,true)
spawntime=0
Player.SetControlOverride(true)
function Update()
spawntime=spawntime+1
if spawntime==60 then
	Arena.ResizeImmediate(-10,-10)
end
	if Input.Left>0 and Input.Right==0 and Player.absx>8 then
		Player.MoveTo(Player.x-2,Player.y,true)
	end
	if Input.Left==0 and Input.Right>0 and Player.absx<632 then
		Player.MoveTo(Player.x+2,Player.y,true)
	end
	if Input.Up>0 and Input.Down==0  and Player.absy<472 then
		Player.MoveTo(Player.x,Player.y+2,true)
	end
	if Input.Up==0 and Input.Down>0  and Player.absy>8 then
		Player.MoveTo(Player.x,Player.y-2,true)
	end
if GetGlobal("ending")==true then
	Arena.ResizeImmediate(130,130)
	Player.MoveTo(0,0,false)
end
end

