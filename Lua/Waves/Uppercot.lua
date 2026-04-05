require "Libraries/hurt" 
collision = require "Libraries/rotational_collision"
time=0
Blasters={}
function Update()
HurtUpd(600)
time=time+1
if time%60==30 then
    local Blaster=CreateProjectile("GasterBlaster/ingo",Player.x,150,"Top")
    Blaster.sprite.alpha=0
    Blaster.sprite.Scale(2,2)
    Blaster.SetVar("time",0)
    Blaster.SetVar("px",Player.x)
    Blaster.SetVar("py",150)
    Audio.PlaySound("sfx_BlasterEntrylight")
    table.insert(Blasters,Blaster)
end

for i=1,#Blasters do
    local bl=Blasters[i]
    local t=bl.GetVar("time")
    bl.SetVar("time",t+1)
    if t<91 then
        bl.sprite.alpha=1-math.cos(t*math.pi/180)
        local r=bl.sprite.rotation
        local x=bl.GetVar("px")+120*math.cos(t*math.pi/180)*math.cos((r+90)*math.pi/180)
        local y=bl.GetVar("py")+120*math.cos(t*math.pi/180)*math.cos(r*math.pi/180)
        bl.MoveTo(x,y)
    elseif t<105 then
        local dlt=1+3*math.sin((t-90)*math.pi/20)
        if t>100 then
            dlt=4
        end
        local r=bl.sprite.rotation
        local x=bl.GetVar("px")+dlt*math.sin((t-90)*math.pi/3)*math.cos(r*math.pi/180)
        local y=bl.GetVar("py")+dlt*math.sin((t-90)*math.pi/3)*math.cos((r+90)*math.pi/180)
        bl.MoveTo(x,y)
    elseif t==105 then
        bl.MoveTo(bl.GetVar("px"),150)
        local r=bl.sprite.rotation
        local laser=CreateProjectile("laser0/laserv6",bl.x+680*math.sin(r*math.pi/180),bl.y+680*math.sin((r-90)*math.pi/180))
        laser.sprite.alpha=0
        laser.sprite.rotation=r
        laser.SetVar("color","none")
        laser.SetVar("damage",0)
        bl.SetVar("laser",laser)
        bl.sprite.Set("GasterBlaster/almost")
        bl.SetVar("b",0)
        Audio.PlaySound("sfx_Blaster")
    elseif t<200 then
        local r=bl.sprite.rotation
        local b=bl.GetVar("b")
        local l=bl.GetVar("laser")
        if t<165 then
            local r=bl.sprite.rotation
            local x=bl.GetVar("px")-90*math.sin((t-105)*math.pi/120)*math.cos((r+270)*math.pi/180)
            local y=bl.GetVar("py")-90*math.sin((t-105)*math.pi/120)*math.cos((r+180)*math.pi/180)
            bl.MoveTo(x,y)
            l.MoveTo(bl.x+680*math.sin(r*math.pi/180),bl.y+680*math.sin((r-90)*math.pi/180))
        end
        if t<121 then
            l.sprite.alpha=math.sin((t-105)*math.pi/30)
        end
        if t<180 then
            b=b+1+3*math.cos((t-105)*math.pi/150)
        else
            b=b+1
        end
        if b>18 then
            bl.sprite.Set("GasterBlaster/1")
            b=b-18
        elseif b>9 then
            bl.sprite.Set("GasterBlaster/0")
        end
        bl.SetVar("b",b)
        if t<125 then
            l.SetVar("color","laser")
            l.SetVar("damage",1)
            l.sprite.Scale(math.sin((t-105)*math.pi/60),1)
        elseif t<180 then
            l.sprite.Scale(0.9+0.1*math.sin((t-125)*math.pi/5),1)
            l.SetVar("damage",2)
        elseif t<195 then
            l.sprite.Scale(0.9*math.cos((t-180)*math.pi/30),1)
            l.sprite.alpha=1-math.sin((t-180)*math.pi/30)
            l.SetVar("damage",1)
        end
        if t>185 and t<200 then
            bl.sprite.alpha=1-math.sin((t-185)*math.pi/30)
        end
        if l.GetVar("color")=="laser" and collision.CheckCollision(Player,l) then
            KnifeHurt(l.GetVar("damage"))
        end
    elseif t==200 then
        local l=bl.GetVar("laser")
        l.Remove()
        bl.Remove()
    end
end

end

function OnHit(hit)
    KnifeHurt(1)
    if hit.GetVar("color")=="none" then
    elseif hit.GetVar("color")=="laser" then
    end
end

