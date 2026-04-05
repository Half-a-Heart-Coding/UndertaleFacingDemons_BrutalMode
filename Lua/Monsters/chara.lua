-- A basic monster script skeleton you can copy and modify for your own creations.
commentater = {"Последний актёр на сцене", "Чара выглядит недовольной", "Осталось только ДРАТЬСЯ", "Ты наполнен ПРЕДАТЕЛЬСТВОМ.", "Пахнет трусом.", "Сотри их в пыль.", "Очередной дурак.", "ДЕРИСЬ или УМРИ.", "Тебе ничего не остаётся.", "Ещё не поздно умереть.", "Чара хихикнула.", "Прячься или дерись.", "Точка невозврата.", "Тебе стоит попытаться сильнее.", "Объясни себе свои действия.", "Присоединяйся к битве.", "Никакой ПОЩАДЫ.", "Тебе придётся уМЕРГеть.", "Чара дрожит.", "Ничего особенного.", "Вступи в шоу и закончи его!", "Новое начало.", "Необычная временная линия.", "Суд.", "Навсегда один.", "Пыль на твоих руках кажется \rнормой.", "Просто ДЕРИСЬ.", "Не останавливайся отныне!"}
comments=commentater
comments={"Последний актёр на сцене"}
randomdialogue = {"[next]"}
fakespare = 0
pray = 0
goneto=0
lostgoneto=0
NewAudio.CreateChannel("dubber")
stomp1=1200
commands = {"ПРОВЕРИТЬ", "МОЛИТВА"}
SetGlobal("BurningMode",0)
--require "Animations/chara_anim"
----------------- Последние слова --------------------

outro1 = "[func:Final_2,finale][noskip][color:797979][effect:shake][waitall:5]Чтож..."
outro2 = "[noskip][color:797979][effect:shake][waitall:5]Кажется...\nТы победил."
outro3 = "[func:head4][noskip][color:797979][effect:shake][waitall:5]Хех..."
outro4 = "[func:head][noskip][color:797979][effect:shake][waitall:5]Вот и всё.\nНикогда не думала ,\nчто я умру вот..."
outro5 = "[noskip][color:797979][effect:shake][waitall:5]так."
outro6 = "[func:Final_3][noskip][color:797979][effect:shake][waitall:5]Умру перед лицом\nпредателя..."
outro7 = "[func:head][noskip][color:797979][effect:shake][waitall:5]Какой же ты\nтрус."
outro8 = "[func:Final_3][noskip][color:797979][effect:shake][waitall:5]Он... верил в тебя..."
outro9 = "[noskip][color:797979][effect:shake][waitall:5]А ты...\nпредала нас..."
outro10 = "[noskip][color:797979][effect:shake][waitall:5]предала все...\nнаши...\nнадежды..."
outro11 = "[func:Final_creepy][noskip][effect:shake][waitall:5][color:ff0000]ТЫ ЖЕ ПРОСТО...\nМЕЛКИЙ...\nБРАТОУБИЙЦА."
outro12 = "[func:Final_4][noskip][color:797979][effect:shake][waitall:5]. . ."
outro13 = "[noskip][color:797979][effect:shake][waitall:5]...Азриель...я..."
outro14 = "[noskip][color:797979][effect:shake][waitall:5]...Я иду к...\n[w:20]т е б е...[func:dead][w:60][func:WON][next]"
-----------------------------------------------------------------
plotdialogue = {d1, d2, d3, d4, d5, d6, d7, d8, d9, d10, d11, d12, d13, d14, d15, d16, d17, d18, d19, d20, d21, d22, d23, d24, d25, d26, d27, d28, d29, d30, d31, d32, d33, d34, d35, d36, d37, d38, d39, d40, d41} -- это наш массив диалогов, сюда вставляем ссылки на фразы.
num_dial = #plotdialogue+1 -- костыль, который пришлось воткнуть, чтобы игра не зависала по истечению заготовленных реплик.
sprite = "empty" --Always PNG. Extension is added automatically.
name = "Чара Дриимурр"
hp = 1500
atk = 1
def = 30
check = "Она использует силу\rПОДЗЕМЕЛЬЯ"
dialogbubble = "rightwide"
LostGotMissed=false
LostChildHopes=false
canspare = false
cancheck = false
dodge=true
unkillable=true
dialogueprefix="[effect:none]"
function Lang(ingo)
	if ingo=="rus" then
		name = "Чара Дриимурр"
		commands = {"ПРОВЕРИТЬ", "МОЛИТВА"}
		else
		name = "Chara Dreemurr"
		commands = {"INSPECT", "PRAY"}
	end
end

function Think()
	SetGlobal("facial_expression",47)
end

function Irony()
	SetGlobal("facial_expression",49)
end

function TakeOutChocolate()
	local t=Encounter.GetVar("charatorso")
	local sp="1.2/chara/chocalatebody0"
	if hp<1500 then
		sp=sp.."_wounded"
	end
	t.Set(sp)
end

function EatChocolate1()
	local t=Encounter.GetVar("charatorso")	
	local l=Encounter.GetVar("charalegs")
	local sp="1.2/chara/chocalatebody1"
	if hp<1500 then
		sp=sp.."_wounded"
	end
	t.Set(sp)
	Encounter.Call("DoHand")
end

function EatChocolate2()
	hp=hp+360
	Audio.PlaySound("healsound")
	local h=Encounter.GetVar("ChocolateHand")
	h.sprite.Set("1.2/chara/chocalatehand1")
	local t=Encounter.GetVar("charatorso")	
	local sp="1.2/chara/chocalatebody1"
	if hp<1500 then
		sp=sp.."_wounded"
	end
	t.Set(sp)
	
end
function HealUp()
	hp=hp+360
	Audio.PlaySound("healsound")
	local t=Encounter.GetVar("charatorso")	
	local sp="1.2/chara/chocalatebody1"
	if hp<1500 then
		sp=sp.."_wounded"
	end
	t.Set(sp)
end

function BackChocolate()
	local t=Encounter.GetVar("charatorso")
	t.Set("1.2/chara/chocalatebody2")
	Encounter.Call("NoDoHand")
end

function NoChocolate()
	local t=Encounter.GetVar("charatorso")
	t.Set("1.2/chara/Chara_body0")
end

function KnifeInPocket()
	local t=Encounter.GetVar("charatorso")
	local sp="1.2/chara/Chara_body0"
	if hp<1500 then
		sp=sp.."_wounded"
	end
	t.Set(sp)
end

function GiveChocolate()
	local t=Encounter.GetVar("charatorso")
	t.Set("1.2/chara/chocalatebody3")
end
	
function HappyCharaMeal2()
	local dial={}
	if Encounter.GetVar("lang")=="rus" then
		dial={"Вы утвердительно киваете и подбегаете ближе к Чаре.","[func:HappyCharaMeal3]"}
		else
		dial={"You nod in agreement and run closer to Chara.","[func:HappyCharaMeal3]"}
	end
	for i=1,#dial do
		dial[i]="[noskip][novoice][voice:uidial]"..dial[i]
	end
	BattleDialog(dial)
end
	
function HappyCharaMeal4()
	local dial={}
	if Encounter.GetVar("lang")=="rus" then
		dial={"Вы спрашиваете Чару,[w:3] в порядке ли она.","[func:HappyCharaMeal5]"}
		else
		dial={"You ask Chara if she is alright.","[func:HappyCharaMeal5]"}
	end
	for i=1,#dial do
		dial[i]="[noskip][novoice][voice:uidial]"..dial[i]
	end
	BattleDialog(dial)
end
	
function HappyCharaMeal6()
	local dial={}
	if Encounter.GetVar("lang")=="rus" then
		dial={"Вы соглашаетесь взять[next]","[func:HappyCharaMeal7]"}
		else
		dial={"You agree to take[next]","[func:HappyCharaMeal7]"}
	end
	for i=1,#dial do
		dial[i]="[noskip][novoice][voice:uidial]"..dial[i]
	end
	BattleDialog(dial)
end
	
function HappyCharaMeal8()
	local dial={}
	if Encounter.GetVar("lang")=="rus" then
		dial={"[w:3].[w:4].[w:4].[w:4]Вы послушно открываете рот и Чара кладет вам на язык кусочек шоколада.[w:6]\nОн будто тает во рту[waitall:4][w:3]...","[health:19]Вы восстановили ОЗ[waitall:4][w:3]...[waitall:1][w:3] \nПросто ОЗ.","[func:HappyCharaMeal9]"}
		else
		dial={"[waitall:4][w:3]...[waitall:1][w:3]You obediently open your mouth and Chara puts a piece of chocolate on your tongue.[w:6]It seems to melt in your mouth.[w:6].[w:6]","[health:19]You regain HP[waitall:4][w:3]...[waitall:1][w:3] HP itself.","[func:HappyCharaMeal9]"}
	end
	for i=1,#dial do
		dial[i]="[noskip][novoice][voice:uidial]"..dial[i]
	end
	BattleDialog(dial)
end
	
function HappyCharaMeal10()
	Encounter.SetVar("ToHappyEnd",1)
	State("NONE")
end

function Cough1()
	Encounter.SetVar("coughtime",30)
	Encounter.SetVar("cough",3)
end

function Cough2()
	Encounter.SetVar("coughtime",60)
	Encounter.SetVar("cough",6)
end

function LostHasLost()
	local lang=Encounter.GetVar("lang")
	local dial={}
	if lang=="rus" then
		dial={"[waitall:4][w:3]...[waitall:1][w:3]\nНу и трепло[waitall:4][w:3]...","Теперь[waitall:4][w:3]...[waitall:1][w:3] \nЧто касается тебя,[w:3] дорогуша[waitall:4][w:3]...[waitall:1][w:3]","[func:LostToMetta1]"}
		else
		dial={"[waitall:4][w:3]...[waitall:1][w:3]\nSuch a ballooney[waitall:4][w:3]...[waitall:1][w:3]","Now[waitall:4][w:3]...[waitall:1][w:3]\nWhat about you,[w:3] darling[waitall:4][w:3]...[waitall:1][w:3]","[func:LostToMetta1]"}
	end
	for i=1,#dial do
		dial[i]="[noskip][color:8040ff]"..dial[i]
	end
	BattleDialog(dial)
end

function Remember()
	SetGlobal("facial_expression",48)
end

function GetsAngry()
	Encounter.Call("GetsAngry")
end

function ToAngry()
	SetGlobal("facial_expression",64)
end

function DUB(ingo)
	if Encounter.GetVar("dubbing")==true then
		NewAudio.PlaySound("dubber",Encounter.GetVar("lang").."/chara/"..ingo)
		Encounter.SetVar("IsTalk",true)
	end
end

function trigered()
	SetGlobal("facial_expression",45)
end

function trigeredrem()
	SetGlobal("facial_expression",50)
end

function trigeredclosed()
	SetGlobal("facial_expression",46)
end

function thoughts()
	SetGlobal("facial_expression",40)
end

function thoughtsleft()
	SetGlobal("facial_expression",42)
end

function LostKidFace(ingo1,ingo2)
	if ingo2=="+" then
		Encounter.SetVar("LostHead","/lost child/lost_"..ingo1)
		SetGlobal("facial_expression",60)
		else
		Encounter.SetVar("LostHead","/lost child/lost_"..ingo1)
		SetGlobal("facial_expression",61)
	end
end

function Reminder()
	Encounter.SetVar("Reminder",true)
	State("NONE")
end
function thoughtsright()
	SetGlobal("facial_expression",41)
end

function BackMusic()
	local songs=Encounter.GetVar("songs")	
	Encounter.Call("SetMusic",songs[1])
end
function mercy()
	SetGlobal("facial_expression",36)
end
function noblack()
	local phone=Encounter.GetVar("phone")
	phone.Remove()
end
function happycry()
	SetGlobal("facial_expression",35)
end
function HAPPY()
	Encounter.SetVar("happyending",0)
end

function lowpitchmusic()
	Encounter.SetVar("phase15slowmusic",0)
end
function stopmusic()
	Encounter.SetVar("lowmusic",0)
end
function nohope1()
	SetGlobal("facial_expression",30)
end
function nohopeanger()
	SetGlobal("facial_expression",34)
end
function nohope2()
	SetGlobal("facial_expression",31)
end
function nohope3()
	SetGlobal("facial_expression",32)
end
function nohope4()
	SetGlobal("facial_expression",33)
end
function Wink()
	SetGlobal("facial_expression",29)
end
function WON()
	local lang=Encounter.GetVar("lang")
	local wons=Encounter.GetVar("wons")
	local prog=Encounter.GetVar("prog")
	local lost=Encounter.GetVar("LostMercy")
	if wons==0 then
		if lang=="rus" then
			BattleDialog("[noskip][waitall:1]Ты победил![w:10]\nТы получил 0 М и 50000 ОП\nТвой УР вырос![func:Level20][w:1800] ")
			else
			BattleDialog("[noskip][waitall:1]You won![w:10]\nYou got 0 G and 50000 EXP\nYour LV raised![func:Level20][w:1800] ")
		end
		elseif wons==1 then
		local dial={}
		if lost<6 then
			if lang=="rus" then
				dial={"[noskip][color:8040ff]Значит ей ещё было что сказать?[w:6]\nЖаль.[w:6] В следующий раз послушаем.[w:6]","[noskip][color:8040ff]Идём дальше.[w:6]\nТвой УР повышен и все дела.[w:6]\nНе будем задерживаться.[func:Level20][w:1800] "}
				else
				dial={"[noskip][color:8040ff]So she had something else to say?[w:6]\nPity.[w:6] We will listen to it other time.[w:6]","[noskip][color:8040ff]Come on.[w:6]\nYour LV raised and etc.[w:6]\nLet's not waster our time.[func:Level20][w:1800] "}
			end
			elseif lost<19 then
			if lang=="rus" then
				dial={"[waitall:4][w:3]...[waitall:1][w:3]Вопреки тому,[w:6] что мне было интересно,[w:6] эта сказка и правда затянулась.[w:6]","Ты всё правильно сделал.[w:6]\nТвой УР повышен и все дела.[w:6]\nНе будем задерживаться.[w:6][func:Level20][w:1800] "}
				else
				dial={"[waitall:4][w:3]...[waitall:1][w:3]Even if I was curious,[w:6] this tale still wasting too much time.[w:6]","You did everything right.[w:6]\nYour LV raised and etc.[w:6]\nLet's not waste our time.[w:6][func:Level20][w:1800] "}
			end
			elseif lost<21 then
			if lang=="rus" then
				dial={"Слава Богу[waitall:4][w:3]...[waitall:1][w:3] Ещё бы немного,[w:6] и я точно её убил.[w:6]\nКакая же она мерзкая[waitall:4][w:3]...[waitall:1][w:3] Даже на эмоции смогла пробить.[w:6]","Я не хочу больше здесь оставаться.[w:6]\nИдём дальше.[w:6][func:Level20][w:1800] "}
				else
				dial={"Golly[waitall:4][w:3]...[waitall:1][w:3] A little more of this and I would kill her for sure.[w:6]\nShe's such a gross[waitall:4][w:3]...[waitall:1][w:3] Even touched my feelings somehow.[w:6]","I don't want to stay here any longer.[w:6]\nCome on.[w:6][func:Level20][w:1800] "}
			end
			else
			if lang=="rus" then
				dial={"Ты был на грани моего терпения.[w:6] Что это значит?[w:6] Тебе не нравится моя постановка?[w:6] Выскажись.[w:6]","Я с радостью учту твои замечания в следующей постановке.[w:6]\nА пока закончим эту.[w:6] Да?[w:6][func:Level20][w:1800] "}
				else
				dial={"You were on edge of my patience.[w:6] \nWhat was that? [w:6]Do you not like my play?[w:6] Spit it out.[w:6]","I will gladly listen to your notices in next script.[w:6]\nAs for now,[w:3] let's end this one.[w:6] Yeah?[w:6][func:Level20][w:1800] "}
			end
		end
		for i=1,#dial do
			dial[i]="[noskip][color:8040ff]"..dial[i]
		end
		BattleDialog(dial)
	end
	SetGlobal("prog",true)
end
function dead()
	SetGlobal("dying",true)
end
function closedyesend()
	SetGlobal("facial_expression",26)
end
function headend()
	SetGlobal("facial_expression",27)
end
function sleepy()
	SetGlobal("facial_expression",25)
end
function Final3()
	SetGlobal("facial_expression", 24)
end
function action()
	State("ACTIONSELECT")
end
function Act1()
	SetGlobal("CHECKED",true)
end
function Final_5()
	SetGlobal("facial_expression",28)
end
function Act2()
	State("ACTIONSELECT")
end
function ph1()
	SetGlobal("phase1", 1)
end
function ph2()
	SetGlobal("phase1",2)
end
function phcon()
	SetGlobal("phase1",3)
end
function phend()
	SetGlobal("phase1",0)
end
function ChangeMusic()
	Encounter.Call("ChangeMusic")
end
function MoveToCenter()
	Encounter.SetVar("TimeToMove",1)
end
function Danger1()
	SetGlobal("facial_expression",23)
end
function Peachy()
	SetGlobal("facial_expression",22)
end

function NoMercy2()
        SetGlobal("facial_expression", 18)
end

function Suprise1()
        SetGlobal("facial_expression", 17)
end

function Surprise1()
        SetGlobal("facial_expression", 17)
end

function NoMercy1()
        SetGlobal("facial_expression", 19)
end

function Suprise2()
        SetGlobal("facial_expression", 20)
end

function Surprise2()
        SetGlobal("facial_expression", 20)
end

function Bad()
        SetGlobal("facial_expression", 21)
end

function Dodging()
	SetGlobal("runy", true)
end

function EveryDial(ingo, part,dubi)
	local outgo=ingo
	if Encounter.GetVar("dubbing")==true then
		for i=1,#ingo do
			outgo[i]=dubi..ingo[i]
		end
	end
	for i=1,#ingo do
		outgo[i]=part..ingo[i]
	end
	return outgo
end

function smart()
	SetGlobal("facial_expression", 53)
end 

function tired()
	SetGlobal("facial_expression", 13)
end 

function normal()
	SetGlobal("facial_expression", 15)
end 

function normal1()
	SetGlobal("facial_expression", 16)
end 

function tired1()
	SetGlobal("facial_expression", 14)
end 

function cens() 
	Audio.PlaySound("dogsecret")
end 

function deadly()
	SetGlobal("facial_expression", 10)
end

function angry()
	SetGlobal("facial_expression", 12)
end

function cry ()
	SetGlobal("facial_expression", 11)
end

function Final_1()
	SetGlobal("facial_expression", 1)
end

function TakeKnife()
	Encounter.Call("SetMusic","none")
	Encounter.SetVar("standtime",0)
	Encounter.SetVar("standnow",2)
	Encounter.SetVar("standnew",2)
	Audio.PlaySound("appear")
	SetGlobal("knifeinhand", true)
end

function DramaIn()
	Encounter.SetVar("drama",true)
end

function DramaOut()
	Encounter.SetVar("drama",false)
end

function weak()
	SetGlobal("facial_expression", 52)
end

function AUCH()
	SetGlobal("facial_expression", 51)
end

function Look()
	SetGlobal("facial_expression", 43)
end
function Lookleft()
	SetGlobal("facial_expression", 44)
end
function Music(ingo)
	Encounter.Call("SetMusic",ingo)
end
function Music2()
	local songs=Encounter.GetVar("songs")
	Encounter.Call("SetMusic",songs[3])
end
function Final_2()
	SetGlobal("facial_expression", 2)
end

function sad()
	SetGlobal("facial_expression", 8)
end

function Final_6()
	SetGlobal("facial_expression", 38)
end

function Final_7()
	SetGlobal("facial_expression", 39)
end

function Final_3()
	SetGlobal("facial_expression", 3)
end

function smile()
	SetGlobal("facial_expression", 9)
end

function Final_4()
	SetGlobal("facial_expression", 4)
end

function Final_creepy()
	SetGlobal("facial_expression", 5)
end

function head4()
	SetGlobal("facial_expression", 6)
end

function head()
	SetGlobal("facial_expression", 7)
end

function BADBad()
	SetGlobal("facial_expression", 54)
end

function mercy()
	SetGlobal("facial_expression",36)
end

function BADsad()
	SetGlobal("facial_expression", 55)
end

function BADIrony()
	SetGlobal("facial_expression", 56)
end

function BADRemember()
	SetGlobal("facial_expression", 57)
end

function BADthoughts()
	SetGlobal("facial_expression", 58)
end

function BADsmart()
	SetGlobal("facial_expression", 59)
end

function BADweak()
	SetGlobal("facial_expression", 63)
end

function hurtme(wound)
	local songs=Encounter.GetVar("songs")	
	Encounter.Call("SetMusic",songs[3])
end

function start(prolog)
	Encounter.Call("SetMusic",prolog)
end

function start1()
	Encounter.Call("SetMusic","none")
end

function start2()
	local songs=Encounter.GetVar("songs")
	Encounter.Call("SetMusic",songs[1])
end

function TireStand()
	Encounter.SetVar("standnew",5)
end

function Bloodshed()
	local songs=Encounter.GetVar("songs")	
	Encounter.Call("SetMusic",songs[2])
	Encounter.SetVar("CharaIsRaging",true)
end

function Devil()
	local songs=Encounter.GetVar("songs")
	--if songs[1]=="night" then
		if Encounter.GetVar("prog")<27 then
			Encounter.Call("SetMusic",songs[1])
			else
			Encounter.Call("SetMusic",songs[4])
		end
	--	else
	--	Encounter.Call("SetMusic",songs[4])
	--end
	--Encounter.Call("SetMusic",songs[4])
end

function BoneFriend()
	Encounter.Call("GiveSprite","Paps_Sprite")
end

function SendToCenter()
	SetBubbleOffset(0,0)
end

function ShowSoul()
	Encounter.SetVar("SoulShowsUp",1)
end

function CrashSoul()
	Encounter.SetVar("SoulShowsUp",61)
	State("NONE")
end

function HideKnife()
	local torso=Encounter.GetVar("charatorso")
	torso.Set(Encounter.GetVar("currentspr").."/chara/Chara_body0")
	Encounter.SetVar("trs_sp",Encounter.GetVar("currentspr").."/chara/Chara_body0")
	Encounter.SetVar("standnew",1)
end

function EpicKnife()
	if Encounter.GetVar("currentspr")=="1.2" then
		local torso=Encounter.GetVar("charatorso")
		torso.Set(Encounter.GetVar("currentspr").."/chara/Chara_body_fight")
		Encounter.SetVar("trs_sp",Encounter.GetVar("currentspr").."/chara/Chara_body_fight")
		local torso=Encounter.GetVar("charalegs")
		torso.Set(Encounter.GetVar("currentspr").."/chara/Chara_legs_fight")
		Encounter.SetVar("trs_sp",Encounter.GetVar("currentspr").."/Chara_legs_fight")
	end
	Encounter.SetVar("standnew",3)
	Encounter.SetVar("standnow",3)
	Encounter.SetVar("standtime",0)
	Encounter.SetVar("EpicKnife",true)
end
	
function NoEpicKnife()
	if Encounter.GetVar("currentspr")=="1.2" then
		local torso=Encounter.GetVar("charatorso")
		torso.Set(Encounter.GetVar("currentspr").."/chara/Chara_body")
		Encounter.SetVar("trs_sp",Encounter.GetVar("currentspr").."/chara/Chara_body")
		local legs=Encounter.GetVar("charalegs")
		legs.Set(Encounter.GetVar("currentspr").."/chara/Chara_legs")
		Encounter.SetVar("lgs_sp",Encounter.GetVar("currentspr").."/Chara_legs")
		torso.x=8
		local head=Encounter.GetVar("charahead")
		Encounter.SetVar("hdx",-7)
	end
	Encounter.SetVar("standnew",5)
	Encounter.SetVar("standnow",5)
	Encounter.SetVar("standtime",0)
	Encounter.SetVar("EpicKnife",false)
end

function GiveCurse()
	if Encounter.GetVar("diff") ~= 6 then
		Encounter.SetVar("IsCursed",true)
	else
		SetGlobal("BurningMode", 1)
	end
	Encounter.SetVar("cursefade",0)
	Encounter.SetVar("cursetime",0)
end

function Weaken()
	Encounter.SetVar("IsWeak",true)
	Encounter.SetVar("MaxHP",99)
	--Encounter.SetVar("LV",20)
	Player.lv=20
	Player.hp=99
end

function NoCurse()
	Encounter.SetVar("IsCursed",false)
	Encounter.SetVar("cursetime",0)
	SetGlobal("BurningMode",0)
end

function QuietMusic()
	Encounter.SetVar("QuietMusic",true)
	Encounter.SetVar("QuietMusicTime",0)
end

function CheckWound()
	Audio.PlaySound("healsound")
	Encounter.Call("Wounded",hp)
end

function Bubble()
	local eva=GetGlobal("evasion")
	if eva==1 or eva==2 then
		SetBubbleOffset(-100,0)
		else
		SetBubbleOffset(0,0)
	end
end
function AddLine(ingo,line)
	local outgo=ingo
	local i
	for i=1,#ingo do
		outgo[i]=line..ingo[i]
	end
	return outgo
end
function HandleAttack()
	local prog=GetGlobal("progress")
	local wav={"nothing"}
	local nrus={}
	local neng={}
	local rus={""}
	local eng={}
	local engcom=""
	local ruscom=""
	local eva=GetGlobal("evasion")
	local diff=Encounter.GetVar("diff")
	if Encounter.GetVar("songs")[4] ~= "wound86" then
		if eva==1 or eva==2 then
			SetBubbleOffset(-100,0)
			else
			SetBubbleOffset(0,0)
		end
	end
	local lang=Encounter.GetVar("lang")
		comments = commentater
	if GetGlobal("Song4") == "wound" then
		SetGlobal("Prgores", prog)
		Encounter.Call("WriteSavio")
		--Encounter.SetVar("phase", "a" + prog)
	end
	if GetGlobal("curse2") == 1 then
		SetGlobal("curse2", 2)
	else
		SetGlobal("curse2", 0)
	end

	if GetGlobal("curseantiresistance") == 1 then
		SetGlobal("curseantiresistance", 2)
	else
		SetGlobal("curseantiresistance", 0)
	end

	if Encounter.GetVar("diff") == 21 then
		Encounter.SetVar("MaxHP", Encounter.GetVar("everythingModeTrueMaxHp")) 
		if Encounter.GetVar("evrerythingModeEffect") == "Wrath" then
			Player.hp = Encounter.GetVar("MaxHP")
		end
	end

	--local randomEffect21 = math.random(149) + 1
	local randomEffect21 = math.random(140) + 1
	Encounter.SetVar("evrerythingModeEffect","sdhiasgfihfihf")
	Encounter.SetVar("evrerythingModeEffectPre", Encounter.GetVar("evrerythingModeEffect"))

	if randomEffect21 >= 136 and randomEffect21 <= 1000 then
		Encounter.SetVar("evrerythingModeEffect","Wrath")
	elseif randomEffect21 <= 10 then
		Encounter.SetVar("evrerythingModeEffect","Glass")
	elseif randomEffect21 >= 11 and randomEffect21 <= 20 then
		Encounter.SetVar("evrerythingModeEffect","Chaos")
	elseif (randomEffect21 >= 21 and randomEffect21 <= 30) then
		Encounter.SetVar("evrerythingModeEffect","Burn")
	elseif randomEffect21 >= 31 and randomEffect21 <= 40 then
		Encounter.SetVar("evrerythingModeEffect","BlackHole")
	elseif randomEffect21 >= 41 and randomEffect21 <= 50 then
		Encounter.SetVar("evrerythingModeEffect","Confusion")
	elseif randomEffect21 >= 51 and randomEffect21 <= 60 then
		Encounter.SetVar("evrerythingModeEffect","Frozen")
	elseif randomEffect21 >= 61 and randomEffect21 <= 70 then
		Encounter.SetVar("evrerythingModeEffect","Funnel")
	elseif randomEffect21 >= 71 and randomEffect21 <= 80 then
		Encounter.SetVar("evrerythingModeEffect","SpeedDemon")
	elseif randomEffect21 >= 81 and randomEffect21 <= 90 then
		Encounter.SetVar("evrerythingModeEffect","Hell")
	--elseif randomEffect21 >= 101 and randomEffect21 <= 110 then
	--	Encounter.SetVar("evrerythingModeEffect","Death")
	elseif randomEffect21 >= 91 and randomEffect21 <= 100 then
		Encounter.SetVar("evrerythingModeEffect","Clock")
	elseif randomEffect21 >= 101 and randomEffect21 <= 110 then
		Encounter.SetVar("evrerythingModeEffect","RevBlackhole")
	elseif randomEffect21 >= 111 and randomEffect21 <= 120 then
		Encounter.SetVar("evrerythingModeEffect","RevClock")
	elseif randomEffect21 >= 121 and randomEffect21 <= 130 then
		Encounter.SetVar("evrerythingModeEffect","RevFunnel")
	elseif randomEffect21 >= 131 and randomEffect21 <= 135 then
		Encounter.SetVar("evrerythingModeEffect","Nightmare2")
	end
	Encounter.SetVar("evrerythingModeEffect","sdhiasgfihfihf")
	--if prog < 1 then
	--	Encounter.SetVar("evrerythingModeEffect","Nightmare")
	--end

	if Encounter.GetVar("diff") == 18 and prog > 1 then
		--currentdialogue={""}
		--neng={""}
		--rus={""}
		--nrus={""}
		--ruscom={""}
		--engcom={""}
		--State("DEFENDING")
	end
	--if Encounter.GetVar("songs")[4] == "last" then
	--	Encounter.SetVar("CharaIsRaging",true)
	--end
	if diff == 33 then
		--Encounter.SetVar("CharaIsRaging",true)
		--Encounter.SetVar("evadelevel",6)
		if GetGlobal("progress") == 1 then
			--Encounter.SetVar("evadelevel",6)
			--if Encounter.GetVar("diff") == 18 then
			--	wav={"imp/k_5_new"}
			--else
			hp=3
			dodge=false
			block=false
			--KnifeStage=5
			if Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare")  then
				neng={""}
				rus={""}
				nrus={""}
				ruscom="Настало время для первого акта."
				engcom="KILL HER!!!"
			end
				wav={"laststrike4","laststand5"}
				--wav={"mutant/10"}
				hp = 500000
				Encounter.SetVar("deadlyhit",false)
				Encounter.SetVar("FightGoes",false)
				Encounter.SetVar("forcedfight",false)
			--end
		elseif GetGlobal("progress") == 2 then
			--if Encounter.GetVar("diff") == 18 then
			--	wav={"imp/rain"}
			--else
			--hp = 999999999999999999999999999
			--hp = 99999999
			dodge=false
			block=false
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
				neng={"I absorded the human\nSouls, All of them\nEven in the\nSurface..."}
				rus={""}
				nrus={""}
				ruscom="Настало время для первого акта."
				engcom="She didn`t get every soul, what about us?"
			end
				wav={"mutant/1"}
			--end
		elseif GetGlobal("progress") == 3 then
			--if Encounter.GetVar("diff") == 18 then
			--	wav={"imp/random"}
			--else
			Encounter.Call("SetMusic","PurgUndyne")
			--Player.hp=135
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
				neng={"We are the only\n2 things left alive..."}
				rus={""}
				nrus={""}
				ruscom="Настало время для первого акта."
				engcom="What about me?"
			end
				wav={"mutant/2"}
			--end
		elseif GetGlobal("progress") == 4 then
			--if Encounter.GetVar("diff") == 18 then
			--	wav={"imp/Reaction"}
			--else

			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
				neng={"Your genocide is\nOver, you have no one\nLeft to kill"}
				rus={""}
				nrus={""}
				ruscom="Настало время для первого акта."
				engcom="This is her full power..."
			end
			--Encounter.Call("SetMusic", "PurgPapyrus")
			wav={"mutant/3"}
			--end
		elseif GetGlobal("progress") == 5 then
			--if Encounter.GetVar("diff") == 18 then
			--	wav={"imp/stoplights"}
			--else
				--Encounter.Call("WriteSavio")
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
				neng={"Welp, it was nice\nKnowing you partner\nBut It`s about time\nThat you...\nBURNED IN HELL!"}
				rus={""}
				nrus={""}
				ruscom="Настало время для первого акта."
				engcom="This is starting to get difficult..."
			end
			Encounter.Call("SetMusic", "PurgPapyrus")
			wav={"mutant/4"}
			--end
		elseif GetGlobal("progress") == 6 then
			--if Encounter.GetVar("diff") == 18 then
			--	wav={"imp/NoMercyToYou"}
			--else
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
				neng={"Say goodbye to METTA\nThey are too weak\nI just killed them."}
				rus={""}
				nrus={""}
				ruscom="*Настало время для первого акта."
				engcom="*You feel overwhelmed with weakness"
			end
			wav={"mutant/5"}
			--end
		elseif GetGlobal("progress") == 7 then
			--if Encounter.GetVar("diff") == 18 then
			--	wav={"imp/k_storm"}
			--else
				neng={"I can`t kill you\nBut I can weaken you!\nYou don`t stand a chance"}
				rus={""}
				nrus={""}
				ruscom="*Настало время для первого акта."
				engcom="*You feel your LV draining away"
			--end
			wav={"mutant/6"}
			Encounter.Call("SetMusic", "PurgSans")
			--end
		elseif GetGlobal("progress") == 8 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
				neng={"You feel weak\nBut you need to be a\nLittle weaker for\nMe to win."}
				rus={""}
				nrus={""}
				ruscom="Настало время для первого акта."
				engcom="*You feel a great amount of fatigue"
			end
			wav={"mutant/7"}
		elseif GetGlobal("progress") == 9 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
				neng={"What`s the point of talking?"}
				rus={""}
				nrus={""}
				ruscom="Настало время для первого акта."
				engcom="*Your LV is completely gone"
				--Encounter.Call("SetMusic", "PurgPapyrus")
			end
			Encounter.SetVar("MaxHP",20)
			--Encounter.SetVar("MaxHP",1)
			Player.lv=1
			wav={"mutant/8"}
		elseif GetGlobal("progress") == 10 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
				neng={"One attack left\nThen I will show you my\nSpecial Attack..."}
				rus={""}
				nrus={""}
				ruscom="Настало время для первого акта."
				engcom="*Your life energy is completely gone"
					--Encounter.SetVar("wavetime",11)
			end
			Encounter.SetVar("MaxHP",1)
			wav={"mutant/9"}
		elseif GetGlobal("progress") >= 11 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			--Encounter.Call("SetMusic", "last")
			--Player.hp=135
				neng={"Here it is...\nMy Special Attack.\nYou will not survive this"}
				rus={""}
				nrus={""}
				ruscom="Настало время для первого акта."
				engcom="*If your seeing this, then your just a dirty Cheater!"
			end
			wav={"mutant/10"}
			--Encounter.SetVar("wavetimer", 13.0)
		elseif GetGlobal("progress") == 12 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
				neng={"GOP is the strongest god in existance, ever.\nYou can`t beat me."}
				rus={""}
				nrus={""}
				ruscom="Настало время для первого акта."
				engcom="No god can save you now"
			end
			wav={"mutant/11"}
			--Encounter.SetVar("wavetimer", 13.0)
		elseif GetGlobal("progress") == 13 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
				neng={"Shut up METTA, before I make you...\nYour not even that strong, it wouldn`t take much too kill you."}
				rus={""}
				nrus={""}
				ruscom="Настало время для первого акта."
				engcom="Liar"
					--Encounter.SetVar("wavetime",10.5)
			end
			wav={"mutant/13"}
		elseif GetGlobal("progress") == 14 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
				neng={"METTA is dead, now it`s just you and me."}
				rus={""}
				nrus={""}
				ruscom="Настало время для первого акта."
				engcom="*You feel uneasy"
			end
			wav={"mutant/14"}
		elseif GetGlobal("progress") == 15 then
			--Player.hp=135
			Encounter.Call("SetMusic", "lost")
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
				neng={"WAIT!..\nGOP I still require your strength!\nWhat do you mean, `not worth my time`??? It`s the fate of the universe.\nYou are just gonna wait for this universe to end and start over...\nI`m that lost of a cause..."}
				rus={""}
				nrus={""}
				ruscom="Настало время для первого акта."
				engcom="*GOP has gotten bored of this universe, he no longer cares who wins..."
			end
			--Encounter.Call("SetMusic", "PurgUndyne")
			wav={"mutant/15"}
			Encounter.SetVar("deadlyhit",true)
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
				Encounter.SetVar("forcedfight",true)
				Encounter.SetVar("FightGoes",false)
			end
		elseif GetGlobal("progress") >= 16 then
			--Player.hp=135
			wav= {"mutant/final"}
			Encounter.SetVar("arenasize", {155, 130})
			--Encounter.SetVar("CharaIsRaging",false)
		end
	elseif diff == 22 then
		Encounter.SetVar("CharaIsRaging",true)
		if GetGlobal("progress") == 1 then
			Encounter.SetVar("evadelevel",1)
			--if Encounter.GetVar("diff") == 18 then
			--	wav={"imp/k_5_new"}
			--else
			if Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare")  then
				neng={'"Did she dodge?",[w:3]\n right?', "[func:NoMercy1]Look,[w:3] you're not \nmy prince,[w:3] \nand I'm not \nyour princess.", "[func:Bad]I can protect \nmyself." ,"[func:head][next]"}
				rus={'[func:DUB,phase1/1/1][w:6]"Как она[w:1] \nувернулась?", \n[w:9]верно?', "[func:DUB,phase1/1/2][func:NoMercy1][w:4]Послушай,[w:3] ты же \nне принц,[w:4] а я \nне твоя принцесса.", "[func:DUB,phase1/1/3][func:Bad][w:3]Я умею за себя \nпостоять.","[func:head][next]"}
				nrus={'"Как она \nувернулась?", \n[w:3]верно?', "[func:NoMercy1]Послушай,[w:3] ты же \nне принц,[w:3] а я \nне твоя принцесса.", "[func:Bad]Я умею за себя \nпостоять.","[func:head][next]"}
				ruscom="Настало время для первого акта."
				engcom="Something feels off"
			end
				wav={"imp/k_5_new"}
			--end
		elseif GetGlobal("progress") == 2 then
			--if Encounter.GetVar("diff") == 18 then
			--	wav={"imp/rain"}
			--else
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
				nrus={"[func:NoMercy1]Позволь задать \nтебе вопрос.", "Ты серьёзно \nдумаешь,[w:3] \n[func:head]что я настолько \nглупа?" }
				neng={"[func:NoMercy1]Let me ask \nyou a question.", "Who do you think \nI am [func:head]to be \nso forgetful?"  }
				rus={"[func:DUB,phase1/2/1][func:NoMercy1][w:2]Позволь задать \nтебе вопрос.", "[func:DUB,phase1/2/2][w:3]Ты серьёзно \nдумаешь,[w:2] \n[func:head]что я настолько \nглупа?" }
				ruscom="Вопрос с подвохом?"
				engcom="What did she just say?!?"
			end
				wav={"imp/rain"}
			--end
		elseif GetGlobal("progress") == 3 then
			--if Encounter.GetVar("diff") == 18 then
			--	wav={"imp/random"}
			--else
			Encounter.Call("SetMusic","wound")
			Player.hp=135
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
				nrus={"[func:NoMercy1][waitall:2]Всё,[waitall:1] [w:3]что ты \nнатворил на \nпути сюда[waitall:5][w:3]...[waitall:1][w:5]\nВся эта кровь \nна твоих руках[waitall:5][w:3]...", "Разве я настолько \nдура,[w:3] \n[func:head]чтобы верить тебе?" }
				rus={"[func:DUB,phase1/3/1][func:NoMercy1][waitall:1][w:3]Всё,[waitall:1] что ты \nнатворил на \nпути сюда[waitall:3][w:3]...[waitall:1][w:5]\nВся эта кровь \nна твоих руках[waitall:5][w:3]...", "[func:DUB,phase1/3/2][w:3]Разве я[w:1] настолько[w:2] \nдура,[w:4] \n[func:head]чтобы верить [w:2]тебе?" }
				neng={"[func:NoMercy1][speed:0.55]Everything [speed:1][w:3]you \nhave done on \nyour way there[waitall:5][w:3]...[waitall:1][w:5] \nAll this dust on \nyour hands[waitall:5][w:3]...", "And killing me... \n[func:head] hundreds of times" }
				ruscom="Чара истерично хихикает."
				engcom="SHE REMEMBERS!?!"
			end
				wav={"imp/random"}
			--end
		elseif GetGlobal("progress") == 4 then
			--if Encounter.GetVar("diff") == 18 then
			--	wav={"imp/Reaction"}
			--else

			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"Мой ответ - [w:6][waitall:2]нет.", "[func:Think]Взгляни вокруг.[w:6] \nТы и я.[w:6] \nОдин на один.", "[func:NoMercy1]Этот коридор \nпропах запахом \nчеловеческой крови.", "На моих руках уже \nесть кровь людей. \n[w:6]Ты - [w:6]не первый [w:6]\nи не последний.", "[func:head]Но только ты \nпричинил столько \nболи.", "И это мой повод \nне опускать руки." }
			rus={"[func:DUB,phase1/4/1][w:5]Мой ответ - [w:2]не[w:1]т.", "[func:DUB,phase1/4/2][func:Think][w:3]Взгляни вокруг.[w:14] \nТы[w:16] и я.[w:15] \nОдин[w:18] на один.", "[func:DUB,phase1/4/3][func:NoMercy1][w:4]Этот коридор[w:2] \nпропах[w:1] запахом \n[w:1]человеческой [w:1]крови.", "[func:DUB,phase1/4/4][w:5]На моих[w:1] руках[w:3] уже[w:2] \nесть [w:1]кровь людей. \n[w:10]Ты - [w:9]не первый [w:9]\nи[w:12] [waitall:1]не пос[w:1]лед[w:1]ний.", "[w:5][func:DUB,phase1/4/5][func:head]Но[w:2] только [w:1]ТЫ[w:3] \nпричинил [w:3]столько[w:1] \nболи!", "[func:DUB,phase1/4/6][w:1]И [w:2]это мой повод \nне [w:1]опускать руки." }
			neng={"My answer - [w:6]no.", "Look around.[w:6]\n[func:Think]It's only you \nand me now.[w:6] \nAnd METTA", "[func:NoMercy1]This corridor stinks \nwith the smell of \nhuman blood.", "My hands are dirty \nfrom their blood \nas well.[w:6] You [w:6]are \nnot the first \n[w:6]nor the last.", "[func:head]But only you \ncaused so much pain.", "And that's my reason \nto conquer once \nagain."}
			ruscom="Не забывай о своей миссии."
			engcom="Usally when she remembers, she gives up..."
			end
			wav={"imp/Reaction"}
			--end
		elseif GetGlobal("progress") == 5 then
			--if Encounter.GetVar("diff") == 18 then
			--	wav={"imp/stoplights"}
			--else
				--Encounter.Call("WriteSavio")
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"[func:NoMercy1]И знаешь,[w:3] что?", "[func:head]С меня хватит \nпритворства.", "[func:sad]Это ведь не \nвпервые?[w:6] \nЯ чувствую, [w:3]будто \nвсё повторяется \nраз за разом.", "[func:head4]Это не похоже на \nСбросы.[w:6] \[func:sad]Временная \nлиния остаётся \nвсё той же.", "[func:head4]Будто меняется[waitall:4][w:3]...[waitall:1][w:5]\n[func:Suprise1]Сам [w:3][waitall:3]мир.", "[func:NoMercy1]Это ведь[waitall:4][w:3]...[waitall:1][w:5] \n[func:head]Твоих рук дело?" }
			rus={"[func:NoMercy1][func:DUB,phase1/5/1][w:3]И знаешь, что?", "[func:head][func:DUB,phase1/5/2][w:2]С меня хватит \nпритворства.", "[func:sad][func:DUB,phase1/5/3][w:3]Это ведь не \nвпервые?[w:12] \nЯ чувствую, [w:1]будто \nвсё [w:1]повторяется \nраз[w:2] за разом.", "[func:DUB,phase1/5/4][func:head4][w:3]Это не похоже на \nСбросы.[w:9] \[func:sad]Временная [w:1]\nлиния остаётся \nвсё той же.", "[func:DUB,phase1/5/5][func:head4][w:3]Будто меняется[waitall:4][w:3]...[waitall:1][w:5]\n[func:Suprise1]Сам [w:5][waitall:1]мир.", "[func:NoMercy1][func:DUB,phase1/5/6][w:2]Это ведь[waitall:4][w:1]...[waitall:1][w:5] \n[func:head]Твоих [w:1]рук дело?" }
			neng={"[func:NoMercy1]And ya know what?", "[func:head]I am done with \nall this acting.", "[func:sad]It's not the first \ntime,[w:3]is it? [w:6]I feel \nlike everything is \nrepeating every time.", "[func:head4]It is not Resets.[w:6] [func:sad]\nThe timeline  is still \nthe same.", "[func:head4]It feels like[waitall:4][w:3]...[waitall:1][w:5] [func:Suprise1]the\nwhole [waitall:2]world [waitall:1][w:5]is \nchanging.", "[func:NoMercy1]It is your fault[waitall:4][w:3]...[waitall:1][w:5] [func:head]\nRight?"}
			ruscom="В её словах есть смысл."
			engcom="Why is this time different???"
			end
			wav={"imp/stoplights"}
			--end
		elseif GetGlobal("progress") == 6 then
			--if Encounter.GetVar("diff") == 18 then
			--	wav={"imp/NoMercyToYou"}
			--else
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"[func:sad]Ты тоже это \nчувствуешь[waitall:5]...", "[func:head4]Тем не менее[waitall:4]...[waitall:1][w:4] [func:NoMercy1]Есть\nкое-что важнее,[w:10]\nчем мои \nпредчувствия.", "[func:mercy]Ты ведь чувствуешь? [w:15]\n[waitall:2][func:head]Грехи,[waitall:1][w:5] что ползут \nпо твоей спине?"}
			rus={"[func:DUB,phase1/6/1][func:sad][w:4]Ты тоже это \nчувствуешь[waitall:5]...", "[func:head4][func:DUB,phase1/6/2][w:2]Тем не менее[waitall:4]...[waitall:1][w:2] [func:NoMercy1]Есть\n[speed:1.17]кое-что важнее,\nчем мои \nпредчувствия.", "[func:DUB,phase1/6/3][func:mercy][w:3]Ты ведь чувствуешь? [w:15]\n[func:head]Грехи,[w:2] что ползут[w:2] \nпо твоей[w:1] спине."}
			neng={"[func:sad]So you do feel \nthe same[waitall:4][w:3]...", "[func:head4]Nevertheless[waitall:4][w:3]...[waitall:1][w:4]\n[func:NoMercy1]There's something \nmore important than\nmy prejudgments.", "[func:mercy]Do you feel them?[w:15] [func:head]\n[waitall:2]Sins[waitall:1][w:5] on your back?"}
			ruscom="Нас не одурачить этой пугалкой."
			engcom="Does she know giving up is pointless... or-"
			end
			wav={"imp/NoMercyToYou"}
			--end
		elseif GetGlobal("progress") == 7 then
			--if Encounter.GetVar("diff") == 18 then
			--	wav={"imp/k_storm"}
			--else
			Encounter.Call("SetMusic", "devil")
			Player.hp=135
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"[func:NoMercy1]Так вот.[w:15] Мой тебе \nсовет [w:4]- не \nповорачивайся.", "[func:head]Иначе нож в ту же \nсекунду пронзит \nтвою глотку.", "Я не отпущу тебя \nбез достойной \nбитвы.[w:6] \nТы отплатишь за \nсвои грехи." }
			rus={"[func:NoMercy1][func:DUB,phase1/7(!!!)/1][w:9][speed:0.80]Так вот.[w:7] Мой тебе \nсовет [w:3]-[w:3] не \nповорачивайся.", "[func:head][func:DUB,phase1/7(!!!)/2][w:4][speed:0.80]Иначе нож в ту же \nсекунду пронзит \nтвою глотку.", "[func:DUB,phase1/7(!!!)/3][w:6][speed:1.05]Я не отпущу тебя \nбез достойной \nбитвы.[w:6][speed:0.85] \nТы [w:1]отпла[w:2]тишь[speed:1.05] за \nсвои [w:1]грехи." }
			neng={"[func:NoMercy1]So I have an advice \nfor ya.[w:6] \n[waitall:2]Do not turn around.", "[func:head]Because in that very \nmoment knife will \npierce your thin \nneck.", "I will not let you go \nwithout proper \nfight.[w:6] You will pay \nfor your actions."}
			ruscom="Ну,[w:3] этот совет был хорошим,[w:3] кажется."
			engcom="-,[w:3] does she know that,[w:3] we won`t stop killing her."
			end
			wav={"imp/k_storm"}
			--end
		elseif GetGlobal("progress") == 8 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"[func:sad]Кому я это говорю[waitall:4][w:3]...",  "[func:head4]Ты ведь не слышишь.[w:15] \n[func:sad]Не хочешь [w:5]или \nне можешь [w:5]- не \nважно.", "[func:Final_7]Полагаю[waitall:4][w:3]...[waitall:1][w:4] \n[func:NoMercy1]Мы оба знаем,[w:3] \n[func:head]что будет в конце."}
			rus={"[func:DUB,phase1/8/1][func:sad][w:4]Кому я это говорю[waitall:2].[w:4].[w:4].", "[func:DUB,phase1/8/2][func:head4][w:4][speed:1.17]Ты ведь[speed:1.26] не слы[w:1]шишь.[w:14] \n[func:sad][speed:1.17]Не хо[w:1]чешь [w:2]или \nне можешь [w:6]- [speed:1.25]не \nважно.", "[func:DUB,phase1/8/3][func:Final_7][w:2]Полагаю,[w:4] \n[func:NoMercy1]Мы[w:3][speed:1.17] оба знаем,[w:1] \n[func:head]что [speed:1.25]будет в конце."}
			neng={"[func:sad]Why do I even \nbother[waitall:4][w:3]...", "[func:head4]You don't listen.[w:15] [func:sad]\nDoesn't matter \nif you can't \n[w:6]or you don`t want to", "[func:Final_7]I guess[waitall:4][w:3]...[waitall:1][w:3] [func:NoMercy1]We both \nknow the [func:head]final act \nof our story."}
			ruscom="Осторожнее.[w:6] \nЧто-то с ней не так[waitall:4][w:3]..."
			engcom="Beware[waitall:4][w:3]...[waitall:1][w:3] \nShe is angry."
			end
			wav={"imp/warning"}
		elseif GetGlobal("progress") == 9 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"[func:head4]Ты думаешь, [w:3]что я \nнаивная[waitall:4][w:3]...[waitall:1][w:3]\nпредсказуемая и \nжалкая.", "[func:Look]Думаешь,[w:3] [func:Lookleft]что я \nвообразила из себя \nсудью,[w:3] \n[func:sad]хотя сама ничем \nне лучше тебя[waitall:4][w:3]...", "[func:head4]Может,[w:3] ты и прав.","[func:head][next]"}
			rus={"[func:DUB,phase1/9/1][func:NoMercy1][w:3]Ты думаешь, [w:2]что я \nнаивная,[w:7][speed:1.15]\nпредсказуемая[w:4] и \nжа[w:3]лкая.", "[func:DUB,phase1/9/2][func:Look][w:8]Думаешь,[w:9] [func:Lookleft]что я \nвообразила из себя \nсудью,[w:2] \n[func:sad]хотя сама ничем \nне лучше тебя[waitall:2][w:3]...", "[func:DUB,phase1/9/3][func:head4][w:5][speed:0.87]Может,[w:6] ты и прав.","[func:head][next]"}
			neng={"[func:head4]You think, I am \nnaive[waitall:4][w:3]...[waitall:1][w:3] predictable \nand pity.", "[func:Look]You think,[w:3] [func:Lookleft]I imagined \nmyself as some judge\nof you and [func:sad]still \nI am not better than \nyou[waitall:4][w:3]...", "[func:head4]Maybe,[w:3] you have a \npoint.","[func:head][next]"}
			ruscom="Конечно,[w:3] прав."
			engcom="Why is she,[w:3] saying the same speach?"
			end
			wav={"imp/BeFast"}
		elseif GetGlobal("progress") == 10 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"Но я не одинока.", "[func:DramaIn][func:head4]Точнее[waitall:4][w:4]...[waitall:1][w:3] была.[w:15]\nНо пусть их и нет \nсо мной[waitall:4][w:4]...", "[func:Final_3]Я чувствую их \nвнутри своей Души.", "[func:Final_4]Каждого,[w:3] кого я \nлюбила и уважала,[w:3]\nи они отвечали \nтем же[waitall:4][w:3]...", "[func:Peachy]Каждый из \nних [w:5]-[w:5] [func:mercy]моя \nсемья.", "[func:DramaOut][func:Peachy]Я многому у них \nнаучилась[waitall:4][w:4]...", "[noskip][func:NoMercy1]Например.[w:16] [speed:0.5][func:head]Этому.[w:30][next]"}
			rus={"[func:DUB,phase1/10/1][w:6][speed:0.75]Но я не [speed:0.8]одинока.", "[func:DUB,phase1/10/2][func:DramaIn][func:head4][w:6]Точнее[waitall:4][w:2]...[waitall:1][w:3] была.[w:15]\nНо пусть их и нет \nсо мной[waitall:4][w:4]...", "[func:DUB,phase1/10/3][func:Final_3][w:4]Я чувствую их \nвнутри своей Души.", "[func:DUB,phase1/10/4][func:Final_4][w:6]Ка[w:1]ждого,[w:1] кого я \nлюбила [w:1]и уважала,[w:9]\nи они отвечали[w:1] \nтем же[waitall:4][w:3]...", "[func:DUB,phase1/10/5][func:Peachy][w:6]Каждый из \nних [w:4]-[w:3] [func:mercy]моя[w:1] \nсемья.", "[func:DUB,phase1/10/6][func:DramaOut][func:Peachy][w:5]Я многому у них \nнаучилась[waitall:4][w:4]...", "[func:DUB,phase1/10/7][noskip][func:NoMercy1][w:6][speed:0.75]Например.[w:20] [speed:0.7][func:head]Э[w:1]тому.[w:30][next]"}
			if Encounter.GetVar("dialogSkip") == true then
				neng={"But I'm not alone.", "[func:DramaIn][func:head4]Well[waitall:4][w:4]...[waitall:1][w:3] I was[waitall:4][w:4]...[waitall:1][w:15] \nBut even if they are \nnot beside me now[waitall:4][w:4]...", "[func:Final_4]I feel them inside \nmy very soul.", "[func:head4]I feel everyone I \nloved and respected", "[func:Peachy]Every one of them[w:9] [func:mercy]\nis my family.", "[func:DramaOut][func:Peachy]I learned a lot from \nthem.", "[func:NoMercy1]For example. [w:15][func:head][waitall:2]This.[w:30][next]"}
			else
				neng={"But I'm not alone.", "[func:DramaIn][func:head4]Well[waitall:4][w:4]...[waitall:1][w:3] I was[waitall:4][w:4]...[waitall:1][w:15] \nBut even if they are \nnot beside me now[waitall:4][w:4]...", "[func:Final_4]I feel them inside \nmy very soul.", "[func:head4]I feel everyone I \nloved and respected", "[func:Peachy]Every one of them[w:9] [func:mercy]\nis my family.", "[func:DramaOut][func:Peachy]I learned a lot from \nthem.", "[noskip][func:NoMercy1]For example. [w:15][func:head][waitall:2]This.[w:30][next]"}
			end
			ruscom="Ну конечно,[w:3] сила любви.[w:6]\nКак я раньше не понял."
			engcom="..."
					--Encounter.SetVar("wavetime",11)
			end
			wav={"imp/bones0"}
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
				Encounter.SetVar("evadelevel",2)
			end
		elseif GetGlobal("progress") == 11 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			Encounter.Call("SetMusic", "last")
			Player.hp=135
			nrus={"[func:Peachy]Понимаешь,[w:3][func:mercy] я ещё \nне совсем привыкла \nк этой[waitall:4][w:3]...[waitall:1][w:3] силе.", "[func:Remember]Моя решимость \nрезонирует внутри \nмоей души[waitall:4][w:3]...", "[func:Peachy]Я чувствую,[w:3] как \nони[waitall:4][w:3]...[waitall:1][w:3] [func:Remember]поддерживают \nменя. \n[w:6]Заботятся обо мне.", "[func:Peachy]И их сила[waitall:4][w:3]...[waitall:1][w:3] \n[func:mercy]Передалась мне.", "[func:NoMercy1]Ну что?[w:9] [func:head]Готов \nко второму раунду?"}
			rus={"[func:Peachy][func:DUB,phase1/11/1][w:7][speed:1.10]Понимаешь,[speed:1.00][w:3][func:mercy] я ещё \nне [speed:1.20]совсем привыкла \nк [speed:1.00]этой[w:3].[w:3].[w:2].[w:2] [speed:0.80]силе.", "[func:DUB,phase1/11/2][func:Remember][w:3]Моя решимость \nрезонирует внутри \nмоей души[waitall:4][w:3]..", "[func:DUB,phase1/11/3][func:Peachy][w:4][speed:1.20]Я чувствую,[w:2] как \nони[w:1].[w:3].[w:3].[w:3] [func:Remember][speed:0.90]поддерживают \nменя. \n[w:7]Заботятся обо мне.", "[func:DUB,phase1/11/4][func:Peachy][w:3]Их сила[waitall:3][w:3]...[waitall:1][w:4][speed:0.88] \n[func:mercy]Передалась [w:1]мне.", "[func:DUB,phase1/11/5][func:NoMercy1][w:4]Ну[w:2] что?[w:9] [func:head][speed:1.10]Готов \nко второму раунду?[w:9]"}
			neng={"[func:Peachy]Sorry,[w:3] [func:mercy]I am \ngetting better with this[waitall:4][w:3]...[waitall:1][w:3] \npower.", "[func:Remember]My Determination \nresonates \nwithin my soul[waitall:4][w:3]...[waitall:1]", "[func:Peachy]It feels like[waitall:4][w:3]...[waitall:1][w:3] [func:Remember]they \ncheer for me.[w:6] \nCare about me.", "[func:Peachy]And their power[waitall:4][w:3]...[waitall:1][w:3] [func:mercy]\nIs now mine.", "[func:NoMercy1]So? [w:9][func:head]Are you ready \nfor the round two?"}
			ruscom="Она адаптируется к новым силам.[w:6]\nУ нас всё меньше времени,[w:3] \rдорогой актер."
			engcom="She already is familiar with these powers"
			end
			wav={"imp/bullettest_touhou"}
			--Encounter.SetVar("wavetimer", 13.0)
		elseif GetGlobal("progress") == 12 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"[func:head4]Эта сила[waitall:4][w:3]...", "[func:Final_5]Я будто слышу в \nушах его голос[waitall:4][w:3]...", "[func:Peachy]Такой родной\nи близкий[waitall:4][w:3]...", "Папайрус[waitall:5]...", "[waitall:4][w:3]...", "[func:mercy]Да,[w:3] я совсем забыла \nпро тебя,[w:3] извини.", "[func:NoMercy1]Итак,[w:6][func:head] на чем мы \nостановились?"}
			rus={"[func:head4][func:DUB,phase1/12/1][w:5][speed:0.85]Эта сила[waitall:4][w:3]...", "[func:Final_5][func:DUB,phase1/12/2][w:3]Я будто слышу в \nушах [speed:1.10]его [w:1]го[w:1]лос[waitall:4][w:3]...", "[func:Peachy][func:DUB,phase1/12/3][w:4][speed:0.76]Такой родной[waitall:4][w:1]...[waitall:1][w:1][speed:1.10]\nИ близкий[waitall:4][w:3]...", "[func:DUB,phase1/12/4][w:3][speed:0.74]Папайрус[waitall:5]...", "[waitall:4][w:3]...", "[func:DUB,phase1/12/5][func:mercy][w:4]Да,[w:15] я[w:3] совсем забыла \nпро тебя,[w:3] извини.", "[func:DUB,phase1/12/6][func:NoMercy1][speed:0.90][w:5]И[w:1]так,[w:6][func:head] на чем мы \nостановились?"}
			neng={"[func:head4]This power[waitall:4][w:3]...", "[func:Final_5]I felt like I heared \nhis voice in my \nhead[waitall:4][w:3]...", "[func:Peachy]So close and caring[waitall:4][w:3]...", "Papyrus[waitall:4][w:3]...", "[waitall:4][w:3]...", "[func:mercy]Yeah,[w:3] I almost forgot \nabout you,[w:3] no \noffensive.", "[func:NoMercy1]So,[w:6] [func:head]shall we \nproceed?"}
			ruscom="Мне не нравится новый вектор \rбитвы.[w:6]\nОна стала сильнее."
			engcom="I don't like this new fight \rvector.[w:6] She became way too powerful."
			end
			wav={"imp/bones1"}
			--Encounter.SetVar("wavetimer", 13.0)
		elseif GetGlobal("progress") == 13 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"[func:head4]Он так заботился \nо тебе[waitall:4][w:3]...", "[func:sad]Папайрус глупо \nпросил меня обещать \nему,[w:3] \nчто я не трону \nтебя.", "[func:head4]Ты был ему \nкак брат[waitall:4][w:3]...", "[func:NoMercy1][waitall:4][w:3]...", "Почему мне должно \nбыть стыдно,[w:3][func:mercy] что \nя не сдержала \nклятву?"}
			rus={"[func:head4][func:DUB,phase1/13/1][w:5]Он[w:4][speed:0.92] так заботился \nо тебе[waitall:4][w:3]...", "[func:sad][func:head4][func:DUB,phase1/13/2][w:5]Папайрус глупо \nпросил меня обещать \nему,[w:3] \nчто я не трону \nтебя.", "[func:head4][func:head4][func:DUB,phase1/13/3][w:4]Ты был ему \nкак [w:1]брат[waitall:4][w:3]...", "[waitall:4][w:3]...", "[func:NoMercy1][func:DUB,phase1/13/4][w:5][speed:1.14]Почему мне должно \nбыть[func:head] стыдно, что \nя не сдержала \nклятву?"}
			neng={"[func:head4]He cared about you \nso much...", "[func:sad]Papyrus forced me \nto give an oath to \nnot hurt you.", "[func:head4]You was like brother \nto him...", "...", "How can[waitall:4][w:3]...[waitall:1][w:3] [func:head]How can I \nbe sorry for \nbreaking this oath?"}
			ruscom="У меня одного кости болят?"
			engcom="KILL HER ALREADY!"
					--Encounter.SetVar("wavetime",10.5)
			end
			wav={"imp/bullettest_chaseorb"}
		elseif GetGlobal("progress") == 14 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"[func:Think]Даже в пылу боя,[w:3] \nон заботился о \nтебе[waitall:4][w:3]...", "[func:head]Я не буду такой \nдоброй,[w:3] не смотри \nна меня.", "[func:head4]Мне так не хватает \nразговоров с ним \nу двери[waitall:4][w:3]...", "Когда я увидела,[w:3] \nчто от двери \nостался лишь \nщебень,[w:3] я поняла,[w:3] \nчто настал [waitall:2][w:2]конец.", "Конец всему[waitall:4][w:3]...[waitall:1][w:3] \n[func:head]Что я любила."}
			rus={"[func:Think][func:DUB,phase1/14/1][w:4][speed:0.87]Даже в пылу[w:1] боя,[w:8] \nон заботился[w:1] о \nтебе[waitall:4][w:3]...", "[func:head][func:DUB,phase1/14/2][w:4]Я[w:2][speed:1.04] не буду такой[speed:1.25] \nдоброй,[w:4][speed:1.04] не смотри \nна меня.", "[func:head4][func:DUB,phase1/14/3][w:5]Мне[w:6] так не хватает \nразговоров[speed:1.25] с ним \nу двери[waitall:4][w:3]...", "[func:DUB,phase1/14/4][w:4][speed:1.15]Когда я увидела, \nчто[w:4] от двери[speed:1.00] \nостался лишь \nщебень,[w:8] я поняла,[w:3] \nчто настал [w:3]ко[w:1]нец.", "[func:DUB,phase1/14/5][w:5][speed:0.80]Конец всему[waitall:2]...[waitall:1][w:3] \n[func:head]Что я [w:1]любила."}
			neng={"[func:Think]Even in the battle \ntendency he cared \nabout you[waitall:4][w:3]...", "[func:head]I won't be so \ngood,[w:3] don't even \ndream.", "[func:head4]I miss so much talking \nto him through the \ndoor[waitall:4][w:3]...", "When I saw ashes \nthat were left \nfrom it,[w:3] I got that \nthis is the [waitall:2][w:2]end.", "[waitall:2][w:1]End [waitall:1][w:9]for everything [func:head]\nI love."}
			ruscom="Чара кажется отчаявшейся."
			engcom="ACTOR!\nSTRIKE WHERE SHE WILL DODGE TO!"
			end
			wav={"imp/bones2"}
		elseif GetGlobal("progress") == 15 then
			Player.hp=135
			Encounter.Call("SetMusic", "lost")
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"[func:Final_1]Казалось,[w:3] будто я \nувидела в твоих \nглазах раскаяние[waitall:4][w:3]...", "[noskip][func:QuietMusic][func:Final_5]Лишь на миг,[w:3] но[waitall:4][w:3]...", "Милое зеркальце.[w:9] \nПартнёр.[w:9] \nКомпаньон.", "[func:Final_5]Если ты[waitall:4][w:3]...[waitall:1][w:3] \nЕсли ты слышишь[waitall:4][w:3]...", "[func:Music,spare]Я[waitall:4][w:3]...[waitall:1][w:3][func:Final_1] [func:HideKnife]Я хочу дать \nтебе шанс[waitall:4][w:3]...", "[func:head4]Но если нет[waitall:4][w:3]...[waitall:1][w:3] \nЕсли я ошибаюсь[waitall:4][w:3]...", "[waitall:4][w:3]...", "[func:Final_7]То тогда я \nдействительно \nдура[waitall:4][w:3]...","[func:Peachy][w:10][func:mercy][next]"}
			rus={"[func:Final_1][func:DUB,phase1/26/1][w:5]Казалось,[w:3] будто я \nувидела в [speed:1.10]твоих \nглазах раска[w:2][speed:0.80]яние[waitall:4][w:3]...", "[noskip][func:QuietMusic][func:Final_5][func:DUB,phase1/26/2][w:5]Лишь на миг,[w:3] но[waitall:4][w:3]...", "[func:DUB,phase1/26/3][w:6]М[w:1]илое зеркальце.[w:9][speed:0.90] \nПартнёр.[w:11][speed:0.80] \nКомпаньон.", "[func:Final_5][func:DUB,phase1/26/4][w:5][speed:0.90]Если ты[waitall:4][w:3]...[waitall:1][w:3] \nЕсли ты слы[w:2]шишь[waitall:4][w:3]...", "[func:Music,spare][func:DUB,phase1/26/5][w:5]Я[waitall:4][w:3]...[waitall:1][w:7][func:Final_1] [func:HideKnife]Я хочу дать \nтебе шанс[waitall:4][w:3]...", "[func:head4][func:DUB,phase1/26/6][w:5][speed:0.80]Но если нет[waitall:3][w:2]...[waitall:1][w:1][speed:0.74] \nЕсли я ошиба[w:1]юсь[waitall:4][w:3]...", "[waitall:4][w:3]...", "[func:Final_7][func:DUB,phase1/26/7][w:4]То тогда я[speed:1.25] \nдействительно [speed:1.40]\nдура[waitall:4][w:3]...","[func:Peachy][w:10][func:mercy][next]"}
			neng={"[func:Final_1]Let`s stop all this pointless chit chat.[next]"}
			engcom="[color:8040ff]I get it, you don`t know what to do\nbecause you don`t have a script, but kill her already!"
			ruscom="Чара даёт вам второй шанс. \n[w:10][speed:0.75][color:8040ff]Даже не смей, дорогуша..."
			end
			wav={"imp/Death"}
			Encounter.SetVar("deadlyhit",true)
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
				Encounter.SetVar("forcedfight",true)
				Encounter.SetVar("FightGoes",false)
			end
		elseif GetGlobal("progress") >= 16 then
			Player.hp=135
			wav= {"laststand3"}
			Encounter.SetVar("arenasize", {155, 130})
			--Encounter.SetVar("CharaIsRaging",false)
		end
	elseif diff == 20 then
		Encounter.SetVar("CharaIsRaging",true)
		if GetGlobal("progress") == 1 then
			Encounter.SetVar("evadelevel",1)
			--if Encounter.GetVar("diff") == 18 then
			--	wav={"phase3/k_5_new"}
			--else
			if Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare")  then
				neng={'"Did she dodge?",[w:3]\n right?', "[func:NoMercy1]Look,[w:3] you're not \nmy prince,[w:3] \nand I'm not \nyour princess.", "[func:Bad]I can protect \nmyself." ,"[func:head][next]"}
				rus={'[func:DUB,phase1/1/1][w:6]"Как она[w:1] \nувернулась?", \n[w:9]верно?', "[func:DUB,phase1/1/2][func:NoMercy1][w:4]Послушай,[w:3] ты же \nне принц,[w:4] а я \nне твоя принцесса.", "[func:DUB,phase1/1/3][func:Bad][w:3]Я умею за себя \nпостоять.","[func:head][next]"}
				nrus={'"Как она \nувернулась?", \n[w:3]верно?', "[func:NoMercy1]Послушай,[w:3] ты же \nне принц,[w:3] а я \nне твоя принцесса.", "[func:Bad]Я умею за себя \nпостоять.","[func:head][next]"}
				ruscom="Настало время для первого акта."
				engcom="Something feels off"
			end
				wav={"phase3/k_5_new"}
			--end
		elseif GetGlobal("progress") == 2 then
			--if Encounter.GetVar("diff") == 18 then
			--	wav={"phase3/rain"}
			--else
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
				nrus={"[func:NoMercy1]Позволь задать \nтебе вопрос.", "Ты серьёзно \nдумаешь,[w:3] \n[func:head]что я настолько \nглупа?" }
				neng={"[func:NoMercy1]Let me ask \nyou a question.", "Who do you think \nI am [func:head]to be \nso forgetful?"  }
				rus={"[func:DUB,phase1/2/1][func:NoMercy1][w:2]Позволь задать \nтебе вопрос.", "[func:DUB,phase1/2/2][w:3]Ты серьёзно \nдумаешь,[w:2] \n[func:head]что я настолько \nглупа?" }
				ruscom="Вопрос с подвохом?"
				engcom="What did she just say?!?"
			end
				wav={"phase3/rain"}
			--end
		elseif GetGlobal("progress") == 3 then
			--if Encounter.GetVar("diff") == 18 then
			--	wav={"phase3/random"}
			--else
			Encounter.Call("SetMusic","wound")
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
				nrus={"[func:NoMercy1][waitall:2]Всё,[waitall:1] [w:3]что ты \nнатворил на \nпути сюда[waitall:5][w:3]...[waitall:1][w:5]\nВся эта кровь \nна твоих руках[waitall:5][w:3]...", "Разве я настолько \nдура,[w:3] \n[func:head]чтобы верить тебе?" }
				rus={"[func:DUB,phase1/3/1][func:NoMercy1][waitall:1][w:3]Всё,[waitall:1] что ты \nнатворил на \nпути сюда[waitall:3][w:3]...[waitall:1][w:5]\nВся эта кровь \nна твоих руках[waitall:5][w:3]...", "[func:DUB,phase1/3/2][w:3]Разве я[w:1] настолько[w:2] \nдура,[w:4] \n[func:head]чтобы верить [w:2]тебе?" }
				neng={"[func:NoMercy1][speed:0.55]Everything [speed:1][w:3]you \nhave done on \nyour way there[waitall:5][w:3]...[waitall:1][w:5] \nAll this dust on \nyour hands[waitall:5][w:3]...", "And killing me... \n[func:head] hundreds of times" }
				ruscom="Чара истерично хихикает."
				engcom="SHE REMEMBERS!?!"
			end
				wav={"phase3/random"}
			--end
		elseif GetGlobal("progress") == 4 then
			--if Encounter.GetVar("diff") == 18 then
			--	wav={"phase3/Reaction"}
			--else

			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"Мой ответ - [w:6][waitall:2]нет.", "[func:Think]Взгляни вокруг.[w:6] \nТы и я.[w:6] \nОдин на один.", "[func:NoMercy1]Этот коридор \nпропах запахом \nчеловеческой крови.", "На моих руках уже \nесть кровь людей. \n[w:6]Ты - [w:6]не первый [w:6]\nи не последний.", "[func:head]Но только ты \nпричинил столько \nболи.", "И это мой повод \nне опускать руки." }
			rus={"[func:DUB,phase1/4/1][w:5]Мой ответ - [w:2]не[w:1]т.", "[func:DUB,phase1/4/2][func:Think][w:3]Взгляни вокруг.[w:14] \nТы[w:16] и я.[w:15] \nОдин[w:18] на один.", "[func:DUB,phase1/4/3][func:NoMercy1][w:4]Этот коридор[w:2] \nпропах[w:1] запахом \n[w:1]человеческой [w:1]крови.", "[func:DUB,phase1/4/4][w:5]На моих[w:1] руках[w:3] уже[w:2] \nесть [w:1]кровь людей. \n[w:10]Ты - [w:9]не первый [w:9]\nи[w:12] [waitall:1]не пос[w:1]лед[w:1]ний.", "[w:5][func:DUB,phase1/4/5][func:head]Но[w:2] только [w:1]ТЫ[w:3] \nпричинил [w:3]столько[w:1] \nболи!", "[func:DUB,phase1/4/6][w:1]И [w:2]это мой повод \nне [w:1]опускать руки." }
			neng={"My answer - [w:6]no.", "Look around.[w:6]\n[func:Think]It's only you \nand me now.[w:6] \nAnd METTA", "[func:NoMercy1]This corridor stinks \nwith the smell of \nhuman blood.", "My hands are dirty \nfrom their blood \nas well.[w:6] You [w:6]are \nnot the first \n[w:6]nor the last.", "[func:head]But only you \ncaused so much pain.", "And that's my reason \nto conquer once \nagain."}
			ruscom="Не забывай о своей миссии."
			engcom="Usally when she remembers, she gives up..."
			end
			wav={"phase3/Reaction"}
			--end
		elseif GetGlobal("progress") == 5 then
			--if Encounter.GetVar("diff") == 18 then
			--	wav={"phase3/stoplights"}
			--else
				--Encounter.Call("WriteSavio")
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"[func:NoMercy1]И знаешь,[w:3] что?", "[func:head]С меня хватит \nпритворства.", "[func:sad]Это ведь не \nвпервые?[w:6] \nЯ чувствую, [w:3]будто \nвсё повторяется \nраз за разом.", "[func:head4]Это не похоже на \nСбросы.[w:6] \[func:sad]Временная \nлиния остаётся \nвсё той же.", "[func:head4]Будто меняется[waitall:4][w:3]...[waitall:1][w:5]\n[func:Suprise1]Сам [w:3][waitall:3]мир.", "[func:NoMercy1]Это ведь[waitall:4][w:3]...[waitall:1][w:5] \n[func:head]Твоих рук дело?" }
			rus={"[func:NoMercy1][func:DUB,phase1/5/1][w:3]И знаешь, что?", "[func:head][func:DUB,phase1/5/2][w:2]С меня хватит \nпритворства.", "[func:sad][func:DUB,phase1/5/3][w:3]Это ведь не \nвпервые?[w:12] \nЯ чувствую, [w:1]будто \nвсё [w:1]повторяется \nраз[w:2] за разом.", "[func:DUB,phase1/5/4][func:head4][w:3]Это не похоже на \nСбросы.[w:9] \[func:sad]Временная [w:1]\nлиния остаётся \nвсё той же.", "[func:DUB,phase1/5/5][func:head4][w:3]Будто меняется[waitall:4][w:3]...[waitall:1][w:5]\n[func:Suprise1]Сам [w:5][waitall:1]мир.", "[func:NoMercy1][func:DUB,phase1/5/6][w:2]Это ведь[waitall:4][w:1]...[waitall:1][w:5] \n[func:head]Твоих [w:1]рук дело?" }
			neng={"[func:NoMercy1]And ya know what?", "[func:head]I am done with \nall this acting.", "[func:sad]It's not the first \ntime,[w:3]is it? [w:6]I feel \nlike everything is \nrepeating every time.", "[func:head4]It is not Resets.[w:6] [func:sad]\nThe timeline  is still \nthe same.", "[func:head4]It feels like[waitall:4][w:3]...[waitall:1][w:5] [func:Suprise1]the\nwhole [waitall:2]world [waitall:1][w:5]is \nchanging.", "[func:NoMercy1]It is your fault[waitall:4][w:3]...[waitall:1][w:5] [func:head]\nRight?"}
			ruscom="В её словах есть смысл."
			engcom="Why is this time different???"
			end
			wav={"phase3/stoplights"}
			--end
		elseif GetGlobal("progress") == 6 then
			--if Encounter.GetVar("diff") == 18 then
			--	wav={"phase3/NoMercyToYou"}
			--else
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"[func:sad]Ты тоже это \nчувствуешь[waitall:5]...", "[func:head4]Тем не менее[waitall:4]...[waitall:1][w:4] [func:NoMercy1]Есть\nкое-что важнее,[w:10]\nчем мои \nпредчувствия.", "[func:mercy]Ты ведь чувствуешь? [w:15]\n[waitall:2][func:head]Грехи,[waitall:1][w:5] что ползут \nпо твоей спине?"}
			rus={"[func:DUB,phase1/6/1][func:sad][w:4]Ты тоже это \nчувствуешь[waitall:5]...", "[func:head4][func:DUB,phase1/6/2][w:2]Тем не менее[waitall:4]...[waitall:1][w:2] [func:NoMercy1]Есть\n[speed:1.17]кое-что важнее,\nчем мои \nпредчувствия.", "[func:DUB,phase1/6/3][func:mercy][w:3]Ты ведь чувствуешь? [w:15]\n[func:head]Грехи,[w:2] что ползут[w:2] \nпо твоей[w:1] спине."}
			neng={"[func:sad]So you do feel \nthe same[waitall:4][w:3]...", "[func:head4]Nevertheless[waitall:4][w:3]...[waitall:1][w:4]\n[func:NoMercy1]There's something \nmore important than\nmy prejudgments.", "[func:mercy]Do you feel them?[w:15] [func:head]\n[waitall:2]Sins[waitall:1][w:5] on your back?"}
			ruscom="Нас не одурачить этой пугалкой."
			engcom="Does she know giving up is pointless... or-"
			end
			wav={"phase3/NoMercyToYou"}
			--end
		elseif GetGlobal("progress") == 7 then
			--if Encounter.GetVar("diff") == 18 then
			--	wav={"phase3/k_storm"}
			--else
			Encounter.Call("SetMusic", "devil")
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"[func:NoMercy1]Так вот.[w:15] Мой тебе \nсовет [w:4]- не \nповорачивайся.", "[func:head]Иначе нож в ту же \nсекунду пронзит \nтвою глотку.", "Я не отпущу тебя \nбез достойной \nбитвы.[w:6] \nТы отплатишь за \nсвои грехи." }
			rus={"[func:NoMercy1][func:DUB,phase1/7(!!!)/1][w:9][speed:0.80]Так вот.[w:7] Мой тебе \nсовет [w:3]-[w:3] не \nповорачивайся.", "[func:head][func:DUB,phase1/7(!!!)/2][w:4][speed:0.80]Иначе нож в ту же \nсекунду пронзит \nтвою глотку.", "[func:DUB,phase1/7(!!!)/3][w:6][speed:1.05]Я не отпущу тебя \nбез достойной \nбитвы.[w:6][speed:0.85] \nТы [w:1]отпла[w:2]тишь[speed:1.05] за \nсвои [w:1]грехи." }
			neng={"[func:NoMercy1]So I have an advice \nfor ya.[w:6] \n[waitall:2]Do not turn around.", "[func:head]Because in that very \nmoment knife will \npierce your thin \nneck.", "I will not let you go \nwithout proper \nfight.[w:6] You will pay \nfor your actions."}
			ruscom="Ну,[w:3] этот совет был хорошим,[w:3] кажется."
			engcom="-,[w:3] does she know that,[w:3] we won`t stop killing her."
			end
			wav={"phase3/k_storm"}
			--end
		elseif GetGlobal("progress") == 8 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"[func:sad]Кому я это говорю[waitall:4][w:3]...",  "[func:head4]Ты ведь не слышишь.[w:15] \n[func:sad]Не хочешь [w:5]или \nне можешь [w:5]- не \nважно.", "[func:Final_7]Полагаю[waitall:4][w:3]...[waitall:1][w:4] \n[func:NoMercy1]Мы оба знаем,[w:3] \n[func:head]что будет в конце."}
			rus={"[func:DUB,phase1/8/1][func:sad][w:4]Кому я это говорю[waitall:2].[w:4].[w:4].", "[func:DUB,phase1/8/2][func:head4][w:4][speed:1.17]Ты ведь[speed:1.26] не слы[w:1]шишь.[w:14] \n[func:sad][speed:1.17]Не хо[w:1]чешь [w:2]или \nне можешь [w:6]- [speed:1.25]не \nважно.", "[func:DUB,phase1/8/3][func:Final_7][w:2]Полагаю,[w:4] \n[func:NoMercy1]Мы[w:3][speed:1.17] оба знаем,[w:1] \n[func:head]что [speed:1.25]будет в конце."}
			neng={"[func:sad]Why do I even \nbother[waitall:4][w:3]...", "[func:head4]You don't listen.[w:15] [func:sad]\nDoesn't matter \nif you can't \n[w:6]or you don`t want to", "[func:Final_7]I guess[waitall:4][w:3]...[waitall:1][w:3] [func:NoMercy1]We both \nknow the [func:head]final act \nof our story."}
			ruscom="Осторожнее.[w:6] \nЧто-то с ней не так[waitall:4][w:3]..."
			engcom="Beware[waitall:4][w:3]...[waitall:1][w:3] \nShe is angry."
			end
			wav={"phase3/warning"}
		elseif GetGlobal("progress") == 9 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"[func:head4]Ты думаешь, [w:3]что я \nнаивная[waitall:4][w:3]...[waitall:1][w:3]\nпредсказуемая и \nжалкая.", "[func:Look]Думаешь,[w:3] [func:Lookleft]что я \nвообразила из себя \nсудью,[w:3] \n[func:sad]хотя сама ничем \nне лучше тебя[waitall:4][w:3]...", "[func:head4]Может,[w:3] ты и прав.","[func:head][next]"}
			rus={"[func:DUB,phase1/9/1][func:NoMercy1][w:3]Ты думаешь, [w:2]что я \nнаивная,[w:7][speed:1.15]\nпредсказуемая[w:4] и \nжа[w:3]лкая.", "[func:DUB,phase1/9/2][func:Look][w:8]Думаешь,[w:9] [func:Lookleft]что я \nвообразила из себя \nсудью,[w:2] \n[func:sad]хотя сама ничем \nне лучше тебя[waitall:2][w:3]...", "[func:DUB,phase1/9/3][func:head4][w:5][speed:0.87]Может,[w:6] ты и прав.","[func:head][next]"}
			neng={"[func:head4]You think, I am \nnaive[waitall:4][w:3]...[waitall:1][w:3] predictable \nand pity.", "[func:Look]You think,[w:3] [func:Lookleft]I imagined \nmyself as some judge\nof you and [func:sad]still \nI am not better than \nyou[waitall:4][w:3]...", "[func:head4]Maybe,[w:3] you have a \npoint.","[func:head][next]"}
			ruscom="Конечно,[w:3] прав."
			engcom="Why is she,[w:3] saying the same speach?"
			end
			wav={"phase3/BeFast"}
		elseif GetGlobal("progress") == 10 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"Но я не одинока.", "[func:DramaIn][func:head4]Точнее[waitall:4][w:4]...[waitall:1][w:3] была.[w:15]\nНо пусть их и нет \nсо мной[waitall:4][w:4]...", "[func:Final_3]Я чувствую их \nвнутри своей Души.", "[func:Final_4]Каждого,[w:3] кого я \nлюбила и уважала,[w:3]\nи они отвечали \nтем же[waitall:4][w:3]...", "[func:Peachy]Каждый из \nних [w:5]-[w:5] [func:mercy]моя \nсемья.", "[func:DramaOut][func:Peachy]Я многому у них \nнаучилась[waitall:4][w:4]...", "[noskip][func:NoMercy1]Например.[w:16] [speed:0.5][func:head]Этому.[w:30][next]"}
			rus={"[func:DUB,phase1/10/1][w:6][speed:0.75]Но я не [speed:0.8]одинока.", "[func:DUB,phase1/10/2][func:DramaIn][func:head4][w:6]Точнее[waitall:4][w:2]...[waitall:1][w:3] была.[w:15]\nНо пусть их и нет \nсо мной[waitall:4][w:4]...", "[func:DUB,phase1/10/3][func:Final_3][w:4]Я чувствую их \nвнутри своей Души.", "[func:DUB,phase1/10/4][func:Final_4][w:6]Ка[w:1]ждого,[w:1] кого я \nлюбила [w:1]и уважала,[w:9]\nи они отвечали[w:1] \nтем же[waitall:4][w:3]...", "[func:DUB,phase1/10/5][func:Peachy][w:6]Каждый из \nних [w:4]-[w:3] [func:mercy]моя[w:1] \nсемья.", "[func:DUB,phase1/10/6][func:DramaOut][func:Peachy][w:5]Я многому у них \nнаучилась[waitall:4][w:4]...", "[func:DUB,phase1/10/7][noskip][func:NoMercy1][w:6][speed:0.75]Например.[w:20] [speed:0.7][func:head]Э[w:1]тому.[w:30][next]"}
			neng={"But I'm not alone.", "[func:DramaIn][func:head4]Well[waitall:4][w:4]...[waitall:1][w:3] I was[waitall:4][w:4]...[waitall:1][w:15] \nBut even if they are \nnot beside me now[waitall:4][w:4]...", "[func:Final_4]I feel them inside \nmy very soul.", "[func:head4]I feel everyone I \nloved and respected", "[func:Peachy]Every one of them[w:9] [func:mercy]\nis my family.", "[func:DramaOut][func:Peachy]I learned a lot from \nthem.", "[noskip][func:NoMercy1]For example. [w:15][func:head][waitall:2]This.[w:30][next]"}
			ruscom="Ну конечно,[w:3] сила любви.[w:6]\nКак я раньше не понял."
			engcom="..."
					--Encounter.SetVar("wavetime",11)
			end
			wav={"phase3/bones0"}
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
				Encounter.SetVar("evadelevel",2)
			end
		elseif GetGlobal("progress") == 11 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			Encounter.Call("SetMusic", "last")
			nrus={"[func:Peachy]Понимаешь,[w:3][func:mercy] я ещё \nне совсем привыкла \nк этой[waitall:4][w:3]...[waitall:1][w:3] силе.", "[func:Remember]Моя решимость \nрезонирует внутри \nмоей души[waitall:4][w:3]...", "[func:Peachy]Я чувствую,[w:3] как \nони[waitall:4][w:3]...[waitall:1][w:3] [func:Remember]поддерживают \nменя. \n[w:6]Заботятся обо мне.", "[func:Peachy]И их сила[waitall:4][w:3]...[waitall:1][w:3] \n[func:mercy]Передалась мне.", "[func:NoMercy1]Ну что?[w:9] [func:head]Готов \nко второму раунду?"}
			rus={"[func:Peachy][func:DUB,phase1/11/1][w:7][speed:1.10]Понимаешь,[speed:1.00][w:3][func:mercy] я ещё \nне [speed:1.20]совсем привыкла \nк [speed:1.00]этой[w:3].[w:3].[w:2].[w:2] [speed:0.80]силе.", "[func:DUB,phase1/11/2][func:Remember][w:3]Моя решимость \nрезонирует внутри \nмоей души[waitall:4][w:3]..", "[func:DUB,phase1/11/3][func:Peachy][w:4][speed:1.20]Я чувствую,[w:2] как \nони[w:1].[w:3].[w:3].[w:3] [func:Remember][speed:0.90]поддерживают \nменя. \n[w:7]Заботятся обо мне.", "[func:DUB,phase1/11/4][func:Peachy][w:3]Их сила[waitall:3][w:3]...[waitall:1][w:4][speed:0.88] \n[func:mercy]Передалась [w:1]мне.", "[func:DUB,phase1/11/5][func:NoMercy1][w:4]Ну[w:2] что?[w:9] [func:head][speed:1.10]Готов \nко второму раунду?[w:9]"}
			neng={"[func:Peachy]Sorry,[w:3] [func:mercy]I am \ngetting better with this[waitall:4][w:3]...[waitall:1][w:3] \npower.", "[func:Remember]My Determination \nresonates \nwithin my soul[waitall:4][w:3]...[waitall:1]", "[func:Peachy]It feels like[waitall:4][w:3]...[waitall:1][w:3] [func:Remember]they \ncheer for me.[w:6] \nCare about me.", "[func:Peachy]And their power[waitall:4][w:3]...[waitall:1][w:3] [func:mercy]\nIs now mine.", "[func:NoMercy1]So? [w:9][func:head]Are you ready \nfor the round two?"}
			ruscom="Она адаптируется к новым силам.[w:6]\nУ нас всё меньше времени,[w:3] \rдорогой актер."
			engcom="She already is familiar with these powers"
			end
			wav={"phase3/bullettest_touhou"}
			--Encounter.SetVar("wavetimer", 13.0)
		elseif GetGlobal("progress") == 12 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"[func:head4]Эта сила[waitall:4][w:3]...", "[func:Final_5]Я будто слышу в \nушах его голос[waitall:4][w:3]...", "[func:Peachy]Такой родной\nи близкий[waitall:4][w:3]...", "Папайрус[waitall:5]...", "[waitall:4][w:3]...", "[func:mercy]Да,[w:3] я совсем забыла \nпро тебя,[w:3] извини.", "[func:NoMercy1]Итак,[w:6][func:head] на чем мы \nостановились?"}
			rus={"[func:head4][func:DUB,phase1/12/1][w:5][speed:0.85]Эта сила[waitall:4][w:3]...", "[func:Final_5][func:DUB,phase1/12/2][w:3]Я будто слышу в \nушах [speed:1.10]его [w:1]го[w:1]лос[waitall:4][w:3]...", "[func:Peachy][func:DUB,phase1/12/3][w:4][speed:0.76]Такой родной[waitall:4][w:1]...[waitall:1][w:1][speed:1.10]\nИ близкий[waitall:4][w:3]...", "[func:DUB,phase1/12/4][w:3][speed:0.74]Папайрус[waitall:5]...", "[waitall:4][w:3]...", "[func:DUB,phase1/12/5][func:mercy][w:4]Да,[w:15] я[w:3] совсем забыла \nпро тебя,[w:3] извини.", "[func:DUB,phase1/12/6][func:NoMercy1][speed:0.90][w:5]И[w:1]так,[w:6][func:head] на чем мы \nостановились?"}
			neng={"[func:head4]This power[waitall:4][w:3]...", "[func:Final_5]I felt like I heared \nhis voice in my \nhead[waitall:4][w:3]...", "[func:Peachy]So close and caring[waitall:4][w:3]...", "Papyrus[waitall:4][w:3]...", "[waitall:4][w:3]...", "[func:mercy]Yeah,[w:3] I almost forgot \nabout you,[w:3] no \noffensive.", "[func:NoMercy1]So,[w:6] [func:head]shall we \nproceed?"}
			ruscom="Мне не нравится новый вектор \rбитвы.[w:6]\nОна стала сильнее."
			engcom="I don't like this new fight \rvector.[w:6] She became way too powerful."
			end
			wav={"phase3/bones1"}
			--Encounter.SetVar("wavetimer", 13.0)
		elseif GetGlobal("progress") == 13 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"[func:head4]Он так заботился \nо тебе[waitall:4][w:3]...", "[func:sad]Папайрус глупо \nпросил меня обещать \nему,[w:3] \nчто я не трону \nтебя.", "[func:head4]Ты был ему \nкак брат[waitall:4][w:3]...", "[func:NoMercy1][waitall:4][w:3]...", "Почему мне должно \nбыть стыдно,[w:3][func:mercy] что \nя не сдержала \nклятву?"}
			rus={"[func:head4][func:DUB,phase1/13/1][w:5]Он[w:4][speed:0.92] так заботился \nо тебе[waitall:4][w:3]...", "[func:sad][func:head4][func:DUB,phase1/13/2][w:5]Папайрус глупо \nпросил меня обещать \nему,[w:3] \nчто я не трону \nтебя.", "[func:head4][func:head4][func:DUB,phase1/13/3][w:4]Ты был ему \nкак [w:1]брат[waitall:4][w:3]...", "[waitall:4][w:3]...", "[func:NoMercy1][func:DUB,phase1/13/4][w:5][speed:1.14]Почему мне должно \nбыть[func:head] стыдно, что \nя не сдержала \nклятву?"}
			neng={"[func:head4]He cared about you \nso much...", "[func:sad]Papyrus forced me \nto give an oath to \nnot hurt you.", "[func:head4]You was like brother \nto him...", "...", "How can[waitall:4][w:3]...[waitall:1][w:3] [func:head]How can I \nbe sorry for \nbreaking this oath?"}
			ruscom="У меня одного кости болят?"
			engcom="KILL HER ALREADY!"
					--Encounter.SetVar("wavetime",10.5)
			end
			wav={"phase3/bullettest_chaseorb"}
		elseif GetGlobal("progress") == 14 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"[func:Think]Даже в пылу боя,[w:3] \nон заботился о \nтебе[waitall:4][w:3]...", "[func:head]Я не буду такой \nдоброй,[w:3] не смотри \nна меня.", "[func:head4]Мне так не хватает \nразговоров с ним \nу двери[waitall:4][w:3]...", "Когда я увидела,[w:3] \nчто от двери \nостался лишь \nщебень,[w:3] я поняла,[w:3] \nчто настал [waitall:2][w:2]конец.", "Конец всему[waitall:4][w:3]...[waitall:1][w:3] \n[func:head]Что я любила."}
			rus={"[func:Think][func:DUB,phase1/14/1][w:4][speed:0.87]Даже в пылу[w:1] боя,[w:8] \nон заботился[w:1] о \nтебе[waitall:4][w:3]...", "[func:head][func:DUB,phase1/14/2][w:4]Я[w:2][speed:1.04] не буду такой[speed:1.25] \nдоброй,[w:4][speed:1.04] не смотри \nна меня.", "[func:head4][func:DUB,phase1/14/3][w:5]Мне[w:6] так не хватает \nразговоров[speed:1.25] с ним \nу двери[waitall:4][w:3]...", "[func:DUB,phase1/14/4][w:4][speed:1.15]Когда я увидела, \nчто[w:4] от двери[speed:1.00] \nостался лишь \nщебень,[w:8] я поняла,[w:3] \nчто настал [w:3]ко[w:1]нец.", "[func:DUB,phase1/14/5][w:5][speed:0.80]Конец всему[waitall:2]...[waitall:1][w:3] \n[func:head]Что я [w:1]любила."}
			neng={"[func:Think]Even in the battle \ntendency he cared \nabout you[waitall:4][w:3]...", "[func:head]I won't be so \ngood,[w:3] don't even \ndream.", "[func:head4]I miss so much talking \nto him through the \ndoor[waitall:4][w:3]...", "When I saw ashes \nthat were left \nfrom it,[w:3] I got that \nthis is the [waitall:2][w:2]end.", "[waitall:2][w:1]End [waitall:1][w:9]for everything [func:head]\nI love."}
			ruscom="Чара кажется отчаявшейся."
			engcom="ACTOR!\nSTRIKE WHERE SHE WILL DODGE TO!"
			end
			wav={"phase3/bones2"}
		elseif GetGlobal("progress") == 15 then
			Encounter.Call("SetMusic", "lost")
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"[func:Final_1]Казалось,[w:3] будто я \nувидела в твоих \nглазах раскаяние[waitall:4][w:3]...", "[noskip][func:QuietMusic][func:Final_5]Лишь на миг,[w:3] но[waitall:4][w:3]...", "Милое зеркальце.[w:9] \nПартнёр.[w:9] \nКомпаньон.", "[func:Final_5]Если ты[waitall:4][w:3]...[waitall:1][w:3] \nЕсли ты слышишь[waitall:4][w:3]...", "[func:Music,spare]Я[waitall:4][w:3]...[waitall:1][w:3][func:Final_1] [func:HideKnife]Я хочу дать \nтебе шанс[waitall:4][w:3]...", "[func:head4]Но если нет[waitall:4][w:3]...[waitall:1][w:3] \nЕсли я ошибаюсь[waitall:4][w:3]...", "[waitall:4][w:3]...", "[func:Final_7]То тогда я \nдействительно \nдура[waitall:4][w:3]...","[func:Peachy][w:10][func:mercy][next]"}
			rus={"[func:Final_1][func:DUB,phase1/26/1][w:5]Казалось,[w:3] будто я \nувидела в [speed:1.10]твоих \nглазах раска[w:2][speed:0.80]яние[waitall:4][w:3]...", "[noskip][func:QuietMusic][func:Final_5][func:DUB,phase1/26/2][w:5]Лишь на миг,[w:3] но[waitall:4][w:3]...", "[func:DUB,phase1/26/3][w:6]М[w:1]илое зеркальце.[w:9][speed:0.90] \nПартнёр.[w:11][speed:0.80] \nКомпаньон.", "[func:Final_5][func:DUB,phase1/26/4][w:5][speed:0.90]Если ты[waitall:4][w:3]...[waitall:1][w:3] \nЕсли ты слы[w:2]шишь[waitall:4][w:3]...", "[func:Music,spare][func:DUB,phase1/26/5][w:5]Я[waitall:4][w:3]...[waitall:1][w:7][func:Final_1] [func:HideKnife]Я хочу дать \nтебе шанс[waitall:4][w:3]...", "[func:head4][func:DUB,phase1/26/6][w:5][speed:0.80]Но если нет[waitall:3][w:2]...[waitall:1][w:1][speed:0.74] \nЕсли я ошиба[w:1]юсь[waitall:4][w:3]...", "[waitall:4][w:3]...", "[func:Final_7][func:DUB,phase1/26/7][w:4]То тогда я[speed:1.25] \nдействительно [speed:1.40]\nдура[waitall:4][w:3]...","[func:Peachy][w:10][func:mercy][next]"}
			neng={"[func:Final_1]Let`s stop all this pointless chit chat.[next]"}
			engcom="[color:8040ff]I get it, you don`t know what to do\nbecause you don`t have a script, but kill her already!"
			ruscom="Чара даёт вам второй шанс. \n[w:10][speed:0.75][color:8040ff]Даже не смей, дорогуша..."
			end
			wav={"phase3/Death"}
			Encounter.SetVar("deadlyhit",true)
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
				Encounter.SetVar("forcedfight",true)
				Encounter.SetVar("FightGoes",false)
			end
		elseif GetGlobal("progress") >= 16 then
			wav= {"laststand2"}
			Encounter.SetVar("arenasize", {155, 130})
			Encounter.SetVar("CharaIsRaging",false)
		end
	elseif Encounter.GetVar("songs")[1] == "insa" then
		if GetGlobal("curse") and GetGlobal("curse") > 0 then
			SetGlobal("curse", math.floor(GetGlobal("curse") / 2))
		end
		if GetGlobal("progress") == 1 then
			Encounter.SetVar("evadelevel",1)
			--if Encounter.GetVar("diff") == 18 then
			--	wav={"phase3/k_5_new"}
			--else
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
				neng={'"Did she dodge?",[w:3]\n right?', "[func:NoMercy1]Look,[w:3] you're not \nmy prince,[w:3] \nand I'm not \nyour princess.", "[func:Bad]I can defend \nmyself." ,"[func:head][next]"}
				rus={'[func:DUB,phase3/1/1][w:6]"Как она[w:1] \nувернулась?", \n[w:9]верно?', "[func:DUB,phase3/1/2][func:NoMercy1][w:4]Послушай,[w:3] ты же \nне принц,[w:4] а я \nне твоя принцесса.", "[func:DUB,phase3/1/3][func:Bad][w:3]Я умею за себя \nпостоять.","[func:head][next]"}
				nrus={'"Как она \nувернулась?", \n[w:3]верно?', "[func:NoMercy1]Послушай,[w:3] ты же \nне принц,[w:3] а я \nне твоя принцесса.", "[func:Bad]Я умею за себя \nпостоять.","[func:head][next]"}
				ruscom="Настало время для первого акта."
				engcom="It's time for the first act."
			end
				wav={"phase3/k_5_new"}
			--end
		elseif GetGlobal("progress") == 2 then
			--if Encounter.GetVar("diff") == 18 then
			--	wav={"phase3/rain"}
			--else
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
				nrus={"[func:NoMercy1]Позволь задать \nтебе вопрос.", "Ты серьёзно \nдумаешь,[w:3] \n[func:head]что я настолько \nглупа?" }
				neng={"[func:NoMercy1]Let me ask \nyou a question.", "Who do you think \nI am [func:head]to be \nso foolish?"  }
				rus={"[func:DUB,phase3/2/1][func:NoMercy1][w:2]Позволь задать \nтебе вопрос.", "[func:DUB,phase3/2/2][w:3]Ты серьёзно \nдумаешь,[w:2] \n[func:head]что я настолько \nглупа?" }
				ruscom="Вопрос с подвохом?"
				engcom="Is it rhetorical question?"
			end
				wav={"phase3/rain"}
			--end
		elseif GetGlobal("progress") == 3 then
			--if Encounter.GetVar("diff") == 18 then
			--	wav={"phase3/random"}
			--else
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
				nrus={"[func:NoMercy1][waitall:2]Всё,[waitall:1] [w:3]что ты \nнатворил на \nпути сюда[waitall:5][w:3]...[waitall:1][w:5]\nВся эта кровь \nна твоих руках[waitall:5][w:3]...", "Разве я настолько \nдура,[w:3] \n[func:head]чтобы верить тебе?" }
				rus={"[func:DUB,phase3/3/1][func:NoMercy1][waitall:1][w:3]Всё,[waitall:1] что ты \nнатворил на \nпути сюда[waitall:3][w:3]...[waitall:1][w:5]\nВся эта кровь \nна твоих руках[waitall:5][w:3]...", "[func:DUB,phase3/3/2][w:3]Разве я[w:1] настолько[w:2] \nдура,[w:4] \n[func:head]чтобы верить [w:2]тебе?" }
				neng={"[func:NoMercy1][speed:0.55]Everything [speed:1][w:3]you \nhave done on \nyour way there[waitall:5][w:3]...[waitall:1][w:5] \nAll this dust on \nyour hands[waitall:5][w:3]...", "Am I the damn fool \n[func:head]to believe in you?" }
				ruscom="Чара истерично хихикает."
				engcom="Chara hysterically laughs."
			end
				wav={"phase3/random"}
			--end
		elseif GetGlobal("progress") == 4 then
			--if Encounter.GetVar("diff") == 18 then
			--	wav={"phase3/Reaction"}
			--else
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"Мой ответ - [w:6][waitall:2]нет.", "[func:Think]Взгляни вокруг.[w:6] \nТы и я.[w:6] \nОдин на один.", "[func:NoMercy1]Этот коридор \nпропах запахом \nчеловеческой крови.", "На моих руках уже \nесть кровь людей. \n[w:6]Ты - [w:6]не первый [w:6]\nи не последний.", "[func:head]Но только ты \nпричинил столько \nболи.", "И это мой повод \nне опускать руки." }
			rus={"[func:DUB,phase3/4/1][w:5]Мой ответ - [w:2]не[w:1]т.", "[func:DUB,phase3/4/2][func:Think][w:3]Взгляни вокруг.[w:14] \nТы[w:16] и я.[w:15] \nОдин[w:18] на один.", "[func:DUB,phase3/4/3][func:NoMercy1][w:4]Этот коридор[w:2] \nпропах[w:1] запахом \n[w:1]человеческой [w:1]крови.", "[func:DUB,phase3/4/4][w:5]На моих[w:1] руках[w:3] уже[w:2] \nесть [w:1]кровь людей. \n[w:10]Ты - [w:9]не первый [w:9]\nи[w:12] [waitall:1]не пос[w:1]лед[w:1]ний.", "[w:5][func:DUB,phase3/4/5][func:head]Но[w:2] только [w:1]ТЫ[w:3] \nпричинил [w:3]столько[w:1] \nболи!", "[func:DUB,phase3/4/6][w:1]И [w:2]это мой повод \nне [w:1]опускать руки." }
			neng={"My answer - [w:6]no.", "Look around.[w:6]\n[func:Think]It's only you \nand me now.[w:6] \nOne per one.", "[func:NoMercy1]This corridor stinks \nwith the smell of \nhuman blood.", "My hands are dirty \nfrom their blood \nas well.[w:6] You [w:6]are \nnot the first \n[w:6]nor the last.", "[func:head]But only you \ncaused so much pain.", "And that's my reason \nto conquer once \nagain."}
			ruscom="Не забывай о своей миссии."
			engcom="Do not forget about your mission."
			end
			wav={"phase3/Reaction"}
			--end
		elseif GetGlobal("progress") == 5 then
			--if Encounter.GetVar("diff") == 18 then
			--	wav={"phase3/stoplights"}
			--else
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"[func:NoMercy1]И знаешь,[w:3] что?", "[func:head]С меня хватит \nпритворства.", "[func:sad]Это ведь не \nвпервые?[w:6] \nЯ чувствую, [w:3]будто \nвсё повторяется \nраз за разом.", "[func:head4]Это не похоже на \nСбросы.[w:6] \[func:sad]Временная \nлиния остаётся \nвсё той же.", "[func:head4]Будто меняется[waitall:4][w:3]...[waitall:1][w:5]\n[func:Suprise1]Сам [w:3][waitall:3]мир.", "[func:NoMercy1]Это ведь[waitall:4][w:3]...[waitall:1][w:5] \n[func:head]Твоих рук дело?" }
			rus={"[func:NoMercy1][func:DUB,phase3/5/1][w:3]И знаешь, что?", "[func:head][func:DUB,phase3/5/2][w:2]С меня хватит \nпритворства.", "[func:sad][func:DUB,phase3/5/3][w:3]Это ведь не \nвпервые?[w:12] \nЯ чувствую, [w:1]будто \nвсё [w:1]повторяется \nраз[w:2] за разом.", "[func:DUB,phase3/5/4][func:head4][w:3]Это не похоже на \nСбросы.[w:9] \[func:sad]Временная [w:1]\nлиния остаётся \nвсё той же.", "[func:DUB,phase3/5/5][func:head4][w:3]Будто меняется[waitall:4][w:3]...[waitall:1][w:5]\n[func:Suprise1]Сам [w:5][waitall:1]мир.", "[func:NoMercy1][func:DUB,phase3/5/6][w:2]Это ведь[waitall:4][w:1]...[waitall:1][w:5] \n[func:head]Твоих [w:1]рук дело?" }
			neng={"[func:NoMercy1]And ya know what?", "[func:head]I am done with \nall this acting.", "[func:sad]It's not the first \ntime,[w:3]is it? [w:6]I feel \nlike everything is \nrepeating every time.", "[func:head4]It is not Resets.[w:6] [func:sad]\nThe timeline  is still \nthe same.", "[func:head4]It feels like[waitall:4][w:3]...[waitall:1][w:5] [func:Suprise1]the\nwhole [waitall:2]world [waitall:1][w:5]is \nchanging.", "[func:NoMercy1]It is your fault[waitall:4][w:3]...[waitall:1][w:5] [func:head]\nRight?"}
			ruscom="В её словах есть смысл."
			engcom="She has a point."
			end
			wav={"phase3/stoplights"}
			--end
		elseif GetGlobal("progress") == 6 then
			--if Encounter.GetVar("diff") == 18 then
			--	wav={"phase3/NoMercyToYou"}
			--else
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"[func:sad]Ты тоже это \nчувствуешь[waitall:5]...", "[func:head4]Тем не менее[waitall:4]...[waitall:1][w:4] [func:NoMercy1]Есть\nкое-что важнее,[w:10]\nчем мои \nпредчувствия.", "[func:mercy]Ты ведь чувствуешь? [w:15]\n[waitall:2][func:head]Грехи,[waitall:1][w:5] что ползут \nпо твоей спине?"}
			rus={"[func:DUB,phase3/6/1][func:sad][w:4]Ты тоже это \nчувствуешь[waitall:5]...", "[func:head4][func:DUB,phase3/6/2][w:2]Тем не менее[waitall:4]...[waitall:1][w:2] [func:NoMercy1]Есть\n[speed:1.17]кое-что важнее,\nчем мои \nпредчувствия.", "[func:DUB,phase3/6/3][func:mercy][w:3]Ты ведь чувствуешь? [w:15]\n[func:head]Грехи,[w:2] что ползут[w:2] \nпо твоей[w:1] спине."}
			neng={"[func:sad]So you do feel \nthe same[waitall:4][w:3]...", "[func:head4]Nevertheless[waitall:4][w:3]...[waitall:1][w:4]\n[func:NoMercy1]There's something \nmore important than\nmy prejudgments.", "[func:mercy]Do you feel them?[w:15] [func:head]\n[waitall:2]Sins[waitall:1][w:5] on your back?"}
			ruscom="Нас не одурачить этой пугалкой."
			engcom="She can't fool us with those nasty words."
			end
			wav={"phase3/NoMercyToYou"}
			--end
		elseif GetGlobal("progress") == 7 then
			--if Encounter.GetVar("diff") == 18 then
			--	wav={"phase3/k_storm"}
			--else
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"[func:NoMercy1]Так вот.[w:15] Мой тебе \nсовет [w:4]- не \nповорачивайся.", "[func:head]Иначе нож в ту же \nсекунду пронзит \nтвою глотку.", "Я не отпущу тебя \nбез достойной \nбитвы.[w:6] \nТы отплатишь за \nсвои грехи." }
			rus={"[func:NoMercy1][func:DUB,phase3/7(!!!)/1][w:9][speed:0.80]Так вот.[w:7] Мой тебе \nсовет [w:3]-[w:3] не \nповорачивайся.", "[func:head][func:DUB,phase3/7(!!!)/2][w:4][speed:0.80]Иначе нож в ту же \nсекунду пронзит \nтвою глотку.", "[func:DUB,phase3/7(!!!)/3][w:6][speed:1.05]Я не отпущу тебя \nбез достойной \nбитвы.[w:6][speed:0.85] \nТы [w:1]отпла[w:2]тишь[speed:1.05] за \nсвои [w:1]грехи." }
			neng={"[func:NoMercy1]So I have an advice \nfor ya.[w:6] \n[waitall:2]Do not turn around.", "[func:head]Because in that very \nmoment knife will \npierce your thin \nneck.", "I will not let you go \nwithout proper \nfight.[w:6] You will pay \nfor your actions."}
			ruscom="Ну,[w:3] этот совет был хорошим,[w:3] кажется."
			engcom="Welp,[w:3] that advice was solid,[w:3] I wonder."
			end
			wav={"phase3/k_storm"}
			--end
		elseif GetGlobal("progress") == 8 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"[func:sad]Кому я это говорю[waitall:4][w:3]...",  "[func:head4]Ты ведь не слышишь.[w:15] \n[func:sad]Не хочешь [w:5]или \nне можешь [w:5]- не \nважно.", "[func:Final_7]Полагаю[waitall:4][w:3]...[waitall:1][w:4] \n[func:NoMercy1]Мы оба знаем,[w:3] \n[func:head]что будет в конце."}
			rus={"[func:DUB,phase3/8/1][func:sad][w:4]Кому я это говорю[waitall:2].[w:4].[w:4].", "[func:DUB,phase3/8/2][func:head4][w:4][speed:1.17]Ты ведь[speed:1.26] не слы[w:1]шишь.[w:14] \n[func:sad][speed:1.17]Не хо[w:1]чешь [w:2]или \nне можешь [w:6]- [speed:1.25]не \nважно.", "[func:DUB,phase3/8/3][func:Final_7][w:2]Полагаю,[w:4] \n[func:NoMercy1]Мы[w:3][speed:1.17] оба знаем,[w:1] \n[func:head]что [speed:1.25]будет в конце."}
			neng={"[func:sad]Why do I even \nbother[waitall:4][w:3]...", "[func:head4]You don't listen.[w:15] [func:sad]\nDoesn't matter \nif you can't \n[w:6]or you don`t want to", "[func:Final_7]I guess[waitall:4][w:3]...[waitall:1][w:3] [func:NoMercy1]We both \nknow the [func:head]final act \nof our story."}
			ruscom="Осторожнее.[w:6] \nЧто-то с ней не так[waitall:4][w:3]..."
			engcom="Beware[waitall:4][w:3]...[waitall:1][w:3] \nSomething is off about her."
			end
			wav={"phase3/warning"}
		elseif GetGlobal("progress") == 9 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"[func:head4]Ты думаешь, [w:3]что я \nнаивная[waitall:4][w:3]...[waitall:1][w:3]\nпредсказуемая и \nжалкая.", "[func:Look]Думаешь,[w:3] [func:Lookleft]что я \nвообразила из себя \nсудью,[w:3] \n[func:sad]хотя сама ничем \nне лучше тебя[waitall:4][w:3]...", "[func:head4]Может,[w:3] ты и прав.","[func:head][next]"}
			rus={"[func:DUB,phase3/9/1][func:NoMercy1][w:3]Ты думаешь, [w:2]что я \nнаивная,[w:7][speed:1.15]\nпредсказуемая[w:4] и \nжа[w:3]лкая.", "[func:DUB,phase3/9/2][func:Look][w:8]Думаешь,[w:9] [func:Lookleft]что я \nвообразила из себя \nсудью,[w:2] \n[func:sad]хотя сама ничем \nне лучше тебя[waitall:2][w:3]...", "[func:DUB,phase3/9/3][func:head4][w:5][speed:0.87]Может,[w:6] ты и прав.","[func:head][next]"}
			neng={"[func:head4]You think, I am \nnaive[waitall:4][w:3]...[waitall:1][w:3] predictable \nand pity.", "[func:Look]You think,[w:3] [func:Lookleft]I imagined \nmyself as some judge\nof you and [func:sad]still \nI am not better than \nyou[waitall:4][w:3]...", "[func:head4]Maybe,[w:3] you have a \npoint.","[func:head][next]"}
			ruscom="Конечно,[w:3] прав."
			engcom="Of course,[w:3] I have."
			end
			wav={"phase3/BeFast"}
		elseif GetGlobal("progress") == 10 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"Но я не одинока.", "[func:DramaIn][func:head4]Точнее[waitall:4][w:4]...[waitall:1][w:3] была.[w:15]\nНо пусть их и нет \nсо мной[waitall:4][w:4]...", "[func:Final_3]Я чувствую их \nвнутри своей Души.", "[func:Final_4]Каждого,[w:3] кого я \nлюбила и уважала,[w:3]\nи они отвечали \nтем же[waitall:4][w:3]...", "[func:Peachy]Каждый из \nних [w:5]-[w:5] [func:mercy]моя \nсемья.", "[func:DramaOut][func:Peachy]Я многому у них \nнаучилась[waitall:4][w:4]...", "[noskip][func:NoMercy1]Например.[w:16] [speed:0.5][func:head]Этому.[w:30][next]"}
			rus={"[func:DUB,phase3/10/1][w:6][speed:0.75]Но я не [speed:0.8]одинока.", "[func:DUB,phase3/10/2][func:DramaIn][func:head4][w:6]Точнее[waitall:4][w:2]...[waitall:1][w:3] была.[w:15]\nНо пусть их и нет \nсо мной[waitall:4][w:4]...", "[func:DUB,phase3/10/3][func:Final_3][w:4]Я чувствую их \nвнутри своей Души.", "[func:DUB,phase3/10/4][func:Final_4][w:6]Ка[w:1]ждого,[w:1] кого я \nлюбила [w:1]и уважала,[w:9]\nи они отвечали[w:1] \nтем же[waitall:4][w:3]...", "[func:DUB,phase3/10/5][func:Peachy][w:6]Каждый из \nних [w:4]-[w:3] [func:mercy]моя[w:1] \nсемья.", "[func:DUB,phase3/10/6][func:DramaOut][func:Peachy][w:5]Я многому у них \nнаучилась[waitall:4][w:4]...", "[func:DUB,phase3/10/7][noskip][func:NoMercy1][w:6][speed:0.75]Например.[w:20] [speed:0.7][func:head]Э[w:1]тому.[w:30][next]"}
			neng={"But I'm not alone.", "[func:DramaIn][func:head4]Well[waitall:4][w:4]...[waitall:1][w:3] I was[waitall:4][w:4]...[waitall:1][w:15] \nBut even if they are \nnot beside me now[waitall:4][w:4]...", "[func:Final_4]I feel them inside \nmy very soul.", "[func:head4]I feel everyone I \nloved and respected", "[func:Peachy]Every one of them[w:9] [func:mercy]\nis my family.", "[func:DramaOut][func:Peachy]I learned a lot from \nthem.", "[noskip][func:NoMercy1]For example. [w:15][func:head][waitall:2]This.[w:30][next]"}
			ruscom="Ну конечно,[w:3] сила любви.[w:6]\nКак я раньше не понял."
			engcom="Of course,[w:3] power of love.[w:6]\nShould have guessed before."
					--Encounter.SetVar("wavetime",11)
			end
			wav={"phase3/bones0"}
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
				Encounter.SetVar("evadelevel",2)
			end
		elseif GetGlobal("progress") == 11 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"[func:Peachy]Понимаешь,[w:3][func:mercy] я ещё \nне совсем привыкла \nк этой[waitall:4][w:3]...[waitall:1][w:3] силе.", "[func:Remember]Моя решимость \nрезонирует внутри \nмоей души[waitall:4][w:3]...", "[func:Peachy]Я чувствую,[w:3] как \nони[waitall:4][w:3]...[waitall:1][w:3] [func:Remember]поддерживают \nменя. \n[w:6]Заботятся обо мне.", "[func:Peachy]И их сила[waitall:4][w:3]...[waitall:1][w:3] \n[func:mercy]Передалась мне.", "[func:NoMercy1]Ну что?[w:9] [func:head]Готов \nко второму раунду?"}
			rus={"[func:Peachy][func:DUB,phase3/11/1][w:7][speed:1.10]Понимаешь,[speed:1.00][w:3][func:mercy] я ещё \nне [speed:1.20]совсем привыкла \nк [speed:1.00]этой[w:3].[w:3].[w:2].[w:2] [speed:0.80]силе.", "[func:DUB,phase3/11/2][func:Remember][w:3]Моя решимость \nрезонирует внутри \nмоей души[waitall:4][w:3]..", "[func:DUB,phase3/11/3][func:Peachy][w:4][speed:1.20]Я чувствую,[w:2] как \nони[w:1].[w:3].[w:3].[w:3] [func:Remember][speed:0.90]поддерживают \nменя. \n[w:7]Заботятся обо мне.", "[func:DUB,phase3/11/4][func:Peachy][w:3]Их сила[waitall:3][w:3]...[waitall:1][w:4][speed:0.88] \n[func:mercy]Передалась [w:1]мне.", "[func:DUB,phase3/11/5][func:NoMercy1][w:4]Ну[w:2] что?[w:9] [func:head][speed:1.10]Готов \nко второму раунду?[w:9]"}
			neng={"[func:Peachy]Sorry,[w:3] [func:mercy]I am still not \nso good with this[waitall:4][w:3]...[waitall:1][w:3] \npower.", "[func:Remember]My Determination \nresonates \nwithin my soul[waitall:4][w:3]...[waitall:1]", "[func:Peachy]It feels like[waitall:4][w:3]...[waitall:1][w:3] [func:Remember]they \ncheer for me.[w:6] \nCare about me.", "[func:Peachy]And their power[waitall:4][w:3]...[waitall:1][w:3] [func:mercy]\nIs now mine.", "[func:NoMercy1]So? [w:9][func:head]Are you ready \nfor the round two?"}
			ruscom="Она адаптируется к новым силам.[w:6]\nУ нас всё меньше времени,[w:3] \rдорогой актер."
			engcom="She is adapting to new powers.[w:6] \nWe have not so much time left,[w:3] \rdear actor."
			end
			wav={"phase3/bullettest_touhou"}
			--Encounter.SetVar("wavetimer", 13.0)
		elseif GetGlobal("progress") == 12 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"[func:head4]Эта сила[waitall:4][w:3]...", "[func:Final_5]Я будто слышу в \nушах его голос[waitall:4][w:3]...", "[func:Peachy]Такой родной\nи близкий[waitall:4][w:3]...", "Папайрус[waitall:5]...", "[waitall:4][w:3]...", "[func:mercy]Да,[w:3] я совсем забыла \nпро тебя,[w:3] извини.", "[func:NoMercy1]Итак,[w:6][func:head] на чем мы \nостановились?"}
			rus={"[func:head4][func:DUB,phase3/12/1][w:5][speed:0.85]Эта сила[waitall:4][w:3]...", "[func:Final_5][func:DUB,phase3/12/2][w:3]Я будто слышу в \nушах [speed:1.10]его [w:1]го[w:1]лос[waitall:4][w:3]...", "[func:Peachy][func:DUB,phase3/12/3][w:4][speed:0.76]Такой родной[waitall:4][w:1]...[waitall:1][w:1][speed:1.10]\nИ близкий[waitall:4][w:3]...", "[func:DUB,phase3/12/4][w:3][speed:0.74]Папайрус[waitall:5]...", "[waitall:4][w:3]...", "[func:DUB,phase3/12/5][func:mercy][w:4]Да,[w:15] я[w:3] совсем забыла \nпро тебя,[w:3] извини.", "[func:DUB,phase3/12/6][func:NoMercy1][speed:0.90][w:5]И[w:1]так,[w:6][func:head] на чем мы \nостановились?"}
			neng={"[func:head4]This power[waitall:4][w:3]...", "[func:Final_5]I felt like I heared \nhis voice in my \nhead[waitall:4][w:3]...", "[func:Peachy]So close and caring[waitall:4][w:3]...", "Papyrus[waitall:4][w:3]...", "[waitall:4][w:3]...", "[func:mercy]Yeah,[w:3] I almost forgot \nabout you,[w:3] no \noffensive.", "[func:NoMercy1]So,[w:6] [func:head]shall we \nproceed?"}
			ruscom="Мне не нравится новый вектор \rбитвы.[w:6]\nОна стала сильнее."
			engcom="I don't like this new fight \rvector.[w:6] She became too powerful."
			end
			wav={"phase3/bones1"}
			--Encounter.SetVar("wavetimer", 13.0)
		elseif GetGlobal("progress") == 13 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"[func:head4]Он так заботился \nо тебе[waitall:4][w:3]...", "[func:sad]Папайрус глупо \nпросил меня обещать \nему,[w:3] \nчто я не трону \nтебя.", "[func:head4]Ты был ему \nкак брат[waitall:4][w:3]...", "[func:NoMercy1][waitall:4][w:3]...", "Почему мне должно \nбыть стыдно,[w:3][func:mercy] что \nя не сдержала \nклятву?"}
			rus={"[func:head4][func:DUB,phase3/13/1][w:5]Он[w:4][speed:0.92] так заботился \nо тебе[waitall:4][w:3]...", "[func:sad][func:head4][func:DUB,phase3/13/2][w:5]Папайрус глупо \nпросил меня обещать \nему,[w:3] \nчто я не трону \nтебя.", "[func:head4][func:head4][func:DUB,phase3/13/3][w:4]Ты был ему \nкак [w:1]брат[waitall:4][w:3]...", "[waitall:4][w:3]...", "[func:NoMercy1][func:DUB,phase3/13/4][w:5][speed:1.14]Почему мне должно \nбыть[func:head] стыдно, что \nя не сдержала \nклятву?"}
			neng={"[func:head4]He cared about you \nso much...", "[func:sad]Papyrus forced me \nto give an oath to \nnot hurt you.", "[func:head4]You was like brother \nto him...", "...", "How can[waitall:4][w:3]...[waitall:1][w:3] [func:head]How can I \nbe sorry for \nbreaking this oath?"}
			ruscom="У меня одного кости болят?"
			engcom="Am I the only one with boneache?"
					--Encounter.SetVar("wavetime",10.5)
			end
			wav={"phase3/bullettest_chaseorb"}
		elseif GetGlobal("progress") == 14 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"[func:Think]Даже в пылу боя,[w:3] \nон заботился о \nтебе[waitall:4][w:3]...", "[func:head]Я не буду такой \nдоброй,[w:3] не смотри \nна меня.", "[func:head4]Мне так не хватает \nразговоров с ним \nу двери[waitall:4][w:3]...", "Когда я увидела,[w:3] \nчто от двери \nостался лишь \nщебень,[w:3] я поняла,[w:3] \nчто настал [waitall:2][w:2]конец.", "Конец всему[waitall:4][w:3]...[waitall:1][w:3] \n[func:head]Что я любила."}
			rus={"[func:Think][func:DUB,phase3/14/1][w:4][speed:0.87]Даже в пылу[w:1] боя,[w:8] \nон заботился[w:1] о \nтебе[waitall:4][w:3]...", "[func:head][func:DUB,phase3/14/2][w:4]Я[w:2][speed:1.04] не буду такой[speed:1.25] \nдоброй,[w:4][speed:1.04] не смотри \nна меня.", "[func:head4][func:DUB,phase3/14/3][w:5]Мне[w:6] так не хватает \nразговоров[speed:1.25] с ним \nу двери[waitall:4][w:3]...", "[func:DUB,phase3/14/4][w:4][speed:1.15]Когда я увидела, \nчто[w:4] от двери[speed:1.00] \nостался лишь \nщебень,[w:8] я поняла,[w:3] \nчто настал [w:3]ко[w:1]нец.", "[func:DUB,phase3/14/5][w:5][speed:0.80]Конец всему[waitall:2]...[waitall:1][w:3] \n[func:head]Что я [w:1]любила."}
			neng={"[func:Think]Even in the battle \ntendency he cared \nabout you[waitall:4][w:3]...", "[func:head]I won't be so \ngood,[w:3] don't even \ndream.", "[func:head4]I miss so much talking \nto him through the \ndoor[waitall:4][w:3]...", "When I saw ashes \nthat were left \nfrom it,[w:3] I got that \nthis is the [waitall:2][w:2]end.", "[waitall:2][w:1]End [waitall:1][w:9]for everything [func:head]\nI love."}
			ruscom="Чара кажется отчаявшейся."
			engcom="Chara seems desperate."
			end
			wav={"phase3/bones2"}
		elseif GetGlobal("progress") == 15 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"[func:NoMercy1]Любовь[waitall:4][w:3]...", "Конечно,[w:3] [func:head]нас обоих \nсвязала любовь.", "[func:NoMercy1]Не настоящая.[w:6] \nНе семейная.[w:6] \nА та,[w:3] что \nгниёт внутри нас.", "Любовь[waitall:4][w:3]...[waitall:1][w:3][func:head] \nк убийствам.[w:6] \nК ненависти,[w:3] \nживотной натуре.", "[func:Think]В конце концов[waitall:4][w:3]...[waitall:1][w:3] \n[func:NoMercy1]Все мы такие,[w:6][speed:0.5] \n[color:ff0000]люди[color:000000][waitall:4][w:3]...","[func:head][next]"}
			rus={"[func:NoMercy1][func:DUB,phase3/15/1][w:5]Лю[w:2]бовь[waitall:4][w:2].[w:2].[w:2].[w:2]", "[func:DUB,phase3/15/2][w:4]Ко[w:1]не[w:1]чно,[w:9] [func:head]нас обоих \nсвязывала лю[w:1]бовь.", "[func:DUB,phase3/15/3][w:4][func:NoMercy1][speed:0.85]Не настоящая.[w:3][speed:0.90] \nНе семе[w:1]йная.[w:6] \nА та,[w:3][speed:1.04] что \nгниёт[w:1][speed:1.04] внутри[w:1] нас.", "[func:DUB,phase3/15/4][w:5]Лю[w:2]бовь[waitall:4][w:2]...[waitall:1][w:1][func:head] \nК убийствам.[w:6] \nК ненависти,[w:7] \nживо[w:1]тной[w:1] нату[w:1]ре.", "[func:Think][func:DUB,phase3/15/5][w:4][speed:0.92]В конце[w:1] концов[waitall:2][w:2]...[waitall:1][w:2] \n[func:NoMercy1]Все мы такие,[w:15][speed:0.75] \n[color:ff0000]лю[w:5]ди[color:000000][waitall:4][w:3]...","[func:head][next]"}
			neng={"[func:NoMercy1]Love[waitall:4][w:3]...", "Sure,[w:3] [func:head]love has bonded \nus.", "[func:NoMercy1]Not real one.[w:6] \nNot family like.[w:6] \nBut that what is \nrotting inside us.", "Love[waitall:4][w:3]...[waitall:1][w:3] [func:head]to bloodshed.[w:6] \nTo hatred,[w:3] \nto wild hunting.", "[func:Think]In the end[waitall:4][w:3]...[waitall:1][w:3] \n[func:NoMercy1]It's natural for us,[w:6] \n[color:ff0000]humans[color:000000][waitall:4][w:3]...","[func:head][next]"}
			ruscom="Атака фантомных ножей![w:6]\nЭто читы!"
			engcom="The reign of phantom knives![w:6]\nYou got to be cheating!"
			end
			wav={"phase3/nostop"}
		elseif GetGlobal("progress") == 16 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"[func:head4]Голоса в голове[waitall:4][w:3]...[waitall:1][w:3] \nИх слишком много[waitall:4][w:3]...", "Они все[waitall:4][w:3]...[waitall:1][w:3] все \nхотят твоей \nсмерти[waitall:4][w:3]...", "[func:NoMercy1]Но я не дам её тебе \nтак просто.", "[func:closedyesend]Так же,[w:3] как ты \nмучила милую \nАльфис,[w:3] \nты будешь гореть \nв [speed:0.5][w:2]агонии[waitall:4][w:3]...", "[func:head][waitall:3][w:3]Д о л г о[w:4]"}
			rus={"[func:head4][func:DUB,phase3/16/1][w:9][speed:0.80]Голоса[w:1] в голове[waitall:3][w:1]...[waitall:1][w:1][speed:0.92] \nИ[w:2]х слишком много[waitall:4][w:3]...", "[func:DUB,phase3/16/2][w:9][speed:0.75]Они[w:1] все[waitall:4][w:3]...[waitall:1][w:2][speed:0.89] все \nхотят[w:1] твоей \nсме[w:2]рти[waitall:4][w:3]...", "[func:NoMercy1][func:DUB,phase3/16/3][w:5][speed:0.93]Но я не дам[w:1] её тебе \nпро[w:1]сто так.", "[func:closedyesend][func:DUB,phase3/16/4][w:4][speed:1.05]Так же,[speed:0.95] как ты \nмучил[w:1] милую[w:1][speed:0.97] \nА[w:2]льфис,[w:9] \nты будешь гореть \nв [speed:0.80][w:2]агонии[waitall:4][w:3]...", "[func:head][func:DUB,phase3/16/5][w:5][w:3]Д[w:1] о[w:11] л[w:2] г о[w:4]"}
			neng={"[func:head4]Voices in my head[waitall:4][w:3]...[waitall:1][w:3] \nThere's too many of \nthem[waitall:4][w:3]...", "They all[waitall:4][w:3]...[waitall:1][w:3] \nwant you dead[waitall:4][w:3]...", "[func:NoMercy1]But quick exit will be \ntoo merciful for you.", "[func:closedyesend]You will burn in [waitall:2][w:2]agony[waitall:1][w:2]\nas long as you \ntortured cute \nAlphys[waitall:4][w:3]...", "[func:head][waitall:2][w:2]For very \n[waitall:3][w:3]l o n g[waitall:2][w:3] time."}
			ruscom="Голоса[waitall:4][w:3]?..[waitall:1][w:3]\nУ неё крыша поплыла."
			engcom="Voices[waitall:4][w:3]?..[waitall:1][w:3]\nIs she nuts?"
			end
			wav={"phase3/electro_rain"}
		elseif GetGlobal("progress") == 17 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"[func:head4]Они[waitall:4][w:3]...[waitall:1][w:3] взрываются\nв моей голове[waitall:4][w:3]...", "Но эта боль[waitall:4][w:3]...[waitall:1][w:3] \n[func:NoMercy1]Она ничто по \nсравнению с тем,[w:3]\nчто ты причинил\nмне.", "Я[waitall:4][w:3]...[waitall:1][w:3] я справлюсь[waitall:4][w:3]...", "[func:head4]Я[waitall:4][w:3]...[waitall:1][w:3] справлюсь[waitall:4][w:3]...", "[waitall:4][w:3]...", "[func:NoMercy1]Покажем ему,[w:9] \n[func:head]Альфи[waitall:4][w:3]..."}
			rus={"[func:head4][func:DUB,phase3/17/1][w:5]О[w:2]ни[waitall:4][w:3]...[waitall:1][w:3][speed:0.85] взрываются\nв моей голове[waitall:4][w:3]...", "[func:DUB,phase3/17/2][w:6]Но[w:1] эта боль[waitall:4][w:3]...[waitall:1][w:3] \n[func:NoMercy1][speed:0.90]Она ничто по \nсравнению с тем[speed:1.10],\nчто ты причинил\nмне.", "[func:DUB,phase3/17/3][w:5]Я[waitall:4][w:3]...[waitall:1][w:6][speed:0.93] я справлюсь[waitall:4][w:3]...", "[func:head4][func:DUB,phase3/17/4][w:5]Я[waitall:4][w:3]...[waitall:1][w:6][speed:0.85] справлюсь[waitall:4][w:3]...", "[waitall:4][w:3]...", "[func:NoMercy1][func:DUB,phase3/17/5][w:5]По[w:2]кажем[w:1] ему,[w:6] \n[func:head]А[w:2]льфи[waitall:4][w:3]."}
			neng={"[func:head4]They are[waitall:4][w:3]...[waitall:1][w:3] exploding \nin my head[waitall:4][w:3]...", "But this pain[waitall:4][w:3]...[waitall:1][w:3] [func:NoMercy1]\nIs nothing comparing\nto what you have \ndone to me.", "I can[waitall:4][w:3]...[waitall:1][w:3] Deal with it[waitall:4][w:3]...", "[func:head4]I[waitall:4][w:3]...[waitall:1][w:3] Can[waitall:4][w:3]...", "[waitall:4][w:3]...", "[func:NoMercy1]Show him,[w:9] [func:head]Alph[waitall:4][w:3]..."}
			ruscom="В её руках сила твоих погибших врагов[waitall:4][w:3]...[waitall:1][w:3] Она[waitall:3][w:3]...[waitall:1][w:3] Настроена серьёзно."
			engcom="She has the power of your fallen foes[waitall:4][w:3]...[waitall:1][w:3] She is[waitall:3][w:3]...[waitall:1][w:3] serious now."
			end
			wav={"phase3/alph"}
		elseif GetGlobal("progress") == 18 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"[func:NoMercy1][waitall:4][w:3]...", "Скажи,[w:3] [func:head]в чем смысл \nвсего этого?", "[func:sad]Мы встречаемся \nвновь и вновь.[w:9] \nЯ вновь и вновь \nдаю тебе отпор.", "[func:head4]Раз за разом[waitall:4][w:3]...[waitall:1][w:3] \n[func:deadly]Этот бесконечный \nкошмар[waitall:4][w:3]...", "Ты в погоне за \nсилой?[w:13] \n[func:Surprise1]Тебе не нравится \nнаш мир?", "[func:head4]Что[waitall:4][w:3]...[waitall:1][w:3] \n[func:Surprise1]Что тебе нужно?", "[waitall:4][w:4]Чего[waitall:1][w:9] тебе не \nхватает?","[func:head][next]"}
			rus={"[func:NoMercy1][func:DUB,prolog2/f][waitall:4][w:3]...", "[func:DUB,phase3/18/1][w:5]Скажи,[w:10] [func:head][speed:1.07]в чем смысл \nвсего этого?", "[func:Think][func:DUB,phase3/18/2][w:5]Мы встречаемся \nвновь и вновь.[w:5] \n[func:head]Я вновь и вновь[w:1] \nдаю[w:1] тебе[w:1] отпор.", "[func:head4][func:DUB,phase3/18/3][w:4]Раз за разом[waitall:3][w:2]...[waitall:1][w:2] \n[func:deadly]Этот бесконечный \nкошмар[waitall:4][w:3]...", "[func:DUB,phase3/18/4][w:3]Ты в погоне за \nсилой?[w:10] \n[func:Surprise1]Тебе не[speed:1.15] нравится \nнаш[w:1] мир?", "[func:head4][func:DUB,phase3/18/5][w:5]Что?[w:11][speed:0.75][w:3] \n[func:Surprise1]Что[w:1] тебе[w:1][speed:1.20] ну[w:2]жно?", "[func:DUB,phase3/18/6][w:4]Чего[w:5] тебе[w:3] не \nхва[w:1]тает?","[func:head][next]"}
			neng={"[func:NoMercy1][waitall:4][w:3]...", "Say,[w:3] [func:head]what is the \npoint in this?", "[func:Think]We are meeting over \nand over again.[w:9][func:head] \nI conquer you every \ntime.", "[func:head4]Over and over[waitall:4][w:3]...[waitall:1][w:3] \nthis nightmare is \nendless[waitall:4][w:3]...", "Are you chasing the \npower?[w:9] \n[func:Surprise1]Do you not like my \nworld?", "[func:head4]What[waitall:4][w:3]...[waitall:2][w:3] [func:Surprise1]What[waitall:1][w:6] is your \ngoal?", "[waitall:4][w:4]What[waitall:1][w:9] are you \nchasing?","[func:head][next]"}
			ruscom="Ей всё равно не понять.[w:6]\nНе отвлекайся."
			engcom="She won`t get it anyway.[w:6]\nDon't bother."
			end
			wav={"phase3/Quickly"}
		elseif GetGlobal("progress") == 19 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"[func:head4]Твоя цель \nоправдывает \nтвои действия?", "[func:Surprise1]Моя семья погибла \nне напрасно,[w:3] [func:sad]верно?", "[func:Surprise1]Ты рушишь семьи,[w:6]\n[func:head4]ты уничтожаешь мир.", "[func:deadly]Каждый раз ты \nставишь нас на \nколени.", "[func:head4]Азриэль верил,[w:3] что \nв тебе есть что-то \nмогущественное.", "Сила,[w:6] [func:Surprise1]способная \nизменить мир.","[func:head][next]"}
			rus={"[func:head4][func:DUB,phase3/19/1][w:3][speed:1.20]Твоя цель[speed:1.08] \nопра[w:1]вдывает[speed:1.00] \nтвои действия?", "[func:Surprise1][func:DUB,phase3/19/2][w:5]Моя семья погибла[speed:1.15][w:1] \nне напра[w:1]сно,[w:3][speed:0.90] [func:sad]ве[w:1]рно?", "[func:Surprise1][func:DUB,phase3/19/3][w:5][speed:0.88]Ты рушишь се[w:1]мьи,[w:5]\n[func:head4][speed:0.77]ты уничтожаешь[w:1] ми[w:1]р.", "[func:deadly][func:DUB,phase3/19/4][w:3][speed:0.95]Ка[w:2]ждый раз[w:1][speed:1.20] ты \nставишь[w:1][speed:0.90] нас на[w:1] \nко[w:1]ле[w:1]ни!", "[func:head4][func:DUB,phase3/19/5][w:5][speed:1.11]Азриэль верил,[w:3][speed:1.30] что \nв тебе есть [speed:1.00]что-то \nмогущественное.", "[func:DUB,phase3/19/6][w:4][speed:0.90]Сила,[w:1][speed:1.11] [func:Surprise1]способная[w:1] \nизменить[w:1] мир.","[func:head][next]"}
			neng={"[func:head4]Does your goal cost \nyour actions?", "[func:Surprise1]My family wasn't \nsacrificed for \nnothing,[w:3] [func:sad]was it?", "[func:Surprise1]You are destroying \nfamilies,[w:3] \n[func:head4]the entire world \nitself.", "[func:deadly]Every time you are \nbreaking us to \nthe bone.", "[func:head4]Asriel believed,[w:3] that \nyou have something \ngreat.", "That you have the \npower [func:Surprise1]to change \nthe world.","[func:head][next]"}
			ruscom="Чара меланхолично крутит \rножом в руках."
			engcom="Chara is melancholically \rswinging her knife."
			end
			wav={"phase3/rei"}
		elseif GetGlobal("progress") == 20 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			Encounter.SetVar("evadelevel",3)
			neng={"[func:Peachy]Yeah[waitall:4][w:3]...[waitall:1][w:3] I hear you.[w:6] \nEnough bragging[waitall:4][w:3]...", "Rei,[w:3] you always was[waitall:4][w:3]...[waitall:1][w:3] \n[func:head4]such a crybaby[waitall:4][w:3]...", "[waitall:4][w:3]...", "[func:Peachy]Oh,[w:3][func:mercy] did I slip \nagain?", "[func:Peachy]Sorry[waitall:4][w:3]...", "All those voices[waitall:4][w:3]...[waitall:1][w:3] [func:Remember]\nThere's too many of \nthem.", "[func:head4]It's almost like I hear \nyour every victim.", "Every[waitall:4][w:3]...[waitall:1][w:3] [func:sad]And no one \nin the same time[waitall:4][w:3]...", "[func:head4][waitall:4][w:3]...", "[func:head]You won't turn the \ntable,[w:6] don't even \ndream."}
			nrus={"[func:Peachy]Да[waitall:4][w:3]...[waitall:1][w:3] Я слышу тебя.[w:6] \nХватит спорить[waitall:4][w:3]...", "Аззи,[w:3] ты всегда[waitall:4][w:3]...[waitall:1][w:3][func:NoMercy1] \nбыл плаксой[waitall:4][w:3]...", "[waitall:4][w:3]...", "[func:Peachy]Ох,[w:3][func:mercy] я опять \nотвлеклась?", "[func:Peachy]Извини[waitall:4][w:3]...", "Эти голоса[waitall:4][w:3]...[waitall:1][w:3] \n[func:Remember]Их слишком много.", "[func:head4]Я будто слышу \nкаждого монстра,[w:3] \nчто ты убил.", "Каждого[waitall:4][w:3]...[waitall:1][w:3] [func:sad]И никого \nодновременно[waitall:4][w:3]...", "[func:head4][func:head4][waitall:4][w:3]...", "[func:head]Я не дам тебе \nвоспользоваться \nмоими слабостями."}
			rus={"[func:Peachy][func:DUB,phase3/20/1][w:7]Да[waitall:4][w:3]...[waitall:1][w:3] Я[w:4] слышу тебя.[w:8][speed:1.11] \nХватит[speed:0.80] спорить!", "[func:DUB,phase3/20/2][w:5]А[w:4]ззи,[w:6] ты[w:1] все[w:1]гда[waitall:3][w:2]...[w:2][speed:0.80] \nБыл пла[w:1]ксой.", "[func:Peachy][waitall:4][w:3]...", "[func:Peachy][func:DUB,phase3/20/3][w:5]Ох,[w:3][func:mercy][speed:1.30] я опять[speed:1.40] \nотвлеклась?", "[func:Peachy][func:DUB,phase3/20/4][w:5][speed:0.80]Извини[waitall:4][w:3]...", "[func:DUB,phase3/20/5][w:5][speed:0.80]Эти го[w:1]ло[w:1]са[waitall:3][w:2]...[waitall:1][w:1] \n[func:Remember]Их[w:1] слишком[w:1] много.", "[func:head4][func:DUB,phase3/20/6][w:5]Я будто слышу \nка[w:3]ждого мо[w:1]нстра, \nчто[w:1] ты[w:1] убил.", "[func:DUB,phase3/20/7][w:4]Ка[w:3]ждого[waitall:3][w:2]...[waitall:1][w:2] [func:sad]И никого[speed:1.20] \nодновреме[w:1]нно[waitall:4][w:3]...", "[func:head4][func:head4][waitall:4][w:3]...", "[func:DUB,phase3/20/8][w:5][func:head][speed:1.15]Я не дам тебе \nвоспользоваться \nмоими сла[w:1]бостями."}
			ruscom="Чара готовит Бластеры Хаоса[waitall:4][w:3]...[waitall:1][w:5]\nПогоди,[w:3] мне это что-то напомнило[waitall:4][w:3]..."
			engcom="Chara readies Chaos Blasters[waitall:4][w:3]...[waitall:1][w:5]\nWait,[w:3] why does it sound so familiar?"
			end
			wav={"phase3/bullettest_bouncy"}
		elseif GetGlobal("progress")==21 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"[func:NoMercy1]Я изучала тебя.", "[func:Think]Следила за каждым \nтвоим шагом.[w:6] [func:head]И \nпришла к некоторым \nинтересным выводам.", "[func:NoMercy1]Азриэль верил,[w:3] что \nты великий человек.[w:6] \n[func:Think]Так и есть.", "[func:NoMercy1]Но твоя \nвеличественность \nвовсе не во благе.[w:6][func:head]\nА в пороке."}
			rus={"[func:NoMercy1][func:DUB,phase3/21/1][w:5][speed:0.88]Я[w:1] изучала[w:1] тебя[waitall:4][w:3]...", "[func:Think][func:DUB,phase3/21/2][w:3]Следила за ка[w:3]ждым \nтвоим шагом.[w:6] [func:head][speed:1.12]И \nпришла к некоторым \nинтересным выводам.", "[func:NoMercy1][func:DUB,phase3/21/3][w:5][speed:1.20]Азриэль верил,[w:3] что \nты великий человек.[w:9] \n[func:Think][speed:0.88]Так и есть.", "[func:NoMercy1][func:DUB,phase3/21/4][w:5][speed:1.20]Но твоя \nвеличественность[w:1] \nвовсе не во благе.[w:12][func:head][speed:0.90]\nА в поро[w:2]ке."}
			neng={"[func:NoMercy1]I studied you.", "[func:Think]I followed your every\nstep.[w:6] [func:head]And I did come \nto few interesting \nconclusions.", "[func:NoMercy1]Asriel believed \nyou're a great \nperson.[w:6] \n[func:Think]So you are.", "[func:NoMercy1]But your greatness \nis not in your good \nwill,[w:3] [func:head]but in your sin."}
			engcom="Don't hesitate.[w:6] \nIt's battle for exhausting."
			ruscom="Не колеблись.[w:6] \nЭто бой на выносливость."
			end
			wav={"phase3/asrielaser"}
		elseif GetGlobal("progress")==22 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"[func:NoMercy1]Твой порок - \n[func:head]неутолимый голод.", "Ты жаждешь всё \nбольше и больше.", "Твоя жадность \nпоглощает собой \nвесь мир.", "[func:Think]Для тебя нет \n'чужого'.[waitall:1][w:6] [func:head]\nЕсть лишь [waitall:2][w:1]'моё'", "[func:NoMercy1]И именно поэтому \nты раз за разом \nуничтожаешь всё,[w:3] \nчто мне дорого.", "[func:head]Ты ненасытен."}
			rus={"[func:NoMercy1][func:DUB,phase3/22/1][w:4][speed:0.90]Твой порок -[w:1] \n[func:head]неутолимый[speed:0.65] голод.", "[func:DUB,phase3/22/2][w:4][speed:0.98]Ты жаждаешь[speed:0.80] всё \nбо[w:1]льше и бо[w:1]льше.", "[func:DUB,phase3/22/3][w:4][speed:0.96]Твоя жадность \nпоглощает собой[speed:0.70][w:1] \nвесь мир.", "[func:Think][func:DUB,phase3/22/4][w:5]Для тебя нет[speed:0.65] \n'чужого'.[speed:0.85][waitall:1][w:6] [func:head]\nЕсть лишь [w:5][speed:0.35][w:1]'моё'.", "[func:NoMercy1][func:DUB,phase3/22/5][w:2]И[w:1] именно поэтому[w:1] \nты раз[w:2] за ра[w:2]зом \nуничтожа[w:1]ешь всё,[w:1] \nчто мне до[w:1]ро[w:1]го!", "[func:head][func:DUB,phase3/22/6][w:5][speed:0.85]Ты не[speed:0.65]насы[speed:0.50]тен."}
			neng={"[func:NoMercy1]Your sin [w:3]-[w:3] \n[func:head]unstoppable hunger.", "You want more \nand more.", "Your selfishness \nis eating the whole \nworld.", "[func:Think]For you there's \nno <other's>,[waitall:1][w:3] [func:head]but[waitall:2] \n<mine>[waitall:1],[w:3] isn't it?", "[func:NoMercy1]And that's the \nreason to destroy \neverything I love \nover and over.", "[func:head]You're voracious."}
			engcom="All this hunger chatting makes \rme hungry for real[waitall:4][w:3]..."
			ruscom="После этой тирады захотелось \rперекусить[waitall:4][w:3]..."
			end
			wav={"phase3/SoulOfHunger"}
		elseif GetGlobal("progress") == 23 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"[func:head4]Все эти разговоры \nо голоде[waitall:4][w:3]...", "Я[waitall:4][w:3]...[waitall:1][w:3] я вспоминаю \nмамину выпечку[waitall:4][w:3]...", "[func:Peachy]Её голос[waitall:4][w:3]...[waitall:1][w:3] Cамый \nзвонкий.", "Я слышу его \nотчетливее других.", "[func:head4]Он[waitall:4][w:3]...[waitall:1][w:3] он будто \nвыжигает мои уши[waitall:4][w:3]...", "[func:NoMercy1][waitall:4][w:3]...", "Взамен всей этой \nболи я[waitall:4][w:3]...[waitall:1][w:3] [func:head]Я выжгу \nтебя!" }
			rus={"[func:head4][func:DUB,phase3/23/1][w:3][speed:1.20]Все эти разговоры \nо [speed:0.90]голоде[waitall:4][w:3]...", "[func:DUB,phase3/23/2][w:4]Я[waitall:3][w:2]...[waitall:1][w:3][speed:0.90] я вспоминаю \nмамину выпечку[waitall:4][w:3]...", "[func:Peachy][func:DUB,phase3/23/3][w:4][speed:0.70]Её голос[waitall:3][w:2]...[waitall:1][w:3][speed:0.80] Cамый \nзвонкий.", "[func:DUB,phase3/23/4][w:4][speed:0.94]Я слышу его \nотчетливее [w:1]других.", "[func:head4][func:DUB,phase3/23/5][w:3]Он[waitall:4][w:3]...[waitall:1][w:3] он будто[speed:0.80] \nвыжигает мои у[w:1]ши[waitall:4][w:3]...", "[func:NoMercy1][waitall:4][w:3]...", "[func:DUB,phase3/23/6][w:3][speed:0.90]Взамен всей[speed:0.90] этой \nболи я[waitall:3][w:3]...[waitall:1][w:3] [func:head][speed:0.70]Я ВЫЖГУ \nТЕ[w:1]БЯ!" }
			neng={"[func:head4]All this hunger \ntalking[waitall:4][w:3]...", "I[waitall:4][w:3]...[waitall:1][w:3] I remember \nmom's pastries[waitall:4][w:3]...", "[func:Peachy]Her voice[waitall:4][w:3]...[waitall:1][w:3] is the \nloudest one.", "I hear her so \nclearly[waitall:4][w:3]...", "[func:head4]It[waitall:4][w:3]...[waitall:1][w:3] It is burning \nmy ears[waitall:4][w:3]...", "[func:NoMercy1][waitall:4][w:3]...", "Instead of this pain,[w:3] \nI[waitall:4][w:3]...[waitall:1][w:3] [func:head]I will burn you!"}
			engcom="Don't get burned."
			ruscom="Не обожгись."
			end
			wav={"phase3/firespears"}
		elseif GetGlobal("progress") == 24 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"[func:thoughts]Я вижу это пламя[waitall:4][w:3]...", "[func:head4]И перед глазами \nмелькают образы из \nдетства.", "Пожар[waitall:4][w:3]...[waitall:1][w:3] \nДеревня[waitall:4][w:3]...", "[func:trigeredclosed]Гх[waitall:4][w:3]...[waitall:1][w:3] [func:trigered]Почему ты \nне можешь наконец \nсдохнуть?!", "Сгори в аду,[w:3] чёртов \nпсих!"}
			rus={"[func:thoughts][func:DUB,phase3/24/1][w:3][speed:0.85]Я вижу это[w:1] пламя[waitall:4][w:3]...", "[func:head4][func:DUB,phase3/24/2][w:5]И перед глазами[speed:1.10] \nмелькают образы из[speed:0.90] \nдетства.", "[func:DUB,phase3/24/3][w:5][speed:0.60]Пожар[waitall:2][w:1]...[waitall:1][w:1][speed:0.54] \nДеревня[waitall:2][w:1]...", "[func:trigeredclosed][func:DUB,phase3/24/4][w:5]Гх[waitall:3][w:2]...[waitall:1][w:2] [func:trigered][speed:0.65]Почему[speed:0.75] ты \nне можешь наконец \nСДОХНУТЬ?!", "[func:DUB,phase3/24/5][w:5][speed:0.75]С[w:2]гори в аду,[w:1] чёртов \nпсих!"}
			neng={"[func:thoughts]When I see this \nflame[waitall:4][w:3]...", "[func:head4]It's like memories \nof the past are \nin front of me[waitall:4][w:3]...", "Fire[waitall:4][w:3]...[waitall:1][w:3] \nVillage[waitall:4][w:3]...", "[func:trigeredclosed]Ugh[waitall:4][w:3]...[waitall:1][w:3] [func:trigered]Why can't you \njust die already?!", "Burn in hell,[w:3] you \ndamn psycho!"}
			engcom="Chara seems to be mad.[w:6] \nFor some reason[waitall:4][w:3]?.."
			ruscom="Чара выглядит безумной.[w:6] \nПо какой-то причине?"
			end
			wav={"phase3/RandomFire"}
		elseif GetGlobal("progress") == 25 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"[func:Final_1]Погодите[waitall:4][w:3]...", "Я[waitall:4][w:3]...[waitall:1][w:3] [func:NoMercy1]Я поняла.", "[func:closedyesend]Ты такой же,[w:3] \nкак и они[waitall:4][w:3]...", "Жадный и полный \nненависти человек.", "[func:NoMercy1][waitall:4][w:3]...", "Сначала[w:6] я хотела \nтебе верить.[w:6] \n[func:Think]Правда,[w:3] хотела.", "[func:NoMercy1]Но сейчас[waitall:4][w:3]...[waitall:1][w:3] \nНет пощады таким,[w:3] \n[func:head]как ты." }
			rus={"[func:Final_1][func:DUB,phase3/25/1][w:5][speed:0.76]Погодите[waitall:4][w:3]...", "[func:DUB,phase3/25/2][w:5]Я[waitall:4][w:3]...[waitall:1][w:4][speed:0.66] [func:NoMercy1]Я поняла.", "[func:closedyesend][func:DUB,phase3/25/3][w:4][speed:0.80]Ты такой же[waitall:4][w:3]...[waitall:1][w:2][speed:0.80] \nКак и они[waitall:4][w:3]...", "[func:DUB,phase3/25/4][w:5][speed:0.85]Жадный и полный \nненависти человек.", "[func:NoMercy1][waitall:4][w:3]...", "[func:DUB,phase3/25/5][w:4][speed:0.93]Сначала я хотела \nтебе верить.[w:5] \n[func:Think]Правда,[w:1] хотела.", "[func:NoMercy1][func:DUB,phase3/25/6][w:5][speed:0.80]Но сейчас[waitall:3][w:2]...[waitall:1][w:3][speed:0.70] \nНет[speed:0.88] пощады таким,[w:2] \n[func:head]как ты." }
			neng={"[func:Final_1]Wait[waitall:4][w:3]...", "I[waitall:4][w:3]...[waitall:1][w:3] [func:NoMercy1]I got it.", "[func:closedyesend]You are almost like \nthem[waitall:4][w:3]...", "Greedy and hateful \nhuman.", "[func:NoMercy1][waitall:4][w:3]...", "At first[w:6] I wanted to \nbelieve you.[w:6]\n[func:Think]Really,[w:3] wanted.", "[func:NoMercy1]But now[waitall:4][w:3]...[waitall:1][w:3] \nNo mercy for \nsomeone [func:head]like you."}
			engcom="Chara has frozen,[w:3] starring \rinto you. "
			ruscom="Чара замерла,[w:3] пристально глядя \rвам в глаза."
			Encounter.SetVar("evadelevel",2)
			end
			wav={"phase3/NotMiddleRoad"}
		elseif GetGlobal("progress") == 26 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"[func:Final_1]Казалось,[w:3] будто я \nувидела в твоих \nглазах раскаяние[waitall:4][w:3]...", "[noskip][func:QuietMusic][func:Final_5]Лишь на миг,[w:3] но[waitall:4][w:3]...", "Милое зеркальце.[w:9] \nПартнёр.[w:9] \nКомпаньон.", "[func:Final_5]Если ты[waitall:4][w:3]...[waitall:1][w:3] \nЕсли ты слышишь[waitall:4][w:3]...", "[func:Music,spare]Я[waitall:4][w:3]...[waitall:1][w:3][func:Final_1] [func:HideKnife]Я хочу дать \nтебе шанс[waitall:4][w:3]...", "[func:head4]Но если нет[waitall:4][w:3]...[waitall:1][w:3] \nЕсли я ошибаюсь[waitall:4][w:3]...", "[waitall:4][w:3]...", "[func:Final_7]То тогда я \nдействительно \nдура[waitall:4][w:3]...","[func:Peachy][w:10][func:mercy][next]"}
			rus={"[func:Final_1][func:DUB,phase3/26/1][w:5]Казалось,[w:3] будто я \nувидела в [speed:1.10]твоих \nглазах раска[w:2][speed:0.80]яние[waitall:4][w:3]...", "[noskip][func:QuietMusic][func:Final_5][func:DUB,phase3/26/2][w:5]Лишь на миг,[w:3] но[waitall:4][w:3]...", "[func:DUB,phase3/26/3][w:6]М[w:1]илое зеркальце.[w:9][speed:0.90] \nПартнёр.[w:11][speed:0.80] \nКомпаньон.", "[func:Final_5][func:DUB,phase3/26/4][w:5][speed:0.90]Если ты[waitall:4][w:3]...[waitall:1][w:3] \nЕсли ты слы[w:2]шишь[waitall:4][w:3]...", "[func:Music,spare][func:DUB,phase3/26/5][w:5]Я[waitall:4][w:3]...[waitall:1][w:7][func:Final_1] [func:HideKnife]Я хочу дать \nтебе шанс[waitall:4][w:3]...", "[func:head4][func:DUB,phase3/26/6][w:5][speed:0.80]Но если нет[waitall:3][w:2]...[waitall:1][w:1][speed:0.74] \nЕсли я ошиба[w:1]юсь[waitall:4][w:3]...", "[waitall:4][w:3]...", "[func:Final_7][func:DUB,phase3/26/7][w:4]То тогда я[speed:1.25] \nдействительно [speed:1.40]\nдура[waitall:4][w:3]...","[func:Peachy][w:10][func:mercy][next]"}
			neng={"[func:Final_1]I felt like[waitall:4][w:3]...[waitall:1][w:3] \nI saw remorse in \nyour eyes[waitall:4][w:3]...", "[noskip][func:QuietMusic][func:Final_5]Only for a moment,[w:3] \nbut[waitall:4][w:3]...", "Pretty mirror.[w:9] \nPartner.[w:9]\nCompanion.", "[func:Final_5]If you[waitall:4][w:3]...[waitall:1][w:3] \nIf you hear me[waitall:4][w:3]...", "[func:Music,spare]I[waitall:4][w:3]...[waitall:1][w:3] [func:Final_1][func:HideKnife]I want to \ngive you a chance[waitall:4][w:3]...", "[func:head4]But if no[waitall:4][w:3]...[waitall:1][w:3] \nIf I have been \nwrong[waitall:4][w:3]...", "[waitall:4][w:3]...", "[func:Final_7]Then I really am \na fool.","[func:Peachy][w:10][func:mercy][next]"}
			engcom="Chara is giving you second \rchance.[w:10][speed:0.75] \n[color:8040ff]Do not you dare, darling..."
			ruscom="Чара даёт вам второй шанс. \n[w:10][speed:0.75][color:8040ff]Даже не смей, дорогуша..."
			end
			wav={"nothing"}
			--if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
				Encounter.SetVar("forcedfight",true)
				Encounter.SetVar("FightGoes",false)
			--end
	------------------------------------------------------------------------
		elseif GetGlobal("progress") == 27 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"Гх!", "[func:deadly][waitall:4][w:3]...", "[func:closedyesend]Ну конечно[waitall:4][w:3]...", "[func:NoMercy1]Даже если ты \nи слышишь[waitall:4][w:3]...[waitall:1][w:3] \n[func:Think]Ты не выше \nпоследствий.", "[func:NoMercy1]Сила нашего с тобой \nУР[waitall:4][w:3]...[waitall:1][w:3] \n[func:Think]Слишком высока,[w:3] \nчтобы ей \nпротивостоять.", "[func:head]У тебя есть высшая \nцель.[w:6] \nКак и у меня.", "[func:Devil]Так что давай не \nбудем отступать от \nнеё."}
			rus={"[func:DUB,phase3/27/1][w:8]Гх!", "[func:deadly][waitall:4][w:3]...", "[func:closedyesend][func:DUB,phase3/27/2][w:5][speed:0.75]Ну [speed:0.65]конечно[waitall:4][w:3]...", "[func:NoMercy1][func:DUB,phase3/27/3][w:4][speed:0.90]Даже если ты \nи слышишь[waitall:3][w:2]...[waitall:1][w:2] \n[func:Think]Ты не выше \nпоследствий.", "[func:NoMercy1][func:DUB,phase3/27/4][w:6]Сила[speed:0.90] нашего с тобой [w:2]\nУ[w:2]Р[w:1] \n[func:Think][speed:1.15]слишком велика,[w:1] \nчтобы ей \nпротивостоять.", "[func:head][func:DUB,phase3/27/5][w:6][speed:0.90]У тебя есть высшая \nцель.[w:9][speed:0.80] \nКак и у меня.", "[func:Devil][func:DUB,phase3/27/6][w:5][speed:1.15]Так что[w:1] давай не \nбудем[speed:1.25] отступать от \nнеё."}
			neng={"Ugh!", "[func:deadly][waitall:4][w:3]...", "[func:closedyesend]Obvious[waitall:4][w:3]...", "[func:NoMercy1]Even if you \nhear me[waitall:4][w:3]...[waitall:1][w:3] \n[func:Think]You're not above \nconsequences.", "[func:NoMercy1]Power of our LV[waitall:4][w:3]...[waitall:1][w:3] \n[func:Think]Is too high for \nresisting.", "[func:head]You have an utter \nmission to complete.[w:6] \nMe as well.", "[func:Devil]So let's not get \ndistracted."}
			ruscom="Чара разочарована в вас."
			engcom="Chara seems disappointed in you."
			end
			wav={"phase3/shadows"}
			--if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
				Encounter.SetVar("forcedfight",false)
				Encounter.SetVar("FightGoes",true)
				Encounter.SetVar("globalstage","2")
				Encounter.Call("WriteSavio")
			--end
		elseif GetGlobal("progress") == 28 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"[func:head]Мой папа,[w:3] Асгор,[w:3] \nизучал мою Душу.", "[func:NoMercy1]Он изучал,[w:3] что \nтакое человеческая \nРешимость.", "[func:Think]Он добился \nинтересных \nрезультатов.[w:6] \nКак я считаю.", "[func:NoMercy1]Ты,[w:3] конечно же,[w:3] \n[func:Bad]знаешь о \nфункциональном \nменю и \nСохранениях[waitall:4][w:3]...", "[func:NoMercy1]Но ты понятия не \nимеешь о[waitall:4][w:3]...[waitall:1][w:3] [func:head]\n[waitall:2]Деформировании[waitall:1][w:3]."}
			rus={"[func:head][func:DUB,phase3/28/1][w:6][speed:0.75]Мой папа,[w:6] Асгор,[w:12][speed:0.94] \nизучал мою Душу.", "[func:NoMercy1][func:DUB,phase3/28/2][w:2]Он изучал,[w:3] что \nтакое человеческая \nРешимость.", "[func:Think][func:DUB,phase3/28/3][w:5]Он добился[speed:1.05] \nинтересных \nрезультатов.[w:6] \nКак я считаю.", "[func:NoMercy1][func:DUB,phase3/28/4][w:5][speed:1.10]Ты, конечно же, \n[func:Bad]знаешь о[speed:1.00] \nфункциональном \nменю и \nСохранениях[waitall:4][w:3]...", "[func:NoMercy1][func:DUB,phase3/28/5][w:5][speed:1.05]Но[w:2] ты понятия не \nимеешь[w:2] о[waitall:3][w:2]...[waitall:1][w:2] [func:head][speed:0.90]\nДеформировании[waitall:1][w:3]."}
			neng={"[func:head]My dad,[w:3] Asgore,[w:3] \nstudied my Soul.", "[func:NoMercy1]He studied human \nDetermination.", "[func:Think]And he achieved \ninteresting \nresults.", "[func:NoMercy1]Of course,[w:3] [func:Bad]you \nknow about \nfunctional menu \nand Saving[waitall:4][w:3]...", "[func:NoMercy1]But you have \nno idea[waitall:4][w:3]...[waitall:1][w:3] [func:head]what \n[w:3][waitall:2]Defragmenting[waitall:1][w:3] is."}
			engcom="Now it seems interesting."
			ruscom="Теперь это кажется интересным."
			end
			wav={"phase3/listopad"}
		elseif GetGlobal("progress") == 29 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"[func:NoMercy1]Когда папа смог \nсинтезировать \nискусственную \nРешимость[waitall:4][w:3]...", "[func:head4]Она не прижилась.[w:6] \n[func:sad]Тела монстров были \nобезображены.[w:6] \nОни слились в \nАмальгамов.", "[func:head4]Ты знаешь эту \nисторию.", "Однако[waitall:4][w:3]...[waitall:1][w:3] Был второй \nэксперимент.[w:6] \nПохожий.", "[func:NoMercy1]Но с моей \nРешимостью.", "[func:Think]С естественной.[w:6] Я \nприняла выведенную \nим искусственную \nРешимость.", "[func:NoMercy1]И[waitall:4][w:3]...[waitall:1][w:3] [func:head]и это дало свои \nплоды."}
			rus={"[func:NoMercy1][func:DUB,phase3/29/1][w:5][speed:1.12]Когда папа смог \nсинтезировать \nискусственную \nРешимость[waitall:4][w:3]...", "[func:head4][func:DUB,phase3/29/2][w:5]Она не прижилась.[w:9][speed:0.88] \n[func:sad]Тела монстров были \nобезображены.[w:9] \nОни слились в \nАмальгамов.", "[func:head4][func:DUB,phase3/29/3][w:4]Ты знаешь эту \nисторию.", "[func:DUB,phase3/29/4][w:5][speed:0.90]Одна[w:2]ко,[w:3] был второй [speed:1.05]\nэксперимент.[w:7] \nПохожий.", "[func:NoMercy1][func:DUB,phase3/29/5][w:5][speed:0.80]Но[w:4] с моей \nРешимостью.", "[func:Think][func:DUB,phase3/29/6][w:5]С естественной.[w:6] Я \nприняла[w:1] выведенную \nим[w:2] искусственную \nРешимость.", "[func:NoMercy1][func:DUB,phase3/29/7][w:5]И[waitall:3][w:2]...[waitall:1][w:2] [func:head]это дало свои \nплоды."}
			neng={"[func:NoMercy1]When dad \nsynthesized \nartificial \nDetermination[waitall:4][w:3]...", "[func:head4]It was a failure.[w:6] \n[func:sad]Monsters body were \ndamaged and they \nmelted into \nAmalgamates.", "[func:head4]You know this story.", "Perhaps[waitall:4][w:3]...[waitall:1][w:3] \nThere was another \nexperiment [w:6] \nPretty similar.", "[func:NoMercy1]But based on my \nDetermination.", "[func:Think]Natural type.[w:6] \nI injected his \nartificial \nDetermination.", "[func:NoMercy1]And[waitall:4][w:3]...[waitall:1][w:3] [func:head]And it was \nsuccessful."}
			engcom="Did I hear this story before[waitall:4][w:3]?.."
			ruscom="Мне кажется, или я слышал эту историю[waitall:4][w:3]?.."
			end
			wav={"phase3/krug"}
		elseif GetGlobal("progress") == 30 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			Encounter.SetVar("evadelevel",3)
			nrus={"[func:NoMercy1]Помимо текущего \nтаймлайна \nпараллельно \nсуществует \nмножество других.", "[func:head4]Я[waitall:4][w:3]...[waitall:1][w:3] я увидела их,[w:6][func:sad]\nкогда Решимость \nначала реакцию.", "Я видела хорошие \nконцовки,[w:3] \nальтернативные \nверсии себя[waitall:4][w:3]...", "Даже[waitall:4][w:3]...[waitall:1][w:3] [waitall:2][w:3][func:deadly]себя[waitall:1][w:3] на \nтвоём месте.", "[func:head4]Всё это[waitall:4][w:3]...[waitall:1][w:3] [func:thoughts]не \nукладывалось у меня \nв голове.", "[func:head4]Тогда я не понимала,[w:3] \nк чему были эти \nобразы.", "[func:head4]Сейчас[waitall:4][w:3]...[waitall:1][w:3] [func:NoMercy1]Я всё \nпоняла.[w:6] [func:head]\nНе трудно сложить \nдва и два."}
			rus={"[func:NoMercy1][func:DUB,phase3/30/1][w:3][speed:1.05]Помимо [speed:0.90]текущего[speed:1.05] \nтаймла[w:2]йна \nпараллельно \nсуществует \nмно[w:2]жество других.", "[func:head4][func:DUB,phase3/30/2][w:5]Я[waitall:3][w:3]...[waitall:1][w:2][speed:0.90] я увидела их,[w:6][func:sad]\nкогда [speed:1.00]Решимость[speed:1.15] \nначала [speed:1.00]реакцию.", "[func:DUB,phase3/30/3][w:5]Я[w:2] видела[w:1] хорошие[w:1] \nконцовки,[w:1] \nальтернативные[w:1] \nверсии себя[waitall:4][w:3]...", "[func:DUB,phase3/30/42][w:5]Да[w:2]же[w:4] [func:deadly]се[w:2]бя[waitall:1][w:5] на \nтвоём[w:1] ме[w:2]сте.", "[func:head4][func:DUB,phase3/30/5][w:3]Всё это[waitall:3][w:2]...[waitall:1][w:2] [func:thoughts][speed:1.19]не \nукладывалось у меня \nв голове[waitall:3][w:2]...[waitall:1][w:2]", "[func:head4][func:DUB,phase3/30/6][w:3][speed:1.19]Тогда я не понимала,[w:2] \nк чему были [speed:1.09]эти \nобразы.", "[func:DUB,phase3/30/7][w:4][func:head4][speed:0.80]Сейчас[waitall:3][w:2]...[waitall:1][w:2] [func:NoMercy1]Я всё \nпоняла.[w:6] [speed:1.20][func:head]\nНе трудно сложить[speed:1.60] \nдва и два."}
			neng={"[func:NoMercy1]Besides current \ntimeline another \nones exists as well.", "[func:head4]I[waitall:4][w:3]...[waitall:1][w:3] I did see them.[w:6][func:sad]\nWhen Determination \nbegan reacting.", "I saw good endings,[w:3] \nalternate selves[waitall:4][w:3]...", "Even[waitall:4][w:3]...[waitall:1][w:3] [waitall:2][w:3][func:deadly]Myself[waitall:1][w:3] on \nyour place.", "[func:head4]All of this[waitall:4][w:3]...[waitall:1][w:3] \n[func:thoughts]Blew my mind.", "[func:head4]That day I couldn't \nunderstand what I \nsaw.", "But now[waitall:4][w:3]...[waitall:1][w:3] [func:NoMercy1]I get it \nclearly.[w:6] [func:head]Not so hard \nto sum one and one."}
			engcom="Chara recovered few of her sanity.[w:6] \nBut she is exhausted as well."
			ruscom="Чара восстанавливает ясность ума.[w:6]\nНо настолько же она и устала."
			end
			--Encounter.SetVar("wavetimer", 20.0)
			wav={"phase3/brave"}
		elseif GetGlobal("progress") == 31 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"[func:Peachy]Андайн\nбеспокоилась,[w:3] что \nАсгор зря ввязал \nменя,[w:3] ребёнка,[w:3] в \nсвои работы.", "Она настаивала,[w:3] \nчтобы я больше не \nвмешивалась.", "[func:Remember]Мои силы были \nслишком ценны для \nеё боевой арены.", "[func:Peachy]Она не хотела \nтерять такого \nоппонента,[w:3] как я.", "[func:mercy]Мне льстила такая \nвысокая оценка.", "[func:Peachy]Андайн умела \nподнять боевой \nдух.[w:6] Азриэль всегда \nей вдохновлялся.", "[func:NoMercy1][waitall:2]Теперь[waitall:1][w:6] [func:head]моя очередь."}
			rus={"[func:Peachy][func:DUB,phase3/31/1][w:4]Андайн\nбеспокоилась,[w:1] что \nАсгор зря ввязал \nменя,[w:8] ребёнка,[w:2] в \nсвои[w:1] работы.", "[func:DUB,phase3/31/2][w:5][speed:1.12]Она настаивала, \nчтобы я больше не \nвмешивалась.", "[func:Remember][func:DUB,phase3/31/3][w:4]Мои силы были[speed:0.75] \nслишком [speed:1.00]ценны для \nеё[w:1] боевой[w:1] арены.", "[func:Peachy][func:DUB,phase3/31/4][w:4]Она не хотела \nтерять такого \nоппонента,[w:1] как я.", "[func:mercy][func:DUB,phase3/31/5][w:5]Мне[w:3][speed:1.19] льстила такая \nв[speed:0.90]ысокая оценка.", "[func:Peachy][func:DUB,phase3/31/6][w:3][speed:0.94]Анда[w:1]йн[w:1] умела \nподнять боевой \nдух.[w:6] Азриэль всегда \nей вдохновлялся.", "[func:head][func:DUB,phase3/31/7][w:4][speed:0.85]Теперь моя[speed:0.78] очередь."}
			neng={"[func:Peachy]Undyne worried that \nAsgore was wrong \nwhen pulled me,[w:3] kid,[w:3] \nin experiments.", "She insisted to not \nbother me.", "[func:Remember]My powers were too \nprecious for her \nbattle arena.", "[func:Peachy]She didn't want to \nlose such a \nfighter as me.", "[func:mercy]I was pleased with \nsuch respect.", "[func:Peachy]Undyne could always \nrise your battle \nspirit.[w:6] Asriel was \ninspired by her.", "[func:NoMercy1][waitall:2]Now[waitall:1][w:6] [func:head]so am I."}
			engcom="Sushi are served cold and without knifes."
			ruscom="Суши подаются холодными и без ножей."
			end
			wav={"phase3/und"}
		elseif GetGlobal("progress") == 32 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"[func:NoMercy1]Теперь,[w:3] когда я \nизучаю таймлайны,[w:3] \n[func:Think]я всё больше и \nбольше понимаю, как \nработает моя \nпамять", "[func:NoMercy1]Тот раз,[w:3] когда я \nприняла \nискусственную \nРешимость,[w:3] стал \nрешающим фактором.", "Ты понимаешь,[w:3][func:Bad] о \nчем я?", "[w:2][waitall:2][func:NoMercy1]Да[waitall:4][w:3]...[waitall:1][w:3] Именно в тот \nдень [w:6][func:head]я получила \nспособность читать \nвременные линии."}
			rus={"[func:NoMercy1][func:DUB,phase3/32/1][w:4]Теперь,[w:3] когда я \nизучаю таймлайны,[w:3] \n[func:Think]я всё больше и \nбольше понимаю, как[speed:1.02] \nработает моя \nпамять.", "[func:NoMercy1][func:DUB,phase3/32/2][w:4]Тот раз,[w:2][speed:1.15] когда я \nприняла \nискусственную \nРешимость,[w:5][speed:0.95] стал \nрешающим [w:1]фактором.", "[func:DUB,phase3/32/3][w:4]Ты понимаешь,[w:2][func:Bad] о \nчем[w:1] я?", "[w:5][waitall:2][func:NoMercy1][func:DUB,phase3/32/4][w:3]Да[waitall:4][w:2]...[waitall:1][w:1][speed:0.90] Именно в тот \nдень [func:head]я получила[speed:1.05] \nспособность читать \nвременные линии."}
			neng={"[func:NoMercy1]Now,[w:3] as I studied \nthose timelines,[w:3] [func:Think]I \nhave understood \nmore about my \nmemory.", "[func:NoMercy1]It was a key factor \nto the truth,[w:3] when \nI injected artificial \nDT.", "Did you get [func:Bad]what \nI mean?", "[w:2][waitall:2][func:NoMercy1]Yes[waitall:4][w:3]...[waitall:1][w:3] In that very \nday[w:6] [func:head]I got the power \nto read timelines."}
			engcom="She[waitall:4][w:3]...[waitall:1][w:3] She [waitall:2][w:3]WHAT?"
			ruscom="Она[waitall:4][w:3]...[waitall:1][w:3] Она [waitall:2][w:3]ЧТО?"
			end
			wav={"phase3/k_random1"}
		elseif GetGlobal("progress") == 33 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"[func:head4]Не знаю,[w:3] что это \nбыло.[w:6] Судьба,[w:3] карма.[w:6] \n[func:sad]Без разницы.", "Главное,[w:3] [func:head4]что я \nблагодарю и \nпроклинаю эту силу \nодновременно.", "[func:sad]Из-за неё я вижу \nсмерти близких мне \nлюдей каждый \nраз,[w:3] как открываю \nглаза.", "[func:NoMercy1]Но с другой?[w:6] [func:head]Я как \nникогда ближе к \nтому,[w:3] чтобы изгнать \nтебя.", "[func:NoMercy1]Твоя сила[waitall:4][w:3]...[waitall:1][w:3] [func:Bad]Ты \nзнаешь о других \nтаймлайнах?", "[func:head]Ты как никто другой \nзнаешь,[w:3] что я хочу \nсделать."}
			rus={"[func:head4][func:DUB,phase3/33/1][w:6]Не знаю, что это \nбыло.[w:8] Судьба,[w:12][speed:0.80] ка[w:2]рма.[w:12][speed:0.90] \n[func:sad]Без разницы.", "[func:DUB,phase3/33/2][w:4]Главное, [func:head4]что я[speed:0.95] \nблагодарю и \nпроклинаю эту силу \nодновременно.", "[func:sad][func:DUB,phase3/33/3][w:4]Из-за неё я вижу \nсмерти близких мне \nлюдей[w:1] ка[w:2]ждый \nраз,[w:1] когда открываю \nглаза.", "[func:NoMercy1][func:DUB,phase3/33/4][w:4]Но[w:3] с другой.[w:3].[w:3].[w:3] [func:head]Я как \nникогда ближе к \nтому, чтобы изгнать \nтебя.", "[func:NoMercy1][func:DUB,phase3/33/5][w:7][speed:0.75]Твоя сила[waitall:4][w:3]...[waitall:1][w:3] [func:Bad][speed:1.00]Ты \nзнаешь о других[speed:1.10] \nтаймлайнах?", "[func:head][func:DUB,phase3/33/6][w:4][speed:0.90]Ты как никто другой \nзнаешь, что я хочу \nсделать."}
			neng={"[func:head4]I dunno how to call \nit.[w:6] Fate [w:3]or karma [w:3]-\n[func:sad]whatever.", "What's matter [w:3]- [func:head4]I am \nthanking and hating \nthis power in the \nsame time.", "[func:sad]With it I see my \nrelatives dying every \ntime I open my eyes.", "[func:NoMercy1]But on opposite \nside?[w:6] [func:head]I never \nwas so close to \ndefeating you.", "[func:NoMercy1]Your power[waitall:4][w:3]...[waitall:1][w:3] [func:Bad]You \ndo know about other \ntimelines,[w:3] don't you?", "[func:head]You as no one else\nknow what I am \nintending to do."}
			engcom="She is trying to defeat us with our weapon.[w:6] Catch this dodging squirrel already!"
			ruscom="Она пытается одолеть нас нашим же оружием.[w:6] Поймай же эту изворотливую белку!"
			end
			wav={"phase3/k_random2"}
		elseif GetGlobal("progress") == 34 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"[func:head4]Наш Король[waitall:4][w:3]...", "[func:sad]Я дала ему клятву,[w:3] \nчто остановлю \nлюбого человека,[w:3] \nкоторый станет на \nпути Стражи.", "[func:head4]Он желает твоей \nсмерти так же,[w:3] \nкак и я.", "[func:NoMercy1]Его мотивы,[w:3] а \nтеперь и его сила[waitall:4][w:3]...", "Я будто с ним на \nодной волне.[w:6] [func:head]\nМоя воля никогда \nне была так крепка."}
			rus={"[func:head4][func:DUB,phase3/34/1][w:5][speed:0.75]Наш[w:4] Король[waitall:4][w:3]...", "[func:sad][func:DUB,phase3/34/2][w:4]Я дала ему клятву,[w:2] \nчто остановлю \nлю[w:1]бого человека,[speed:1.10] \nкоторый станет на \nпути [w:1]Стражи.", "[func:head4][func:DUB,phase3/34/3][w:4][speed:0.94]Он желает твоей \nсмерти так же, \nкак и я.", "[func:NoMercy1][func:DUB,phase3/34/4][w:4][speed:0.85]Его моти[w:1]вы[waitall:3][w:2]...[waitall:1][w:2] [speed:0.95]а \nтеперь и его сила[waitall:4][w:3]...", "[func:DUB,phase3/34/5][w:4]Я будто с ним на \nодной волне.[w:11] [func:head]\nМоя воля ни[w:1]ко[w:1]гда \nне была [w:1]так [w:1]крепка."}
			neng={"[func:head4]Our King[waitall:4][w:3]...", "I[func:sad] promised that \nno human will \nget through the \nGuard.", "[func:head4]He wishes you dead \nas well as I do.", "[func:NoMercy1]His motives and \nnow [w:4]- his power[waitall:4][w:3]...", "It's almost like \nhe's beside me.[w:6] \n[func:head]My will never \nwas so strong."}
			engcom="It seems like this situation[waitall:4][w:3]...[waitall:1][w:3] cut her to the bone.[w:6]\nHe-he."
			ruscom="Похоже,[w:3] эта ситуация[waitall:4][w:3]...[waitall:1][w:3] проняла её до костей.[w:6]\nХе-хе."
			end
			wav={"phase3/2lasers"}
		elseif GetGlobal("progress") == 35 then	
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"[func:Final_7]Как иронично,[w:3] что я \nстолько раз видела \nего смерть[waitall:4][w:3]...", "[func:Irony]В тех,[w:3] других \nтаймлайнах[waitall:4][w:3]...", "[func:head4]А в этом[waitall:4][w:3]...[waitall:1][w:3] [func:sad]При \nнашей первой \nвстрече он был \nготов убить меня.", "[func:NoMercy1]И какова ирония[waitall:4][w:3]...[waitall:1][w:3] \n[func:Think]Сейчас я служу ему.[w:6] \n[func:NoMercy1]Зная,[w:3] что скоро \nпробьет его час.", "[func:head4][waitall:4][w:3]...", "Может[waitall:4][w:3]...[waitall:1][w:3] Было бы \nлучше,[w:3] [func:sad]убей он меня \nтогда?","[func:head][next]"}
			rus={"[func:Final_7][func:DUB,phase3/35/1][w:5]Как иронично,[w:1] что я \nстолько раз видела \nего смерть[waitall:4][w:3]...", "[func:Irony][func:DUB,phase3/35/2][w:5]В тех,[w:10][speed:1.15] других \nтаймлайнах[waitall:4][w:3]...", "[func:head4][func:DUB,phase3/35/3][w:5]А в этом[waitall:3][w:2]...[waitall:1][w:2][speed:1.15] [func:sad]При \nнашей встрече \nон был готов \nубить [w:1]меня.", "[func:NoMercy1][func:DUB,phase3/35/4][w:5][speed:0.85]И какова ирония[waitall:3][w:3]...[waitall:1][w:2] \n[func:Think]Сейчас я служу ему.[w:8] \n[func:NoMercy1]Зная,[w:3] что скоро \nпробьет его [w:1]час.", "[func:head4][waitall:4][w:3]...", "[func:DUB,phase3/35/5][w:7]Мо[w:2]жет[waitall:3][w:2]...[waitall:1][w:2] Было бы \nлу[w:2]чше,[w:5] [func:sad]убей [w:1]он меня \nтогда?","[func:head][next]"}
			neng={"[func:Final_7]How ironical,[w:3] I saw \nhis death so many \ntimes[waitall:4][w:3]...", "[func:Irony]In those,[w:3] other \ntimelines.", "[func:head4]But in mine[waitall:4][w:3]...[waitall:1][w:3] [func:sad]He \nintended to kill me \nat the first sight.", "[func:NoMercy1]And how ironical,[w:3] [func:Think]now \nI am at his service.[w:6] \n[func:NoMercy1]And I know that his \ntime is running out.", "[func:head4][waitall:4][w:3]...", "Maybe[waitall:4][w:3]...[waitall:1][w:3] Would it be \nbetter [func:sad]if he killed \nme that day[waitall:4][w:3]?..","[func:head][next]"}
			engcom="Chara smiles gloomy."
			ruscom="Чара печально ухмыляется."
			end
			wav={"phase3/sans3"}
		elseif GetGlobal("progress") == 36 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"[func:head]А ведь он[waitall:4][w:3]...[waitall:1][w:3] [func:NoMercy1]он \nведь даже не \nподозревает.", "[func:Think]Сидит в тронном \nзале, ожидает \nчеловека[waitall:4][w:3]...", "С которым у него \nдолжен пройти бой \nза 'судьбу' монстров.", "[func:NoMercy1]Знал бы он, что на \nсамом деле \nпроисходит[waitall:4][w:3]...", "[func:Final_7]Это был бы слишком \nсильный удар для \nнего[waitall:4][w:3]...","[func:head][next]"}
			rus={"[func:head][func:DUB,phase3/36/1][w:5]А ведь он[waitall:4][w:3]...[waitall:1][w:3] [func:NoMercy1]он \nведь даже[speed:1.15] не \nподозревает.", "[func:Think][func:DUB,phase3/36/2][w:5][speed:0.90]Сидит в тронном \nзале,[w:5] ожидает[speed:0.85] \nчеловека[waitall:4][w:3]...", "[func:DUB,phase3/36/3][w:5]С которым у него \nдолжен пройти бой \nза[w:3][speed:0.60] 'судьбу'[speed:0.70][w:6] монстров.", "[func:NoMercy1][func:DUB,phase3/36/4][w:5]Знал бы он,[w:1] что на \nсамом деле \nпроисходит[waitall:4][w:3]...", "[func:Final_7][func:DUB,phase3/36/5][w:5]Это был бы[speed:0.85] слишком \nсильный удар для \nнего[waitall:4][w:3]...","[func:head][next]"}
			neng={"[func:head]And he[waitall:4][w:3]...[waitall:1][w:3] [func:NoMercy1]He still \nhas no clue what's \ngoing on.", "[func:Think]He sits in the throne \nroom, waiting for a \nhuman[waitall:4][w:3]...", "He waits for the \nbattle that will \ndecide monsters \n'fate'.", "[func:NoMercy1]How pity he doesn't \nknow that there's \nnothing to decide[waitall:4][w:3]...", "[func:Final_7]It would be too \ntough hit for him[waitall:4][w:3]...","[func:head][next]"}
			engcom="Would be better for her if she was thinking how tough will be our hit[waitall:4][w:3]...[waitall:1][w:3]"
			ruscom="Лучше бы подумала о том,[w:3] каким сильным будет наш удар по ней[waitall:4][w:3]...[waitall:1][w:3]"
			end
			wav={"phase3/sansnew"}
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
				currentdialogue = {"[noskip]"}
			end
		elseif GetGlobal("progress") == 37 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"[func:head]Я[waitall:4][w:3]...[waitall:1][w:3] [func:head4]Я не буду врать.", "Я устаю.[w:6] [func:sad]Ты и сам \nэто понимаешь.", "[func:head4]И эти голоса в \nголове[waitall:4][w:3]...[waitall:1][w:3] они \nне утихают.[w:6] Они всё \nгромче и громче.", "[func:sad]Что,[w:3] если даже этой \nсилы будет мало?[w:6] \nЧто,[w:3] если я вновь \nпроиграю?", "[func:NoMercy1]Чёрт,[w:3] если бы я \nзнала.", "Поживем [w:4]- увидим,[w:3][func:head] \nверно?[w:6] Хех[waitall:4][w:3]..."}
			rus={"[func:head][func:DUB,phase3/37/1][w:6]Я[waitall:4][w:3]...[waitall:1][w:4] [func:head4][speed:0.94]Я не буду врать.", "[func:DUB,phase3/37/2][w:5][speed:0.80]Я[w:1] устаю.[w:15] [func:sad][speed:0.85]Ты и сам \nэто понимаешь.", "[func:head4][func:DUB,phase3/37/3][w:5]И эти голоса в \nголове[waitall:3][w:2]...[waitall:1][w:2] Они \nне утихают.[w:9] Они всё \nгромче и громче.", "[func:sad][func:DUB,phase3/37/4][w:5]Что,[w:3] если[w:1] даже[w:1] этой [w:2]\nсилы[w:1] будет мало?[w:9] \nЧто,[w:3] если[w:1] я [w:1]вновь[w:2] \nпроиграю?", "[func:NoMercy1][func:DUB,phase3/37/5][w:5][speed:0.80]Чёрт,[w:10] если бы я \nзнала[waitall:4][w:3]...", "[func:DUB,phase3/37/6][w:5][speed:1.10]Поживем - увидим,[func:head] \nверно?[w:6][speed:0.82] Хе-хе[waitall:4][w:3]..."}
			neng={"[func:head]I[waitall:4][w:3]...[waitall:1][w:3] [func:head4]I'm not gonna \nlie.", "I am growing tired.[w:6] \n[func:sad]And you know it well.", "[func:head4]And those voices in \nmy head[waitall:4][w:3]...[waitall:1][w:3] They \ndidn't calm down.[w:6] \nOn opposite [w:4]- only \ngrew louder.", "[func:sad]What if even this \npower will be not \nenough?[w:6] What if I \nlose again?", "[func:NoMercy1]Hell,[w:3] if I know.", "We'll see in the \nend,[w:3][func:head] right?[w:6] \nHeh[waitall:4][w:3]..."}
			engcom="We highly likely will see it.[w:6]\nI wouldn`t be so sure about her tho."
			ruscom="Мы,[w:3] может,[w:3] и поживём.[w:6]\nОна -[w:3] вряд ли."
			end
			wav={"phase3/kniferain"}
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
				currentdialogue = {"[noskip]"}
			end
		elseif GetGlobal("progress") == 38 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"Хотя,[w:3] [func:NoMercy1]что тебе \nзнать о лишениях?", "[func:head]Ты ведь так жестоко \nрасправился с \nпитомцем Маффет[waitall:4][w:3]...", "Я лично ухаживала \nза ним.[w:6] Он был \nпочти что моим \nпитомцем.", "[func:sad]Если бы Маффет,[w:3] \nконечно,[w:3] знала \nслово [waitall:2][w:3]<делиться>[waitall:4][w:3]...", "[func:NoMercy1]А затем пришел ты.[w:6] [func:head]\nЖестоко \nрасправился с ними \nобоими[waitall:4][w:3]...", "[func:head4]Не знаю,[w:3] почему[waitall:4][w:3]...[waitall:1][w:3] \nНо во мне даже нет \nзлости,[w:3] когда я \nдумаю о Паукексе.", "Только [waitall:2][w:3]звенящая \nпустота[waitall:1][w:3] в груди.", "Интересно.[w:6] [func:sad]\nК чему бы это?","[func:head][next]"}
			rus={"[func:DUB,phase3/38/1][w:4]Хо[w:2]тя,[w:9] [func:NoMercy1][speed:0.93]что тебе \nзнать[speed:0.87] о лишениях?", "[func:head][func:DUB,phase3/38/2][w:4][speed:0.88]Ты [w:1]ведь[w:1] так жестоко[speed:0.95] \nрасправился с \nпитомцем Маффет[waitall:4][w:3]...", "[func:DUB,phase3/38/3][w:4]Я[w:1] ли[w:1]чно ухаживала \nза ним.[w:6] Он был[w:1] \nпочти[w:1] что мои[w:2]м [w:1]\nпитомцем.", "[func:sad][func:DUB,phase3/38/4][w:4][speed:0.90]Если бы Маффет, \nконечно,[w:2] знала \nслово[w:1] [speed:0.88]'делиться'[waitall:4][w:3]...", "[func:NoMercy1][func:DUB,phase3/38/5][w:4][speed:0.88]А затем пришёл ты.[w:6] [func:head]\nЖестоко[speed:0.99] \nрасправился с ними \nобо[w:2]ими[waitall:4][w:3]...", "[func:head4][func:DUB,phase3/38/6][w:5][speed:0.88]Не знаю, почему,[w:5][speed:1.10] \nно во мне даже нет \nзлости,[w:1] когда я[w:1] \nдумаю [w:1]о[w:3][speed:0.90] Пау[w:1]кексе.", "[func:DUB,phase3/38/7][w:5][speed:0.75]То[w:1]лько[waitall:4][w:3]...[waitall:1][w:4][speed:0.63] Звенящая \nпустота[waitall:3][w:2]...[waitall:1][w:1][speed:0.85] в груди.", "[func:DUB,phase3/38/8][w:5][speed:0.93]Интересно,[w:1] [func:sad]\nк чему бы это?","[func:head][next]"}
			neng={"Though [w:3][func:NoMercy1]what do you \neven know of losing \nsomeone?", "[func:head]You so cruelly \ndestroyed Muffet's \npet[waitall:4][w:3]...", "I personally cared \nfor him.[w:6] It was \nalmost like my own \npet.", "[func:sad]It would be,[w:3] if \nMuffet even knew \nthe word [waitall:2][w:3]<share>[waitall:4][w:3]...", "[func:NoMercy1]But you have come.[w:6] [func:head]\nAnd made them both \ngone[waitall:4][w:3]...", "[func:head4]I don't know why[waitall:4][w:3]...[waitall:1][w:3] \nBut I'm not mad \nthinking about \nSpidonut.", "Only [waitall:2][w:3]silent void[waitall:1][w:3] \ninside the chest.", "Interesting.[w:6] [func:sad]\nWhy?","[func:head][next]"}
			engcom="What about a spiderdance?[w:6]\nHow relieving that she forgot that stupid pun."
			ruscom="Как насчёт танца с пауками?[w:6]\nКак хорошо,[w:3] что она избавилась от этой тупой шутки."
			end
			wav={"phase3/muffet"}
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
				currentdialogue = {"[noskip]"}
			end
		elseif GetGlobal("progress") == 39 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"[func:head4]Как сложно просто \nперестать \nзаботиться.", "[func:sad]Перестать \nволноваться \nо пустяках и \nотпустить любую \nмотивацию.", "[func:head4]Бугги смог,[w:3] потому \nчто он бездушный \nцветок[waitall:4][w:3]...", "[func:thoughts]А у меня есть \nстремления.[w:6] Рвения.[w:6] \nНадежды и мечты.", "[func:NoMercy1]Я не могу[waitall:4][w:3]...[waitall:1][w:3] [func:head]Не могу \nпозволить тебе их \nразрушить."}
			rus={"[func:head4][func:DUB,phase3/39/1!!!][w:4][speed:0.95]Как сложно[w:4] просто[speed:1.15] \nперестать[speed:1.00] \nзаботиться[waitall:4][w:3]...", "[func:sad][func:DUB,phase3/39/2][w:4][speed:1.09]Перестать \nволноваться \nо пустяках и \nотпустить[w:2][speed:0.90] любую[w:2] \nмотивацию.", "[func:head4][func:DUB,phase3/39/3][w:3][speed:0.85]Бугги смог,[w:8][speed:0.94] потому \nчто он[speed:1.03] бездушный \nцветок[waitall:4][w:3]...", "[func:thoughts][func:DUB,phase3/39/4][w:4][speed:0.90]А у меня есть \nстремления.[w:12] Рве[w:2]ния.[w:12] \nНаде[w:2]жды[w:2] и мечты.", "[func:NoMercy1][func:DUB,phase3/39/5][w:4]Я не могу[waitall:4][w:3]...[waitall:1][w:3] [func:head]Не могу \nпозволить тебе их \nразрушить."}
			neng={"[func:head4]It's uneasy to just \nlet everything go.", "[func:sad]To stop bother \nabout details and \nforget any \nmotivation.", "[func:head4]Boogie could do it,[w:3] \nbecause he's \nsoulless flower[waitall:4][w:3]...", "[func:thoughts]But I have my own \nmotto.[w:6] Goals.[w:6] \nHopes and dreams.", "[func:NoMercy1]I can't let you[waitall:4][w:3]...[waitall:1][w:3] \n[func:head]Can't let you break \nthem."}
			engcom="Hopes and dreams[waitall:4][w:3]...[waitall:1][w:3] Such a nuisance.[w:6]\nAll that matters [w:3]-[w:3] GLAMOUR."
			ruscom="Надежды и мечты[waitall:4][w:3]...[waitall:1][w:3] Что за вздор.[w:6]\nВсё, что имеет значение [w:3]-[w:3] ГЛАМУР."
			end
			wav={"phase3/field"}
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
				currentdialogue = {"[noskip]"}
			end
		elseif GetGlobal("progress") == 40 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			Encounter.SetVar("evadelevel",4)
			nrus={"[func:NoMercy1]Какое тебе дело до \nнас,[w:3] не так ли?", "[func:head4]Бугги рассказывал \nмне,[w:3] что есть сила,[w:3] \nкоторая \nпревосходит \nРешимость.", "[func:sad]Я ему не поверила.[w:6] \n[func:NoMercy1]Но,[w:3] кажется,[w:3] теперь \nэто очевидно.", "[func:head]Наша с тобой \n[waitall:2][w:3]ЛЮБОВЬ.", "[func:Think]Неважно,[w:3] сколько у \nнас Решимости,[w:3][func:head] лишь \n[waitall:2][w:3]ЛЮБОВЬ[waitall:1] -[w:3] мерило \nнаших сил."}
			rus={"[func:NoMercy1][func:DUB,phase3/40/1][w:5]Какое тебе дело до \nнас, [speed:1.10]не так ли?", "[func:head4][func:DUB,phase3/40/2][w:4]Бугги рассказывал \nмне, что есть сила, \nкоторая \nпревосходит \nРешимость.", "[func:sad][func:DUB,phase3/40/3][w:4]Я ему не поверила.[w:8] \n[func:NoMercy1]Но,[w:2] кажется,[w:1] теперь \nэто очевидно.", "[func:head][func:DUB,phase3/40/4][w:4][speed:0.72]Наша с тобой \n[w:7][speed:0.50]ЛЮБОВЬ.", "[func:Think][func:DUB,phase3/40/5][w:4]Неважно,[w:1] сколько у \nнас Решимости,[w:8][func:head] лишь[w:5] \n[waitall:2][w:3]ЛЮБОВЬ[waitall:1] -[w:5] мерило[w:1] \nнаших[w:1] сил."}
			neng={"[func:NoMercy1]It's not your \nbusiness anyway,[w:3] \nis it?", "[func:head4]Boogie told me \nthere's a power much \ngreater than \nDetermination.", "[func:sad]I didn't believe him \nback then.[w:6] [func:NoMercy1]But now \nthat's obvious.", "[func:head]Our [waitall:2][w:3]LOVE.", "[func:Think]Doesn't matter how \nmuch DT we have,[w:3] \nif we didn't gain \nany [waitall:2][w:3]LOVE[waitall:1][w:3],[w:3][func:head] right?"}
			engcom="Chara seems chaotic neutral."
			ruscom="Чара выглядит хаотично нейтральной."
			end
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
				currentdialogue = {"[noskip]"}
			end
			wav={"phase3/buggy1"}
		elseif GetGlobal("progress") == 41 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"[func:head4]Подобно этим \nсеменам \nразлетелись [func:sad]\nнаши жизни[waitall:4][w:3]...", "[func:head4]Этот танец \nнапоминает мне \nо прошлом,[w:3] что \nбеспощадно \nулизнуло[waitall:4][w:3]...", "У меня больше нет \nни дома,[w:3] \nни семьи,[w:3] \nни цели в жизни[waitall:4][w:3]...", "[func:deadly]И во всём[waitall:4][w:3]...[waitall:1][w:3] [func:closedyesend]\nВиноват[waitall:4][w:3]...[waitall:1][w:3] [func:head]\nТы[waitall:4][w:3]..."}
			rus={"[func:head4][func:DUB,phase3/41/1][w:5]Подобно этим \nсеменам \nразлетались [func:sad]\nнаши[w:1] жи[w:1]зни[waitall:4][w:3]...", "[func:head4][func:DUB,phase3/41/2][w:5]Этот танец[w:1] \nнапоминает мне[w:1] \nо прошлом,[w:5] что \nбеспощадно \nулизнуло[waitall:4][w:3]...", "[func:LostKidFace,sobbing_close,-][func:DUB,phase3/41/3][w:5]У меня больше нет \nни[w:2] до[w:2]ма,[w:10][func:LostKidFace,sobbing,+] \nни[w:2] семьи,[w:12][func:LostKidFace,sobbing_upsmile,+] \nни цели [w:1]в [w:1]жизни[waitall:4][w:3]...", "[func:NoMercy1][func:DUB,phase3/41/4][w:5]И во всём[waitall:4][w:3]...[waitall:1][w:3] [func:closedyesend]\nВиноват[waitall:4][w:3]...[waitall:1][w:5] [func:head]\nТы[waitall:4][w:3]..."} 
			neng={"[func:head4]Our lives flew away \nlike [func:sad]those petals[waitall:4][w:3]...", "[func:head4]This dance reminds \nme about my lost \npast[waitall:4][w:3]...", "I have no home,[w:3] \nno family,[w:3] \nno life goals[waitall:4][w:3]...", "[func:deadly]And this is[waitall:4][w:3]...[waitall:1][w:3] \n[func:closedyesend]all your[waitall:4][w:3]...[waitall:1][w:3] \n[func:head]Fault[waitall:4][w:3]..."}
			engcom="It`s rude to deny your blame."
			ruscom="Невежливо спихивать свои ошибки на других."
			end
			wav={"phase3/buggy2"}
		elseif GetGlobal("progress") == 42 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"[func:head4]Виноват[waitall:4][w:3]...[waitall:1][w:3] [func:NoMercy1]\nДа[waitall:4][w:3]...", "[func:head]Да,[w:3] чёрт возьми!", "А-ха-ха-ха!!", "[func:Think]Я такая дура и \n[func:head]вправду!!", "[func:NoMercy1]Ведь ты[waitall:4][w:3]...[waitall:1][w:3] [func:head]Это ты \nразрушил наш мир[waitall:4][w:3]...[waitall:1][w:3] \n[func:Think]Нет моей вины в \nтом,[w:3] что я не \nсмогла его \nзащитить!", "[func:NoMercy1]Это ты[waitall:4][w:3]...[waitall:1][w:3] [func:head]\nТвоя вина![w:6] \nТвоя вина!!"}
			rus={"[func:head4][func:DUB,phase3/42/1][w:5]Виноват[waitall:3][w:2]...[waitall:1][w:2] [func:NoMercy1]\nДа[waitall:4][w:3]...", "[func:head][func:DUB,phase3/42/2][w:5]Да,[w:3] чёрт[w:2] возьми!", "[func:DUB,phase3/42/3][w:5]А-ха-ха-ха-ха-ха\nха!![w:12]\nХа-ха-ха-ха-ха-ха\nха!!", "[func:Think][func:DUB,phase3/42/4][w:5][speed:0.80]Я такая дура и \n[func:head]вправду!!", "[func:NoMercy1][func:DUB,phase3/42/5][w:5]Ведь ты[waitall:3][w:3]...[waitall:1][w:2] [func:head]Это ты \nразрушил наш мир![w:8] \n[func:Think]Нет моей вины в \nтом,[speed:1.10] что я не \nсмогла его \nзащитить!", "[func:NoMercy1][func:DUB,phase3/42/6][w:5]Это ты[waitall:4][w:3]...[waitall:1][w:3] [func:head][speed:0.85]\nТво[w:2]я[w:2] ви[w:2]на!![w:6]"}
			neng={"[func:head4]Fault[waitall:4][w:3]...[waitall:1][w:3] [func:NoMercy1]\nYa[waitall:4][w:3]...", "[func:head]Yes,[w:3] god damn it!", "A-ha-ha-ha-ha!!", "[func:Think]I'm such a fool,[w:3][func:head] \nreally!!", "[func:NoMercy1]It's you[waitall:4][w:3]...[waitall:1][w:3] [func:head]You have\ndestroyed our world[waitall:4][w:3]...[waitall:1][w:3] \n[func:Think]I'm not the one to \nbe blamed for not \nprotecting it!", "[func:NoMercy1]It's you[waitall:4][w:3]...[waitall:1][w:3] [func:head]\nYour fault![w:6] \nYour fault!!"}
			engcom="Ok,[w:3] now she is chaotic evil."
			ruscom="Окей,[w:3] теперь она хаотично зла."
			end
			wav={"phase3/k_3"}
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
				Encounter.SetVar("evadelevel",5)
			end
		elseif GetGlobal("progress") == 43 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
				Encounter.SetVar("evadelevel",6)
			end
			dodge=false
			block=true
			if GetGlobal("pray")<4 then
				SetGlobal("pray",4)
			end
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"[func:start1][func:head4]Хватит![w:6] [func:trigeredclosed]С меня \nдовольно этих \nдетских игр!!", "Давай,[w:3] покажи,[w:3] \nна что ты способен!", "Я не дам тебе \nпройти дальше![w:6] \nНи [w:3]за [w:3]что!!", "Ты будешь вечно \nумирать и \nвозвращаться,[w:3] \nумирать и \nвозвращаться!", "[func:trigeredclosed]Это мой последний \nоплот!", "[func:Bloodshed][func:trigered]Да начнётся \nкровопролитие!!","[func:MoveToCenter][next]"}
			rus={"[func:start1][func:head4][w:3][func:DUB,phase3.5/1/1][speed:0.93][w:2]Хва[w:2]тит!![w:6] [func:trigeredclosed]С меня[speed:1.05] \nдовольно этих \nдетских и[w:2]гр!", "[func:DUB,phase3.5/1/2][w:5]Давай,[w:3][speed:1.19][func:trigered][func:EpicKnife] покажи, \nна что ты способен!", "[func:DUB,phase3.5/1/3][w:5]Я не дам тебе \nпройти дальше![w:6] \nНи [w:2]за[w:2] что!!", "[func:DUB,phase3.5/1/4][w:5]Ты будешь вечно \nумирать и \nвозвращаться,[w:3] \nумирать и \nвозвращаться!", "[func:trigeredclosed][func:DUB,phase3.5/1/5][w:5]Это мой[w:1] последний \nоплот!", "[func:Bloodshed][func:trigered][func:DUB,phase3.5/1/6][w:5][speed:0.89]Да начнётся \nкровопроли[w:1]тие!!","[func:MoveToCenter][next]"}
			neng={"[func:start1][func:head4]Enough![w:6] [func:trigeredclosed]I'm done \nwith all those \nchild play!!", "Common,[w:3][func:trigered][func:EpicKnife] show me \nwhat you have got!", "I will not let \nyou pass![w:6] \nNever!!", "You will endlessly \ndie and return,[w:3] \ndie and return!", "[func:trigeredclosed]This is my last \nstand!", "[func:Bloodshed][func:trigered]Let the bloodshed \nbegin!!","[func:MoveToCenter][next]"}
			engcom="So she wants to play hard[waitall:4][w:3]...[waitall:1][w:3] \nOkay,[w:3] daddy."
			ruscom="Значит,[w:3] она хочет сыграть по-взрослому[waitall:4][w:3]...[waitall:1][w:3] \nХорошо,[w:3] папик."
			end
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
				Encounter.SetVar("phase",1.5)
			end
			wav={"phase3.5/easy"}
			--if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
				Encounter.SetVar("globalstage","3")
				Encounter.Call("WriteSavio")
			--end
			Encounter.SetVar("ghostsnow",{"Asriel_Sprite"})
		elseif GetGlobal("progress") == 44 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"Ты даже \nпредставить себе \nне можешь,[w:3] каково \nэто!", "Ты просто ведёшь \nсебя как кусок \nдерьма!", "[func:trigeredrem]Каждый раз ты \nвтаптываешь меня \nи мой мир в грязь!", "[func:trigered]Да ты сам кусок \nжалкой и мерзкой \nгрязи!!"}
			rus={"[func:DUB,phase3.5/2/1][w:5]Ты даже \nпредставить себе \nне можешь, каково[w:1] \nэто!", "[func:DUB,phase3.5/2/2][w:5]Ты просто ведёшь \nсебя как[w:1] кусок \nдерьма!", "[func:trigeredrem][func:DUB,phase3.5/2/3][w:5][speed:0.80]Каждый раз[speed:0.89] ты \nвтаптываешь меня \nи мой мир в грязь!", "[func:trigered][func:DUB,phase3.5/2/4][w:5][speed:0.86]Да ты сам[w:1] [speed:0.93]кусок [w:1]\nжалкой [w:1]и мерзкой \nгрязи!"}
			neng={"You can't even \nimagine how it \nfeels!", "You're acting like a \ndouche bag!", "[func:trigeredrem]Every time you`re \nbumping me into \nthe mud!", "[func:trigered]But you're the pity \nand ugly dirt as well!!"}
			engcom="She's not kidding now![w:6] Don't be distracted,[w:3] exhaust her!"
			ruscom="Она не шутит![w:6] Не отвлекайся,[w:3] надо её измотать!"
			end
			wav={"phase3.5/BroFight"}
			Encounter.SetVar("ghostsnow",{"Toriel_Sprite","Asgore_Sprite"})
		elseif GetGlobal("progress") == 45 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"Я доверяла не тому \nчеловеку!", "[func:trigeredrem]Может,[w:3] мне вообще \nникому не стоило \nдоверять!", "Все одинаковые![w:6] [func:trigeredclosed]\nЛживые и наивные \nидиоты!", "Никого не волнует,[w:3] \nчто я чувствую! [w:6][func:trigered]\nС меня хватит!!"}
			rus={"[func:DUB,phase3.5/3/1][w:5][speed:0.92]Я доверяла не тому \nчеловеку!", "[func:trigeredrem][func:DUB,phase3.5/3/2][w:5]Может,[w:6] мне[speed:1.09] вообще \nникому не стоило \nдоверять?", "[func:DUB,phase3.5/3/3][w:5][speed:0.85]Все одинаковые.[w:6] [func:trigeredclosed]\nЛживые[w:1] и наивные \nидио[w:1]ты!", "[func:DUB,phase3.5/3/4][w:5][speed:1.10]Никого не волнует, \nчто я чувствую. [w:8][func:trigered][speed:0.90]\nС меня хва[w:1]тит!!"}
			neng={"I trusted the wrong \nperson!", "[func:trigeredrem]Maybe I shouldn't \ntrust anyone!", "They all are the \nsame![w:6] [func:trigeredclosed]\nLying and naive \nidiots!", "No one bothers how \nI feel![w:6] [func:trigered]\nI am done!!"}
			engcom="Burned skin chilling to the bone."
			ruscom="Ожоги прожигают твои кости."
			end
			wav={"phase3.5/firehell"}
			Encounter.SetVar("ghostsnow",{"Alphys_Sprite","Muffet_Sprite","Undyne_Sprite"})
		elseif GetGlobal("progress") == 46 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"[func:trigeredclosed]Мне не стоило ни к \nкому привязываться!", "Завести питомца?![w:9] [func:trigeredrem]\nЗачем?!", "[func:trigeredclosed]Дружить с \nмонстрами?![w:9] \nКак же я была глупа!", "[func:trigered]Все,[w:3] все вы \nодинаковые!", "Никто не понимает \nменя![w:9] \nИ не пытается!"}
			rus={"[func:trigeredclosed][func:DUB,phase3.5/4/1][w:5]Мне не стоило [speed:1.10]ни к \nкому привязываться!", "[func:DUB,phase3.5/4/2][w:5][speed:0.90]Завести питомца?[w:8] [func:trigeredrem]\nЗа[w:2]чем?!", "[func:trigeredclosed][func:DUB,phase3.5/4/3][w:5]Дружить с \nмонстрами?![w:9][speed:0.88] \nКак же я была глупа!", "[func:trigered][func:DUB,phase3.5/4/4][w:5]Все,[w:12] все[w:2] вы[w:1] \nодина[w:2]ковые!", "[func:DUB,phase3.5/4/5][w:5]Ни[w:2]кто[w:1] не понимает \nменя![w:9] \nИ [w:1]не[w:1] пыта[w:2]ет[w:1]ся!"}
			neng={"[func:trigeredclosed]I shouldn't get \nattached to \nanyone!", "Having a pet?![w:9] [func:trigeredrem]\nFor what?!", "[func:trigeredclosed]Befriending with \nmonsters?![w:9] \nI was so damn \nfoolish!", "[func:trigered]You all are the same!", "No one understands \nme,[w:3] you didn't even \ntry to!"}
			engcom="I feel the aroma of rotten blood[waitall:4][w:3]...[waitall:1][w:3]\nWe're at our limit,[w:3] actor."
			ruscom="Я чувствую запах гниющей крови[waitall:4][w:3]...[waitall:1][w:3]\nМы на пределе,[w:3] актер."
			end
			wav={"phase3.5/spidercombo"}
			Encounter.SetVar("ghostsnow",{"Paps_Sprite","Sans_Sprite","Flowey_Sprite"})
		elseif GetGlobal("progress") == 47 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"Знаешь,[w:3] как я сюда \nпопала?![w:6] \n[func:trigeredclosed]Я сбежала!", "Сбежала от пожара,[w:3] \nкоторый сама же и \nустроила!", "[func:trigered]Да,[w:3] твою мать,[w:3] \nя спалила свою \nродную деревню![w:6] \nДотла!![w:6] \nДо тлеющих трупов!!!"}
			rus={"[func:DUB,phase3.5/5/1][w:5]Знаешь, как я сюда \nпопала?![w:8][speed:0.85] \n[func:trigeredclosed]Я сбе[w:1]жа[w:1]ла!", "[func:DUB,phase3.5/5/2][w:5]Сбежала от пожара,[w:1] \nкоторый сама же и[w:1] \nустроила!", "[func:trigered][func:DUB,phase3.5/5/3][w:5][speed:0.90]Да, твою мать, \nя[speed:1.00] спалила свою \nродную деревню![w:7][speed:0.88] \nДотла!![w:6] \nДо [w:1]тлеющих трупов!!"}
			neng={"Do you wanna know \nhow I appeared \nhere?![w:6] [func:trigeredclosed]I ran away!", "I ran away from \nthe fire,[w:3] that \nI began!", "[func:trigered]Yes,[w:3] dammit,[w:3] I \nburned down my own \nvillage![w:6] \nTo the last building!![w:6] \nTo the very burned \ncorpse!!!"}
			end
			dodge=true
			block=false
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			engcom="She[waitall:4][w:3]...[waitall:1][w:3] She [waitall:2][w:3]WHAT?!"
			ruscom="Она[waitall:4][w:3]...[waitall:1][w:3] она [waitall:2][w:3]ЧТО?!"
			end
			wav={"imp/DEATH2"}
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
				Encounter.SetVar("evadelevel",2)
			end
		elseif GetGlobal("progress") == 48 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"[func:trigeredclosed]Да,[w:3] ты правильно \nрасслышал!", "[func:trigered]Я ненавидела их![w:6] \nЯ хотела им смерти!", "[func:trigeredclosed]У меня было всё,[w:3] но \nв один момент жизнь \nотобрала у меня \nэто!", "Семью,[w:3] свободу,[w:3] \nжелание жить!", "Когда весь мой мир,[w:3] \nмоя деревня \nсгорела,[w:3] \nя сбежала \nв Подземелье!", "Раньше я мечтала,[w:3] \nчто покажу миру,[w:3] \nкакие монстры \nдобрые[waitall:4][w:3]...", "[func:trigered]А они -[w:6] ничем не \nлучше людей![w:6] [func:trigeredrem]Они \nхотели меня убить,[w:3] \nпотому что я \nчеловек!", "[func:trigeredclosed]Я ни человек,[w:3] ни \nмонстр!","Я[waitall:4][w:3]...[waitall:1][w:3] \nЯ [waitall:2]Д е м о н,[waitall:1][w:3] \n[func:trigered]понимаешь?!", "Вот моя сущность!"}
			rus={"[func:trigeredclosed][func:DUB,phase3.5/6/1][w:4]Да,[w:2][speed:1.15] ты правильно \nрасслышал!", "[func:trigered][func:DUB,phase3.5/6/2][w:5][speed:0.86]Я ненавидела их![w:8][speed:0.80] \nЯ хотела им сме[w:2]рти!", "[func:trigeredclosed][func:DUB,phase3.5/6/3][w:5]У меня было всё,[w:8] но \nв один [speed:1.09]момент жизнь \nотобрала у меня \nэто!", "[func:DUB,phase3.5/6/4][w:5][speed:0.93]Семью,[w:4] свобо[w:1]ду,[w:1] \nжела[w:1]ние[w:1] жить!", "[func:DUB,phase3.5/6/5][w:5]Когда весь мой мир,[w:3] \nмоя деревня \nсгорела,[w:7][speed:0.90] \nя сбежала \nв Подземелье.", "[func:DUB,phase3.5/6/6][w:5][speed:1.09]Раньше я мечтала,[w:1][speed:1.15] \nчто покажу миру,[speed:1.09] \nкакие монстры \nдо[w:1]брые[waitall:4][w:3]...", "[func:DUB,phase3.5/6/7][w:5][func:trigered][speed:0.90]А они ничем не \nлучше людей![w:6] [func:trigeredrem]Они \nхотели меня убить,[w:1][speed:0.94] \nпотому что я \nчеловек!", "[func:trigeredclosed][func:DUB,phase3.5/6/8][w:6][speed:0.85]Я[w:1] ни человек,[w:4] ни \nмонстр!", "[func:DUB,phase3.5/6/9][w:5]Я[waitall:3][w:3]...[waitall:1][w:2][speed:0.89] \nЯ[w:2] Д е м о н,[w:2][speed:1.15] \n[func:trigered]понимаешь?!", "[func:DUB,phase3.5/6/10][w:5]Вот[w:2] моя[w:2] сущ[w:2]ность!"}
			neng={"[func:trigeredclosed]Yes,[w:3] you heard well!", "[func:trigered]I hated them![w:6] \nI wanted them to die!", "[func:trigeredclosed]I had everything I \ncould dream of,[w:3] but \nlife destroyed them \nall!", "My family,[w:3] my \nfreedom,[w:3] my life will!", "When my entire world,[w:3] \nmy dear village \nburned to the ashes,[w:3] \nI went to \nUnderground", "Not so long before \nthe Fall I thought \nmonsters would be \nnice and caring[waitall:4][w:3]...", "[func:trigered]But they were the \nsame as humans![w:6] [func:trigeredrem]\nThey wanted to kill \nme just because I am \nhuman!", "[func:trigeredclosed]But I am not the \nhuman,[w:3] neither the \nmonster!", "I am[waitall:4][w:3]...[waitall:1][w:3] \nI am the D e m o n,[w:3] [func:trigered]\nyou get it?!", "That's who I am!"}
			engcom="[waitall:4][w:3]...[waitall:1][w:3]She is exhausted."
			ruscom="[waitall:4][w:3]...[waitall:1][w:3]Она вымоталась."
			Encounter.SetVar("evadelevel",2)
			end
			block=false
			dodge=true
			wav={"phase3.5/bereadytodie"}
		elseif GetGlobal("progress") == 49 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
				Encounter.SetVar("evadelevel",2)
				Encounter.SetVar("SuddenStrike",true)
				Encounter.SetVar("CharaIsRaging",false)
			end
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"[noskip][func:trigeredclosed]И теперь[waitall:4][w:3]...", "[noskip][func:head4][func:NoEpicKnife][func:lowpitchmusic]Я не знаю,[w:3] \nзачем я живу[waitall:4][w:3]...", "[noskip]Я[waitall:4][w:3]...[waitall:1][w:3] я больше не \nхочу жить[waitall:4][w:3]...[waitall:1][w:3] \nжить [waitall:2][w:3]так[waitall:4][w:3]...", "[noskip][func:tired][waitall:2][w:5]Я просто хочу \nпокоя[waitall:4][w:3]..."}
			rus={"[noskip][func:trigeredclosed][func:DUB,phase3.5/7/1][w:6][speed:0.70]И[w:1] теперь[waitall:4][w:3]...", "[noskip][func:DUB,phase3.5/7/2][w:10]Я[w:4].[w:4].[w:4].[w:9][func:head4][func:NoEpicKnife][func:lowpitchmusic][speed:0.91] я не знаю,[w:1] \nзачем я живу[waitall:4][w:3]...", "[noskip][func:DUB,phase3.5/7/3][w:8]Я[waitall:4][w:3]...[waitall:1][w:3][speed:0.90] я больше не[w:1] \nхочу[w:2] жить[waitall:3][w:2]...[waitall:1][w:2] \nЖить [waitall:2][w:3]та[w:2]к[waitall:4][w:3]...", "[noskip][func:tired][speed:0.50][func:DUB,phase3.5/7/4][w:6]Я про[w:1]сто[w:1] хочу \nпо[w:1]ко[w:2]я[waitall:4][w:3]..."}
			neng={"[noskip][func:trigeredclosed]And now[waitall:4][w:3]...", "[noskip][func:head4][func:NoEpicKnife][func:lowpitchmusic]I don't even know \nwhy do I still live[waitall:4][w:3]...", "[noskip]I[waitall:4][w:3]...[waitall:1][w:3] I don't wanna \nlive[waitall:4][w:3]...[waitall:1][w:3] \nlive like [waitall:2][w:3]that[waitall:1][w:3] \nanymore.", "[noskip][func:tired][waitall:2][w:5]I just want peace[waitall:4][w:3]..."}
			engcom="The time has come,[w:3] actor![w:6] \nImpact her!"
			ruscom="Сейчас,[w:3] актер![w:6] Нападай!"
			end
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
				Encounter.SetVar("FightGoes",2)
			end
			wav={"nothing"}
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
				Encounter.SetVar("globalstage","4")
				Encounter.Call("WriteSavio")
				Encounter.SetVar("phase",2)
			end
			dodge=false
		elseif GetGlobal("progress") == 50 then
			nrus={"[func:thoughts]Кгха!", "[waitall:2][func:Cough1]*кашель*", "[func:SetMusic,star]Ты[waitall:4][w:3]...[waitall:1][w:3] ты что,[w:3] \nранил меня[waitall:4][w:3]?..", "[func:head4]Я[waitall:4][w:3]...\n[waitall:1][w:3]Кха[waitall:4][w:3]...[waitall:1][w:3] \nНе может быть[waitall:4][w:3]...","[func:thoughts][func:MoveToCenter][next]"}
			rus={"[func:thoughts][func:DUB,phase4/1/1][w:6][speed:2.80]Кгха!", "[func:DUB,phase4/1/2][w:5]*к[w:4]аш[w:4]е[w:7]ль*", "[func:SetMusic,star][func:DUB,phase4/1/3][w:5]Ты[waitall:3][w:2]...[waitall:1][w:2] ты что,[w:9] \nра[w:2]нил [w:1]меня[waitall:4][w:3]?..", "[func:head4][func:DUB,phase4/1/4][w:5]Я[waitall:4][w:3]...\n[waitall:1][w:3]Кха[waitall:3][w:3]...[waitall:1][w:2] \nНе может быть[waitall:4][w:3]...","[func:thoughts][func:MoveToCenter][next]"}
			neng={"[func:thoughts]Ghah!", "[waitall:2][func:Cough1]*cough*", "[func:SetMusic,star]Did you[waitall:4][w:3]...\n[waitall:1][w:3]Did you just \nwound me[waitall:4][w:3]?..", "[func:head4]But I[waitall:4][w:3]...\n[waitall:1][w:3]Gha[waitall:4][w:3]...\n[waitall:1][w:3]But it can't be[waitall:4][w:3]...","[func:thoughts][func:MoveToCenter][next]"}
			engcom="She is wounded!"
			ruscom="Она ранена!"
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
				Encounter.SetVar("evadelevel",6)
			end
		elseif GetGlobal("progress") == 51 then
			nrus={"Я[waitall:4][w:3]...[waitall:1][w:3] [func:head4]Я \nотвлеклась[waitall:4][w:3]?..", "[func:Final_7]И получила по \nзаслугам,[w:3] \nконечно[waitall:4][w:3]...", "[waitall:4][w:3]...", "[noskip][func:NoMercy1][func:SetMusic,none]Но даже если так[waitall:4][w:3]...[waitall:1][w:3]\n[func:head][func:Music2]Наш вопрос ещё не \nзакрыт."}
			rus={"[func:DUB,phase4/2/1][w:5]Я[waitall:4][w:3]...[waitall:1][w:3] [func:head4]\nОтвлеклась[waitall:4]?..", "[func:Final_7][func:DUB,phase4/2/2][w:5][speed:1.15]И получила по \nзаслугам,[w:5] \nконечно[waitall:4][w:3]...", "[waitall:4][w:3]...", "[noskip][func:NoMercy1][func:SetMusic,none][func:DUB,phase4/2/3][w:5]Но[w:1] даже[w:1] если так[waitall:3][w:3]...[waitall:1][w:2][speed:0.98]\n[func:head][func:Music2]Наш вопрос ещё не \nзакрыт."}
			neng={"Did I[waitall:4][w:3]...[waitall:1][w:3] [func:head4]\nDid I slip[waitall:4][w:3]?..", "[func:Final_7]And got punished \nfor that,[w:3] of \ncourse[waitall:4][w:3]...", "[waitall:4][w:3]...", "[noskip][func:NoMercy1][func:SetMusic,none]But even so[waitall:4][w:3]...[waitall:1][w:3] \n[func:head][func:Music2]We still have \nunanswered \nquestions."}
			engcom="What is she talking about?[w:6]\nI have all answers."
			ruscom="О чём она говорит?[w:6]\nМне всё предельно ясно."
			wav={"phase4/netkonzaidejam"}
			--wav={"phase4/WrathOnly"}
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
				Encounter.SetVar("FightGoes",true)
			end
		elseif GetGlobal("progress") == 52 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"[func:NoMercy1]Да,[w:3] ты,[w:3] наверное,[w:3] \nне понимаешь,[w:3] но[waitall:4][w:3]...", "[func:Think]Разве ты не хочешь \nопять уничтожить \nмир?", "[func:NoMercy1]Да,[w:3] ведь это твоя \nпервоначальная \nцель[waitall:4][w:3]...", "[func:head]Твоя [waitall:2][w:3]<миссия>[waitall:4][w:3]..."}
			rus={"[func:NoMercy1][func:DUB,phase4/3/1][w:5]Да,[w:3][speed:1.15] ты, наверное, \nне понимаешь,[w:1] но[waitall:4][w:3]...", "[func:Think][func:DUB,phase4/3/2][w:5][speed:1.10]Разве ты не хочешь \nопять уничтожить \nмир?", "[func:NoMercy1][func:DUB,phase4/3/3][w:5]Да,[w:3] ведь это твоя \nпервоначальная \nцель[waitall:4][w:3]...", "[func:head][func:DUB,phase4/3/4][w:5][speed:0.75]Твоя [speed:0.45][w:3]'[w:6]миссия'[w:3][waitall:4][w:4]..."}
			neng={"[func:NoMercy1]Yes,[w:3] probably,[w:3] \nyou don't get it,[w:3] \nbut[waitall:4][w:3]...", "[func:Think]Aren't you going \nto destroy world \nonce again?", "[func:NoMercy1]Yes,[w:3] cuz' that's \nyour utter goal[waitall:4][w:3]...", "[func:head]Your [waitall:2][w:3]<quest>[waitall:4][w:3]..."}
			engcom="Ah yes[waitall:4][w:3]...[waitall:1][w:3] Almost forgot."
			ruscom="Ах да[waitall:4][w:3]...[waitall:1][w:3] Совсем запамятовал."
			end
			wav={"phase4/k_1"} 
		elseif GetGlobal("progress") == 53 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"[func:Bad]Но не думай,[w:3] что \nя сдалась[waitall:4][w:3]...[waitall:1][w:3] \n[func:Final_7]Я истекаю кровью и,[w:3] \nвероятно,[w:3] долго не \nпроживу,[w:3] но[waitall:4][w:3]...", "[noskip][func:ToAngry][waitall:4][w:3]...[w:600][next] " , "[noskip][func:GetsAngry]У меня всё ещё \nесть силы дать \nтебе отпор!", "[func:NoMercy1]Если я и не \nчеловек,[w:3] и не \nмонстр[waitall:4][w:3]...[waitall:1][w:3]","[func:angry]Тогда мне,[w:3] как \nДемону,[w:3] положено \nдраться до \nпоследней капли \nкрови!", "Я положу тебе \nконец,[waitall:2][w:3][func:GiveCurse]проклятая \nкровь!"}
			rus={"[func:Bad][func:DUB,phase4/4/1][w:5]Но не думай, что \nя сдалась[waitall:3][w:2]...[waitall:1][w:2] \n[func:Final_7]Я истекаю кровью и,[w:3] \nвероятно,[w:1] долго не \nпроживу,[w:1] но[waitall:4][w:3]...", "[noskip][func:ToAngry][waitall:4][w:3]...[w:600][next] " , "[noskip][func:GetsAngry][func:DUB,phase4/4/2][w:8][speed:0.90]У меня всё ещё \nесть силы дать \nтебе отпор!", "[func:NoMercy1][func:DUB,phase4/4/3][w:5]Если я и не \nчеловек,[w:3] и не \nмонстр[waitall:4][w:3]...[waitall:1][w:3]","[func:angry][func:DUB,phase4/4/4][w:5]Тогда мне,[w:1] как \nДемону,[w:1] положено \nдраться до \nпоследней[speed:1.15] капли \nкрови!", "[func:DUB,phase4/4/5][w:7]Я положу тебе \nконец,[w:1][func:GiveCurse] проклятая \nкровь!"}
			neng={"[func:Bad]But don't you think \nI already gave up[waitall:4][w:3]?..[waitall:1][w:3] \n[func:Final_7]I am bleeding and,[w:3] \nmaybe,[w:3] will not live \nfor long,[w:3] but[waitall:4][w:3]...", "[noskip][func:ToAngry][waitall:4][w:3]...[w:600][next] ", "[noskip][func:GetsAngry]I still have powers \nto resist you!", "[func:NoMercy1]If I'm neither human \nnor monster[waitall:4][w:3]...[waitall:1][w:3] ","[func:angry]Then,[w:3] as a Demon,[w:3] \nI should fight 'til \nlast drop of my \nblood!", "I will end you,[waitall:2][w:3]\n[func:GiveCurse]cursed blood!"}
			engcom="Damn![w:6] Chainsaw has broken![w:6]\nBe careful,[w:3] i sense a strong curse[waitall:4][w:3]...[waitall:1][w:3]"
			ruscom="Чёрт![w:6] Бензопила замкнулась![w:6]\nОсторожнее,[w:3] я чувствую сильную порчу[waitall:4][w:3]...[waitall:1][w:3]"
			else
				GiveCurse()
			end
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
				Encounter.SetVar("chainsaw",false)
			end
			wav={"phase4/HARD"}
		elseif GetGlobal("progress") == 54 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"[func:NoMercy1]Вместе с моей \nкровью вытекает и \nискусственная \nРешимость[waitall:4][w:3]...", "[func:head4]Очевидно,[w:3] что я \nбольше не соперник \nтебе.[w:6] [func:BADsad]Я потеряла \nвозможность.", "[func:NoMercy1]Но если я смогу \nтебя убить[waitall:4][w:3]...[waitall:1][w:3] \n[func:angry]Я смогу оттолкнуть \nтебя назад.", "Задержать тебя."}
			rus={"[func:DUB,phase4/5/1][w:5][func:NoMercy1]Вместе с моей \nкровью вытекает[speed:1.15] и \nискусственная \nРешимость[waitall:4][w:3]...", "[func:head4][func:DUB,phase4/5/2][w:5][speed:1.10]Очевидно,[w:2] что я \nбольше не соперник \nтебе.[w:7] [func:BADsad][speed:0.78]Я[w:2] потеряла \nвозможность.", "[func:NoMercy1][func:DUB,phase4/5/3][w:5]Но если я смогу \nтебя убить[waitall:4][w:3]...[waitall:1][w:2] \n[func:angry]Я смогу оттолкнуть[speed:1.1ы5] \nтебя назад.", "[func:DUB,phase4/5/4][w:5][speed:0.90]Задержать[w:1] тебя."}
			neng={"[func:NoMercy1]I'm losing artificial \nDetermination with \nmy blood[waitall:4][w:3]...", "[func:head4]It's obvious,[w:3] I am \nno longer an equal \nto you.[w:6] [func:BADsad]I lost the \nopportunity.", "[func:NoMercy1]But if I can kill you[waitall:4][w:3]...[waitall:1][w:3] \n[func:angry]I will push you back.", "I will put you on hold."}
			engcom="This won`t happen,[w:3] naive fool.[w:6]\nI have already won."
			ruscom="Этому не бывать,[w:3] наивная дура.[w:6]\nЯ уже победил."
			end
			wav={"phase4/knives4"}
		elseif GetGlobal("progress") == 55 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"[func:head4]Я просто[waitall:4][w:3]...[waitall:1][w:3] [func:BADsad]Просто \nхочу,[w:3] чтобы в мои \nпоследние минуты \nя ни о чем не \nсожалела.", "[func:head4]Ты понимаешь,[w:3] \n[func:BADthoughts]каково это?", "[func:head4]Когда твой мир \nускользает от тебя,[w:3] \nи ты остаёшься \nодна[waitall:4][w:3]...[waitall:1][w:3] [func:deadly]в темноте[waitall:4][w:3]..."}
			rus={"[func:head4][func:DUB,phase4/6/1][w:5]Я[w:2] просто[waitall:4][w:3]...[waitall:1][w:3] [func:BADsad]Просто \nхочу, чтобы в мои \nпоследующие минуты \nя ни о чем не \nсожалела.", "[func:head4][func:DUB,phase4/6/2][w:5]Ты понимаешь, \n[func:BADthoughts]каково это?", "[func:deadly][func:DUB,phase4/6/3][w:5]Когда твой мир \nускользает от тебя, \nи ты остаёшься \nодна[waitall:4][w:3]...[waitall:1][w:3]"}
			neng={"[func:head4]I just[waitall:4][w:3]...[waitall:1][w:3] [func:BADsad]I just wanted \nto have no regrets \nin last minutes \nof my life.", "[func:head4]Do you even \nunderstand [func:BADthoughts]this \nfeeling?", "[func:head4]Felling when entire \nworld is slipping and \nyou find yourself \nin the darkness[waitall:4][w:3]...[waitall:1][w:3] \n[func:deadly]all alone[waitall:4][w:3]..."}
			engcom="Stop this fuss[waitall:4][w:3]...[waitall:1][w:3]\nDeath never was an option for two of us."
			ruscom="Хватит драматизировать[waitall:4][w:3]...[waitall:1][w:3]\nСмерть [w:3]-[w:3] это роскошь для нас."
			end
			wav={"phase4/StayLow"}
		elseif GetGlobal("progress") == 56 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"[func:Peachy]Хех[waitall:4][w:3]...[waitall:1][w:3] Хах[waitall:4][w:3]...", "[func:BADsmart]Извини,[w:3] я просто \nподумала,[w:3] как \nвойдёт эта битва в \nисторию[waitall:4][w:3]...", "[func:Peachy]Дуэль,[w:3] которой не \nдолжно было быть[waitall:4][w:3]...", "Битва двух \nаномалий[waitall:4][w:3]...[waitall:1][w:3] [func:BADRemember]\nЭто так красиво \nзвучит[waitall:4][w:3]..."}
			rus={"[func:Peachy][func:DUB,phase4/7/1][w:5]Хе[w:1]хе[waitall:4][w:3]...[waitall:1][w:3] Е[w:1]хехе[waitall:4][w:3]...", "[func:BADsmart][func:DUB,phase4/7/2][w:7][speed:0.90]Извини,[w:9] я просто[speed:1.15] \nподумала,[w:1] как эта \nбитва войдёт в \nисторию[waitall:4][w:3]...", "[func:Peachy][func:DUB,phase4/7/3][w:5]Дуэль,[w:3] которой не \nдолжно было быть[waitall:4][w:3]...", "[func:DUB,phase4/7/4][w:5][speed:0.85]Битва двух \nаномалий[waitall:3][w:3]...[waitall:1][w:2] [func:BADRemember][speed:0.84]\nЭто так красиво \nзвучит[waitall:4][w:3]..."}
			neng={"[func:Peachy]Hehe[waitall:4][w:3]...[waitall:1][w:3] Ahah[waitall:4][w:3]...", "[func:BADsmart]Sorry,[w:3] I thought for \na moment,[w:3] how \nhistory has its \neyes on us[waitall:4][w:3]...", "[func:Peachy]This is duel that \nshouldn't have \nhappened[waitall:4][w:3]...", "Battle of two \nanomalies[waitall:4][w:3]...[waitall:1][w:3] [func:BADRemember]\nThis sounds so \npoetic[waitall:4][w:3]..."}
			engcom="She is losing herself[waitall:4][w:3]...[waitall:1][w:3]\nShe has no strength.[w:3] Cut out this nonsense"
			ruscom="Она бредит[waitall:4][w:3]...[waitall:1][w:3]\nСилы покидают её.[w:3] Кончай этот балаган."
			end
			wav={"phase4/BadKnifes"}
		elseif GetGlobal("progress") == 57 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			neng={"[func:head4][waitall:4][w:3]...", "I no longer hear \nvoices[waitall:4][w:3]...[waitall:1][w:3] [func:BADsad]They have \ndisappeared.", "[func:head4]I hear only the beat \nof my heart which \nit stealing leftovers \nof my oxygen[waitall:4][w:3]...", "[waitall:2][func:Cough1]*hard [w:8][func:Cough2]coughing*[w:9] [func:head4]\nDammit[waitall:4][w:3]...[waitall:1][w:3] \n[func:BADweak]I have no time left[waitall:4][w:3]..."}
			nrus={"[func:head4][waitall:4][w:3]...", "Я больше не слышу \nголоса[waitall:4][w:3]...[waitall:1][w:3] [func:BADsad]Они \nзатихли[waitall:4][w:3]...", "[func:head4]Лишь стук моего \nумирающего сердца \nпродолжает жадно \nотбирать мой \nкислород[w:4].[w:4].[w:4].[w:4]", "[waitall:2][func:Cough1]Кхах[w:4].[w:4].[w:4].[w:4] [func:Cough2][waitall:2]Кха-кха![w:9][waitall:1] [func:head4]\nЧёрт[w:4].[w:4].[w:4].[w:4] \n[func:BADweak]У меня совсем не \nосталось времени[w:4].[w:4].[w:4].[w:4]"}
			rus={"[func:head4][func:DUB,prolog2/f][waitall:4][w:3]...", "[func:DUB,phase4/8/1][w:5]Я[w:1] больше[w:1] не слышу \nголоса[waitall:4][w:3]...[waitall:1][w:3] [func:BADsad]Они[w:2] \nзатихли[waitall:4][w:3]...", "[func:head4][func:DUB,phase4/8/2][w:5][speed:1.09]Лишь[w:2] стук моего[w:1] \nумирающего[w:1] сердца[w:1] \nпродолжает жадно \nотбирать[w:1] мой \nкислород[w:4].[w:4].[w:4].[w:4]", "[func:Cough1][func:DUB,phase4/8/3][speed:1.70][w:6]Кхах.[w:4].[w:4].[w:7] [func:Cough2]Кха-[w:5]кха.[w:4].[w:4].[w:8] [speed:1.05][func:head4]\nЧёрт[w:3].[w:3].[w:3].[w:3] \n[func:BADweak]У меня совсем не \nосталось времени[w:4].[w:4].[w:4].[w:4]"}
			engcom="Good point."
			ruscom="Хорошо подмечено."
			end
			wav={"phase4/AllAround"}
		elseif GetGlobal("progress") == 58 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"[func:head4]Знаешь[w:3].[w:3].[w:3].[w:3] После \nстольких смертей[w:3].[w:3].[w:3].[w:3] \n[func:BADsad]Я больше не боюсь \nвида крови[waitall:4][w:3]...", "В детстве я \nненавидела кровь[w:3].[w:3].[w:3].[w:3] \n[func:head4]Меня тошнило при \nвиде неё...", "А сейчас[w:3].[w:3].[w:3].[w:3] [func:Final_7]Всё \nравно,[w:3] что вода на \nладонях[w:3].[w:3].[w:3].[w:3] Только \nочень горячая[waitall:4][w:3]...", "[func:BADIrony]Почти как кипяток[w:3].[w:3].[w:3].[w:3] \n[func:Final_7]Но я не чувствую \nболи[waitall:4][w:3]..."}
			rus={"[func:DUB,phase4/9/1][w:5][func:head4]Знаешь[w:3].[w:3].[w:3].[w:6] После \nстольких смертей[w:3].[w:3].[w:3].[w:3] \n[func:BADsad]Я больше не боюсь \nвида крови[waitall:4][w:3]...", "[func:DUB,phase4/9/2][w:5]В детстве я \nненавидела кровь[w:2].[w:2].[w:2].[w:2] \n[func:head4]Меня тошнило при \nвиде неё[w:3].[w:3].[w:3].[w:3]", "[func:DUB,phase4/9/3][w:5]А сейчас[w:3].[w:3].[w:3].[w:3] [func:Final_7]Всё \nравно, что вода на \nладонях[w:3].[w:3].[w:2].[w:2] Только[w:4] \nочень[w:1] горя[w:2]чая[waitall:4][w:3]...", "[func:BADIrony][func:DUB,phase4/9/4][w:5]Почти[w:1] как[w:1] кипяток[w:3].[w:3].[w:2].[w:2] \n[func:Final_7]Но я не чувствую \nболи[waitall:4][w:3]..."}
			neng={"[func:head4]Ya'know[w:3].[w:3].[w:3].[w:3] After \nso many deaths[w:3].[w:3].[w:3].[w:3] \n[func:BADsad]I no longer fear \nblood[waitall:4][w:3]...", "I hated the sight \nof blood in \nchildhood[w:3].[w:3].[w:3].[w:3] \n[func:head4]I was sick of it[waitall:4][w:3]...", "And now[w:3].[w:3].[w:3].[w:3] [func:Final_7]It's \nalmost like water on \nmy palms[w:3].[w:3].[w:3].[w:3] \nBut very hot[waitall:4][w:3]...", "[func:BADIrony]Almost boiling[w:3].[w:3].[w:3].[w:3] \n[func:Final_7]But I don't feel pain \nat all[waitall:4][w:3]..."}
			engcom="Maybe,[w:3] she is dying at last?[w:6]\nI wouldn`t be against it."
			ruscom="Может,[w:3] она наконец умирает?[w:6]\nЯ был бы не против."
			end
			wav={"phase4/CopyCat"}
		elseif GetGlobal("progress") == 59 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"[func:head4]Ты[w:3].[w:3].[w:3].[w:3] [func:BADweak]всё ещё \nживой[w:3]?[w:3].[w:3].[w:3] [func:head4]Живучий \nоднако[w:3].[w:3].[w:3].[w:3]", "Хотя не исключено,[w:3] \n[func:sad][func:NoCurse]что я уже ослабла \nдаже больше,[w:3] \nчем ты устал[w:3].[w:3].[w:3].[w:3]", "[func:head4]Тогда[w:3].[w:3].[w:3].[w:3] Мне не \nостаётся ничего,[w:3] \nкроме как[w:3].[w:3].[w:3].[w:3]", "[func:angry][func:GiveCurse]Показать свой \n[w:3][waitall:3]максимум."}
			rus={"[func:head4][func:DUB,phase4/10/1][w:6]Ты[w:4].[w:4].[w:4].[w:3] [func:BADweak]всё ещё \nживой[w:3]?[w:3].[w:3].[w:3] [func:head4]Живу[w:2]чий[w:1] \nодна[w:2]ко[w:3].[w:3].[w:3].[w:3]", "[func:DUB,phase4/10/2][w:5]Хо[w:2]тя[w:3].[w:3].[w:3].[w:2] не исключено,[w:1] \n[func:sad][func:NoCurse]что я уже ослабла \nдаже больше, \nчем ты устал[w:3].[w:3].[w:3].[w:3]", "[func:head4][func:DUB,phase4/10/3][w:5]Тогда мне не \nостаётся ничего,[w:1] \nкроме как[w:3].[w:3].[w:3].[w:3]", "[func:angry][func:GiveCurse][func:DUB,phase4/10/4][w:5]Показать свой \nмаксимум."}
			neng={"[func:head4]Are[w:3].[w:3].[w:3].[w:3] [func:BADweak]Are you \nstill alive[w:3]?[w:3].[w:3].[w:3] \n[func:head4]Whatever[w:3].[w:3].[w:3].[w:3]", "Still it could be [func:sad][func:NoCurse]that \nI have weakened \neven more than you \nhave tired[w:3].[w:3].[w:3].[w:3]", "[func:head4]If so[w:3].[w:3].[w:3].[w:3] I have no \nother choice but[w:3].[w:3].[w:3].[w:3]", "[func:angry][func:GiveCurse]But to show you \nmy [w:3][waitall:3]maximum."}
			engcom="What?[w:6] Is it this boring <special attack> again?[w:6]\nNo one fears it this day."
			ruscom="Что?[w:6] Опять её <специальная атака>?[w:6] Никого больше это не пугает,[w:3] дорогуша."
			end
			wav={"phase4/MovingKnifes"}
		elseif GetGlobal("progress") == 60 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"[func:Final_7]Я вижу по твоим \nглазам,[w:3] [func:BADBad]что ты \nнедооцениваешь \nменя[w:3].[w:3].[w:3].[w:3] [func:Final_7]Что же,[w:3] это \nк лучшему.", "Когда я умру,[w:3] моя \nдуша расколется[w:3].[w:3].[w:3].[w:3] \n[func:BADsmart]Но остатки \nискусственной \nрешимости не дадут \nей распасться.", "[func:Final_7]Резонанс энергии \nвзорвётся и \nвысвободит мощный \nвсплеск магии.[w:6] \n[func:NoMercy1]И эта атака[w:3].[w:3].[w:3].[w:3]", "[func:angry][speed:0.75]Станет твоей \nпогибелью."}
			rus={"[func:Final_7][func:DUB,phase4/11/1][w:5]Я уже вижу по твоим \nглазам,[w:3] [func:BADBad]что ты \nнедооцениваешь \nменя[w:3].[w:3].[w:3].[w:3] [func:Final_7]Что[w:3] же,[w:9] это \nк лучшему.", "[func:DUB,phase4/11/2][w:5]Когда я умру,[w:1] моя \nдуша раско[w:2]лется.[w:6] \n[func:BADsmart]Но остатки \nискусственной \nрешимости не дадут \nей распасться.", "[func:Final_7][func:DUB,phase4/11/3][w:5]Резонанс энергии \nвзорвётся[w:1] и \nвысвободит [w:1]мощный \nвсплеск [w:1]ма[w:1]гии.[w:10] \n[func:NoMercy1]И[w:1] эта[w:1] ата[w:2]ка[w:3].[w:3].[w:3].[w:3]", "[func:angry][speed:0.75][func:DUB,phase4/11/4][w:5]Станет твоей \nпогибелью."}
			neng={"[func:Final_7]I see it in your \neyes [w:3]- [func:BADBad]you're \nmisjudging me[w:3].[w:3].[w:3].[w:3] \n[func:Final_7]Well,[w:3] that's for \nbetter.", "When I will die,[w:3] my \nsoul will break[w:3].[w:3].[w:3].[w:3] \n[func:BADsmart]But leftovers of \nartificial DT won't \nlet it shred \nto pieces.", "[func:Final_7]Energy collapse will \nblow up in powerful \nmagic strike.[w:6] [func:NoMercy1]And \nthis strike[w:3].[w:3].[w:3].[w:3]", "[func:angry][speed:0.75]Will be my last \nstrike back at \nthis point."}
			engcom="Wait,[w:3] actor,[w:3] i am trying to undestand what she said[waitall:4][w:3]...[waitall:2][w:3]\nOh no."
			ruscom="Погоди,[w:3] актёр,[w:3] я пытаюсь понять,[w:3] что она пытается сказать[waitall:4][w:3]...[waitall:2][w:3]\nО нет."
			end
			wav={"phase4/k_4"} 
		elseif GetGlobal("progress") == 61 and diff~=24 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			neng={"[func:NoMercy1]I can't wait for \n[func:BADsmart]this moment to \ncome[waitall:4][w:3]...[waitall:1][w:3]", "When you will die, [func:NoMercy1]we \nwill return to\nbeginning[waitall:4][w:3]...[waitall:1][w:3]" , "[func:NoMercy1]And while you will \nbe losing your goal, \n[func:angry]I will become \ncloser to mine[waitall:4][w:3]...[waitall:1][w:3]", "[func:NoMercy1]If you cared about \nus for a little, you \nwould let me kill you[waitall:4][w:3]...[waitall:1][w:3]\n[func:head4]But now there's no \ngoing back.", "[func:Final_7]Here it is[waitall:4][w:3]...[waitall:1][w:3]", "Last strike.", "I must say[waitall:4][w:3]...[waitall:1][w:3] that[waitall:4][w:3]...[waitall:1][w:3] \nyou was a good \npartner[waitall:4][w:3]...[waitall:1][w:3] somewhere[waitall:4][w:3]...[waitall:1][w:3]\nin another reality[waitall:4][w:3]...", "I am sorry that I[waitall:4][w:3]...[waitall:1][w:3]\n[func:NoCurse]I lost you[waitall:4][w:3]..."}
			nrus={"[func:NoMercy1]Я не могу \nдождаться, [func:BADsmart]когда \nнаступит этот миг[waitall:4][w:3]...[waitall:1][w:3]", "Если ты умрёшь, [func:NoMercy1]то \nмы вернёмся к \nначалу[waitall:4][w:3]...[waitall:1][w:3] И чем \nдальше ты от своей \nцели, [func:angry]тем ближе \nя к своей[waitall:4][w:3]...[waitall:1][w:3]", "[func:NoMercy1]Если бы тебя \nволновал мой мир, \nты бы просто дал \nсебя убить[waitall:4][w:3]...[waitall:1][w:3]\n[func:head4]Но теперь шанс \nупущен.", "[func:Final_7]Вот и настал он[waitall:4][w:3]...[waitall:1][w:3]", "Последний удар.", "Я должна сказать[waitall:4][w:3]...[waitall:1][w:3]\nЧто ты[waitall:4][w:3]...[waitall:1][w:3] был \nхорошим партнёром[waitall:4][w:3]...[waitall:1][w:3]\nКогда-то[waitall:4][w:3]...[waitall:1][w:3] в другой \nреальности[waitall:4][w:3]...[waitall:1][w:3]", "Мне так жаль,  \nчто я[waitall:4][w:3]...[waitall:1][w:3]\n[func:NoCurse][func:TireStand]я потеряла \nтебя[waitall:4][w:3]...[waitall:1][w:3]"}
			rus={"[func:NoMercy1][func:DUB,phase4/12/1][w:5]Я не могу \nдожда[w:1]ться,[w:1] [func:BADsmart]когда \nнаступит этот миг[waitall:4][w:3]...[waitall:1][w:3]", "[func:DUB,phase4/12/2][w:5]Если ты умрёшь, [func:NoMercy1]то \nмы вернёмся к \nначалу[waitall:3][w:2]...[waitall:1][w:2] И чем \nдальше ты от своей[speed:1.09] \nцели, [func:angry]тем ближе \nя к своей[waitall:4][w:3]...[waitall:1][w:3]", "[func:NoMercy1][func:DUB,phase4/12/3][w:5]Если бы тебя \nволновал[w:1] мой мир,[w:1] \nты бы про[w:1]сто дал \nсебя убить[waitall:4][w:3]...[waitall:1][w:3]\n[func:head4]Но [w:1]теперь[w:1] шанс \nупу[w:1]щен.", "[func:Final_7][func:DUB,phase4/12/4][w:5]Вот[w:1] и настал[w:1] он[waitall:4][w:3]...[waitall:1][w:3]", "[func:DUB,phase4/12/5][w:5]По[w:1]сле[w:2]дний удар.", "[func:DUB,phase4/12/6][w:5]Я должна сказать[waitall:4][w:3]...[waitall:1][w:3]\nЧто ты[waitall:4][w:3]...[waitall:1][w:4] был \nхорошим партнёром[waitall:4][w:3]...[waitall:1][w:3]\nКогда-то[waitall:4][w:3]...[waitall:1][w:5] в другой \nреальности[waitall:4][w:3]...[waitall:1][w:3]", "[func:DUB,phase4/12/7][w:5]Мне[w:1] так жаль, \nчто я[waitall:4][w:3]...[waitall:1][w:9]\n[func:NoCurse][func:TireStand]Потеряла \nтебя[waitall:4][w:3]...[waitall:1][w:3]"}
			engcom="Don't listen to her whining,[w:3] darling![w:6] Chainsaw back in action,[w:3] strike her!"
			ruscom="Она давит на жалость![w:6] Не слушай её,[w:3] дорогуша![w:6]\nБензопила завелась,[w:3] [color:8040ff]нападай!"	
			else
				NoCurse()
			end
			Encounter.SetVar("deadlyhit",true)
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
				Encounter.SetVar("chainsaw",true)
				Encounter.SetVar("FightGoes",false)
				Encounter.Call("WriteSavio")
			end
			if diff==24 then
				wav={"phase4/WrathOnly"}
			else
				wav={"nothing"}
			end
		elseif GetGlobal("progress") == 61 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			neng={"[func:NoMercy1]I can't wait for \n[func:BADsmart]this moment to \ncome[waitall:4][w:3]...[waitall:1][w:3]", "When you will die, [func:NoMercy1]we \nwill return to\nbeginning[waitall:4][w:3]...[waitall:1][w:3]" , "[func:NoMercy1]And while you will \nbe losing your goal, \n[func:angry]I will become \ncloser to mine[waitall:4][w:3]...[waitall:1][w:3]", "[func:NoMercy1]If you cared about \nus for a little, you \nwould let me kill you[waitall:4][w:3]...[waitall:1][w:3]\n[func:head4]But now there's no \ngoing back.", "[func:Final_7]Here it is[waitall:4][w:3]...[waitall:1][w:3]", "Last strike.", "I must say[waitall:4][w:3]...[waitall:1][w:3] that[waitall:4][w:3]...[waitall:1][w:3] \nyou was a good \npartner[waitall:4][w:3]...[waitall:1][w:3] somewhere[waitall:4][w:3]...[waitall:1][w:3]\nin another reality[waitall:4][w:3]...", "I am sorry that I[waitall:4][w:3]...[waitall:1][w:3]\n[func:NoCurse]I lost you[waitall:4][w:3]..."}
			nrus={"[func:NoMercy1]Я не могу \nдождаться, [func:BADsmart]когда \nнаступит этот миг[waitall:4][w:3]...[waitall:1][w:3]", "Если ты умрёшь, [func:NoMercy1]то \nмы вернёмся к \nначалу[waitall:4][w:3]...[waitall:1][w:3] И чем \nдальше ты от своей \nцели, [func:angry]тем ближе \nя к своей[waitall:4][w:3]...[waitall:1][w:3]", "[func:NoMercy1]Если бы тебя \nволновал мой мир, \nты бы просто дал \nсебя убить[waitall:4][w:3]...[waitall:1][w:3]\n[func:head4]Но теперь шанс \nупущен.", "[func:Final_7]Вот и настал он[waitall:4][w:3]...[waitall:1][w:3]", "Последний удар.", "Я должна сказать[waitall:4][w:3]...[waitall:1][w:3]\nЧто ты[waitall:4][w:3]...[waitall:1][w:3] был \nхорошим партнёром[waitall:4][w:3]...[waitall:1][w:3]\nКогда-то[waitall:4][w:3]...[waitall:1][w:3] в другой \nреальности[waitall:4][w:3]...[waitall:1][w:3]", "Мне так жаль,  \nчто я[waitall:4][w:3]...[waitall:1][w:3]\n[func:NoCurse][func:TireStand]я потеряла \nтебя[waitall:4][w:3]...[waitall:1][w:3]"}
			rus={"[func:NoMercy1][func:DUB,phase4/12/1][w:5]Я не могу \nдожда[w:1]ться,[w:1] [func:BADsmart]когда \nнаступит этот миг[waitall:4][w:3]...[waitall:1][w:3]", "[func:DUB,phase4/12/2][w:5]Если ты умрёшь, [func:NoMercy1]то \nмы вернёмся к \nначалу[waitall:3][w:2]...[waitall:1][w:2] И чем \nдальше ты от своей[speed:1.09] \nцели, [func:angry]тем ближе \nя к своей[waitall:4][w:3]...[waitall:1][w:3]", "[func:NoMercy1][func:DUB,phase4/12/3][w:5]Если бы тебя \nволновал[w:1] мой мир,[w:1] \nты бы про[w:1]сто дал \nсебя убить[waitall:4][w:3]...[waitall:1][w:3]\n[func:head4]Но [w:1]теперь[w:1] шанс \nупу[w:1]щен.", "[func:Final_7][func:DUB,phase4/12/4][w:5]Вот[w:1] и настал[w:1] он[waitall:4][w:3]...[waitall:1][w:3]", "[func:DUB,phase4/12/5][w:5]По[w:1]сле[w:2]дний удар.", "[func:DUB,phase4/12/6][w:5]Я должна сказать[waitall:4][w:3]...[waitall:1][w:3]\nЧто ты[waitall:4][w:3]...[waitall:1][w:4] был \nхорошим партнёром[waitall:4][w:3]...[waitall:1][w:3]\nКогда-то[waitall:4][w:3]...[waitall:1][w:5] в другой \nреальности[waitall:4][w:3]...[waitall:1][w:3]", "[func:DUB,phase4/12/7][w:5]Мне[w:1] так жаль, \nчто я[waitall:4][w:3]...[waitall:1][w:9]\n[func:NoCurse][func:TireStand]Потеряла \nтебя[waitall:4][w:3]...[waitall:1][w:3]"}
			engcom="Don't listen to her whining,[w:3] darling![w:6] Chainsaw back in action,[w:3] strike her!"
			ruscom="Она давит на жалость![w:6] Не слушай её,[w:3] дорогуша![w:6]\nБензопила завелась,[w:3] [color:8040ff]нападай!"	
			else
				NoCurse()
			end
			--Encounter.SetVar("deadlyhit",true)
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
				--Encounter.SetVar("chainsaw",true)
				--Encounter.SetVar("FightGoes",false)
				--Encounter.Call("WriteSavio")
			end
			if 1==1 then
				wav={"phase4/WrathOnly"}
			else
				wav={"nothing"}
			end
		elseif GetGlobal("progress") == 62 then
			wav={"nothing"}
			Encounter.SetVar("deadlyhit",true)
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
				Encounter.SetVar("chainsaw",true)
				Encounter.SetVar("FightGoes",false)
				Encounter.Call("WriteSavio")
			end
		elseif GetGlobal("progress") >= 999 then
			wav= {"laststand4"}
			Encounter.SetVar("arenasize", {155, 130})
		end
	elseif Encounter.GetVar("songs")[1] == "night2" then
		if GetGlobal("curse") and GetGlobal("curse") > 0 then
			SetGlobal("curse", math.floor(GetGlobal("curse") / 2))
		end
		--if prog<99 and diff~=36 then
		--	Encounter.SetVar("CharaIsRaging",true)
		--end
		if GetGlobal("progress") == 1 then
			Encounter.SetVar("evadelevel",1)
			--if Encounter.GetVar("diff") == 18 then
			--	wav={"imp/k_5_new"}
			--else
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
				neng={'"Did she dodge?",[w:3]\n right?', "[func:NoMercy1]Look,[w:3] you're not \nmy prince,[w:3] \nand I'm not \nyour princess.", "[func:Bad]I can defend \nmyself." ,"[func:head][next]"}
				rus={'[func:DUB,imp/1/1][w:6]"Как она[w:1] \nувернулась?", \n[w:9]верно?', "[func:DUB,imp/1/2][func:NoMercy1][w:4]Послушай,[w:3] ты же \nне принц,[w:4] а я \nне твоя принцесса.", "[func:DUB,imp/1/3][func:Bad][w:3]Я умею за себя \nпостоять.","[func:head][next]"}
				nrus={'"Как она \nувернулась?", \n[w:3]верно?', "[func:NoMercy1]Послушай,[w:3] ты же \nне принц,[w:3] а я \nне твоя принцесса.", "[func:Bad]Я умею за себя \nпостоять.","[func:head][next]"}
				ruscom="Настало время для первого акта."
				engcom="It's time for the first act."
			end
				wav={"imp/k_5_new"}
			--end
		elseif GetGlobal("progress") == 2 then
			--if Encounter.GetVar("diff") == 18 then
			--	wav={"imp/rain"}
			--else
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
				nrus={"[func:NoMercy1]Позволь задать \nтебе вопрос.", "Ты серьёзно \nдумаешь,[w:3] \n[func:head]что я настолько \nглупа?" }
				neng={"[func:NoMercy1]Let me ask \nyou a question.", "Who do you think \nI am [func:head]to be \nso foolish?"  }
				rus={"[func:DUB,imp/2/1][func:NoMercy1][w:2]Позволь задать \nтебе вопрос.", "[func:DUB,imp/2/2][w:3]Ты серьёзно \nдумаешь,[w:2] \n[func:head]что я настолько \nглупа?" }
				ruscom="Вопрос с подвохом?"
				engcom="Is it rhetorical question?"
			end
				wav={"imp/rain"}
			--end
		elseif GetGlobal("progress") == 3 then
			--if Encounter.GetVar("diff") == 18 then
			--	wav={"imp/random"}
			--else
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
				nrus={"[func:NoMercy1][waitall:2]Всё,[waitall:1] [w:3]что ты \nнатворил на \nпути сюда[waitall:5][w:3]...[waitall:1][w:5]\nВся эта кровь \nна твоих руках[waitall:5][w:3]...", "Разве я настолько \nдура,[w:3] \n[func:head]чтобы верить тебе?" }
				rus={"[func:DUB,imp/3/1][func:NoMercy1][waitall:1][w:3]Всё,[waitall:1] что ты \nнатворил на \nпути сюда[waitall:3][w:3]...[waitall:1][w:5]\nВся эта кровь \nна твоих руках[waitall:5][w:3]...", "[func:DUB,imp/3/2][w:3]Разве я[w:1] настолько[w:2] \nдура,[w:4] \n[func:head]чтобы верить [w:2]тебе?" }
				neng={"[func:NoMercy1][speed:0.55]Everything [speed:1][w:3]you \nhave done on \nyour way there[waitall:5][w:3]...[waitall:1][w:5] \nAll this dust on \nyour hands[waitall:5][w:3]...", "Am I the damn fool \n[func:head]to believe in you?" }
				ruscom="Чара истерично хихикает."
				engcom="Chara hysterically laughs."
			end
				wav={"imp/random"}
			--end
		elseif GetGlobal("progress") == 4 then
			--if Encounter.GetVar("diff") == 18 then
			--	wav={"imp/Reaction"}
			--else
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"Мой ответ - [w:6][waitall:2]нет.", "[func:Think]Взгляни вокруг.[w:6] \nТы и я.[w:6] \nОдин на один.", "[func:NoMercy1]Этот коридор \nпропах запахом \nчеловеческой крови.", "На моих руках уже \nесть кровь людей. \n[w:6]Ты - [w:6]не первый [w:6]\nи не последний.", "[func:head]Но только ты \nпричинил столько \nболи.", "И это мой повод \nне опускать руки." }
			rus={"[func:DUB,imp/4/1][w:5]Мой ответ - [w:2]не[w:1]т.", "[func:DUB,imp/4/2][func:Think][w:3]Взгляни вокруг.[w:14] \nТы[w:16] и я.[w:15] \nОдин[w:18] на один.", "[func:DUB,imp/4/3][func:NoMercy1][w:4]Этот коридор[w:2] \nпропах[w:1] запахом \n[w:1]человеческой [w:1]крови.", "[func:DUB,imp/4/4][w:5]На моих[w:1] руках[w:3] уже[w:2] \nесть [w:1]кровь людей. \n[w:10]Ты - [w:9]не первый [w:9]\nи[w:12] [waitall:1]не пос[w:1]лед[w:1]ний.", "[w:5][func:DUB,imp/4/5][func:head]Но[w:2] только [w:1]ТЫ[w:3] \nпричинил [w:3]столько[w:1] \nболи!", "[func:DUB,imp/4/6][w:1]И [w:2]это мой повод \nне [w:1]опускать руки." }
			neng={"My answer - [w:6]no.", "Look around.[w:6]\n[func:Think]It's only you \nand me now.[w:6] \nOne per one.", "[func:NoMercy1]This corridor stinks \nwith the smell of \nhuman blood.", "My hands are dirty \nfrom their blood \nas well.[w:6] You [w:6]are \nnot the first \n[w:6]nor the last.", "[func:head]But only you \ncaused so much pain.", "And that's my reason \nto conquer once \nagain."}
			ruscom="Не забывай о своей миссии."
			engcom="Do not forget about your mission."
			end
			wav={"imp/Reaction"}
			--end
		elseif GetGlobal("progress") == 5 then
			--if Encounter.GetVar("diff") == 18 then
			--	wav={"imp/stoplights"}
			--else
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"[func:NoMercy1]И знаешь,[w:3] что?", "[func:head]С меня хватит \nпритворства.", "[func:sad]Это ведь не \nвпервые?[w:6] \nЯ чувствую, [w:3]будто \nвсё повторяется \nраз за разом.", "[func:head4]Это не похоже на \nСбросы.[w:6] \[func:sad]Временная \nлиния остаётся \nвсё той же.", "[func:head4]Будто меняется[waitall:4][w:3]...[waitall:1][w:5]\n[func:Suprise1]Сам [w:3][waitall:3]мир.", "[func:NoMercy1]Это ведь[waitall:4][w:3]...[waitall:1][w:5] \n[func:head]Твоих рук дело?" }
			rus={"[func:NoMercy1][func:DUB,imp/5/1][w:3]И знаешь, что?", "[func:head][func:DUB,imp/5/2][w:2]С меня хватит \nпритворства.", "[func:sad][func:DUB,imp/5/3][w:3]Это ведь не \nвпервые?[w:12] \nЯ чувствую, [w:1]будто \nвсё [w:1]повторяется \nраз[w:2] за разом.", "[func:DUB,imp/5/4][func:head4][w:3]Это не похоже на \nСбросы.[w:9] \[func:sad]Временная [w:1]\nлиния остаётся \nвсё той же.", "[func:DUB,imp/5/5][func:head4][w:3]Будто меняется[waitall:4][w:3]...[waitall:1][w:5]\n[func:Suprise1]Сам [w:5][waitall:1]мир.", "[func:NoMercy1][func:DUB,imp/5/6][w:2]Это ведь[waitall:4][w:1]...[waitall:1][w:5] \n[func:head]Твоих [w:1]рук дело?" }
			neng={"[func:NoMercy1]And ya know what?", "[func:head]I am done with \nall this acting.", "[func:sad]It's not the first \ntime,[w:3]is it? [w:6]I feel \nlike everything is \nrepeating every time.", "[func:head4]It is not Resets.[w:6] [func:sad]\nThe timeline  is still \nthe same.", "[func:head4]It feels like[waitall:4][w:3]...[waitall:1][w:5] [func:Suprise1]the\nwhole [waitall:2]world [waitall:1][w:5]is \nchanging.", "[func:NoMercy1]It is your fault[waitall:4][w:3]...[waitall:1][w:5] [func:head]\nRight?"}
			ruscom="В её словах есть смысл."
			engcom="She has a point."
			end
			wav={"imp/stoplights"}
			--end
		elseif GetGlobal("progress") == 6 then
			--if Encounter.GetVar("diff") == 18 then
			--	wav={"imp/NoMercyToYou"}
			--else
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"[func:sad]Ты тоже это \nчувствуешь[waitall:5]...", "[func:head4]Тем не менее[waitall:4]...[waitall:1][w:4] [func:NoMercy1]Есть\nкое-что важнее,[w:10]\nчем мои \nпредчувствия.", "[func:mercy]Ты ведь чувствуешь? [w:15]\n[waitall:2][func:head]Грехи,[waitall:1][w:5] что ползут \nпо твоей спине?"}
			rus={"[func:DUB,imp/6/1][func:sad][w:4]Ты тоже это \nчувствуешь[waitall:5]...", "[func:head4][func:DUB,imp/6/2][w:2]Тем не менее[waitall:4]...[waitall:1][w:2] [func:NoMercy1]Есть\n[speed:1.17]кое-что важнее,\nчем мои \nпредчувствия.", "[func:DUB,imp/6/3][func:mercy][w:3]Ты ведь чувствуешь? [w:15]\n[func:head]Грехи,[w:2] что ползут[w:2] \nпо твоей[w:1] спине."}
			neng={"[func:sad]So you do feel \nthe same[waitall:4][w:3]...", "[func:head4]Nevertheless[waitall:4][w:3]...[waitall:1][w:4]\n[func:NoMercy1]There's something \nmore important than\nmy prejudgments.", "[func:mercy]Do you feel them?[w:15] [func:head]\n[waitall:2]Sins[waitall:1][w:5] on your back?"}
			ruscom="Нас не одурачить этой пугалкой."
			engcom="She can't fool us with those nasty words."
			end
			wav={"imp/NoMercyToYou"}
			--end
		elseif GetGlobal("progress") == 7 then
			--if Encounter.GetVar("diff") == 18 then
			--	wav={"imp/k_storm"}
			--else
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"[func:NoMercy1]Так вот.[w:15] Мой тебе \nсовет [w:4]- не \nповорачивайся.", "[func:head]Иначе нож в ту же \nсекунду пронзит \nтвою глотку.", "Я не отпущу тебя \nбез достойной \nбитвы.[w:6] \nТы отплатишь за \nсвои грехи." }
			rus={"[func:NoMercy1][func:DUB,imp/7(!!!)/1][w:9][speed:0.80]Так вот.[w:7] Мой тебе \nсовет [w:3]-[w:3] не \nповорачивайся.", "[func:head][func:DUB,imp/7(!!!)/2][w:4][speed:0.80]Иначе нож в ту же \nсекунду пронзит \nтвою глотку.", "[func:DUB,imp/7(!!!)/3][w:6][speed:1.05]Я не отпущу тебя \nбез достойной \nбитвы.[w:6][speed:0.85] \nТы [w:1]отпла[w:2]тишь[speed:1.05] за \nсвои [w:1]грехи." }
			neng={"[func:NoMercy1]So I have an advice \nfor ya.[w:6] \n[waitall:2]Do not turn around.", "[func:head]Because in that very \nmoment knife will \npierce your thin \nneck.", "I will not let you go \nwithout proper \nfight.[w:6] You will pay \nfor your actions."}
			ruscom="Ну,[w:3] этот совет был хорошим,[w:3] кажется."
			engcom="Welp,[w:3] that advice was solid,[w:3] I wonder."
			end
			wav={"imp/k_storm"}
			--end
		elseif GetGlobal("progress") == 8 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"[func:sad]Кому я это говорю[waitall:4][w:3]...",  "[func:head4]Ты ведь не слышишь.[w:15] \n[func:sad]Не хочешь [w:5]или \nне можешь [w:5]- не \nважно.", "[func:Final_7]Полагаю[waitall:4][w:3]...[waitall:1][w:4] \n[func:NoMercy1]Мы оба знаем,[w:3] \n[func:head]что будет в конце."}
			rus={"[func:DUB,imp/8/1][func:sad][w:4]Кому я это говорю[waitall:2].[w:4].[w:4].", "[func:DUB,imp/8/2][func:head4][w:4][speed:1.17]Ты ведь[speed:1.26] не слы[w:1]шишь.[w:14] \n[func:sad][speed:1.17]Не хо[w:1]чешь [w:2]или \nне можешь [w:6]- [speed:1.25]не \nважно.", "[func:DUB,imp/8/3][func:Final_7][w:2]Полагаю,[w:4] \n[func:NoMercy1]Мы[w:3][speed:1.17] оба знаем,[w:1] \n[func:head]что [speed:1.25]будет в конце."}
			neng={"[func:sad]Why do I even \nbother[waitall:4][w:3]...", "[func:head4]You don't listen.[w:15] [func:sad]\nDoesn't matter \nif you can't \n[w:6]or you don`t want to", "[func:Final_7]I guess[waitall:4][w:3]...[waitall:1][w:3] [func:NoMercy1]We both \nknow the [func:head]final act \nof our story."}
			ruscom="Осторожнее.[w:6] \nЧто-то с ней не так[waitall:4][w:3]..."
			engcom="Beware[waitall:4][w:3]...[waitall:1][w:3] \nSomething is off about her."
			end
			wav={"imp/warning"}
		elseif GetGlobal("progress") == 9 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"[func:head4]Ты думаешь, [w:3]что я \nнаивная[waitall:4][w:3]...[waitall:1][w:3]\nпредсказуемая и \nжалкая.", "[func:Look]Думаешь,[w:3] [func:Lookleft]что я \nвообразила из себя \nсудью,[w:3] \n[func:sad]хотя сама ничем \nне лучше тебя[waitall:4][w:3]...", "[func:head4]Может,[w:3] ты и прав.","[func:head][next]"}
			rus={"[func:DUB,imp/9/1][func:NoMercy1][w:3]Ты думаешь, [w:2]что я \nнаивная,[w:7][speed:1.15]\nпредсказуемая[w:4] и \nжа[w:3]лкая.", "[func:DUB,imp/9/2][func:Look][w:8]Думаешь,[w:9] [func:Lookleft]что я \nвообразила из себя \nсудью,[w:2] \n[func:sad]хотя сама ничем \nне лучше тебя[waitall:2][w:3]...", "[func:DUB,imp/9/3][func:head4][w:5][speed:0.87]Может,[w:6] ты и прав.","[func:head][next]"}
			neng={"[func:head4]You think, I am \nnaive[waitall:4][w:3]...[waitall:1][w:3] predictable \nand pity.", "[func:Look]You think,[w:3] [func:Lookleft]I imagined \nmyself as some judge\nof you and [func:sad]still \nI am not better than \nyou[waitall:4][w:3]...", "[func:head4]Maybe,[w:3] you have a \npoint.","[func:head][next]"}
			ruscom="Конечно,[w:3] прав."
			engcom="Of course,[w:3] I have."
			end
			wav={"imp/BeFast"}
		elseif GetGlobal("progress") == 10 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"Но я не одинока.", "[func:DramaIn][func:head4]Точнее[waitall:4][w:4]...[waitall:1][w:3] была.[w:15]\nНо пусть их и нет \nсо мной[waitall:4][w:4]...", "[func:Final_3]Я чувствую их \nвнутри своей Души.", "[func:Final_4]Каждого,[w:3] кого я \nлюбила и уважала,[w:3]\nи они отвечали \nтем же[waitall:4][w:3]...", "[func:Peachy]Каждый из \nних [w:5]-[w:5] [func:mercy]моя \nсемья.", "[func:DramaOut][func:Peachy]Я многому у них \nнаучилась[waitall:4][w:4]...", "[noskip][func:NoMercy1]Например.[w:16] [speed:0.5][func:head]Этому.[w:30][next]"}
			rus={"[func:DUB,imp/10/1][w:6][speed:0.75]Но я не [speed:0.8]одинока.", "[func:DUB,imp/10/2][func:DramaIn][func:head4][w:6]Точнее[waitall:4][w:2]...[waitall:1][w:3] была.[w:15]\nНо пусть их и нет \nсо мной[waitall:4][w:4]...", "[func:DUB,imp/10/3][func:Final_3][w:4]Я чувствую их \nвнутри своей Души.", "[func:DUB,imp/10/4][func:Final_4][w:6]Ка[w:1]ждого,[w:1] кого я \nлюбила [w:1]и уважала,[w:9]\nи они отвечали[w:1] \nтем же[waitall:4][w:3]...", "[func:DUB,imp/10/5][func:Peachy][w:6]Каждый из \nних [w:4]-[w:3] [func:mercy]моя[w:1] \nсемья.", "[func:DUB,imp/10/6][func:DramaOut][func:Peachy][w:5]Я многому у них \nнаучилась[waitall:4][w:4]...", "[func:DUB,imp/10/7][noskip][func:NoMercy1][w:6][speed:0.75]Например.[w:20] [speed:0.7][func:head]Э[w:1]тому.[w:30][next]"}
			neng={"But I'm not alone.", "[func:DramaIn][func:head4]Well[waitall:4][w:4]...[waitall:1][w:3] I was[waitall:4][w:4]...[waitall:1][w:15] \nBut even if they are \nnot beside me now[waitall:4][w:4]...", "[func:Final_4]I feel them inside \nmy very soul.", "[func:head4]I feel everyone I \nloved and respected", "[func:Peachy]Every one of them[w:9] [func:mercy]\nis my family.", "[func:DramaOut][func:Peachy]I learned a lot from \nthem.", "[noskip][func:NoMercy1]For example. [w:15][func:head][waitall:2]This.[w:30][next]"}
			ruscom="Ну конечно,[w:3] сила любви.[w:6]\nКак я раньше не понял."
			engcom="Of course,[w:3] power of love.[w:6]\nShould have guessed before."
					--Encounter.SetVar("wavetime",11)
			end
			wav={"imp/bones0"}
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
				Encounter.SetVar("evadelevel",2)
			end
		elseif GetGlobal("progress") == 11 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"[func:Peachy]Понимаешь,[w:3][func:mercy] я ещё \nне совсем привыкла \nк этой[waitall:4][w:3]...[waitall:1][w:3] силе.", "[func:Remember]Моя решимость \nрезонирует внутри \nмоей души[waitall:4][w:3]...", "[func:Peachy]Я чувствую,[w:3] как \nони[waitall:4][w:3]...[waitall:1][w:3] [func:Remember]поддерживают \nменя. \n[w:6]Заботятся обо мне.", "[func:Peachy]И их сила[waitall:4][w:3]...[waitall:1][w:3] \n[func:mercy]Передалась мне.", "[func:NoMercy1]Ну что?[w:9] [func:head]Готов \nко второму раунду?"}
			rus={"[func:Peachy][func:DUB,imp/11/1][w:7][speed:1.10]Понимаешь,[speed:1.00][w:3][func:mercy] я ещё \nне [speed:1.20]совсем привыкла \nк [speed:1.00]этой[w:3].[w:3].[w:2].[w:2] [speed:0.80]силе.", "[func:DUB,imp/11/2][func:Remember][w:3]Моя решимость \nрезонирует внутри \nмоей души[waitall:4][w:3]..", "[func:DUB,imp/11/3][func:Peachy][w:4][speed:1.20]Я чувствую,[w:2] как \nони[w:1].[w:3].[w:3].[w:3] [func:Remember][speed:0.90]поддерживают \nменя. \n[w:7]Заботятся обо мне.", "[func:DUB,imp/11/4][func:Peachy][w:3]Их сила[waitall:3][w:3]...[waitall:1][w:4][speed:0.88] \n[func:mercy]Передалась [w:1]мне.", "[func:DUB,imp/11/5][func:NoMercy1][w:4]Ну[w:2] что?[w:9] [func:head][speed:1.10]Готов \nко второму раунду?[w:9]"}
			neng={"[func:Peachy]Sorry,[w:3] [func:mercy]I am still not \nso good with this[waitall:4][w:3]...[waitall:1][w:3] \npower.", "[func:Remember]My Determination \nresonates \nwithin my soul[waitall:4][w:3]...[waitall:1]", "[func:Peachy]It feels like[waitall:4][w:3]...[waitall:1][w:3] [func:Remember]they \ncheer for me.[w:6] \nCare about me.", "[func:Peachy]And their power[waitall:4][w:3]...[waitall:1][w:3] [func:mercy]\nIs now mine.", "[func:NoMercy1]So? [w:9][func:head]Are you ready \nfor the round two?"}
			ruscom="Она адаптируется к новым силам.[w:6]\nУ нас всё меньше времени,[w:3] \rдорогой актер."
			engcom="She is adapting to new powers.[w:6] \nWe have not so much time left,[w:3] \rdear actor."
			end
			wav={"imp/bullettest_touhou"}
			--Encounter.SetVar("wavetimer", 13.0)
		elseif GetGlobal("progress") == 12 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"[func:head4]Эта сила[waitall:4][w:3]...", "[func:Final_5]Я будто слышу в \nушах его голос[waitall:4][w:3]...", "[func:Peachy]Такой родной\nи близкий[waitall:4][w:3]...", "Папайрус[waitall:5]...", "[waitall:4][w:3]...", "[func:mercy]Да,[w:3] я совсем забыла \nпро тебя,[w:3] извини.", "[func:NoMercy1]Итак,[w:6][func:head] на чем мы \nостановились?"}
			rus={"[func:head4][func:DUB,imp/12/1][w:5][speed:0.85]Эта сила[waitall:4][w:3]...", "[func:Final_5][func:DUB,imp/12/2][w:3]Я будто слышу в \nушах [speed:1.10]его [w:1]го[w:1]лос[waitall:4][w:3]...", "[func:Peachy][func:DUB,imp/12/3][w:4][speed:0.76]Такой родной[waitall:4][w:1]...[waitall:1][w:1][speed:1.10]\nИ близкий[waitall:4][w:3]...", "[func:DUB,imp/12/4][w:3][speed:0.74]Папайрус[waitall:5]...", "[waitall:4][w:3]...", "[func:DUB,imp/12/5][func:mercy][w:4]Да,[w:15] я[w:3] совсем забыла \nпро тебя,[w:3] извини.", "[func:DUB,imp/12/6][func:NoMercy1][speed:0.90][w:5]И[w:1]так,[w:6][func:head] на чем мы \nостановились?"}
			neng={"[func:head4]This power[waitall:4][w:3]...", "[func:Final_5]I felt like I heared \nhis voice in my \nhead[waitall:4][w:3]...", "[func:Peachy]So close and caring[waitall:4][w:3]...", "Papyrus[waitall:4][w:3]...", "[waitall:4][w:3]...", "[func:mercy]Yeah,[w:3] I almost forgot \nabout you,[w:3] no \noffensive.", "[func:NoMercy1]So,[w:6] [func:head]shall we \nproceed?"}
			ruscom="Мне не нравится новый вектор \rбитвы.[w:6]\nОна стала сильнее."
			engcom="I don't like this new fight \rvector.[w:6] She became too powerful."
			end
			wav={"imp/bones1"}
			--Encounter.SetVar("wavetimer", 13.0)
		elseif GetGlobal("progress") == 13 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"[func:head4]Он так заботился \nо тебе[waitall:4][w:3]...", "[func:sad]Папайрус глупо \nпросил меня обещать \nему,[w:3] \nчто я не трону \nтебя.", "[func:head4]Ты был ему \nкак брат[waitall:4][w:3]...", "[func:NoMercy1][waitall:4][w:3]...", "Почему мне должно \nбыть стыдно,[w:3][func:mercy] что \nя не сдержала \nклятву?"}
			rus={"[func:head4][func:DUB,imp/13/1][w:5]Он[w:4][speed:0.92] так заботился \nо тебе[waitall:4][w:3]...", "[func:sad][func:head4][func:DUB,imp/13/2][w:5]Папайрус глупо \nпросил меня обещать \nему,[w:3] \nчто я не трону \nтебя.", "[func:head4][func:head4][func:DUB,imp/13/3][w:4]Ты был ему \nкак [w:1]брат[waitall:4][w:3]...", "[waitall:4][w:3]...", "[func:NoMercy1][func:DUB,imp/13/4][w:5][speed:1.14]Почему мне должно \nбыть[func:head] стыдно, что \nя не сдержала \nклятву?"}
			neng={"[func:head4]He cared about you \nso much...", "[func:sad]Papyrus forced me \nto give an oath to \nnot hurt you.", "[func:head4]You was like brother \nto him...", "...", "How can[waitall:4][w:3]...[waitall:1][w:3] [func:head]How can I \nbe sorry for \nbreaking this oath?"}
			ruscom="У меня одного кости болят?"
			engcom="Am I the only one with boneache?"
					--Encounter.SetVar("wavetime",10.5)
			end
			wav={"imp/bullettest_chaseorb"}
		elseif GetGlobal("progress") == 14 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"[func:Think]Даже в пылу боя,[w:3] \nон заботился о \nтебе[waitall:4][w:3]...", "[func:head]Я не буду такой \nдоброй,[w:3] не смотри \nна меня.", "[func:head4]Мне так не хватает \nразговоров с ним \nу двери[waitall:4][w:3]...", "Когда я увидела,[w:3] \nчто от двери \nостался лишь \nщебень,[w:3] я поняла,[w:3] \nчто настал [waitall:2][w:2]конец.", "Конец всему[waitall:4][w:3]...[waitall:1][w:3] \n[func:head]Что я любила."}
			rus={"[func:Think][func:DUB,imp/14/1][w:4][speed:0.87]Даже в пылу[w:1] боя,[w:8] \nон заботился[w:1] о \nтебе[waitall:4][w:3]...", "[func:head][func:DUB,imp/14/2][w:4]Я[w:2][speed:1.04] не буду такой[speed:1.25] \nдоброй,[w:4][speed:1.04] не смотри \nна меня.", "[func:head4][func:DUB,imp/14/3][w:5]Мне[w:6] так не хватает \nразговоров[speed:1.25] с ним \nу двери[waitall:4][w:3]...", "[func:DUB,imp/14/4][w:4][speed:1.15]Когда я увидела, \nчто[w:4] от двери[speed:1.00] \nостался лишь \nщебень,[w:8] я поняла,[w:3] \nчто настал [w:3]ко[w:1]нец.", "[func:DUB,imp/14/5][w:5][speed:0.80]Конец всему[waitall:2]...[waitall:1][w:3] \n[func:head]Что я [w:1]любила."}
			neng={"[func:Think]Even in the battle \ntendency he cared \nabout you[waitall:4][w:3]...", "[func:head]I won't be so \ngood,[w:3] don't even \ndream.", "[func:head4]I miss so much talking \nto him through the \ndoor[waitall:4][w:3]...", "When I saw ashes \nthat were left \nfrom it,[w:3] I got that \nthis is the [waitall:2][w:2]end.", "[waitall:2][w:1]End [waitall:1][w:9]for everything [func:head]\nI love."}
			ruscom="Чара кажется отчаявшейся."
			engcom="Chara seems desperate."
			end
			wav={"imp/bones2"}
		elseif GetGlobal("progress") == 15 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"[func:NoMercy1]Любовь[waitall:4][w:3]...", "Конечно,[w:3] [func:head]нас обоих \nсвязала любовь.", "[func:NoMercy1]Не настоящая.[w:6] \nНе семейная.[w:6] \nА та,[w:3] что \nгниёт внутри нас.", "Любовь[waitall:4][w:3]...[waitall:1][w:3][func:head] \nк убийствам.[w:6] \nК ненависти,[w:3] \nживотной натуре.", "[func:Think]В конце концов[waitall:4][w:3]...[waitall:1][w:3] \n[func:NoMercy1]Все мы такие,[w:6][speed:0.5] \n[color:ff0000]люди[color:000000][waitall:4][w:3]...","[func:head][next]"}
			rus={"[func:NoMercy1][func:DUB,imp/15/1][w:5]Лю[w:2]бовь[waitall:4][w:2].[w:2].[w:2].[w:2]", "[func:DUB,imp/15/2][w:4]Ко[w:1]не[w:1]чно,[w:9] [func:head]нас обоих \nсвязывала лю[w:1]бовь.", "[func:DUB,imp/15/3][w:4][func:NoMercy1][speed:0.85]Не настоящая.[w:3][speed:0.90] \nНе семе[w:1]йная.[w:6] \nА та,[w:3][speed:1.04] что \nгниёт[w:1][speed:1.04] внутри[w:1] нас.", "[func:DUB,imp/15/4][w:5]Лю[w:2]бовь[waitall:4][w:2]...[waitall:1][w:1][func:head] \nК убийствам.[w:6] \nК ненависти,[w:7] \nживо[w:1]тной[w:1] нату[w:1]ре.", "[func:Think][func:DUB,imp/15/5][w:4][speed:0.92]В конце[w:1] концов[waitall:2][w:2]...[waitall:1][w:2] \n[func:NoMercy1]Все мы такие,[w:15][speed:0.75] \n[color:ff0000]лю[w:5]ди[color:000000][waitall:4][w:3]...","[func:head][next]"}
			neng={"[func:NoMercy1]Love[waitall:4][w:3]...", "Sure,[w:3] [func:head]love has bonded \nus.", "[func:NoMercy1]Not real one.[w:6] \nNot family like.[w:6] \nBut that what is \nrotting inside us.", "Love[waitall:4][w:3]...[waitall:1][w:3] [func:head]to bloodshed.[w:6] \nTo hatred,[w:3] \nto wild hunting.", "[func:Think]In the end[waitall:4][w:3]...[waitall:1][w:3] \n[func:NoMercy1]It's natural for us,[w:6] \n[color:ff0000]humans[color:000000][waitall:4][w:3]...","[func:head][next]"}
			ruscom="Атака фантомных ножей![w:6]\nЭто читы!"
			engcom="The reign of phantom knives![w:6]\nYou got to be cheating!"
			end
			wav={"imp/nostop"}
		elseif GetGlobal("progress") == 16 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"[func:head4]Голоса в голове[waitall:4][w:3]...[waitall:1][w:3] \nИх слишком много[waitall:4][w:3]...", "Они все[waitall:4][w:3]...[waitall:1][w:3] все \nхотят твоей \nсмерти[waitall:4][w:3]...", "[func:NoMercy1]Но я не дам её тебе \nтак просто.", "[func:closedyesend]Так же,[w:3] как ты \nмучила милую \nАльфис,[w:3] \nты будешь гореть \nв [speed:0.5][w:2]агонии[waitall:4][w:3]...", "[func:head][waitall:3][w:3]Д о л г о[w:4]"}
			rus={"[func:head4][func:DUB,imp/16/1][w:9][speed:0.80]Голоса[w:1] в голове[waitall:3][w:1]...[waitall:1][w:1][speed:0.92] \nИ[w:2]х слишком много[waitall:4][w:3]...", "[func:DUB,imp/16/2][w:9][speed:0.75]Они[w:1] все[waitall:4][w:3]...[waitall:1][w:2][speed:0.89] все \nхотят[w:1] твоей \nсме[w:2]рти[waitall:4][w:3]...", "[func:NoMercy1][func:DUB,imp/16/3][w:5][speed:0.93]Но я не дам[w:1] её тебе \nпро[w:1]сто так.", "[func:closedyesend][func:DUB,imp/16/4][w:4][speed:1.05]Так же,[speed:0.95] как ты \nмучил[w:1] милую[w:1][speed:0.97] \nА[w:2]льфис,[w:9] \nты будешь гореть \nв [speed:0.80][w:2]агонии[waitall:4][w:3]...", "[func:head][func:DUB,imp/16/5][w:5][w:3]Д[w:1] о[w:11] л[w:2] г о[w:4]"}
			neng={"[func:head4]Voices in my head[waitall:4][w:3]...[waitall:1][w:3] \nThere's too many of \nthem[waitall:4][w:3]...", "They all[waitall:4][w:3]...[waitall:1][w:3] \nwant you dead[waitall:4][w:3]...", "[func:NoMercy1]But quick exit will be \ntoo merciful for you.", "[func:closedyesend]You will burn in [waitall:2][w:2]agony[waitall:1][w:2]\nas long as you \ntortured cute \nAlphys[waitall:4][w:3]...", "[func:head][waitall:2][w:2]For very \n[waitall:3][w:3]l o n g[waitall:2][w:3] time."}
			ruscom="Голоса[waitall:4][w:3]?..[waitall:1][w:3]\nУ неё крыша поплыла."
			engcom="Voices[waitall:4][w:3]?..[waitall:1][w:3]\nIs she nuts?"
			end
			wav={"imp/electro_rain"}
		elseif GetGlobal("progress") == 17 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"[func:head4]Они[waitall:4][w:3]...[waitall:1][w:3] взрываются\nв моей голове[waitall:4][w:3]...", "Но эта боль[waitall:4][w:3]...[waitall:1][w:3] \n[func:NoMercy1]Она ничто по \nсравнению с тем,[w:3]\nчто ты причинил\nмне.", "Я[waitall:4][w:3]...[waitall:1][w:3] я справлюсь[waitall:4][w:3]...", "[func:head4]Я[waitall:4][w:3]...[waitall:1][w:3] справлюсь[waitall:4][w:3]...", "[waitall:4][w:3]...", "[func:NoMercy1]Покажем ему,[w:9] \n[func:head]Альфи[waitall:4][w:3]..."}
			rus={"[func:head4][func:DUB,imp/17/1][w:5]О[w:2]ни[waitall:4][w:3]...[waitall:1][w:3][speed:0.85] взрываются\nв моей голове[waitall:4][w:3]...", "[func:DUB,imp/17/2][w:6]Но[w:1] эта боль[waitall:4][w:3]...[waitall:1][w:3] \n[func:NoMercy1][speed:0.90]Она ничто по \nсравнению с тем[speed:1.10],\nчто ты причинил\nмне.", "[func:DUB,imp/17/3][w:5]Я[waitall:4][w:3]...[waitall:1][w:6][speed:0.93] я справлюсь[waitall:4][w:3]...", "[func:head4][func:DUB,imp/17/4][w:5]Я[waitall:4][w:3]...[waitall:1][w:6][speed:0.85] справлюсь[waitall:4][w:3]...", "[waitall:4][w:3]...", "[func:NoMercy1][func:DUB,imp/17/5][w:5]По[w:2]кажем[w:1] ему,[w:6] \n[func:head]А[w:2]льфи[waitall:4][w:3]."}
			neng={"[func:head4]They are[waitall:4][w:3]...[waitall:1][w:3] exploding \nin my head[waitall:4][w:3]...", "But this pain[waitall:4][w:3]...[waitall:1][w:3] [func:NoMercy1]\nIs nothing comparing\nto what you have \ndone to me.", "I can[waitall:4][w:3]...[waitall:1][w:3] Deal with it[waitall:4][w:3]...", "[func:head4]I[waitall:4][w:3]...[waitall:1][w:3] Can[waitall:4][w:3]...", "[waitall:4][w:3]...", "[func:NoMercy1]Show him,[w:9] [func:head]Alph[waitall:4][w:3]..."}
			ruscom="В её руках сила твоих погибших врагов[waitall:4][w:3]...[waitall:1][w:3] Она[waitall:3][w:3]...[waitall:1][w:3] Настроена серьёзно."
			engcom="She has the power of your fallen foes[waitall:4][w:3]...[waitall:1][w:3] She is[waitall:3][w:3]...[waitall:1][w:3] serious now."
			end
			wav={"imp/alph"}
		elseif GetGlobal("progress") == 18 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"[func:NoMercy1][waitall:4][w:3]...", "Скажи,[w:3] [func:head]в чем смысл \nвсего этого?", "[func:sad]Мы встречаемся \nвновь и вновь.[w:9] \nЯ вновь и вновь \nдаю тебе отпор.", "[func:head4]Раз за разом[waitall:4][w:3]...[waitall:1][w:3] \n[func:deadly]Этот бесконечный \nкошмар[waitall:4][w:3]...", "Ты в погоне за \nсилой?[w:13] \n[func:Surprise1]Тебе не нравится \nнаш мир?", "[func:head4]Что[waitall:4][w:3]...[waitall:1][w:3] \n[func:Surprise1]Что тебе нужно?", "[waitall:4][w:4]Чего[waitall:1][w:9] тебе не \nхватает?","[func:head][next]"}
			rus={"[func:NoMercy1][func:DUB,prolog2/f][waitall:4][w:3]...", "[func:DUB,imp/18/1][w:5]Скажи,[w:10] [func:head][speed:1.07]в чем смысл \nвсего этого?", "[func:Think][func:DUB,imp/18/2][w:5]Мы встречаемся \nвновь и вновь.[w:5] \n[func:head]Я вновь и вновь[w:1] \nдаю[w:1] тебе[w:1] отпор.", "[func:head4][func:DUB,imp/18/3][w:4]Раз за разом[waitall:3][w:2]...[waitall:1][w:2] \n[func:deadly]Этот бесконечный \nкошмар[waitall:4][w:3]...", "[func:DUB,imp/18/4][w:3]Ты в погоне за \nсилой?[w:10] \n[func:Surprise1]Тебе не[speed:1.15] нравится \nнаш[w:1] мир?", "[func:head4][func:DUB,imp/18/5][w:5]Что?[w:11][speed:0.75][w:3] \n[func:Surprise1]Что[w:1] тебе[w:1][speed:1.20] ну[w:2]жно?", "[func:DUB,imp/18/6][w:4]Чего[w:5] тебе[w:3] не \nхва[w:1]тает?","[func:head][next]"}
			neng={"[func:NoMercy1][waitall:4][w:3]...", "Say,[w:3] [func:head]what is the \npoint in this?", "[func:Think]We are meeting over \nand over again.[w:9][func:head] \nI conquer you every \ntime.", "[func:head4]Over and over[waitall:4][w:3]...[waitall:1][w:3] \nthis nightmare is \nendless[waitall:4][w:3]...", "Are you chasing the \npower?[w:9] \n[func:Surprise1]Do you not like my \nworld?", "[func:head4]What[waitall:4][w:3]...[waitall:2][w:3] [func:Surprise1]What[waitall:1][w:6] is your \ngoal?", "[waitall:4][w:4]What[waitall:1][w:9] are you \nchasing?","[func:head][next]"}
			ruscom="Ей всё равно не понять.[w:6]\nНе отвлекайся."
			engcom="She won`t get it anyway.[w:6]\nDon't bother."
			end
			wav={"imp/Quickly"}
		elseif GetGlobal("progress") == 19 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"[func:head4]Твоя цель \nоправдывает \nтвои действия?", "[func:Surprise1]Моя семья погибла \nне напрасно,[w:3] [func:sad]верно?", "[func:Surprise1]Ты рушишь семьи,[w:6]\n[func:head4]ты уничтожаешь мир.", "[func:deadly]Каждый раз ты \nставишь нас на \nколени.", "[func:head4]Азриэль верил,[w:3] что \nв тебе есть что-то \nмогущественное.", "Сила,[w:6] [func:Surprise1]способная \nизменить мир.","[func:head][next]"}
			rus={"[func:head4][func:DUB,imp/19/1][w:3][speed:1.20]Твоя цель[speed:1.08] \nопра[w:1]вдывает[speed:1.00] \nтвои действия?", "[func:Surprise1][func:DUB,imp/19/2][w:5]Моя семья погибла[speed:1.15][w:1] \nне напра[w:1]сно,[w:3][speed:0.90] [func:sad]ве[w:1]рно?", "[func:Surprise1][func:DUB,imp/19/3][w:5][speed:0.88]Ты рушишь се[w:1]мьи,[w:5]\n[func:head4][speed:0.77]ты уничтожаешь[w:1] ми[w:1]р.", "[func:deadly][func:DUB,imp/19/4][w:3][speed:0.95]Ка[w:2]ждый раз[w:1][speed:1.20] ты \nставишь[w:1][speed:0.90] нас на[w:1] \nко[w:1]ле[w:1]ни!", "[func:head4][func:DUB,imp/19/5][w:5][speed:1.11]Азриэль верил,[w:3][speed:1.30] что \nв тебе есть [speed:1.00]что-то \nмогущественное.", "[func:DUB,imp/19/6][w:4][speed:0.90]Сила,[w:1][speed:1.11] [func:Surprise1]способная[w:1] \nизменить[w:1] мир.","[func:head][next]"}
			neng={"[func:head4]Does your goal cost \nyour actions?", "[func:Surprise1]My family wasn't \nsacrificed for \nnothing,[w:3] [func:sad]was it?", "[func:Surprise1]You are destroying \nfamilies,[w:3] \n[func:head4]the entire world \nitself.", "[func:deadly]Every time you are \nbreaking us to \nthe bone.", "[func:head4]Asriel believed,[w:3] that \nyou have something \ngreat.", "That you have the \npower [func:Surprise1]to change \nthe world.","[func:head][next]"}
			ruscom="Чара меланхолично крутит \rножом в руках."
			engcom="Chara is melancholically \rswinging her knife."
			end
			wav={"imp/rei"}
		elseif GetGlobal("progress") == 20 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			Encounter.SetVar("evadelevel",3)
			neng={"[func:Peachy]Yeah[waitall:4][w:3]...[waitall:1][w:3] I hear you.[w:6] \nEnough bragging[waitall:4][w:3]...", "Rei,[w:3] you always was[waitall:4][w:3]...[waitall:1][w:3] \n[func:head4]such a crybaby[waitall:4][w:3]...", "[waitall:4][w:3]...", "[func:Peachy]Oh,[w:3][func:mercy] did I slip \nagain?", "[func:Peachy]Sorry[waitall:4][w:3]...", "All those voices[waitall:4][w:3]...[waitall:1][w:3] [func:Remember]\nThere's too many of \nthem.", "[func:head4]It's almost like I hear \nyour every victim.", "Every[waitall:4][w:3]...[waitall:1][w:3] [func:sad]And no one \nin the same time[waitall:4][w:3]...", "[func:head4][waitall:4][w:3]...", "[func:head]You won't turn the \ntable,[w:6] don't even \ndream."}
			nrus={"[func:Peachy]Да[waitall:4][w:3]...[waitall:1][w:3] Я слышу тебя.[w:6] \nХватит спорить[waitall:4][w:3]...", "Аззи,[w:3] ты всегда[waitall:4][w:3]...[waitall:1][w:3][func:NoMercy1] \nбыл плаксой[waitall:4][w:3]...", "[waitall:4][w:3]...", "[func:Peachy]Ох,[w:3][func:mercy] я опять \nотвлеклась?", "[func:Peachy]Извини[waitall:4][w:3]...", "Эти голоса[waitall:4][w:3]...[waitall:1][w:3] \n[func:Remember]Их слишком много.", "[func:head4]Я будто слышу \nкаждого монстра,[w:3] \nчто ты убил.", "Каждого[waitall:4][w:3]...[waitall:1][w:3] [func:sad]И никого \nодновременно[waitall:4][w:3]...", "[func:head4][func:head4][waitall:4][w:3]...", "[func:head]Я не дам тебе \nвоспользоваться \nмоими слабостями."}
			rus={"[func:Peachy][func:DUB,imp/20/1][w:7]Да[waitall:4][w:3]...[waitall:1][w:3] Я[w:4] слышу тебя.[w:8][speed:1.11] \nХватит[speed:0.80] спорить!", "[func:DUB,imp/20/2][w:5]А[w:4]ззи,[w:6] ты[w:1] все[w:1]гда[waitall:3][w:2]...[w:2][speed:0.80] \nБыл пла[w:1]ксой.", "[func:Peachy][waitall:4][w:3]...", "[func:Peachy][func:DUB,imp/20/3][w:5]Ох,[w:3][func:mercy][speed:1.30] я опять[speed:1.40] \nотвлеклась?", "[func:Peachy][func:DUB,imp/20/4][w:5][speed:0.80]Извини[waitall:4][w:3]...", "[func:DUB,imp/20/5][w:5][speed:0.80]Эти го[w:1]ло[w:1]са[waitall:3][w:2]...[waitall:1][w:1] \n[func:Remember]Их[w:1] слишком[w:1] много.", "[func:head4][func:DUB,imp/20/6][w:5]Я будто слышу \nка[w:3]ждого мо[w:1]нстра, \nчто[w:1] ты[w:1] убил.", "[func:DUB,imp/20/7][w:4]Ка[w:3]ждого[waitall:3][w:2]...[waitall:1][w:2] [func:sad]И никого[speed:1.20] \nодновреме[w:1]нно[waitall:4][w:3]...", "[func:head4][func:head4][waitall:4][w:3]...", "[func:DUB,imp/20/8][w:5][func:head][speed:1.15]Я не дам тебе \nвоспользоваться \nмоими сла[w:1]бостями."}
			ruscom="Чара готовит Бластеры Хаоса[waitall:4][w:3]...[waitall:1][w:5]\nПогоди,[w:3] мне это что-то напомнило[waitall:4][w:3]..."
			engcom="Chara readies Chaos Blasters[waitall:4][w:3]...[waitall:1][w:5]\nWait,[w:3] why does it sound so familiar?"
			end
			wav={"imp/bullettest_bouncy"}
		elseif GetGlobal("progress")==21 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"[func:NoMercy1]Я изучала тебя.", "[func:Think]Следила за каждым \nтвоим шагом.[w:6] [func:head]И \nпришла к некоторым \nинтересным выводам.", "[func:NoMercy1]Азриэль верил,[w:3] что \nты великий человек.[w:6] \n[func:Think]Так и есть.", "[func:NoMercy1]Но твоя \nвеличественность \nвовсе не во благе.[w:6][func:head]\nА в пороке."}
			rus={"[func:NoMercy1][func:DUB,imp/21/1][w:5][speed:0.88]Я[w:1] изучала[w:1] тебя[waitall:4][w:3]...", "[func:Think][func:DUB,imp/21/2][w:3]Следила за ка[w:3]ждым \nтвоим шагом.[w:6] [func:head][speed:1.12]И \nпришла к некоторым \nинтересным выводам.", "[func:NoMercy1][func:DUB,imp/21/3][w:5][speed:1.20]Азриэль верил,[w:3] что \nты великий человек.[w:9] \n[func:Think][speed:0.88]Так и есть.", "[func:NoMercy1][func:DUB,imp/21/4][w:5][speed:1.20]Но твоя \nвеличественность[w:1] \nвовсе не во благе.[w:12][func:head][speed:0.90]\nА в поро[w:2]ке."}
			neng={"[func:NoMercy1]I studied you.", "[func:Think]I followed your every\nstep.[w:6] [func:head]And I did come \nto few interesting \nconclusions.", "[func:NoMercy1]Asriel believed \nyou're a great \nperson.[w:6] \n[func:Think]So you are.", "[func:NoMercy1]But your greatness \nis not in your good \nwill,[w:3] [func:head]but in your sin."}
			engcom="Don't hesitate.[w:6] \nIt's battle for exhausting."
			ruscom="Не колеблись.[w:6] \nЭто бой на выносливость."
			end
			wav={"imp/asrielaser"}
		elseif GetGlobal("progress")==22 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"[func:NoMercy1]Твой порок - \n[func:head]неутолимый голод.", "Ты жаждешь всё \nбольше и больше.", "Твоя жадность \nпоглощает собой \nвесь мир.", "[func:Think]Для тебя нет \n'чужого'.[waitall:1][w:6] [func:head]\nЕсть лишь [waitall:2][w:1]'моё'", "[func:NoMercy1]И именно поэтому \nты раз за разом \nуничтожаешь всё,[w:3] \nчто мне дорого.", "[func:head]Ты ненасытен."}
			rus={"[func:NoMercy1][func:DUB,imp/22/1][w:4][speed:0.90]Твой порок -[w:1] \n[func:head]неутолимый[speed:0.65] голод.", "[func:DUB,imp/22/2][w:4][speed:0.98]Ты жаждаешь[speed:0.80] всё \nбо[w:1]льше и бо[w:1]льше.", "[func:DUB,imp/22/3][w:4][speed:0.96]Твоя жадность \nпоглощает собой[speed:0.70][w:1] \nвесь мир.", "[func:Think][func:DUB,imp/22/4][w:5]Для тебя нет[speed:0.65] \n'чужого'.[speed:0.85][waitall:1][w:6] [func:head]\nЕсть лишь [w:5][speed:0.35][w:1]'моё'.", "[func:NoMercy1][func:DUB,imp/22/5][w:2]И[w:1] именно поэтому[w:1] \nты раз[w:2] за ра[w:2]зом \nуничтожа[w:1]ешь всё,[w:1] \nчто мне до[w:1]ро[w:1]го!", "[func:head][func:DUB,imp/22/6][w:5][speed:0.85]Ты не[speed:0.65]насы[speed:0.50]тен."}
			neng={"[func:NoMercy1]Your sin [w:3]-[w:3] \n[func:head]unstoppable hunger.", "You want more \nand more.", "Your selfishness \nis eating the whole \nworld.", "[func:Think]For you there's \nno <other's>,[waitall:1][w:3] [func:head]but[waitall:2] \n<mine>[waitall:1],[w:3] isn't it?", "[func:NoMercy1]And that's the \nreason to destroy \neverything I love \nover and over.", "[func:head]You're voracious."}
			engcom="All this hunger chatting makes \rme hungry for real[waitall:4][w:3]..."
			ruscom="После этой тирады захотелось \rперекусить[waitall:4][w:3]..."
			end
			wav={"imp/SoulOfHunger"}
		elseif GetGlobal("progress") == 23 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"[func:head4]Все эти разговоры \nо голоде[waitall:4][w:3]...", "Я[waitall:4][w:3]...[waitall:1][w:3] я вспоминаю \nмамину выпечку[waitall:4][w:3]...", "[func:Peachy]Её голос[waitall:4][w:3]...[waitall:1][w:3] Cамый \nзвонкий.", "Я слышу его \nотчетливее других.", "[func:head4]Он[waitall:4][w:3]...[waitall:1][w:3] он будто \nвыжигает мои уши[waitall:4][w:3]...", "[func:NoMercy1][waitall:4][w:3]...", "Взамен всей этой \nболи я[waitall:4][w:3]...[waitall:1][w:3] [func:head]Я выжгу \nтебя!" }
			rus={"[func:head4][func:DUB,imp/23/1][w:3][speed:1.20]Все эти разговоры \nо [speed:0.90]голоде[waitall:4][w:3]...", "[func:DUB,imp/23/2][w:4]Я[waitall:3][w:2]...[waitall:1][w:3][speed:0.90] я вспоминаю \nмамину выпечку[waitall:4][w:3]...", "[func:Peachy][func:DUB,imp/23/3][w:4][speed:0.70]Её голос[waitall:3][w:2]...[waitall:1][w:3][speed:0.80] Cамый \nзвонкий.", "[func:DUB,imp/23/4][w:4][speed:0.94]Я слышу его \nотчетливее [w:1]других.", "[func:head4][func:DUB,imp/23/5][w:3]Он[waitall:4][w:3]...[waitall:1][w:3] он будто[speed:0.80] \nвыжигает мои у[w:1]ши[waitall:4][w:3]...", "[func:NoMercy1][waitall:4][w:3]...", "[func:DUB,imp/23/6][w:3][speed:0.90]Взамен всей[speed:0.90] этой \nболи я[waitall:3][w:3]...[waitall:1][w:3] [func:head][speed:0.70]Я ВЫЖГУ \nТЕ[w:1]БЯ!" }
			neng={"[func:head4]All this hunger \ntalking[waitall:4][w:3]...", "I[waitall:4][w:3]...[waitall:1][w:3] I remember \nmom's pastries[waitall:4][w:3]...", "[func:Peachy]Her voice[waitall:4][w:3]...[waitall:1][w:3] is the \nloudest one.", "I hear her so \nclearly[waitall:4][w:3]...", "[func:head4]It[waitall:4][w:3]...[waitall:1][w:3] It is burning \nmy ears[waitall:4][w:3]...", "[func:NoMercy1][waitall:4][w:3]...", "Instead of this pain,[w:3] \nI[waitall:4][w:3]...[waitall:1][w:3] [func:head]I will burn you!"}
			engcom="Don't get burned."
			ruscom="Не обожгись."
			end
			wav={"imp/firespears"}
		elseif GetGlobal("progress") == 24 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"[func:thoughts]Я вижу это пламя[waitall:4][w:3]...", "[func:head4]И перед глазами \nмелькают образы из \nдетства.", "Пожар[waitall:4][w:3]...[waitall:1][w:3] \nДеревня[waitall:4][w:3]...", "[func:trigeredclosed]Гх[waitall:4][w:3]...[waitall:1][w:3] [func:trigered]Почему ты \nне можешь наконец \nсдохнуть?!", "Сгори в аду,[w:3] чёртов \nпсих!"}
			rus={"[func:thoughts][func:DUB,imp/24/1][w:3][speed:0.85]Я вижу это[w:1] пламя[waitall:4][w:3]...", "[func:head4][func:DUB,imp/24/2][w:5]И перед глазами[speed:1.10] \nмелькают образы из[speed:0.90] \nдетства.", "[func:DUB,imp/24/3][w:5][speed:0.60]Пожар[waitall:2][w:1]...[waitall:1][w:1][speed:0.54] \nДеревня[waitall:2][w:1]...", "[func:trigeredclosed][func:DUB,imp/24/4][w:5]Гх[waitall:3][w:2]...[waitall:1][w:2] [func:trigered][speed:0.65]Почему[speed:0.75] ты \nне можешь наконец \nСДОХНУТЬ?!", "[func:DUB,imp/24/5][w:5][speed:0.75]С[w:2]гори в аду,[w:1] чёртов \nпсих!"}
			neng={"[func:thoughts]When I see this \nflame[waitall:4][w:3]...", "[func:head4]It's like memories \nof the past are \nin front of me[waitall:4][w:3]...", "Fire[waitall:4][w:3]...[waitall:1][w:3] \nVillage[waitall:4][w:3]...", "[func:trigeredclosed]Ugh[waitall:4][w:3]...[waitall:1][w:3] [func:trigered]Why can't you \njust die already?!", "Burn in hell,[w:3] you \ndamn psycho!"}
			engcom="Chara seems to be mad.[w:6] \nFor some reason[waitall:4][w:3]?.."
			ruscom="Чара выглядит безумной.[w:6] \nПо какой-то причине?"
			end
			wav={"imp/RandomFire"}
		elseif GetGlobal("progress") == 25 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"[func:Final_1]Погодите[waitall:4][w:3]...", "Я[waitall:4][w:3]...[waitall:1][w:3] [func:NoMercy1]Я поняла.", "[func:closedyesend]Ты такой же,[w:3] \nкак и они[waitall:4][w:3]...", "Жадный и полный \nненависти человек.", "[func:NoMercy1][waitall:4][w:3]...", "Сначала[w:6] я хотела \nтебе верить.[w:6] \n[func:Think]Правда,[w:3] хотела.", "[func:NoMercy1]Но сейчас[waitall:4][w:3]...[waitall:1][w:3] \nНет пощады таким,[w:3] \n[func:head]как ты." }
			rus={"[func:Final_1][func:DUB,imp/25/1][w:5][speed:0.76]Погодите[waitall:4][w:3]...", "[func:DUB,imp/25/2][w:5]Я[waitall:4][w:3]...[waitall:1][w:4][speed:0.66] [func:NoMercy1]Я поняла.", "[func:closedyesend][func:DUB,imp/25/3][w:4][speed:0.80]Ты такой же[waitall:4][w:3]...[waitall:1][w:2][speed:0.80] \nКак и они[waitall:4][w:3]...", "[func:DUB,imp/25/4][w:5][speed:0.85]Жадный и полный \nненависти человек.", "[func:NoMercy1][waitall:4][w:3]...", "[func:DUB,imp/25/5][w:4][speed:0.93]Сначала я хотела \nтебе верить.[w:5] \n[func:Think]Правда,[w:1] хотела.", "[func:NoMercy1][func:DUB,imp/25/6][w:5][speed:0.80]Но сейчас[waitall:3][w:2]...[waitall:1][w:3][speed:0.70] \nНет[speed:0.88] пощады таким,[w:2] \n[func:head]как ты." }
			neng={"[func:Final_1]Wait[waitall:4][w:3]...", "I[waitall:4][w:3]...[waitall:1][w:3] [func:NoMercy1]I got it.", "[func:closedyesend]You are almost like \nthem[waitall:4][w:3]...", "Greedy and hateful \nhuman.", "[func:NoMercy1][waitall:4][w:3]...", "At first[w:6] I wanted to \nbelieve you.[w:6]\n[func:Think]Really,[w:3] wanted.", "[func:NoMercy1]But now[waitall:4][w:3]...[waitall:1][w:3] \nNo mercy for \nsomeone [func:head]like you."}
			engcom="Chara has frozen,[w:3] starring \rinto you. "
			ruscom="Чара замерла,[w:3] пристально глядя \rвам в глаза."
			Encounter.SetVar("evadelevel",2)
			end
			wav={"imp/NotMiddleRoad"}
		elseif GetGlobal("progress") == 26 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"[func:Final_1]Казалось,[w:3] будто я \nувидела в твоих \nглазах раскаяние[waitall:4][w:3]...", "[noskip][func:QuietMusic][func:Final_5]Лишь на миг,[w:3] но[waitall:4][w:3]...", "Милое зеркальце.[w:9] \nПартнёр.[w:9] \nКомпаньон.", "[func:Final_5]Если ты[waitall:4][w:3]...[waitall:1][w:3] \nЕсли ты слышишь[waitall:4][w:3]...", "[func:Music,spare]Я[waitall:4][w:3]...[waitall:1][w:3][func:Final_1] [func:HideKnife]Я хочу дать \nтебе шанс[waitall:4][w:3]...", "[func:head4]Но если нет[waitall:4][w:3]...[waitall:1][w:3] \nЕсли я ошибаюсь[waitall:4][w:3]...", "[waitall:4][w:3]...", "[func:Final_7]То тогда я \nдействительно \nдура[waitall:4][w:3]...","[func:Peachy][w:10][func:mercy][next]"}
			rus={"[func:Final_1][func:DUB,imp/26/1][w:5]Казалось,[w:3] будто я \nувидела в [speed:1.10]твоих \nглазах раска[w:2][speed:0.80]яние[waitall:4][w:3]...", "[noskip][func:QuietMusic][func:Final_5][func:DUB,imp/26/2][w:5]Лишь на миг,[w:3] но[waitall:4][w:3]...", "[func:DUB,imp/26/3][w:6]М[w:1]илое зеркальце.[w:9][speed:0.90] \nПартнёр.[w:11][speed:0.80] \nКомпаньон.", "[func:Final_5][func:DUB,imp/26/4][w:5][speed:0.90]Если ты[waitall:4][w:3]...[waitall:1][w:3] \nЕсли ты слы[w:2]шишь[waitall:4][w:3]...", "[func:Music,spare][func:DUB,imp/26/5][w:5]Я[waitall:4][w:3]...[waitall:1][w:7][func:Final_1] [func:HideKnife]Я хочу дать \nтебе шанс[waitall:4][w:3]...", "[func:head4][func:DUB,imp/26/6][w:5][speed:0.80]Но если нет[waitall:3][w:2]...[waitall:1][w:1][speed:0.74] \nЕсли я ошиба[w:1]юсь[waitall:4][w:3]...", "[waitall:4][w:3]...", "[func:Final_7][func:DUB,imp/26/7][w:4]То тогда я[speed:1.25] \nдействительно [speed:1.40]\nдура[waitall:4][w:3]...","[func:Peachy][w:10][func:mercy][next]"}
			neng={"[func:Final_1]I felt like[waitall:4][w:3]...[waitall:1][w:3] \nI saw remorse in \nyour eyes[waitall:4][w:3]...", "[noskip][func:QuietMusic][func:Final_5]Only for a moment,[w:3] \nbut[waitall:4][w:3]...", "Pretty mirror.[w:9] \nPartner.[w:9]\nCompanion.", "[func:Final_5]If you[waitall:4][w:3]...[waitall:1][w:3] \nIf you hear me[waitall:4][w:3]...", "[func:Music,spare]I[waitall:4][w:3]...[waitall:1][w:3] [func:Final_1][func:HideKnife]I want to \ngive you a chance[waitall:4][w:3]...", "[func:head4]But if no[waitall:4][w:3]...[waitall:1][w:3] \nIf I have been \nwrong[waitall:4][w:3]...", "[waitall:4][w:3]...", "[func:Final_7]Then I really am \na fool.","[func:Peachy][w:10][func:mercy][next]"}
			engcom="Chara is giving you second \rchance.[w:10][speed:0.75] \n[color:8040ff]Do not you dare, darling..."
			ruscom="Чара даёт вам второй шанс. \n[w:10][speed:0.75][color:8040ff]Даже не смей, дорогуша..."
			end
			wav={"nothing"}
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
				Encounter.SetVar("forcedfight",true)
				Encounter.SetVar("FightGoes",false)
			end
	------------------------------------------------------------------------
		elseif GetGlobal("progress") == 27 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"Гх!", "[func:deadly][waitall:4][w:3]...", "[func:closedyesend]Ну конечно[waitall:4][w:3]...", "[func:NoMercy1]Даже если ты \nи слышишь[waitall:4][w:3]...[waitall:1][w:3] \n[func:Think]Ты не выше \nпоследствий.", "[func:NoMercy1]Сила нашего с тобой \nУР[waitall:4][w:3]...[waitall:1][w:3] \n[func:Think]Слишком высока,[w:3] \nчтобы ей \nпротивостоять.", "[func:head]У тебя есть высшая \nцель.[w:6] \nКак и у меня.", "[func:Devil]Так что давай не \nбудем отступать от \nнеё."}
			rus={"[func:DUB,imp/27/1][w:8]Гх!", "[func:deadly][waitall:4][w:3]...", "[func:closedyesend][func:DUB,imp/27/2][w:5][speed:0.75]Ну [speed:0.65]конечно[waitall:4][w:3]...", "[func:NoMercy1][func:DUB,imp/27/3][w:4][speed:0.90]Даже если ты \nи слышишь[waitall:3][w:2]...[waitall:1][w:2] \n[func:Think]Ты не выше \nпоследствий.", "[func:NoMercy1][func:DUB,imp/27/4][w:6]Сила[speed:0.90] нашего с тобой [w:2]\nУ[w:2]Р[w:1] \n[func:Think][speed:1.15]слишком велика,[w:1] \nчтобы ей \nпротивостоять.", "[func:head][func:DUB,imp/27/5][w:6][speed:0.90]У тебя есть высшая \nцель.[w:9][speed:0.80] \nКак и у меня.", "[func:Devil][func:DUB,imp/27/6][w:5][speed:1.15]Так что[w:1] давай не \nбудем[speed:1.25] отступать от \nнеё."}
			neng={"Ugh!", "[func:deadly][waitall:4][w:3]...", "[func:closedyesend]Obvious[waitall:4][w:3]...", "[func:NoMercy1]Even if you \nhear me[waitall:4][w:3]...[waitall:1][w:3] \n[func:Think]You're not above \nconsequences.", "[func:NoMercy1]Power of our LV[waitall:4][w:3]...[waitall:1][w:3] \n[func:Think]Is too high for \nresisting.", "[func:head]You have an utter \nmission to complete.[w:6] \nMe as well.", "[func:Devil]So let's not get \ndistracted."}
			ruscom="Чара разочарована в вас."
			engcom="Chara seems disappointed in you."
			end
			wav={"imp/shadows"}
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
				Encounter.SetVar("forcedfight",false)
				Encounter.SetVar("FightGoes",true)
				Encounter.SetVar("globalstage","2")
				Encounter.Call("WriteSavio")
			end
		elseif GetGlobal("progress") == 28 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"[func:head]Мой папа,[w:3] Асгор,[w:3] \nизучал мою Душу.", "[func:NoMercy1]Он изучал,[w:3] что \nтакое человеческая \nРешимость.", "[func:Think]Он добился \nинтересных \nрезультатов.[w:6] \nКак я считаю.", "[func:NoMercy1]Ты,[w:3] конечно же,[w:3] \n[func:Bad]знаешь о \nфункциональном \nменю и \nСохранениях[waitall:4][w:3]...", "[func:NoMercy1]Но ты понятия не \nимеешь о[waitall:4][w:3]...[waitall:1][w:3] [func:head]\n[waitall:2]Деформировании[waitall:1][w:3]."}
			rus={"[func:head][func:DUB,imp/28/1][w:6][speed:0.75]Мой папа,[w:6] Асгор,[w:12][speed:0.94] \nизучал мою Душу.", "[func:NoMercy1][func:DUB,imp/28/2][w:2]Он изучал,[w:3] что \nтакое человеческая \nРешимость.", "[func:Think][func:DUB,imp/28/3][w:5]Он добился[speed:1.05] \nинтересных \nрезультатов.[w:6] \nКак я считаю.", "[func:NoMercy1][func:DUB,imp/28/4][w:5][speed:1.10]Ты, конечно же, \n[func:Bad]знаешь о[speed:1.00] \nфункциональном \nменю и \nСохранениях[waitall:4][w:3]...", "[func:NoMercy1][func:DUB,imp/28/5][w:5][speed:1.05]Но[w:2] ты понятия не \nимеешь[w:2] о[waitall:3][w:2]...[waitall:1][w:2] [func:head][speed:0.90]\nДеформировании[waitall:1][w:3]."}
			neng={"[func:head]My dad,[w:3] Asgore,[w:3] \nstudied my Soul.", "[func:NoMercy1]He studied human \nDetermination.", "[func:Think]And he achieved \ninteresting \nresults.", "[func:NoMercy1]Of course,[w:3] [func:Bad]you \nknow about \nfunctional menu \nand Saving[waitall:4][w:3]...", "[func:NoMercy1]But you have \nno idea[waitall:4][w:3]...[waitall:1][w:3] [func:head]what \n[w:3][waitall:2]Defragmenting[waitall:1][w:3] is."}
			engcom="Now it seems interesting."
			ruscom="Теперь это кажется интересным."
			end
			wav={"imp/listopad"}
		elseif GetGlobal("progress") == 29 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"[func:NoMercy1]Когда папа смог \nсинтезировать \nискусственную \nРешимость[waitall:4][w:3]...", "[func:head4]Она не прижилась.[w:6] \n[func:sad]Тела монстров были \nобезображены.[w:6] \nОни слились в \nАмальгамов.", "[func:head4]Ты знаешь эту \nисторию.", "Однако[waitall:4][w:3]...[waitall:1][w:3] Был второй \nэксперимент.[w:6] \nПохожий.", "[func:NoMercy1]Но с моей \nРешимостью.", "[func:Think]С естественной.[w:6] Я \nприняла выведенную \nим искусственную \nРешимость.", "[func:NoMercy1]И[waitall:4][w:3]...[waitall:1][w:3] [func:head]и это дало свои \nплоды."}
			rus={"[func:NoMercy1][func:DUB,imp/29/1][w:5][speed:1.12]Когда папа смог \nсинтезировать \nискусственную \nРешимость[waitall:4][w:3]...", "[func:head4][func:DUB,imp/29/2][w:5]Она не прижилась.[w:9][speed:0.88] \n[func:sad]Тела монстров были \nобезображены.[w:9] \nОни слились в \nАмальгамов.", "[func:head4][func:DUB,imp/29/3][w:4]Ты знаешь эту \nисторию.", "[func:DUB,imp/29/4][w:5][speed:0.90]Одна[w:2]ко,[w:3] был второй [speed:1.05]\nэксперимент.[w:7] \nПохожий.", "[func:NoMercy1][func:DUB,imp/29/5][w:5][speed:0.80]Но[w:4] с моей \nРешимостью.", "[func:Think][func:DUB,imp/29/6][w:5]С естественной.[w:6] Я \nприняла[w:1] выведенную \nим[w:2] искусственную \nРешимость.", "[func:NoMercy1][func:DUB,imp/29/7][w:5]И[waitall:3][w:2]...[waitall:1][w:2] [func:head]это дало свои \nплоды."}
			neng={"[func:NoMercy1]When dad \nsynthesized \nartificial \nDetermination[waitall:4][w:3]...", "[func:head4]It was a failure.[w:6] \n[func:sad]Monsters body were \ndamaged and they \nmelted into \nAmalgamates.", "[func:head4]You know this story.", "Perhaps[waitall:4][w:3]...[waitall:1][w:3] \nThere was another \nexperiment [w:6] \nPretty similar.", "[func:NoMercy1]But based on my \nDetermination.", "[func:Think]Natural type.[w:6] \nI injected his \nartificial \nDetermination.", "[func:NoMercy1]And[waitall:4][w:3]...[waitall:1][w:3] [func:head]And it was \nsuccessful."}
			engcom="Did I hear this story before[waitall:4][w:3]?.."
			ruscom="Мне кажется, или я слышал эту историю[waitall:4][w:3]?.."
			end
			wav={"imp/krug"}
		elseif GetGlobal("progress") == 30 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			Encounter.SetVar("evadelevel",3)
			nrus={"[func:NoMercy1]Помимо текущего \nтаймлайна \nпараллельно \nсуществует \nмножество других.", "[func:head4]Я[waitall:4][w:3]...[waitall:1][w:3] я увидела их,[w:6][func:sad]\nкогда Решимость \nначала реакцию.", "Я видела хорошие \nконцовки,[w:3] \nальтернативные \nверсии себя[waitall:4][w:3]...", "Даже[waitall:4][w:3]...[waitall:1][w:3] [waitall:2][w:3][func:deadly]себя[waitall:1][w:3] на \nтвоём месте.", "[func:head4]Всё это[waitall:4][w:3]...[waitall:1][w:3] [func:thoughts]не \nукладывалось у меня \nв голове.", "[func:head4]Тогда я не понимала,[w:3] \nк чему были эти \nобразы.", "[func:head4]Сейчас[waitall:4][w:3]...[waitall:1][w:3] [func:NoMercy1]Я всё \nпоняла.[w:6] [func:head]\nНе трудно сложить \nдва и два."}
			rus={"[func:NoMercy1][func:DUB,imp/30/1][w:3][speed:1.05]Помимо [speed:0.90]текущего[speed:1.05] \nтаймла[w:2]йна \nпараллельно \nсуществует \nмно[w:2]жество других.", "[func:head4][func:DUB,imp/30/2][w:5]Я[waitall:3][w:3]...[waitall:1][w:2][speed:0.90] я увидела их,[w:6][func:sad]\nкогда [speed:1.00]Решимость[speed:1.15] \nначала [speed:1.00]реакцию.", "[func:DUB,imp/30/3][w:5]Я[w:2] видела[w:1] хорошие[w:1] \nконцовки,[w:1] \nальтернативные[w:1] \nверсии себя[waitall:4][w:3]...", "[func:DUB,imp/30/42][w:5]Да[w:2]же[w:4] [func:deadly]се[w:2]бя[waitall:1][w:5] на \nтвоём[w:1] ме[w:2]сте.", "[func:head4][func:DUB,imp/30/5][w:3]Всё это[waitall:3][w:2]...[waitall:1][w:2] [func:thoughts][speed:1.19]не \nукладывалось у меня \nв голове[waitall:3][w:2]...[waitall:1][w:2]", "[func:head4][func:DUB,imp/30/6][w:3][speed:1.19]Тогда я не понимала,[w:2] \nк чему были [speed:1.09]эти \nобразы.", "[func:DUB,imp/30/7][w:4][func:head4][speed:0.80]Сейчас[waitall:3][w:2]...[waitall:1][w:2] [func:NoMercy1]Я всё \nпоняла.[w:6] [speed:1.20][func:head]\nНе трудно сложить[speed:1.60] \nдва и два."}
			neng={"[func:NoMercy1]Besides current \ntimeline another \nones exists as well.", "[func:head4]I[waitall:4][w:3]...[waitall:1][w:3] I did see them.[w:6][func:sad]\nWhen Determination \nbegan reacting.", "I saw good endings,[w:3] \nalternate selves[waitall:4][w:3]...", "Even[waitall:4][w:3]...[waitall:1][w:3] [waitall:2][w:3][func:deadly]Myself[waitall:1][w:3] on \nyour place.", "[func:head4]All of this[waitall:4][w:3]...[waitall:1][w:3] \n[func:thoughts]Blew my mind.", "[func:head4]That day I couldn't \nunderstand what I \nsaw.", "But now[waitall:4][w:3]...[waitall:1][w:3] [func:NoMercy1]I get it \nclearly.[w:6] [func:head]Not so hard \nto sum one and one."}
			engcom="Chara recovered few of her sanity.[w:6] \nBut she is exhausted as well."
			ruscom="Чара восстанавливает ясность ума.[w:6]\nНо настолько же она и устала."
			end
			--Encounter.SetVar("wavetimer", 20.0)
			wav={"imp/brave"}
		elseif GetGlobal("progress") == 31 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"[func:Peachy]Андайн\nбеспокоилась,[w:3] что \nАсгор зря ввязал \nменя,[w:3] ребёнка,[w:3] в \nсвои работы.", "Она настаивала,[w:3] \nчтобы я больше не \nвмешивалась.", "[func:Remember]Мои силы были \nслишком ценны для \nеё боевой арены.", "[func:Peachy]Она не хотела \nтерять такого \nоппонента,[w:3] как я.", "[func:mercy]Мне льстила такая \nвысокая оценка.", "[func:Peachy]Андайн умела \nподнять боевой \nдух.[w:6] Азриэль всегда \nей вдохновлялся.", "[func:NoMercy1][waitall:2]Теперь[waitall:1][w:6] [func:head]моя очередь."}
			rus={"[func:Peachy][func:DUB,imp/31/1][w:4]Андайн\nбеспокоилась,[w:1] что \nАсгор зря ввязал \nменя,[w:8] ребёнка,[w:2] в \nсвои[w:1] работы.", "[func:DUB,imp/31/2][w:5][speed:1.12]Она настаивала, \nчтобы я больше не \nвмешивалась.", "[func:Remember][func:DUB,imp/31/3][w:4]Мои силы были[speed:0.75] \nслишком [speed:1.00]ценны для \nеё[w:1] боевой[w:1] арены.", "[func:Peachy][func:DUB,imp/31/4][w:4]Она не хотела \nтерять такого \nоппонента,[w:1] как я.", "[func:mercy][func:DUB,imp/31/5][w:5]Мне[w:3][speed:1.19] льстила такая \nв[speed:0.90]ысокая оценка.", "[func:Peachy][func:DUB,imp/31/6][w:3][speed:0.94]Анда[w:1]йн[w:1] умела \nподнять боевой \nдух.[w:6] Азриэль всегда \nей вдохновлялся.", "[func:head][func:DUB,imp/31/7][w:4][speed:0.85]Теперь моя[speed:0.78] очередь."}
			neng={"[func:Peachy]Undyne worried that \nAsgore was wrong \nwhen pulled me,[w:3] kid,[w:3] \nin experiments.", "She insisted to not \nbother me.", "[func:Remember]My powers were too \nprecious for her \nbattle arena.", "[func:Peachy]She didn't want to \nlose such a \nfighter as me.", "[func:mercy]I was pleased with \nsuch respect.", "[func:Peachy]Undyne could always \nrise your battle \nspirit.[w:6] Asriel was \ninspired by her.", "[func:NoMercy1][waitall:2]Now[waitall:1][w:6] [func:head]so am I."}
			engcom="Sushi are served cold and without knifes."
			ruscom="Суши подаются холодными и без ножей."
			end
			wav={"imp/und"}
		elseif GetGlobal("progress") == 32 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"[func:NoMercy1]Теперь,[w:3] когда я \nизучаю таймлайны,[w:3] \n[func:Think]я всё больше и \nбольше понимаю, как \nработает моя \nпамять", "[func:NoMercy1]Тот раз,[w:3] когда я \nприняла \nискусственную \nРешимость,[w:3] стал \nрешающим фактором.", "Ты понимаешь,[w:3][func:Bad] о \nчем я?", "[w:2][waitall:2][func:NoMercy1]Да[waitall:4][w:3]...[waitall:1][w:3] Именно в тот \nдень [w:6][func:head]я получила \nспособность читать \nвременные линии."}
			rus={"[func:NoMercy1][func:DUB,imp/32/1][w:4]Теперь,[w:3] когда я \nизучаю таймлайны,[w:3] \n[func:Think]я всё больше и \nбольше понимаю, как[speed:1.02] \nработает моя \nпамять.", "[func:NoMercy1][func:DUB,imp/32/2][w:4]Тот раз,[w:2][speed:1.15] когда я \nприняла \nискусственную \nРешимость,[w:5][speed:0.95] стал \nрешающим [w:1]фактором.", "[func:DUB,imp/32/3][w:4]Ты понимаешь,[w:2][func:Bad] о \nчем[w:1] я?", "[w:5][waitall:2][func:NoMercy1][func:DUB,imp/32/4][w:3]Да[waitall:4][w:2]...[waitall:1][w:1][speed:0.90] Именно в тот \nдень [func:head]я получила[speed:1.05] \nспособность читать \nвременные линии."}
			neng={"[func:NoMercy1]Now,[w:3] as I studied \nthose timelines,[w:3] [func:Think]I \nhave understood \nmore about my \nmemory.", "[func:NoMercy1]It was a key factor \nto the truth,[w:3] when \nI injected artificial \nDT.", "Did you get [func:Bad]what \nI mean?", "[w:2][waitall:2][func:NoMercy1]Yes[waitall:4][w:3]...[waitall:1][w:3] In that very \nday[w:6] [func:head]I got the power \nto read timelines."}
			engcom="She[waitall:4][w:3]...[waitall:1][w:3] She [waitall:2][w:3]WHAT?"
			ruscom="Она[waitall:4][w:3]...[waitall:1][w:3] Она [waitall:2][w:3]ЧТО?"
			end
			wav={"imp/k_random1"}
		elseif GetGlobal("progress") == 33 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"[func:head4]Не знаю,[w:3] что это \nбыло.[w:6] Судьба,[w:3] карма.[w:6] \n[func:sad]Без разницы.", "Главное,[w:3] [func:head4]что я \nблагодарю и \nпроклинаю эту силу \nодновременно.", "[func:sad]Из-за неё я вижу \nсмерти близких мне \nлюдей каждый \nраз,[w:3] как открываю \nглаза.", "[func:NoMercy1]Но с другой?[w:6] [func:head]Я как \nникогда ближе к \nтому,[w:3] чтобы изгнать \nтебя.", "[func:NoMercy1]Твоя сила[waitall:4][w:3]...[waitall:1][w:3] [func:Bad]Ты \nзнаешь о других \nтаймлайнах?", "[func:head]Ты как никто другой \nзнаешь,[w:3] что я хочу \nсделать."}
			rus={"[func:head4][func:DUB,imp/33/1][w:6]Не знаю, что это \nбыло.[w:8] Судьба,[w:12][speed:0.80] ка[w:2]рма.[w:12][speed:0.90] \n[func:sad]Без разницы.", "[func:DUB,imp/33/2][w:4]Главное, [func:head4]что я[speed:0.95] \nблагодарю и \nпроклинаю эту силу \nодновременно.", "[func:sad][func:DUB,imp/33/3][w:4]Из-за неё я вижу \nсмерти близких мне \nлюдей[w:1] ка[w:2]ждый \nраз,[w:1] когда открываю \nглаза.", "[func:NoMercy1][func:DUB,imp/33/4][w:4]Но[w:3] с другой.[w:3].[w:3].[w:3] [func:head]Я как \nникогда ближе к \nтому, чтобы изгнать \nтебя.", "[func:NoMercy1][func:DUB,imp/33/5][w:7][speed:0.75]Твоя сила[waitall:4][w:3]...[waitall:1][w:3] [func:Bad][speed:1.00]Ты \nзнаешь о других[speed:1.10] \nтаймлайнах?", "[func:head][func:DUB,imp/33/6][w:4][speed:0.90]Ты как никто другой \nзнаешь, что я хочу \nсделать."}
			neng={"[func:head4]I dunno how to call \nit.[w:6] Fate [w:3]or karma [w:3]-\n[func:sad]whatever.", "What's matter [w:3]- [func:head4]I am \nthanking and hating \nthis power in the \nsame time.", "[func:sad]With it I see my \nrelatives dying every \ntime I open my eyes.", "[func:NoMercy1]But on opposite \nside?[w:6] [func:head]I never \nwas so close to \ndefeating you.", "[func:NoMercy1]Your power[waitall:4][w:3]...[waitall:1][w:3] [func:Bad]You \ndo know about other \ntimelines,[w:3] don't you?", "[func:head]You as no one else\nknow what I am \nintending to do."}
			engcom="She is trying to defeat us with our weapon.[w:6] Catch this dodging squirrel already!"
			ruscom="Она пытается одолеть нас нашим же оружием.[w:6] Поймай же эту изворотливую белку!"
			end
			wav={"imp/k_random2"}
		elseif GetGlobal("progress") == 34 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"[func:head4]Наш Король[waitall:4][w:3]...", "[func:sad]Я дала ему клятву,[w:3] \nчто остановлю \nлюбого человека,[w:3] \nкоторый станет на \nпути Стражи.", "[func:head4]Он желает твоей \nсмерти так же,[w:3] \nкак и я.", "[func:NoMercy1]Его мотивы,[w:3] а \nтеперь и его сила[waitall:4][w:3]...", "Я будто с ним на \nодной волне.[w:6] [func:head]\nМоя воля никогда \nне была так крепка."}
			rus={"[func:head4][func:DUB,imp/34/1][w:5][speed:0.75]Наш[w:4] Король[waitall:4][w:3]...", "[func:sad][func:DUB,imp/34/2][w:4]Я дала ему клятву,[w:2] \nчто остановлю \nлю[w:1]бого человека,[speed:1.10] \nкоторый станет на \nпути [w:1]Стражи.", "[func:head4][func:DUB,imp/34/3][w:4][speed:0.94]Он желает твоей \nсмерти так же, \nкак и я.", "[func:NoMercy1][func:DUB,imp/34/4][w:4][speed:0.85]Его моти[w:1]вы[waitall:3][w:2]...[waitall:1][w:2] [speed:0.95]а \nтеперь и его сила[waitall:4][w:3]...", "[func:DUB,imp/34/5][w:4]Я будто с ним на \nодной волне.[w:11] [func:head]\nМоя воля ни[w:1]ко[w:1]гда \nне была [w:1]так [w:1]крепка."}
			neng={"[func:head4]Our King[waitall:4][w:3]...", "I[func:sad] promised that \nno human will \nget through the \nGuard.", "[func:head4]He wishes you dead \nas well as I do.", "[func:NoMercy1]His motives and \nnow [w:4]- his power[waitall:4][w:3]...", "It's almost like \nhe's beside me.[w:6] \n[func:head]My will never \nwas so strong."}
			engcom="It seems like this situation[waitall:4][w:3]...[waitall:1][w:3] cut her to the bone.[w:6]\nHe-he."
			ruscom="Похоже,[w:3] эта ситуация[waitall:4][w:3]...[waitall:1][w:3] проняла её до костей.[w:6]\nХе-хе."
			end
			wav={"imp/2lasers"}
		elseif GetGlobal("progress") == 35 then	
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"[func:Final_7]Как иронично,[w:3] что я \nстолько раз видела \nего смерть[waitall:4][w:3]...", "[func:Irony]В тех,[w:3] других \nтаймлайнах[waitall:4][w:3]...", "[func:head4]А в этом[waitall:4][w:3]...[waitall:1][w:3] [func:sad]При \nнашей первой \nвстрече он был \nготов убить меня.", "[func:NoMercy1]И какова ирония[waitall:4][w:3]...[waitall:1][w:3] \n[func:Think]Сейчас я служу ему.[w:6] \n[func:NoMercy1]Зная,[w:3] что скоро \nпробьет его час.", "[func:head4][waitall:4][w:3]...", "Может[waitall:4][w:3]...[waitall:1][w:3] Было бы \nлучше,[w:3] [func:sad]убей он меня \nтогда?","[func:head][next]"}
			rus={"[func:Final_7][func:DUB,imp/35/1][w:5]Как иронично,[w:1] что я \nстолько раз видела \nего смерть[waitall:4][w:3]...", "[func:Irony][func:DUB,imp/35/2][w:5]В тех,[w:10][speed:1.15] других \nтаймлайнах[waitall:4][w:3]...", "[func:head4][func:DUB,imp/35/3][w:5]А в этом[waitall:3][w:2]...[waitall:1][w:2][speed:1.15] [func:sad]При \nнашей встрече \nон был готов \nубить [w:1]меня.", "[func:NoMercy1][func:DUB,imp/35/4][w:5][speed:0.85]И какова ирония[waitall:3][w:3]...[waitall:1][w:2] \n[func:Think]Сейчас я служу ему.[w:8] \n[func:NoMercy1]Зная,[w:3] что скоро \nпробьет его [w:1]час.", "[func:head4][waitall:4][w:3]...", "[func:DUB,imp/35/5][w:7]Мо[w:2]жет[waitall:3][w:2]...[waitall:1][w:2] Было бы \nлу[w:2]чше,[w:5] [func:sad]убей [w:1]он меня \nтогда?","[func:head][next]"}
			neng={"[func:Final_7]How ironical,[w:3] I saw \nhis death so many \ntimes[waitall:4][w:3]...", "[func:Irony]In those,[w:3] other \ntimelines.", "[func:head4]But in mine[waitall:4][w:3]...[waitall:1][w:3] [func:sad]He \nintended to kill me \nat the first sight.", "[func:NoMercy1]And how ironical,[w:3] [func:Think]now \nI am at his service.[w:6] \n[func:NoMercy1]And I know that his \ntime is running out.", "[func:head4][waitall:4][w:3]...", "Maybe[waitall:4][w:3]...[waitall:1][w:3] Would it be \nbetter [func:sad]if he killed \nme that day[waitall:4][w:3]?..","[func:head][next]"}
			engcom="Chara smiles gloomy."
			ruscom="Чара печально ухмыляется."
			end
			wav={"imp/sans3"}
		elseif GetGlobal("progress") == 36 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"[func:head]А ведь он[waitall:4][w:3]...[waitall:1][w:3] [func:NoMercy1]он \nведь даже не \nподозревает.", "[func:Think]Сидит в тронном \nзале, ожидает \nчеловека[waitall:4][w:3]...", "С которым у него \nдолжен пройти бой \nза 'судьбу' монстров.", "[func:NoMercy1]Знал бы он, что на \nсамом деле \nпроисходит[waitall:4][w:3]...", "[func:Final_7]Это был бы слишком \nсильный удар для \nнего[waitall:4][w:3]...","[func:head][next]"}
			rus={"[func:head][func:DUB,imp/36/1][w:5]А ведь он[waitall:4][w:3]...[waitall:1][w:3] [func:NoMercy1]он \nведь даже[speed:1.15] не \nподозревает.", "[func:Think][func:DUB,imp/36/2][w:5][speed:0.90]Сидит в тронном \nзале,[w:5] ожидает[speed:0.85] \nчеловека[waitall:4][w:3]...", "[func:DUB,imp/36/3][w:5]С которым у него \nдолжен пройти бой \nза[w:3][speed:0.60] 'судьбу'[speed:0.70][w:6] монстров.", "[func:NoMercy1][func:DUB,imp/36/4][w:5]Знал бы он,[w:1] что на \nсамом деле \nпроисходит[waitall:4][w:3]...", "[func:Final_7][func:DUB,imp/36/5][w:5]Это был бы[speed:0.85] слишком \nсильный удар для \nнего[waitall:4][w:3]...","[func:head][next]"}
			neng={"[func:head]And he[waitall:4][w:3]...[waitall:1][w:3] [func:NoMercy1]He still \nhas no clue what's \ngoing on.", "[func:Think]He sits in the throne \nroom, waiting for a \nhuman[waitall:4][w:3]...", "He waits for the \nbattle that will \ndecide monsters \n'fate'.", "[func:NoMercy1]How pity he doesn't \nknow that there's \nnothing to decide[waitall:4][w:3]...", "[func:Final_7]It would be too \ntough hit for him[waitall:4][w:3]...","[func:head][next]"}
			engcom="Would be better for her if she was thinking how tough will be our hit[waitall:4][w:3]...[waitall:1][w:3]"
			ruscom="Лучше бы подумала о том,[w:3] каким сильным будет наш удар по ней[waitall:4][w:3]...[waitall:1][w:3]"
			end
			wav={"imp/sansnew"}
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
				currentdialogue = {"[noskip]"}
			end
		elseif GetGlobal("progress") == 37 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"[func:head]Я[waitall:4][w:3]...[waitall:1][w:3] [func:head4]Я не буду врать.", "Я устаю.[w:6] [func:sad]Ты и сам \nэто понимаешь.", "[func:head4]И эти голоса в \nголове[waitall:4][w:3]...[waitall:1][w:3] они \nне утихают.[w:6] Они всё \nгромче и громче.", "[func:sad]Что,[w:3] если даже этой \nсилы будет мало?[w:6] \nЧто,[w:3] если я вновь \nпроиграю?", "[func:NoMercy1]Чёрт,[w:3] если бы я \nзнала.", "Поживем [w:4]- увидим,[w:3][func:head] \nверно?[w:6] Хех[waitall:4][w:3]..."}
			rus={"[func:head][func:DUB,imp/37/1][w:6]Я[waitall:4][w:3]...[waitall:1][w:4] [func:head4][speed:0.94]Я не буду врать.", "[func:DUB,imp/37/2][w:5][speed:0.80]Я[w:1] устаю.[w:15] [func:sad][speed:0.85]Ты и сам \nэто понимаешь.", "[func:head4][func:DUB,imp/37/3][w:5]И эти голоса в \nголове[waitall:3][w:2]...[waitall:1][w:2] Они \nне утихают.[w:9] Они всё \nгромче и громче.", "[func:sad][func:DUB,imp/37/4][w:5]Что,[w:3] если[w:1] даже[w:1] этой [w:2]\nсилы[w:1] будет мало?[w:9] \nЧто,[w:3] если[w:1] я [w:1]вновь[w:2] \nпроиграю?", "[func:NoMercy1][func:DUB,imp/37/5][w:5][speed:0.80]Чёрт,[w:10] если бы я \nзнала[waitall:4][w:3]...", "[func:DUB,imp/37/6][w:5][speed:1.10]Поживем - увидим,[func:head] \nверно?[w:6][speed:0.82] Хе-хе[waitall:4][w:3]..."}
			neng={"[func:head]I[waitall:4][w:3]...[waitall:1][w:3] [func:head4]I'm not gonna \nlie.", "I am growing tired.[w:6] \n[func:sad]And you know it well.", "[func:head4]And those voices in \nmy head[waitall:4][w:3]...[waitall:1][w:3] They \ndidn't calm down.[w:6] \nOn opposite [w:4]- only \ngrew louder.", "[func:sad]What if even this \npower will be not \nenough?[w:6] What if I \nlose again?", "[func:NoMercy1]Hell,[w:3] if I know.", "We'll see in the \nend,[w:3][func:head] right?[w:6] \nHeh[waitall:4][w:3]..."}
			engcom="We highly likely will see it.[w:6]\nI wouldn`t be so sure about her tho."
			ruscom="Мы,[w:3] может,[w:3] и поживём.[w:6]\nОна -[w:3] вряд ли."
			end
			wav={"imp/kniferain"}
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
				currentdialogue = {"[noskip]"}
			end
		elseif GetGlobal("progress") == 38 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"Хотя,[w:3] [func:NoMercy1]что тебе \nзнать о лишениях?", "[func:head]Ты ведь так жестоко \nрасправился с \nпитомцем Маффет[waitall:4][w:3]...", "Я лично ухаживала \nза ним.[w:6] Он был \nпочти что моим \nпитомцем.", "[func:sad]Если бы Маффет,[w:3] \nконечно,[w:3] знала \nслово [waitall:2][w:3]<делиться>[waitall:4][w:3]...", "[func:NoMercy1]А затем пришел ты.[w:6] [func:head]\nЖестоко \nрасправился с ними \nобоими[waitall:4][w:3]...", "[func:head4]Не знаю,[w:3] почему[waitall:4][w:3]...[waitall:1][w:3] \nНо во мне даже нет \nзлости,[w:3] когда я \nдумаю о Паукексе.", "Только [waitall:2][w:3]звенящая \nпустота[waitall:1][w:3] в груди.", "Интересно.[w:6] [func:sad]\nК чему бы это?","[func:head][next]"}
			rus={"[func:DUB,imp/38/1][w:4]Хо[w:2]тя,[w:9] [func:NoMercy1][speed:0.93]что тебе \nзнать[speed:0.87] о лишениях?", "[func:head][func:DUB,imp/38/2][w:4][speed:0.88]Ты [w:1]ведь[w:1] так жестоко[speed:0.95] \nрасправился с \nпитомцем Маффет[waitall:4][w:3]...", "[func:DUB,imp/38/3][w:4]Я[w:1] ли[w:1]чно ухаживала \nза ним.[w:6] Он был[w:1] \nпочти[w:1] что мои[w:2]м [w:1]\nпитомцем.", "[func:sad][func:DUB,imp/38/4][w:4][speed:0.90]Если бы Маффет, \nконечно,[w:2] знала \nслово[w:1] [speed:0.88]'делиться'[waitall:4][w:3]...", "[func:NoMercy1][func:DUB,imp/38/5][w:4][speed:0.88]А затем пришёл ты.[w:6] [func:head]\nЖестоко[speed:0.99] \nрасправился с ними \nобо[w:2]ими[waitall:4][w:3]...", "[func:head4][func:DUB,imp/38/6][w:5][speed:0.88]Не знаю, почему,[w:5][speed:1.10] \nно во мне даже нет \nзлости,[w:1] когда я[w:1] \nдумаю [w:1]о[w:3][speed:0.90] Пау[w:1]кексе.", "[func:DUB,imp/38/7][w:5][speed:0.75]То[w:1]лько[waitall:4][w:3]...[waitall:1][w:4][speed:0.63] Звенящая \nпустота[waitall:3][w:2]...[waitall:1][w:1][speed:0.85] в груди.", "[func:DUB,imp/38/8][w:5][speed:0.93]Интересно,[w:1] [func:sad]\nк чему бы это?","[func:head][next]"}
			neng={"Though [w:3][func:NoMercy1]what do you \neven know of losing \nsomeone?", "[func:head]You so cruelly \ndestroyed Muffet's \npet[waitall:4][w:3]...", "I personally cared \nfor him.[w:6] It was \nalmost like my own \npet.", "[func:sad]It would be,[w:3] if \nMuffet even knew \nthe word [waitall:2][w:3]<share>[waitall:4][w:3]...", "[func:NoMercy1]But you have come.[w:6] [func:head]\nAnd made them both \ngone[waitall:4][w:3]...", "[func:head4]I don't know why[waitall:4][w:3]...[waitall:1][w:3] \nBut I'm not mad \nthinking about \nSpidonut.", "Only [waitall:2][w:3]silent void[waitall:1][w:3] \ninside the chest.", "Interesting.[w:6] [func:sad]\nWhy?","[func:head][next]"}
			engcom="What about a spiderdance?[w:6]\nHow relieving that she forgot that stupid pun."
			ruscom="Как насчёт танца с пауками?[w:6]\nКак хорошо,[w:3] что она избавилась от этой тупой шутки."
			end
			wav={"imp/muffet"}
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
				currentdialogue = {"[noskip]"}
			end
		elseif GetGlobal("progress") == 39 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"[func:head4]Как сложно просто \nперестать \nзаботиться.", "[func:sad]Перестать \nволноваться \nо пустяках и \nотпустить любую \nмотивацию.", "[func:head4]Бугги смог,[w:3] потому \nчто он бездушный \nцветок[waitall:4][w:3]...", "[func:thoughts]А у меня есть \nстремления.[w:6] Рвения.[w:6] \nНадежды и мечты.", "[func:NoMercy1]Я не могу[waitall:4][w:3]...[waitall:1][w:3] [func:head]Не могу \nпозволить тебе их \nразрушить."}
			rus={"[func:head4][func:DUB,imp/39/1!!!][w:4][speed:0.95]Как сложно[w:4] просто[speed:1.15] \nперестать[speed:1.00] \nзаботиться[waitall:4][w:3]...", "[func:sad][func:DUB,imp/39/2][w:4][speed:1.09]Перестать \nволноваться \nо пустяках и \nотпустить[w:2][speed:0.90] любую[w:2] \nмотивацию.", "[func:head4][func:DUB,imp/39/3][w:3][speed:0.85]Бугги смог,[w:8][speed:0.94] потому \nчто он[speed:1.03] бездушный \nцветок[waitall:4][w:3]...", "[func:thoughts][func:DUB,imp/39/4][w:4][speed:0.90]А у меня есть \nстремления.[w:12] Рве[w:2]ния.[w:12] \nНаде[w:2]жды[w:2] и мечты.", "[func:NoMercy1][func:DUB,imp/39/5][w:4]Я не могу[waitall:4][w:3]...[waitall:1][w:3] [func:head]Не могу \nпозволить тебе их \nразрушить."}
			neng={"[func:head4]It's uneasy to just \nlet everything go.", "[func:sad]To stop bother \nabout details and \nforget any \nmotivation.", "[func:head4]Boogie could do it,[w:3] \nbecause he's \nsoulless flower[waitall:4][w:3]...", "[func:thoughts]But I have my own \nmotto.[w:6] Goals.[w:6] \nHopes and dreams.", "[func:NoMercy1]I can't let you[waitall:4][w:3]...[waitall:1][w:3] \n[func:head]Can't let you break \nthem."}
			engcom="Hopes and dreams[waitall:4][w:3]...[waitall:1][w:3] Such a nuisance.[w:6]\nAll that matters [w:3]-[w:3] GLAMOUR."
			ruscom="Надежды и мечты[waitall:4][w:3]...[waitall:1][w:3] Что за вздор.[w:6]\nВсё, что имеет значение [w:3]-[w:3] ГЛАМУР."
			end
			wav={"imp/field"}
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
				currentdialogue = {"[noskip]"}
			end
		elseif GetGlobal("progress") == 40 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			Encounter.SetVar("evadelevel",4)
			nrus={"[func:NoMercy1]Какое тебе дело до \nнас,[w:3] не так ли?", "[func:head4]Бугги рассказывал \nмне,[w:3] что есть сила,[w:3] \nкоторая \nпревосходит \nРешимость.", "[func:sad]Я ему не поверила.[w:6] \n[func:NoMercy1]Но,[w:3] кажется,[w:3] теперь \nэто очевидно.", "[func:head]Наша с тобой \n[waitall:2][w:3]ЛЮБОВЬ.", "[func:Think]Неважно,[w:3] сколько у \nнас Решимости,[w:3][func:head] лишь \n[waitall:2][w:3]ЛЮБОВЬ[waitall:1] -[w:3] мерило \nнаших сил."}
			rus={"[func:NoMercy1][func:DUB,imp/40/1][w:5]Какое тебе дело до \nнас, [speed:1.10]не так ли?", "[func:head4][func:DUB,imp/40/2][w:4]Бугги рассказывал \nмне, что есть сила, \nкоторая \nпревосходит \nРешимость.", "[func:sad][func:DUB,imp/40/3][w:4]Я ему не поверила.[w:8] \n[func:NoMercy1]Но,[w:2] кажется,[w:1] теперь \nэто очевидно.", "[func:head][func:DUB,imp/40/4][w:4][speed:0.72]Наша с тобой \n[w:7][speed:0.50]ЛЮБОВЬ.", "[func:Think][func:DUB,imp/40/5][w:4]Неважно,[w:1] сколько у \nнас Решимости,[w:8][func:head] лишь[w:5] \n[waitall:2][w:3]ЛЮБОВЬ[waitall:1] -[w:5] мерило[w:1] \nнаших[w:1] сил."}
			neng={"[func:NoMercy1]It's not your \nbusiness anyway,[w:3] \nis it?", "[func:head4]Boogie told me \nthere's a power much \ngreater than \nDetermination.", "[func:sad]I didn't believe him \nback then.[w:6] [func:NoMercy1]But now \nthat's obvious.", "[func:head]Our [waitall:2][w:3]LOVE.", "[func:Think]Doesn't matter how \nmuch DT we have,[w:3] \nif we didn't gain \nany [waitall:2][w:3]LOVE[waitall:1][w:3],[w:3][func:head] right?"}
			engcom="Chara seems chaotic neutral."
			ruscom="Чара выглядит хаотично нейтральной."
			end
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
				currentdialogue = {"[noskip]"}
			end
			wav={"imp/buggy1"}
		elseif GetGlobal("progress") == 41 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"[func:head4]Подобно этим \nсеменам \nразлетелись [func:sad]\nнаши жизни[waitall:4][w:3]...", "[func:head4]Этот танец \nнапоминает мне \nо прошлом,[w:3] что \nбеспощадно \nулизнуло[waitall:4][w:3]...", "У меня больше нет \nни дома,[w:3] \nни семьи,[w:3] \nни цели в жизни[waitall:4][w:3]...", "[func:deadly]И во всём[waitall:4][w:3]...[waitall:1][w:3] [func:closedyesend]\nВиноват[waitall:4][w:3]...[waitall:1][w:3] [func:head]\nТы[waitall:4][w:3]..."}
			rus={"[func:head4][func:DUB,imp/41/1][w:5]Подобно этим \nсеменам \nразлетались [func:sad]\nнаши[w:1] жи[w:1]зни[waitall:4][w:3]...", "[func:head4][func:DUB,imp/41/2][w:5]Этот танец[w:1] \nнапоминает мне[w:1] \nо прошлом,[w:5] что \nбеспощадно \nулизнуло[waitall:4][w:3]...", "[func:LostKidFace,sobbing_close,-][func:DUB,imp/41/3][w:5]У меня больше нет \nни[w:2] до[w:2]ма,[w:10][func:LostKidFace,sobbing,+] \nни[w:2] семьи,[w:12][func:LostKidFace,sobbing_upsmile,+] \nни цели [w:1]в [w:1]жизни[waitall:4][w:3]...", "[func:NoMercy1][func:DUB,imp/41/4][w:5]И во всём[waitall:4][w:3]...[waitall:1][w:3] [func:closedyesend]\nВиноват[waitall:4][w:3]...[waitall:1][w:5] [func:head]\nТы[waitall:4][w:3]..."} 
			neng={"[func:head4]Our lives flew away \nlike [func:sad]those petals[waitall:4][w:3]...", "[func:head4]This dance reminds \nme about my lost \npast[waitall:4][w:3]...", "I have no home,[w:3] \nno family,[w:3] \nno life goals[waitall:4][w:3]...", "[func:deadly]And this is[waitall:4][w:3]...[waitall:1][w:3] \n[func:closedyesend]all your[waitall:4][w:3]...[waitall:1][w:3] \n[func:head]Fault[waitall:4][w:3]..."}
			engcom="It`s rude to deny your blame."
			ruscom="Невежливо спихивать свои ошибки на других."
			end
			wav={"imp/buggy2"}
		elseif GetGlobal("progress") == 42 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"[func:head4]Виноват[waitall:4][w:3]...[waitall:1][w:3] [func:NoMercy1]\nДа[waitall:4][w:3]...", "[func:head]Да,[w:3] чёрт возьми!", "А-ха-ха-ха!!", "[func:Think]Я такая дура и \n[func:head]вправду!!", "[func:NoMercy1]Ведь ты[waitall:4][w:3]...[waitall:1][w:3] [func:head]Это ты \nразрушил наш мир[waitall:4][w:3]...[waitall:1][w:3] \n[func:Think]Нет моей вины в \nтом,[w:3] что я не \nсмогла его \nзащитить!", "[func:NoMercy1]Это ты[waitall:4][w:3]...[waitall:1][w:3] [func:head]\nТвоя вина![w:6] \nТвоя вина!!"}
			rus={"[func:head4][func:DUB,imp/42/1][w:5]Виноват[waitall:3][w:2]...[waitall:1][w:2] [func:NoMercy1]\nДа[waitall:4][w:3]...", "[func:head][func:DUB,imp/42/2][w:5]Да,[w:3] чёрт[w:2] возьми!", "[func:DUB,imp/42/3][w:5]А-ха-ха-ха-ха-ха\nха!![w:12]\nХа-ха-ха-ха-ха-ха\nха!!", "[func:Think][func:DUB,imp/42/4][w:5][speed:0.80]Я такая дура и \n[func:head]вправду!!", "[func:NoMercy1][func:DUB,imp/42/5][w:5]Ведь ты[waitall:3][w:3]...[waitall:1][w:2] [func:head]Это ты \nразрушил наш мир![w:8] \n[func:Think]Нет моей вины в \nтом,[speed:1.10] что я не \nсмогла его \nзащитить!", "[func:NoMercy1][func:DUB,imp/42/6][w:5]Это ты[waitall:4][w:3]...[waitall:1][w:3] [func:head][speed:0.85]\nТво[w:2]я[w:2] ви[w:2]на!![w:6]"}
			neng={"[func:head4]Fault[waitall:4][w:3]...[waitall:1][w:3] [func:NoMercy1]\nYa[waitall:4][w:3]...", "[func:head]Yes,[w:3] god damn it!", "A-ha-ha-ha-ha!!", "[func:Think]I'm such a fool,[w:3][func:head] \nreally!!", "[func:NoMercy1]It's you[waitall:4][w:3]...[waitall:1][w:3] [func:head]You have\ndestroyed our world[waitall:4][w:3]...[waitall:1][w:3] \n[func:Think]I'm not the one to \nbe blamed for not \nprotecting it!", "[func:NoMercy1]It's you[waitall:4][w:3]...[waitall:1][w:3] [func:head]\nYour fault![w:6] \nYour fault!!"}
			engcom="Ok,[w:3] now she is chaotic evil."
			ruscom="Окей,[w:3] теперь она хаотично зла."
			end
			wav={"imp/k_3"}
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
				Encounter.SetVar("evadelevel",5)
			end
		elseif GetGlobal("progress") == 43 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
				Encounter.SetVar("evadelevel",6)
			end
			dodge=false
			block=true
			if GetGlobal("pray")<4 then
				SetGlobal("pray",4)
			end
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"[func:start1][func:head4]Хватит![w:6] [func:trigeredclosed]С меня \nдовольно этих \nдетских игр!!", "Давай,[w:3] покажи,[w:3] \nна что ты способен!", "Я не дам тебе \nпройти дальше![w:6] \nНи [w:3]за [w:3]что!!", "Ты будешь вечно \nумирать и \nвозвращаться,[w:3] \nумирать и \nвозвращаться!", "[func:trigeredclosed]Это мой последний \nоплот!", "[func:Bloodshed][func:trigered]Да начнётся \nкровопролитие!!","[func:MoveToCenter][next]"}
			rus={"[func:start1][func:head4][w:3][func:DUB,imp1.5/1/1][speed:0.93][w:2]Хва[w:2]тит!![w:6] [func:trigeredclosed]С меня[speed:1.05] \nдовольно этих \nдетских и[w:2]гр!", "[func:DUB,imp1.5/1/2][w:5]Давай,[w:3][speed:1.19][func:trigered][func:EpicKnife] покажи, \nна что ты способен!", "[func:DUB,imp1.5/1/3][w:5]Я не дам тебе \nпройти дальше![w:6] \nНи [w:2]за[w:2] что!!", "[func:DUB,imp1.5/1/4][w:5]Ты будешь вечно \nумирать и \nвозвращаться,[w:3] \nумирать и \nвозвращаться!", "[func:trigeredclosed][func:DUB,imp1.5/1/5][w:5]Это мой[w:1] последний \nоплот!", "[func:Bloodshed][func:trigered][func:DUB,imp1.5/1/6][w:5][speed:0.89]Да начнётся \nкровопроли[w:1]тие!!","[func:MoveToCenter][next]"}
			neng={"[func:start1][func:head4]Enough![w:6] [func:trigeredclosed]I'm done \nwith all those \nchild play!!", "Common,[w:3][func:trigered][func:EpicKnife] show me \nwhat you have got!", "I will not let \nyou pass![w:6] \nNever!!", "You will endlessly \ndie and return,[w:3] \ndie and return!", "[func:trigeredclosed]This is my last \nstand!", "[func:Bloodshed][func:trigered]Let the bloodshed \nbegin!!","[func:MoveToCenter][next]"}
			engcom="So she wants to play hard[waitall:4][w:3]...[waitall:1][w:3] \nOkay,[w:3] daddy."
			ruscom="Значит,[w:3] она хочет сыграть по-взрослому[waitall:4][w:3]...[waitall:1][w:3] \nХорошо,[w:3] папик."
			end
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
				Encounter.SetVar("phase",1.5)
			end
			--if Encounter.GetVar("SavedProg") > GetGlobal("progress") then
				wav={"imp1.5/easy"}
			--else
			--	wav={"nothing"}
			--end
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
				Encounter.SetVar("globalstage","3")
				Encounter.Call("WriteSavio")
			end
			Encounter.SetVar("ghostsnow",{"Asriel_Sprite"})
		elseif GetGlobal("progress") == 44 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"Ты даже \nпредставить себе \nне можешь,[w:3] каково \nэто!", "Ты просто ведёшь \nсебя как кусок \nдерьма!", "[func:trigeredrem]Каждый раз ты \nвтаптываешь меня \nи мой мир в грязь!", "[func:trigered]Да ты сам кусок \nжалкой и мерзкой \nгрязи!!"}
			rus={"[func:DUB,imp1.5/2/1][w:5]Ты даже \nпредставить себе \nне можешь, каково[w:1] \nэто!", "[func:DUB,imp1.5/2/2][w:5]Ты просто ведёшь \nсебя как[w:1] кусок \nдерьма!", "[func:trigeredrem][func:DUB,imp1.5/2/3][w:5][speed:0.80]Каждый раз[speed:0.89] ты \nвтаптываешь меня \nи мой мир в грязь!", "[func:trigered][func:DUB,imp1.5/2/4][w:5][speed:0.86]Да ты сам[w:1] [speed:0.93]кусок [w:1]\nжалкой [w:1]и мерзкой \nгрязи!"}
			neng={"You can't even \nimagine how it \nfeels!", "You're acting like a \ndouche bag!", "[func:trigeredrem]Every time you`re \nbumping me into \nthe mud!", "[func:trigered]But you're the pity \nand ugly dirt as well!!"}
			engcom="She's not kidding now![w:6] Don't be distracted,[w:3] exhaust her!"
			ruscom="Она не шутит![w:6] Не отвлекайся,[w:3] надо её измотать!"
			end
			wav={"imp1.5/BroFight"}
			Encounter.SetVar("ghostsnow",{"Toriel_Sprite","Asgore_Sprite"})
		elseif GetGlobal("progress") == 45 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"Я доверяла не тому \nчеловеку!", "[func:trigeredrem]Может,[w:3] мне вообще \nникому не стоило \nдоверять!", "Все одинаковые![w:6] [func:trigeredclosed]\nЛживые и наивные \nидиоты!", "Никого не волнует,[w:3] \nчто я чувствую! [w:6][func:trigered]\nС меня хватит!!"}
			rus={"[func:DUB,imp1.5/3/1][w:5][speed:0.92]Я доверяла не тому \nчеловеку!", "[func:trigeredrem][func:DUB,imp1.5/3/2][w:5]Может,[w:6] мне[speed:1.09] вообще \nникому не стоило \nдоверять?", "[func:DUB,imp1.5/3/3][w:5][speed:0.85]Все одинаковые.[w:6] [func:trigeredclosed]\nЛживые[w:1] и наивные \nидио[w:1]ты!", "[func:DUB,imp1.5/3/4][w:5][speed:1.10]Никого не волнует, \nчто я чувствую. [w:8][func:trigered][speed:0.90]\nС меня хва[w:1]тит!!"}
			neng={"I trusted the wrong \nperson!", "[func:trigeredrem]Maybe I shouldn't \ntrust anyone!", "They all are the \nsame![w:6] [func:trigeredclosed]\nLying and naive \nidiots!", "No one bothers how \nI feel![w:6] [func:trigered]\nI am done!!"}
			engcom="Burned skin chilling to the bone."
			ruscom="Ожоги прожигают твои кости."
			end
			wav={"imp1.5/firehell"}
			Encounter.SetVar("ghostsnow",{"Alphys_Sprite","Muffet_Sprite","Undyne_Sprite"})
		elseif GetGlobal("progress") == 46 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"[func:trigeredclosed]Мне не стоило ни к \nкому привязываться!", "Завести питомца?![w:9] [func:trigeredrem]\nЗачем?!", "[func:trigeredclosed]Дружить с \nмонстрами?![w:9] \nКак же я была глупа!", "[func:trigered]Все,[w:3] все вы \nодинаковые!", "Никто не понимает \nменя![w:9] \nИ не пытается!"}
			rus={"[func:trigeredclosed][func:DUB,imp1.5/4/1][w:5]Мне не стоило [speed:1.10]ни к \nкому привязываться!", "[func:DUB,imp1.5/4/2][w:5][speed:0.90]Завести питомца?[w:8] [func:trigeredrem]\nЗа[w:2]чем?!", "[func:trigeredclosed][func:DUB,imp1.5/4/3][w:5]Дружить с \nмонстрами?![w:9][speed:0.88] \nКак же я была глупа!", "[func:trigered][func:DUB,imp1.5/4/4][w:5]Все,[w:12] все[w:2] вы[w:1] \nодина[w:2]ковые!", "[func:DUB,imp1.5/4/5][w:5]Ни[w:2]кто[w:1] не понимает \nменя![w:9] \nИ [w:1]не[w:1] пыта[w:2]ет[w:1]ся!"}
			neng={"[func:trigeredclosed]I shouldn't get \nattached to \nanyone!", "Having a pet?![w:9] [func:trigeredrem]\nFor what?!", "[func:trigeredclosed]Befriending with \nmonsters?![w:9] \nI was so damn \nfoolish!", "[func:trigered]You all are the same!", "No one understands \nme,[w:3] you didn't even \ntry to!"}
			engcom="I feel the aroma of rotten blood[waitall:4][w:3]...[waitall:1][w:3]\nWe're at our limit,[w:3] actor."
			ruscom="Я чувствую запах гниющей крови[waitall:4][w:3]...[waitall:1][w:3]\nМы на пределе,[w:3] актер."
			end
			wav={"imp1.5/spidercombo"}
			Encounter.SetVar("ghostsnow",{"Paps_Sprite","Sans_Sprite","Flowey_Sprite"})
		elseif GetGlobal("progress") == 47 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"Знаешь,[w:3] как я сюда \nпопала?![w:6] \n[func:trigeredclosed]Я сбежала!", "Сбежала от пожара,[w:3] \nкоторый сама же и \nустроила!", "[func:trigered]Да,[w:3] твою мать,[w:3] \nя спалила свою \nродную деревню![w:6] \nДотла!![w:6] \nДо тлеющих трупов!!!"}
			rus={"[func:DUB,imp1.5/5/1][w:5]Знаешь, как я сюда \nпопала?![w:8][speed:0.85] \n[func:trigeredclosed]Я сбе[w:1]жа[w:1]ла!", "[func:DUB,imp1.5/5/2][w:5]Сбежала от пожара,[w:1] \nкоторый сама же и[w:1] \nустроила!", "[func:trigered][func:DUB,imp1.5/5/3][w:5][speed:0.90]Да, твою мать, \nя[speed:1.00] спалила свою \nродную деревню![w:7][speed:0.88] \nДотла!![w:6] \nДо [w:1]тлеющих трупов!!"}
			neng={"Do you wanna know \nhow I appeared \nhere?![w:6] [func:trigeredclosed]I ran away!", "I ran away from \nthe fire,[w:3] that \nI began!", "[func:trigered]Yes,[w:3] dammit,[w:3] I \nburned down my own \nvillage![w:6] \nTo the last building!![w:6] \nTo the very burned \ncorpse!!!"}
			end
			dodge=true
			block=false
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			engcom="She[waitall:4][w:3]...[waitall:1][w:3] She [waitall:2][w:3]WHAT?!"
			ruscom="Она[waitall:4][w:3]...[waitall:1][w:3] она [waitall:2][w:3]ЧТО?!"
			end
			wav={"imp/DEATH2"}
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
				Encounter.SetVar("evadelevel",2)
			end
		elseif GetGlobal("progress") == 48 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"[func:trigeredclosed]Да,[w:3] ты правильно \nрасслышал!", "[func:trigered]Я ненавидела их![w:6] \nЯ хотела им смерти!", "[func:trigeredclosed]У меня было всё,[w:3] но \nв один момент жизнь \nотобрала у меня \nэто!", "Семью,[w:3] свободу,[w:3] \nжелание жить!", "Когда весь мой мир,[w:3] \nмоя деревня \nсгорела,[w:3] \nя сбежала \nв Подземелье!", "Раньше я мечтала,[w:3] \nчто покажу миру,[w:3] \nкакие монстры \nдобрые[waitall:4][w:3]...", "[func:trigered]А они -[w:6] ничем не \nлучше людей![w:6] [func:trigeredrem]Они \nхотели меня убить,[w:3] \nпотому что я \nчеловек!", "[func:trigeredclosed]Я ни человек,[w:3] ни \nмонстр!","Я[waitall:4][w:3]...[waitall:1][w:3] \nЯ [waitall:2]Д е м о н,[waitall:1][w:3] \n[func:trigered]понимаешь?!", "Вот моя сущность!"}
			rus={"[func:trigeredclosed][func:DUB,imp1.5/6/1][w:4]Да,[w:2][speed:1.15] ты правильно \nрасслышал!", "[func:trigered][func:DUB,imp1.5/6/2][w:5][speed:0.86]Я ненавидела их![w:8][speed:0.80] \nЯ хотела им сме[w:2]рти!", "[func:trigeredclosed][func:DUB,imp1.5/6/3][w:5]У меня было всё,[w:8] но \nв один [speed:1.09]момент жизнь \nотобрала у меня \nэто!", "[func:DUB,imp1.5/6/4][w:5][speed:0.93]Семью,[w:4] свобо[w:1]ду,[w:1] \nжела[w:1]ние[w:1] жить!", "[func:DUB,imp1.5/6/5][w:5]Когда весь мой мир,[w:3] \nмоя деревня \nсгорела,[w:7][speed:0.90] \nя сбежала \nв Подземелье.", "[func:DUB,imp1.5/6/6][w:5][speed:1.09]Раньше я мечтала,[w:1][speed:1.15] \nчто покажу миру,[speed:1.09] \nкакие монстры \nдо[w:1]брые[waitall:4][w:3]...", "[func:DUB,imp1.5/6/7][w:5][func:trigered][speed:0.90]А они ничем не \nлучше людей![w:6] [func:trigeredrem]Они \nхотели меня убить,[w:1][speed:0.94] \nпотому что я \nчеловек!", "[func:trigeredclosed][func:DUB,imp1.5/6/8][w:6][speed:0.85]Я[w:1] ни человек,[w:4] ни \nмонстр!", "[func:DUB,imp1.5/6/9][w:5]Я[waitall:3][w:3]...[waitall:1][w:2][speed:0.89] \nЯ[w:2] Д е м о н,[w:2][speed:1.15] \n[func:trigered]понимаешь?!", "[func:DUB,imp1.5/6/10][w:5]Вот[w:2] моя[w:2] сущ[w:2]ность!"}
			neng={"[func:trigeredclosed]Yes,[w:3] you heard well!", "[func:trigered]I hated them![w:6] \nI wanted them to die!", "[func:trigeredclosed]I had everything I \ncould dream of,[w:3] but \nlife destroyed them \nall!", "My family,[w:3] my \nfreedom,[w:3] my life will!", "When my entire world,[w:3] \nmy dear village \nburned to the ashes,[w:3] \nI went to \nUnderground", "Not so long before \nthe Fall I thought \nmonsters would be \nnice and caring[waitall:4][w:3]...", "[func:trigered]But they were the \nsame as humans![w:6] [func:trigeredrem]\nThey wanted to kill \nme just because I am \nhuman!", "[func:trigeredclosed]But I am not the \nhuman,[w:3] neither the \nmonster!", "I am[waitall:4][w:3]...[waitall:1][w:3] \nI am the D e m o n,[w:3] [func:trigered]\nyou get it?!", "That's who I am!"}
			engcom="[waitall:4][w:3]...[waitall:1][w:3]She is exhausted."
			ruscom="[waitall:4][w:3]...[waitall:1][w:3]Она вымоталась."
			Encounter.SetVar("evadelevel",2)
			end
			block=false
			dodge=true
			wav={"imp1.5/bereadytodie"}
		elseif GetGlobal("progress") == 49 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
				Encounter.SetVar("evadelevel",2)
				Encounter.SetVar("SuddenStrike",true)
				Encounter.SetVar("CharaIsRaging",false)
			end
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"[noskip][func:trigeredclosed]И теперь[waitall:4][w:3]...", "[noskip][func:head4][func:NoEpicKnife][func:lowpitchmusic]Я не знаю,[w:3] \nзачем я живу[waitall:4][w:3]...", "[noskip]Я[waitall:4][w:3]...[waitall:1][w:3] я больше не \nхочу жить[waitall:4][w:3]...[waitall:1][w:3] \nжить [waitall:2][w:3]так[waitall:4][w:3]...", "[noskip][func:tired][waitall:2][w:5]Я просто хочу \nпокоя[waitall:4][w:3]..."}
			rus={"[noskip][func:trigeredclosed][func:DUB,imp1.5/7/1][w:6][speed:0.70]И[w:1] теперь[waitall:4][w:3]...", "[noskip][func:DUB,imp1.5/7/2][w:10]Я[w:4].[w:4].[w:4].[w:9][func:head4][func:NoEpicKnife][func:lowpitchmusic][speed:0.91] я не знаю,[w:1] \nзачем я живу[waitall:4][w:3]...", "[noskip][func:DUB,imp1.5/7/3][w:8]Я[waitall:4][w:3]...[waitall:1][w:3][speed:0.90] я больше не[w:1] \nхочу[w:2] жить[waitall:3][w:2]...[waitall:1][w:2] \nЖить [waitall:2][w:3]та[w:2]к[waitall:4][w:3]...", "[noskip][func:tired][speed:0.50][func:DUB,imp1.5/7/4][w:6]Я про[w:1]сто[w:1] хочу \nпо[w:1]ко[w:2]я[waitall:4][w:3]..."}
			neng={"[noskip][func:trigeredclosed]And now[waitall:4][w:3]...", "[noskip][func:head4][func:NoEpicKnife][func:lowpitchmusic]I don't even know \nwhy do I still live[waitall:4][w:3]...", "[noskip]I[waitall:4][w:3]...[waitall:1][w:3] I don't wanna \nlive[waitall:4][w:3]...[waitall:1][w:3] \nlive like [waitall:2][w:3]that[waitall:1][w:3] \nanymore.", "[noskip][func:tired][waitall:2][w:5]I just want peace[waitall:4][w:3]..."}
			engcom="The time has come,[w:3] actor![w:6] \nImpact her!"
			ruscom="Сейчас,[w:3] актер![w:6] Нападай!"
			end
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
				Encounter.SetVar("FightGoes",2)
			end
			wav={"nothing"}
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
				Encounter.SetVar("globalstage","4")
				Encounter.Call("WriteSavio")
				Encounter.SetVar("phase",2)
			end
			dodge=false
		elseif GetGlobal("progress") == 50 then
			nrus={"[func:thoughts]Кгха!", "[waitall:2][func:Cough1]*кашель*", "[func:SetMusic,star]Ты[waitall:4][w:3]...[waitall:1][w:3] ты что,[w:3] \nранил меня[waitall:4][w:3]?..", "[func:head4]Я[waitall:4][w:3]...\n[waitall:1][w:3]Кха[waitall:4][w:3]...[waitall:1][w:3] \nНе может быть[waitall:4][w:3]...","[func:thoughts][func:MoveToCenter][next]"}
			rus={"[func:thoughts][func:DUB,imp2/1/1][w:6][speed:2.80]Кгха!", "[func:DUB,imp2/1/2][w:5]*к[w:4]аш[w:4]е[w:7]ль*", "[func:SetMusic,star][func:DUB,imp2/1/3][w:5]Ты[waitall:3][w:2]...[waitall:1][w:2] ты что,[w:9] \nра[w:2]нил [w:1]меня[waitall:4][w:3]?..", "[func:head4][func:DUB,imp2/1/4][w:5]Я[waitall:4][w:3]...\n[waitall:1][w:3]Кха[waitall:3][w:3]...[waitall:1][w:2] \nНе может быть[waitall:4][w:3]...","[func:thoughts][func:MoveToCenter][next]"}
			neng={"[func:thoughts]Ghah!", "[waitall:2][func:Cough1]*cough*", "[func:SetMusic,star]Did you[waitall:4][w:3]...\n[waitall:1][w:3]Did you just \nwound me[waitall:4][w:3]?..", "[func:head4]But I[waitall:4][w:3]...\n[waitall:1][w:3]Gha[waitall:4][w:3]...\n[waitall:1][w:3]But it can't be[waitall:4][w:3]...","[func:thoughts][func:MoveToCenter][next]"}
			engcom="She is wounded!"
			ruscom="Она ранена!"
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
				Encounter.SetVar("evadelevel",6)
			end
		elseif GetGlobal("progress") == 51 then
			nrus={"Я[waitall:4][w:3]...[waitall:1][w:3] [func:head4]Я \nотвлеклась[waitall:4][w:3]?..", "[func:Final_7]И получила по \nзаслугам,[w:3] \nконечно[waitall:4][w:3]...", "[waitall:4][w:3]...", "[noskip][func:NoMercy1][func:SetMusic,none]Но даже если так[waitall:4][w:3]...[waitall:1][w:3]\n[func:head][func:Music2]Наш вопрос ещё не \nзакрыт."}
			rus={"[func:DUB,imp2/2/1][w:5]Я[waitall:4][w:3]...[waitall:1][w:3] [func:head4]\nОтвлеклась[waitall:4]?..", "[func:Final_7][func:DUB,imp2/2/2][w:5][speed:1.15]И получила по \nзаслугам,[w:5] \nконечно[waitall:4][w:3]...", "[waitall:4][w:3]...", "[noskip][func:NoMercy1][func:SetMusic,none][func:DUB,imp2/2/3][w:5]Но[w:1] даже[w:1] если так[waitall:3][w:3]...[waitall:1][w:2][speed:0.98]\n[func:head][func:Music2]Наш вопрос ещё не \nзакрыт."}
			neng={"Did I[waitall:4][w:3]...[waitall:1][w:3] [func:head4]\nDid I slip[waitall:4][w:3]?..", "[func:Final_7]And got punished \nfor that,[w:3] of \ncourse[waitall:4][w:3]...", "[waitall:4][w:3]...", "[noskip][func:NoMercy1][func:SetMusic,none]But even so[waitall:4][w:3]...[waitall:1][w:3] \n[func:head][func:Music2]We still have \nunanswered \nquestions."}
			engcom="What is she talking about?[w:6]\nI have all answers."
			ruscom="О чём она говорит?[w:6]\nМне всё предельно ясно."
			wav={"imp2/netkonzaidejam"}
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
				Encounter.SetVar("FightGoes",true)
			end
		elseif GetGlobal("progress") == 52 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"[func:NoMercy1]Да,[w:3] ты,[w:3] наверное,[w:3] \nне понимаешь,[w:3] но[waitall:4][w:3]...", "[func:Think]Разве ты не хочешь \nопять уничтожить \nмир?", "[func:NoMercy1]Да,[w:3] ведь это твоя \nпервоначальная \nцель[waitall:4][w:3]...", "[func:head]Твоя [waitall:2][w:3]<миссия>[waitall:4][w:3]..."}
			rus={"[func:NoMercy1][func:DUB,imp2/3/1][w:5]Да,[w:3][speed:1.15] ты, наверное, \nне понимаешь,[w:1] но[waitall:4][w:3]...", "[func:Think][func:DUB,imp2/3/2][w:5][speed:1.10]Разве ты не хочешь \nопять уничтожить \nмир?", "[func:NoMercy1][func:DUB,imp2/3/3][w:5]Да,[w:3] ведь это твоя \nпервоначальная \nцель[waitall:4][w:3]...", "[func:head][func:DUB,imp2/3/4][w:5][speed:0.75]Твоя [speed:0.45][w:3]'[w:6]миссия'[w:3][waitall:4][w:4]..."}
			neng={"[func:NoMercy1]Yes,[w:3] probably,[w:3] \nyou don't get it,[w:3] \nbut[waitall:4][w:3]...", "[func:Think]Aren't you going \nto destroy world \nonce again?", "[func:NoMercy1]Yes,[w:3] cuz' that's \nyour utter goal[waitall:4][w:3]...", "[func:head]Your [waitall:2][w:3]<quest>[waitall:4][w:3]..."}
			engcom="Ah yes[waitall:4][w:3]...[waitall:1][w:3] Almost forgot."
			ruscom="Ах да[waitall:4][w:3]...[waitall:1][w:3] Совсем запамятовал."
			end
			wav={"imp2/k_1"} 
		elseif GetGlobal("progress") == 53 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"[func:Bad]Но не думай,[w:3] что \nя сдалась[waitall:4][w:3]...[waitall:1][w:3] \n[func:Final_7]Я истекаю кровью и,[w:3] \nвероятно,[w:3] долго не \nпроживу,[w:3] но[waitall:4][w:3]...", "[noskip][func:ToAngry][waitall:4][w:3]...[w:600][next] " , "[noskip][func:GetsAngry]У меня всё ещё \nесть силы дать \nтебе отпор!", "[func:NoMercy1]Если я и не \nчеловек,[w:3] и не \nмонстр[waitall:4][w:3]...[waitall:1][w:3]","[func:angry]Тогда мне,[w:3] как \nДемону,[w:3] положено \nдраться до \nпоследней капли \nкрови!", "Я положу тебе \nконец,[waitall:2][w:3][func:GiveCurse]проклятая \nкровь!"}
			rus={"[func:Bad][func:DUB,imp2/4/1][w:5]Но не думай, что \nя сдалась[waitall:3][w:2]...[waitall:1][w:2] \n[func:Final_7]Я истекаю кровью и,[w:3] \nвероятно,[w:1] долго не \nпроживу,[w:1] но[waitall:4][w:3]...", "[noskip][func:ToAngry][waitall:4][w:3]...[w:600][next] " , "[noskip][func:GetsAngry][func:DUB,imp2/4/2][w:8][speed:0.90]У меня всё ещё \nесть силы дать \nтебе отпор!", "[func:NoMercy1][func:DUB,imp2/4/3][w:5]Если я и не \nчеловек,[w:3] и не \nмонстр[waitall:4][w:3]...[waitall:1][w:3]","[func:angry][func:DUB,imp2/4/4][w:5]Тогда мне,[w:1] как \nДемону,[w:1] положено \nдраться до \nпоследней[speed:1.15] капли \nкрови!", "[func:DUB,imp2/4/5][w:7]Я положу тебе \nконец,[w:1][func:GiveCurse] проклятая \nкровь!"}
			neng={"[func:Bad]But don't you think \nI already gave up[waitall:4][w:3]?..[waitall:1][w:3] \n[func:Final_7]I am bleeding and,[w:3] \nmaybe,[w:3] will not live \nfor long,[w:3] but[waitall:4][w:3]...", "[noskip][func:ToAngry][waitall:4][w:3]...[w:600][next] ", "[noskip][func:GetsAngry]I still have powers \nto resist you!", "[func:NoMercy1]If I'm neither human \nnor monster[waitall:4][w:3]...[waitall:1][w:3] ","[func:angry]Then,[w:3] as a Demon,[w:3] \nI should fight 'til \nlast drop of my \nblood!", "I will end you,[waitall:2][w:3]\n[func:GiveCurse]cursed blood!"}
			engcom="Damn![w:6] Chainsaw has broken![w:6]\nBe careful,[w:3] i sense a strong curse[waitall:4][w:3]...[waitall:1][w:3]"
			ruscom="Чёрт![w:6] Бензопила замкнулась![w:6]\nОсторожнее,[w:3] я чувствую сильную порчу[waitall:4][w:3]...[waitall:1][w:3]"
			else
				GiveCurse()
			end
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
				Encounter.SetVar("chainsaw",false)
			end
			wav={"imp2/HARD"}
		elseif GetGlobal("progress") == 54 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"[func:NoMercy1]Вместе с моей \nкровью вытекает и \nискусственная \nРешимость[waitall:4][w:3]...", "[func:head4]Очевидно,[w:3] что я \nбольше не соперник \nтебе.[w:6] [func:BADsad]Я потеряла \nвозможность.", "[func:NoMercy1]Но если я смогу \nтебя убить[waitall:4][w:3]...[waitall:1][w:3] \n[func:angry]Я смогу оттолкнуть \nтебя назад.", "Задержать тебя."}
			rus={"[func:DUB,imp2/5/1][w:5][func:NoMercy1]Вместе с моей \nкровью вытекает[speed:1.15] и \nискусственная \nРешимость[waitall:4][w:3]...", "[func:head4][func:DUB,imp2/5/2][w:5][speed:1.10]Очевидно,[w:2] что я \nбольше не соперник \nтебе.[w:7] [func:BADsad][speed:0.78]Я[w:2] потеряла \nвозможность.", "[func:NoMercy1][func:DUB,imp2/5/3][w:5]Но если я смогу \nтебя убить[waitall:4][w:3]...[waitall:1][w:2] \n[func:angry]Я смогу оттолкнуть[speed:1.1ы5] \nтебя назад.", "[func:DUB,imp2/5/4][w:5][speed:0.90]Задержать[w:1] тебя."}
			neng={"[func:NoMercy1]I'm losing artificial \nDetermination with \nmy blood[waitall:4][w:3]...", "[func:head4]It's obvious,[w:3] I am \nno longer an equal \nto you.[w:6] [func:BADsad]I lost the \nopportunity.", "[func:NoMercy1]But if I can kill you[waitall:4][w:3]...[waitall:1][w:3] \n[func:angry]I will push you back.", "I will put you on hold."}
			engcom="This won`t happen,[w:3] naive fool.[w:6]\nI have already won."
			ruscom="Этому не бывать,[w:3] наивная дура.[w:6]\nЯ уже победил."
			end
			wav={"imp2/knives4"}
		elseif GetGlobal("progress") == 55 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"[func:head4]Я просто[waitall:4][w:3]...[waitall:1][w:3] [func:BADsad]Просто \nхочу,[w:3] чтобы в мои \nпоследние минуты \nя ни о чем не \nсожалела.", "[func:head4]Ты понимаешь,[w:3] \n[func:BADthoughts]каково это?", "[func:head4]Когда твой мир \nускользает от тебя,[w:3] \nи ты остаёшься \nодна[waitall:4][w:3]...[waitall:1][w:3] [func:deadly]в темноте[waitall:4][w:3]..."}
			rus={"[func:head4][func:DUB,imp2/6/1][w:5]Я[w:2] просто[waitall:4][w:3]...[waitall:1][w:3] [func:BADsad]Просто \nхочу, чтобы в мои \nпоследующие минуты \nя ни о чем не \nсожалела.", "[func:head4][func:DUB,imp2/6/2][w:5]Ты понимаешь, \n[func:BADthoughts]каково это?", "[func:deadly][func:DUB,imp2/6/3][w:5]Когда твой мир \nускользает от тебя, \nи ты остаёшься \nодна[waitall:4][w:3]...[waitall:1][w:3]"}
			neng={"[func:head4]I just[waitall:4][w:3]...[waitall:1][w:3] [func:BADsad]I just wanted \nto have no regrets \nin last minutes \nof my life.", "[func:head4]Do you even \nunderstand [func:BADthoughts]this \nfeeling?", "[func:head4]Felling when entire \nworld is slipping and \nyou find yourself \nin the darkness[waitall:4][w:3]...[waitall:1][w:3] \n[func:deadly]all alone[waitall:4][w:3]..."}
			engcom="Stop this fuss[waitall:4][w:3]...[waitall:1][w:3]\nDeath never was an option for two of us."
			ruscom="Хватит драматизировать[waitall:4][w:3]...[waitall:1][w:3]\nСмерть [w:3]-[w:3] это роскошь для нас."
			end
			wav={"imp2/StayLow"}
		elseif GetGlobal("progress") == 56 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"[func:Peachy]Хех[waitall:4][w:3]...[waitall:1][w:3] Хах[waitall:4][w:3]...", "[func:BADsmart]Извини,[w:3] я просто \nподумала,[w:3] как \nвойдёт эта битва в \nисторию[waitall:4][w:3]...", "[func:Peachy]Дуэль,[w:3] которой не \nдолжно было быть[waitall:4][w:3]...", "Битва двух \nаномалий[waitall:4][w:3]...[waitall:1][w:3] [func:BADRemember]\nЭто так красиво \nзвучит[waitall:4][w:3]..."}
			rus={"[func:Peachy][func:DUB,imp2/7/1][w:5]Хе[w:1]хе[waitall:4][w:3]...[waitall:1][w:3] Е[w:1]хехе[waitall:4][w:3]...", "[func:BADsmart][func:DUB,imp2/7/2][w:7][speed:0.90]Извини,[w:9] я просто[speed:1.15] \nподумала,[w:1] как эта \nбитва войдёт в \nисторию[waitall:4][w:3]...", "[func:Peachy][func:DUB,imp2/7/3][w:5]Дуэль,[w:3] которой не \nдолжно было быть[waitall:4][w:3]...", "[func:DUB,imp2/7/4][w:5][speed:0.85]Битва двух \nаномалий[waitall:3][w:3]...[waitall:1][w:2] [func:BADRemember][speed:0.84]\nЭто так красиво \nзвучит[waitall:4][w:3]..."}
			neng={"[func:Peachy]Hehe[waitall:4][w:3]...[waitall:1][w:3] Ahah[waitall:4][w:3]...", "[func:BADsmart]Sorry,[w:3] I thought for \na moment,[w:3] how \nhistory has its \neyes on us[waitall:4][w:3]...", "[func:Peachy]This is duel that \nshouldn't have \nhappened[waitall:4][w:3]...", "Battle of two \nanomalies[waitall:4][w:3]...[waitall:1][w:3] [func:BADRemember]\nThis sounds so \npoetic[waitall:4][w:3]..."}
			engcom="She is losing herself[waitall:4][w:3]...[waitall:1][w:3]\nShe has no strength.[w:3] Cut out this nonsense"
			ruscom="Она бредит[waitall:4][w:3]...[waitall:1][w:3]\nСилы покидают её.[w:3] Кончай этот балаган."
			end
			wav={"imp2/BadKnifes"}
		elseif GetGlobal("progress") == 57 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			neng={"[func:head4][waitall:4][w:3]...", "I no longer hear \nvoices[waitall:4][w:3]...[waitall:1][w:3] [func:BADsad]They have \ndisappeared.", "[func:head4]I hear only the beat \nof my heart which \nit stealing leftovers \nof my oxygen[waitall:4][w:3]...", "[waitall:2][func:Cough1]*hard [w:8][func:Cough2]coughing*[w:9] [func:head4]\nDammit[waitall:4][w:3]...[waitall:1][w:3] \n[func:BADweak]I have no time left[waitall:4][w:3]..."}
			nrus={"[func:head4][waitall:4][w:3]...", "Я больше не слышу \nголоса[waitall:4][w:3]...[waitall:1][w:3] [func:BADsad]Они \nзатихли[waitall:4][w:3]...", "[func:head4]Лишь стук моего \nумирающего сердца \nпродолжает жадно \nотбирать мой \nкислород[w:4].[w:4].[w:4].[w:4]", "[waitall:2][func:Cough1]Кхах[w:4].[w:4].[w:4].[w:4] [func:Cough2][waitall:2]Кха-кха![w:9][waitall:1] [func:head4]\nЧёрт[w:4].[w:4].[w:4].[w:4] \n[func:BADweak]У меня совсем не \nосталось времени[w:4].[w:4].[w:4].[w:4]"}
			rus={"[func:head4][func:DUB,prolog2/f][waitall:4][w:3]...", "[func:DUB,imp2/8/1][w:5]Я[w:1] больше[w:1] не слышу \nголоса[waitall:4][w:3]...[waitall:1][w:3] [func:BADsad]Они[w:2] \nзатихли[waitall:4][w:3]...", "[func:head4][func:DUB,imp2/8/2][w:5][speed:1.09]Лишь[w:2] стук моего[w:1] \nумирающего[w:1] сердца[w:1] \nпродолжает жадно \nотбирать[w:1] мой \nкислород[w:4].[w:4].[w:4].[w:4]", "[func:Cough1][func:DUB,imp2/8/3][speed:1.70][w:6]Кхах.[w:4].[w:4].[w:7] [func:Cough2]Кха-[w:5]кха.[w:4].[w:4].[w:8] [speed:1.05][func:head4]\nЧёрт[w:3].[w:3].[w:3].[w:3] \n[func:BADweak]У меня совсем не \nосталось времени[w:4].[w:4].[w:4].[w:4]"}
			engcom="Good point."
			ruscom="Хорошо подмечено."
			end
			wav={"imp2/AllAround"}
		elseif GetGlobal("progress") == 58 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"[func:head4]Знаешь[w:3].[w:3].[w:3].[w:3] После \nстольких смертей[w:3].[w:3].[w:3].[w:3] \n[func:BADsad]Я больше не боюсь \nвида крови[waitall:4][w:3]...", "В детстве я \nненавидела кровь[w:3].[w:3].[w:3].[w:3] \n[func:head4]Меня тошнило при \nвиде неё...", "А сейчас[w:3].[w:3].[w:3].[w:3] [func:Final_7]Всё \nравно,[w:3] что вода на \nладонях[w:3].[w:3].[w:3].[w:3] Только \nочень горячая[waitall:4][w:3]...", "[func:BADIrony]Почти как кипяток[w:3].[w:3].[w:3].[w:3] \n[func:Final_7]Но я не чувствую \nболи[waitall:4][w:3]..."}
			rus={"[func:DUB,imp2/9/1][w:5][func:head4]Знаешь[w:3].[w:3].[w:3].[w:6] После \nстольких смертей[w:3].[w:3].[w:3].[w:3] \n[func:BADsad]Я больше не боюсь \nвида крови[waitall:4][w:3]...", "[func:DUB,imp2/9/2][w:5]В детстве я \nненавидела кровь[w:2].[w:2].[w:2].[w:2] \n[func:head4]Меня тошнило при \nвиде неё[w:3].[w:3].[w:3].[w:3]", "[func:DUB,imp2/9/3][w:5]А сейчас[w:3].[w:3].[w:3].[w:3] [func:Final_7]Всё \nравно, что вода на \nладонях[w:3].[w:3].[w:2].[w:2] Только[w:4] \nочень[w:1] горя[w:2]чая[waitall:4][w:3]...", "[func:BADIrony][func:DUB,imp2/9/4][w:5]Почти[w:1] как[w:1] кипяток[w:3].[w:3].[w:2].[w:2] \n[func:Final_7]Но я не чувствую \nболи[waitall:4][w:3]..."}
			neng={"[func:head4]Ya'know[w:3].[w:3].[w:3].[w:3] After \nso many deaths[w:3].[w:3].[w:3].[w:3] \n[func:BADsad]I no longer fear \nblood[waitall:4][w:3]...", "I hated the sight \nof blood in \nchildhood[w:3].[w:3].[w:3].[w:3] \n[func:head4]I was sick of it[waitall:4][w:3]...", "And now[w:3].[w:3].[w:3].[w:3] [func:Final_7]It's \nalmost like water on \nmy palms[w:3].[w:3].[w:3].[w:3] \nBut very hot[waitall:4][w:3]...", "[func:BADIrony]Almost boiling[w:3].[w:3].[w:3].[w:3] \n[func:Final_7]But I don't feel pain \nat all[waitall:4][w:3]..."}
			engcom="Maybe,[w:3] she is dying at last?[w:6]\nI wouldn`t be against it."
			ruscom="Может,[w:3] она наконец умирает?[w:6]\nЯ был бы не против."
			end
			wav={"imp2/CopyCat"}
		elseif GetGlobal("progress") == 59 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"[func:head4]Ты[w:3].[w:3].[w:3].[w:3] [func:BADweak]всё ещё \nживой[w:3]?[w:3].[w:3].[w:3] [func:head4]Живучий \nоднако[w:3].[w:3].[w:3].[w:3]", "Хотя не исключено,[w:3] \n[func:sad][func:NoCurse]что я уже ослабла \nдаже больше,[w:3] \nчем ты устал[w:3].[w:3].[w:3].[w:3]", "[func:head4]Тогда[w:3].[w:3].[w:3].[w:3] Мне не \nостаётся ничего,[w:3] \nкроме как[w:3].[w:3].[w:3].[w:3]", "[func:angry][func:GiveCurse]Показать свой \n[w:3][waitall:3]максимум."}
			rus={"[func:head4][func:DUB,imp2/10/1][w:6]Ты[w:4].[w:4].[w:4].[w:3] [func:BADweak]всё ещё \nживой[w:3]?[w:3].[w:3].[w:3] [func:head4]Живу[w:2]чий[w:1] \nодна[w:2]ко[w:3].[w:3].[w:3].[w:3]", "[func:DUB,imp2/10/2][w:5]Хо[w:2]тя[w:3].[w:3].[w:3].[w:2] не исключено,[w:1] \n[func:sad][func:NoCurse]что я уже ослабла \nдаже больше, \nчем ты устал[w:3].[w:3].[w:3].[w:3]", "[func:head4][func:DUB,imp2/10/3][w:5]Тогда мне не \nостаётся ничего,[w:1] \nкроме как[w:3].[w:3].[w:3].[w:3]", "[func:angry][func:GiveCurse][func:DUB,imp2/10/4][w:5]Показать свой \nмаксимум."}
			neng={"[func:head4]Are[w:3].[w:3].[w:3].[w:3] [func:BADweak]Are you \nstill alive[w:3]?[w:3].[w:3].[w:3] \n[func:head4]Whatever[w:3].[w:3].[w:3].[w:3]", "Still it could be [func:sad][func:NoCurse]that \nI have weakened \neven more than you \nhave tired[w:3].[w:3].[w:3].[w:3]", "[func:head4]If so[w:3].[w:3].[w:3].[w:3] I have no \nother choice but[w:3].[w:3].[w:3].[w:3]", "[func:angry][func:GiveCurse]But to show you \nmy [w:3][waitall:3]maximum."}
			engcom="What?[w:6] Is it this boring <special attack> again?[w:6]\nNo one fears it this day."
			ruscom="Что?[w:6] Опять её <специальная атака>?[w:6] Никого больше это не пугает,[w:3] дорогуша."
			end
			wav={"imp2/MovingKnifes"}
		elseif GetGlobal("progress") == 60 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"[func:Final_7]Я вижу по твоим \nглазам,[w:3] [func:BADBad]что ты \nнедооцениваешь \nменя[w:3].[w:3].[w:3].[w:3] [func:Final_7]Что же,[w:3] это \nк лучшему.", "Когда я умру,[w:3] моя \nдуша расколется[w:3].[w:3].[w:3].[w:3] \n[func:BADsmart]Но остатки \nискусственной \nрешимости не дадут \nей распасться.", "[func:Final_7]Резонанс энергии \nвзорвётся и \nвысвободит мощный \nвсплеск магии.[w:6] \n[func:NoMercy1]И эта атака[w:3].[w:3].[w:3].[w:3]", "[func:angry][speed:0.75]Станет твоей \nпогибелью."}
			rus={"[func:Final_7][func:DUB,imp2/11/1][w:5]Я уже вижу по твоим \nглазам,[w:3] [func:BADBad]что ты \nнедооцениваешь \nменя[w:3].[w:3].[w:3].[w:3] [func:Final_7]Что[w:3] же,[w:9] это \nк лучшему.", "[func:DUB,imp2/11/2][w:5]Когда я умру,[w:1] моя \nдуша раско[w:2]лется.[w:6] \n[func:BADsmart]Но остатки \nискусственной \nрешимости не дадут \nей распасться.", "[func:Final_7][func:DUB,imp2/11/3][w:5]Резонанс энергии \nвзорвётся[w:1] и \nвысвободит [w:1]мощный \nвсплеск [w:1]ма[w:1]гии.[w:10] \n[func:NoMercy1]И[w:1] эта[w:1] ата[w:2]ка[w:3].[w:3].[w:3].[w:3]", "[func:angry][speed:0.75][func:DUB,imp2/11/4][w:5]Станет твоей \nпогибелью."}
			neng={"[func:Final_7]I see it in your \neyes [w:3]- [func:BADBad]you're \nmisjudging me[w:3].[w:3].[w:3].[w:3] \n[func:Final_7]Well,[w:3] that's for \nbetter.", "When I will die,[w:3] my \nsoul will break[w:3].[w:3].[w:3].[w:3] \n[func:BADsmart]But leftovers of \nartificial DT won't \nlet it shred \nto pieces.", "[func:Final_7]Energy collapse will \nblow up in powerful \nmagic strike.[w:6] [func:NoMercy1]And \nthis strike[w:3].[w:3].[w:3].[w:3]", "[func:angry][speed:0.75]Will be my last \nstrike back at \nthis point."}
			engcom="Wait,[w:3] actor,[w:3] i am trying to undestand what she said[waitall:4][w:3]...[waitall:2][w:3]\nOh no."
			ruscom="Погоди,[w:3] актёр,[w:3] я пытаюсь понять,[w:3] что она пытается сказать[waitall:4][w:3]...[waitall:2][w:3]\nО нет."
			end
			wav={"imp2/k_4"} 
		elseif GetGlobal("progress") == 61 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			neng={"[func:NoMercy1]I can't wait for \n[func:BADsmart]this moment to \ncome[waitall:4][w:3]...[waitall:1][w:3]", "When you will die, [func:NoMercy1]we \nwill return to\nbeginning[waitall:4][w:3]...[waitall:1][w:3]" , "[func:NoMercy1]And while you will \nbe losing your goal, \n[func:angry]I will become \ncloser to mine[waitall:4][w:3]...[waitall:1][w:3]", "[func:NoMercy1]If you cared about \nus for a little, you \nwould let me kill you[waitall:4][w:3]...[waitall:1][w:3]\n[func:head4]But now there's no \ngoing back.", "[func:Final_7]Here it is[waitall:4][w:3]...[waitall:1][w:3]", "Last strike.", "I must say[waitall:4][w:3]...[waitall:1][w:3] that[waitall:4][w:3]...[waitall:1][w:3] \nyou was a good \npartner[waitall:4][w:3]...[waitall:1][w:3] somewhere[waitall:4][w:3]...[waitall:1][w:3]\nin another reality[waitall:4][w:3]...", "I am sorry that I[waitall:4][w:3]...[waitall:1][w:3]\n[func:NoCurse]I lost you[waitall:4][w:3]..."}
			nrus={"[func:NoMercy1]Я не могу \nдождаться, [func:BADsmart]когда \nнаступит этот миг[waitall:4][w:3]...[waitall:1][w:3]", "Если ты умрёшь, [func:NoMercy1]то \nмы вернёмся к \nначалу[waitall:4][w:3]...[waitall:1][w:3] И чем \nдальше ты от своей \nцели, [func:angry]тем ближе \nя к своей[waitall:4][w:3]...[waitall:1][w:3]", "[func:NoMercy1]Если бы тебя \nволновал мой мир, \nты бы просто дал \nсебя убить[waitall:4][w:3]...[waitall:1][w:3]\n[func:head4]Но теперь шанс \nупущен.", "[func:Final_7]Вот и настал он[waitall:4][w:3]...[waitall:1][w:3]", "Последний удар.", "Я должна сказать[waitall:4][w:3]...[waitall:1][w:3]\nЧто ты[waitall:4][w:3]...[waitall:1][w:3] был \nхорошим партнёром[waitall:4][w:3]...[waitall:1][w:3]\nКогда-то[waitall:4][w:3]...[waitall:1][w:3] в другой \nреальности[waitall:4][w:3]...[waitall:1][w:3]", "Мне так жаль,  \nчто я[waitall:4][w:3]...[waitall:1][w:3]\n[func:NoCurse][func:TireStand]я потеряла \nтебя[waitall:4][w:3]...[waitall:1][w:3]"}
			rus={"[func:NoMercy1][func:DUB,phase2/12/1][w:5]Я не могу \nдожда[w:1]ться,[w:1] [func:BADsmart]когда \nнаступит этот миг[waitall:4][w:3]...[waitall:1][w:3]", "[func:DUB,phase2/12/2][w:5]Если ты умрёшь, [func:NoMercy1]то \nмы вернёмся к \nначалу[waitall:3][w:2]...[waitall:1][w:2] И чем \nдальше ты от своей[speed:1.09] \nцели, [func:angry]тем ближе \nя к своей[waitall:4][w:3]...[waitall:1][w:3]", "[func:NoMercy1][func:DUB,phase2/12/3][w:5]Если бы тебя \nволновал[w:1] мой мир,[w:1] \nты бы про[w:1]сто дал \nсебя убить[waitall:4][w:3]...[waitall:1][w:3]\n[func:head4]Но [w:1]теперь[w:1] шанс \nупу[w:1]щен.", "[func:Final_7][func:DUB,phase2/12/4][w:5]Вот[w:1] и настал[w:1] он[waitall:4][w:3]...[waitall:1][w:3]", "[func:DUB,phase2/12/5][w:5]По[w:1]сле[w:2]дний удар.", "[func:DUB,phase2/12/6][w:5]Я должна сказать[waitall:4][w:3]...[waitall:1][w:3]\nЧто ты[waitall:4][w:3]...[waitall:1][w:4] был \nхорошим партнёром[waitall:4][w:3]...[waitall:1][w:3]\nКогда-то[waitall:4][w:3]...[waitall:1][w:5] в другой \nреальности[waitall:4][w:3]...[waitall:1][w:3]", "[func:DUB,phase2/12/7][w:5]Мне[w:1] так жаль, \nчто я[waitall:4][w:3]...[waitall:1][w:9]\n[func:NoCurse][func:TireStand]Потеряла \nтебя[waitall:4][w:3]...[waitall:1][w:3]"}
			engcom="Don't listen to her whining,[w:3] darling![w:6] Chainsaw back in action,[w:3] strike her!"
			ruscom="Она давит на жалость![w:6] Не слушай её,[w:3] дорогуша![w:6]\nБензопила завелась,[w:3] [color:8040ff]нападай!"	
			else
				NoCurse()
			end
			Encounter.SetVar("deadlyhit",true)
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
				Encounter.SetVar("chainsaw",true)
				Encounter.SetVar("FightGoes",false)
				Encounter.Call("WriteSavio")
			end
			if GetGlobal("DifficultyPoints") >= 210 then
				wav={"phase4/WrathOnly"}--very easy attack, but tests reflexes on the unknown
			else
				wav={"nothing"}
			end
		elseif GetGlobal("progress") == 61 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			neng={"[func:NoMercy1]I can't wait for \n[func:BADsmart]this moment to \ncome[waitall:4][w:3]...[waitall:1][w:3]", "When you will die, [func:NoMercy1]we \nwill return to\nbeginning[waitall:4][w:3]...[waitall:1][w:3]" , "[func:NoMercy1]And while you will \nbe losing your goal, \n[func:angry]I will become \ncloser to mine[waitall:4][w:3]...[waitall:1][w:3]", "[func:NoMercy1]If you cared about \nus for a little, you \nwould let me kill you[waitall:4][w:3]...[waitall:1][w:3]\n[func:head4]But now there's no \ngoing back.", "[func:Final_7]Here it is[waitall:4][w:3]...[waitall:1][w:3]", "Last strike.", "I must say[waitall:4][w:3]...[waitall:1][w:3] that[waitall:4][w:3]...[waitall:1][w:3] \nyou was a good \npartner[waitall:4][w:3]...[waitall:1][w:3] somewhere[waitall:4][w:3]...[waitall:1][w:3]\nin another reality[waitall:4][w:3]...", "I am sorry that I[waitall:4][w:3]...[waitall:1][w:3]\n[func:NoCurse]I lost you[waitall:4][w:3]..."}
			nrus={"[func:NoMercy1]Я не могу \nдождаться, [func:BADsmart]когда \nнаступит этот миг[waitall:4][w:3]...[waitall:1][w:3]", "Если ты умрёшь, [func:NoMercy1]то \nмы вернёмся к \nначалу[waitall:4][w:3]...[waitall:1][w:3] И чем \nдальше ты от своей \nцели, [func:angry]тем ближе \nя к своей[waitall:4][w:3]...[waitall:1][w:3]", "[func:NoMercy1]Если бы тебя \nволновал мой мир, \nты бы просто дал \nсебя убить[waitall:4][w:3]...[waitall:1][w:3]\n[func:head4]Но теперь шанс \nупущен.", "[func:Final_7]Вот и настал он[waitall:4][w:3]...[waitall:1][w:3]", "Последний удар.", "Я должна сказать[waitall:4][w:3]...[waitall:1][w:3]\nЧто ты[waitall:4][w:3]...[waitall:1][w:3] был \nхорошим партнёром[waitall:4][w:3]...[waitall:1][w:3]\nКогда-то[waitall:4][w:3]...[waitall:1][w:3] в другой \nреальности[waitall:4][w:3]...[waitall:1][w:3]", "Мне так жаль,  \nчто я[waitall:4][w:3]...[waitall:1][w:3]\n[func:NoCurse][func:TireStand]я потеряла \nтебя[waitall:4][w:3]...[waitall:1][w:3]"}
			rus={"[func:NoMercy1][func:DUB,imp2/12/1][w:5]Я не могу \nдожда[w:1]ться,[w:1] [func:BADsmart]когда \nнаступит этот миг[waitall:4][w:3]...[waitall:1][w:3]", "[func:DUB,imp2/12/2][w:5]Если ты умрёшь, [func:NoMercy1]то \nмы вернёмся к \nначалу[waitall:3][w:2]...[waitall:1][w:2] И чем \nдальше ты от своей[speed:1.09] \nцели, [func:angry]тем ближе \nя к своей[waitall:4][w:3]...[waitall:1][w:3]", "[func:NoMercy1][func:DUB,imp2/12/3][w:5]Если бы тебя \nволновал[w:1] мой мир,[w:1] \nты бы про[w:1]сто дал \nсебя убить[waitall:4][w:3]...[waitall:1][w:3]\n[func:head4]Но [w:1]теперь[w:1] шанс \nупу[w:1]щен.", "[func:Final_7][func:DUB,imp2/12/4][w:5]Вот[w:1] и настал[w:1] он[waitall:4][w:3]...[waitall:1][w:3]", "[func:DUB,imp2/12/5][w:5]По[w:1]сле[w:2]дний удар.", "[func:DUB,imp2/12/6][w:5]Я должна сказать[waitall:4][w:3]...[waitall:1][w:3]\nЧто ты[waitall:4][w:3]...[waitall:1][w:4] был \nхорошим партнёром[waitall:4][w:3]...[waitall:1][w:3]\nКогда-то[waitall:4][w:3]...[waitall:1][w:5] в другой \nреальности[waitall:4][w:3]...[waitall:1][w:3]", "[func:DUB,imp2/12/7][w:5]Мне[w:1] так жаль, \nчто я[waitall:4][w:3]...[waitall:1][w:9]\n[func:NoCurse][func:TireStand]Потеряла \nтебя[waitall:4][w:3]...[waitall:1][w:3]"}
			engcom="Don't listen to her whining,[w:3] darling![w:6] Chainsaw back in action,[w:3] strike her!"
			ruscom="Она давит на жалость![w:6] Не слушай её,[w:3] дорогуша![w:6]\nБензопила завелась,[w:3] [color:8040ff]нападай!"	
			else
				NoCurse()
			end
			--Encounter.SetVar("deadlyhit",true)
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
				Encounter.SetVar("chainsaw",true)
				--Encounter.SetVar("FightGoes",false)
				--Encounter.Call("WriteSavio")
			end
			if diff==30 then
				wav={"phase4/WrathOnly"}
			else
				wav={"nothing"}
			end
			Encounter.SetVar("evadelevel",1)
		elseif GetGlobal("progress") == 62 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			neng={"[func:NoMercy1]You thought I was gonna die,[waitall:4][w:3]didn`t you?[waitall:1][w:3]\n[func:NoCurse]I won`t die this time."}
			nrus={"[func:NoMercy1]Я не могу \nдождаться, [func:BADsmart]когда \nнаступит этот миг[waitall:4][w:3]...[waitall:1][w:3]", "Если ты умрёшь, [func:NoMercy1]то \nмы вернёмся к \nначалу[waitall:4][w:3]...[waitall:1][w:3] И чем \nдальше ты от своей \nцели, [func:angry]тем ближе \nя к своей[waitall:4][w:3]...[waitall:1][w:3]", "[func:NoMercy1]Если бы тебя \nволновал мой мир, \nты бы просто дал \nсебя убить[waitall:4][w:3]...[waitall:1][w:3]\n[func:head4]Но теперь шанс \nупущен.", "[func:Final_7]Вот и настал он[waitall:4][w:3]...[waitall:1][w:3]", "Последний удар.", "Я должна сказать[waitall:4][w:3]...[waitall:1][w:3]\nЧто ты[waitall:4][w:3]...[waitall:1][w:3] был \nхорошим партнёром[waitall:4][w:3]...[waitall:1][w:3]\nКогда-то[waitall:4][w:3]...[waitall:1][w:3] в другой \nреальности[waitall:4][w:3]...[waitall:1][w:3]", "Мне так жаль,  \nчто я[waitall:4][w:3]...[waitall:1][w:3]\n[func:NoCurse][func:TireStand]я потеряла \nтебя[waitall:4][w:3]...[waitall:1][w:3]"}
			rus={"[func:NoMercy1][func:DUB,imp2/12/1][w:5]Я не могу \nдожда[w:1]ться,[w:1] [func:BADsmart]когда \nнаступит этот миг[waitall:4][w:3]...[waitall:1][w:3]", "[func:DUB,imp2/12/2][w:5]Если ты умрёшь, [func:NoMercy1]то \nмы вернёмся к \nначалу[waitall:3][w:2]...[waitall:1][w:2] И чем \nдальше ты от своей[speed:1.09] \nцели, [func:angry]тем ближе \nя к своей[waitall:4][w:3]...[waitall:1][w:3]", "[func:NoMercy1][func:DUB,imp2/12/3][w:5]Если бы тебя \nволновал[w:1] мой мир,[w:1] \nты бы про[w:1]сто дал \nсебя убить[waitall:4][w:3]...[waitall:1][w:3]\n[func:head4]Но [w:1]теперь[w:1] шанс \nупу[w:1]щен.", "[func:Final_7][func:DUB,imp2/12/4][w:5]Вот[w:1] и настал[w:1] он[waitall:4][w:3]...[waitall:1][w:3]", "[func:DUB,imp2/12/5][w:5]По[w:1]сле[w:2]дний удар.", "[func:DUB,imp2/12/6][w:5]Я должна сказать[waitall:4][w:3]...[waitall:1][w:3]\nЧто ты[waitall:4][w:3]...[waitall:1][w:4] был \nхорошим партнёром[waitall:4][w:3]...[waitall:1][w:3]\nКогда-то[waitall:4][w:3]...[waitall:1][w:5] в другой \nреальности[waitall:4][w:3]...[waitall:1][w:3]", "[func:DUB,imp2/12/7][w:5]Мне[w:1] так жаль, \nчто я[waitall:4][w:3]...[waitall:1][w:9]\n[func:NoCurse][func:TireStand]Потеряла \nтебя[waitall:4][w:3]...[waitall:1][w:3]"}
			engcom="HOW DID YOU MISS[w:3], IT WAS A DIRECT HIT!"
			ruscom="Она давит на жалость![w:6] Не слушай её,[w:3] дорогуша![w:6]\nБензопила завелась,[w:3] [color:8040ff]нападай!"	
			end
			--Encounter.SetVar("deadlyhit",true)
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
				--Encounter.SetVar("chainsaw",true)
				--Encounter.SetVar("FightGoes",false)
				--Encounter.Call("WriteSavio")
			end
			Encounter.SetVar("evadelevel",1)
			--if diff==24 then
			wav={"imp3/red"}
			--else
			--	wav={"nothing"}
			--end
		elseif GetGlobal("progress") == 63 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			neng={"[func:NoMercy1]You thought I was gonna die,[waitall:4][w:3]didn`t you?[waitall:1][w:3]\n[func:NoCurse]I won`t die this time."}
			nrus={"[func:NoMercy1]Я не могу \nдождаться, [func:BADsmart]когда \nнаступит этот миг[waitall:4][w:3]...[waitall:1][w:3]", "Если ты умрёшь, [func:NoMercy1]то \nмы вернёмся к \nначалу[waitall:4][w:3]...[waitall:1][w:3] И чем \nдальше ты от своей \nцели, [func:angry]тем ближе \nя к своей[waitall:4][w:3]...[waitall:1][w:3]", "[func:NoMercy1]Если бы тебя \nволновал мой мир, \nты бы просто дал \nсебя убить[waitall:4][w:3]...[waitall:1][w:3]\n[func:head4]Но теперь шанс \nупущен.", "[func:Final_7]Вот и настал он[waitall:4][w:3]...[waitall:1][w:3]", "Последний удар.", "Я должна сказать[waitall:4][w:3]...[waitall:1][w:3]\nЧто ты[waitall:4][w:3]...[waitall:1][w:3] был \nхорошим партнёром[waitall:4][w:3]...[waitall:1][w:3]\nКогда-то[waitall:4][w:3]...[waitall:1][w:3] в другой \nреальности[waitall:4][w:3]...[waitall:1][w:3]", "Мне так жаль,  \nчто я[waitall:4][w:3]...[waitall:1][w:3]\n[func:NoCurse][func:TireStand]я потеряла \nтебя[waitall:4][w:3]...[waitall:1][w:3]"}
			rus={"[func:NoMercy1][func:DUB,imp2/12/1][w:5]Я не могу \nдожда[w:1]ться,[w:1] [func:BADsmart]когда \nнаступит этот миг[waitall:4][w:3]...[waitall:1][w:3]", "[func:DUB,imp2/12/2][w:5]Если ты умрёшь, [func:NoMercy1]то \nмы вернёмся к \nначалу[waitall:3][w:2]...[waitall:1][w:2] И чем \nдальше ты от своей[speed:1.09] \nцели, [func:angry]тем ближе \nя к своей[waitall:4][w:3]...[waitall:1][w:3]", "[func:NoMercy1][func:DUB,imp2/12/3][w:5]Если бы тебя \nволновал[w:1] мой мир,[w:1] \nты бы про[w:1]сто дал \nсебя убить[waitall:4][w:3]...[waitall:1][w:3]\n[func:head4]Но [w:1]теперь[w:1] шанс \nупу[w:1]щен.", "[func:Final_7][func:DUB,imp2/12/4][w:5]Вот[w:1] и настал[w:1] он[waitall:4][w:3]...[waitall:1][w:3]", "[func:DUB,imp2/12/5][w:5]По[w:1]сле[w:2]дний удар.", "[func:DUB,imp2/12/6][w:5]Я должна сказать[waitall:4][w:3]...[waitall:1][w:3]\nЧто ты[waitall:4][w:3]...[waitall:1][w:4] был \nхорошим партнёром[waitall:4][w:3]...[waitall:1][w:3]\nКогда-то[waitall:4][w:3]...[waitall:1][w:5] в другой \nреальности[waitall:4][w:3]...[waitall:1][w:3]", "[func:DUB,imp2/12/7][w:5]Мне[w:1] так жаль, \nчто я[waitall:4][w:3]...[waitall:1][w:9]\n[func:NoCurse][func:TireStand]Потеряла \nтебя[waitall:4][w:3]...[waitall:1][w:3]"}
			engcom="HOW DID YOU MISS[w:3], IT WAS A DIRECT HIT!"
			ruscom="Она давит на жалость![w:6] Не слушай её,[w:3] дорогуша![w:6]\nБензопила завелась,[w:3] [color:8040ff]нападай!"	
			end
			--Encounter.SetVar("deadlyhit",true)
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
				--Encounter.SetVar("chainsaw",true)
				--Encounter.SetVar("FightGoes",false)
				--Encounter.Call("WriteSavio")
			end
			--if diff==24 then
			wav={"imp3/yellow"}
			--else
			--	wav={"nothing"}
			--end
		elseif GetGlobal("progress") == 64 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			neng={"[func:NoMercy1]You thought I was gonna die,[waitall:4][w:3]didn`t you?[waitall:1][w:3]\n[func:NoCurse]I won`t die this time."}
			nrus={"[func:NoMercy1]Я не могу \nдождаться, [func:BADsmart]когда \nнаступит этот миг[waitall:4][w:3]...[waitall:1][w:3]", "Если ты умрёшь, [func:NoMercy1]то \nмы вернёмся к \nначалу[waitall:4][w:3]...[waitall:1][w:3] И чем \nдальше ты от своей \nцели, [func:angry]тем ближе \nя к своей[waitall:4][w:3]...[waitall:1][w:3]", "[func:NoMercy1]Если бы тебя \nволновал мой мир, \nты бы просто дал \nсебя убить[waitall:4][w:3]...[waitall:1][w:3]\n[func:head4]Но теперь шанс \nупущен.", "[func:Final_7]Вот и настал он[waitall:4][w:3]...[waitall:1][w:3]", "Последний удар.", "Я должна сказать[waitall:4][w:3]...[waitall:1][w:3]\nЧто ты[waitall:4][w:3]...[waitall:1][w:3] был \nхорошим партнёром[waitall:4][w:3]...[waitall:1][w:3]\nКогда-то[waitall:4][w:3]...[waitall:1][w:3] в другой \nреальности[waitall:4][w:3]...[waitall:1][w:3]", "Мне так жаль,  \nчто я[waitall:4][w:3]...[waitall:1][w:3]\n[func:NoCurse][func:TireStand]я потеряла \nтебя[waitall:4][w:3]...[waitall:1][w:3]"}
			rus={"[func:NoMercy1][func:DUB,imp2/12/1][w:5]Я не могу \nдожда[w:1]ться,[w:1] [func:BADsmart]когда \nнаступит этот миг[waitall:4][w:3]...[waitall:1][w:3]", "[func:DUB,imp2/12/2][w:5]Если ты умрёшь, [func:NoMercy1]то \nмы вернёмся к \nначалу[waitall:3][w:2]...[waitall:1][w:2] И чем \nдальше ты от своей[speed:1.09] \nцели, [func:angry]тем ближе \nя к своей[waitall:4][w:3]...[waitall:1][w:3]", "[func:NoMercy1][func:DUB,imp2/12/3][w:5]Если бы тебя \nволновал[w:1] мой мир,[w:1] \nты бы про[w:1]сто дал \nсебя убить[waitall:4][w:3]...[waitall:1][w:3]\n[func:head4]Но [w:1]теперь[w:1] шанс \nупу[w:1]щен.", "[func:Final_7][func:DUB,imp2/12/4][w:5]Вот[w:1] и настал[w:1] он[waitall:4][w:3]...[waitall:1][w:3]", "[func:DUB,imp2/12/5][w:5]По[w:1]сле[w:2]дний удар.", "[func:DUB,imp2/12/6][w:5]Я должна сказать[waitall:4][w:3]...[waitall:1][w:3]\nЧто ты[waitall:4][w:3]...[waitall:1][w:4] был \nхорошим партнёром[waitall:4][w:3]...[waitall:1][w:3]\nКогда-то[waitall:4][w:3]...[waitall:1][w:5] в другой \nреальности[waitall:4][w:3]...[waitall:1][w:3]", "[func:DUB,imp2/12/7][w:5]Мне[w:1] так жаль, \nчто я[waitall:4][w:3]...[waitall:1][w:9]\n[func:NoCurse][func:TireStand]Потеряла \nтебя[waitall:4][w:3]...[waitall:1][w:3]"}
			engcom="HOW DID YOU MISS[w:3], IT WAS A DIRECT HIT!"
			ruscom="Она давит на жалость![w:6] Не слушай её,[w:3] дорогуша![w:6]\nБензопила завелась,[w:3] [color:8040ff]нападай!"	
			end
			--Encounter.SetVar("deadlyhit",true)
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
				--Encounter.SetVar("chainsaw",true)
				--Encounter.SetVar("FightGoes",false)
				--Encounter.Call("WriteSavio")
			end
			--if diff==24 then
			wav={"imp3/blue"}
			--else
			--	wav={"nothing"}
			--end
		elseif GetGlobal("progress") == 65 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			neng={"[func:NoMercy1]You thought I was gonna die,[waitall:4][w:3]didn`t you?[waitall:1][w:3]\n[func:NoCurse]I won`t die this time."}
			nrus={"[func:NoMercy1]Я не могу \nдождаться, [func:BADsmart]когда \nнаступит этот миг[waitall:4][w:3]...[waitall:1][w:3]", "Если ты умрёшь, [func:NoMercy1]то \nмы вернёмся к \nначалу[waitall:4][w:3]...[waitall:1][w:3] И чем \nдальше ты от своей \nцели, [func:angry]тем ближе \nя к своей[waitall:4][w:3]...[waitall:1][w:3]", "[func:NoMercy1]Если бы тебя \nволновал мой мир, \nты бы просто дал \nсебя убить[waitall:4][w:3]...[waitall:1][w:3]\n[func:head4]Но теперь шанс \nупущен.", "[func:Final_7]Вот и настал он[waitall:4][w:3]...[waitall:1][w:3]", "Последний удар.", "Я должна сказать[waitall:4][w:3]...[waitall:1][w:3]\nЧто ты[waitall:4][w:3]...[waitall:1][w:3] был \nхорошим партнёром[waitall:4][w:3]...[waitall:1][w:3]\nКогда-то[waitall:4][w:3]...[waitall:1][w:3] в другой \nреальности[waitall:4][w:3]...[waitall:1][w:3]", "Мне так жаль,  \nчто я[waitall:4][w:3]...[waitall:1][w:3]\n[func:NoCurse][func:TireStand]я потеряла \nтебя[waitall:4][w:3]...[waitall:1][w:3]"}
			rus={"[func:NoMercy1][func:DUB,imp2/12/1][w:5]Я не могу \nдожда[w:1]ться,[w:1] [func:BADsmart]когда \nнаступит этот миг[waitall:4][w:3]...[waitall:1][w:3]", "[func:DUB,imp2/12/2][w:5]Если ты умрёшь, [func:NoMercy1]то \nмы вернёмся к \nначалу[waitall:3][w:2]...[waitall:1][w:2] И чем \nдальше ты от своей[speed:1.09] \nцели, [func:angry]тем ближе \nя к своей[waitall:4][w:3]...[waitall:1][w:3]", "[func:NoMercy1][func:DUB,imp2/12/3][w:5]Если бы тебя \nволновал[w:1] мой мир,[w:1] \nты бы про[w:1]сто дал \nсебя убить[waitall:4][w:3]...[waitall:1][w:3]\n[func:head4]Но [w:1]теперь[w:1] шанс \nупу[w:1]щен.", "[func:Final_7][func:DUB,imp2/12/4][w:5]Вот[w:1] и настал[w:1] он[waitall:4][w:3]...[waitall:1][w:3]", "[func:DUB,imp2/12/5][w:5]По[w:1]сле[w:2]дний удар.", "[func:DUB,imp2/12/6][w:5]Я должна сказать[waitall:4][w:3]...[waitall:1][w:3]\nЧто ты[waitall:4][w:3]...[waitall:1][w:4] был \nхорошим партнёром[waitall:4][w:3]...[waitall:1][w:3]\nКогда-то[waitall:4][w:3]...[waitall:1][w:5] в другой \nреальности[waitall:4][w:3]...[waitall:1][w:3]", "[func:DUB,imp2/12/7][w:5]Мне[w:1] так жаль, \nчто я[waitall:4][w:3]...[waitall:1][w:9]\n[func:NoCurse][func:TireStand]Потеряла \nтебя[waitall:4][w:3]...[waitall:1][w:3]"}
			engcom="HOW DID YOU MISS[w:3], IT WAS A DIRECT HIT!"
			ruscom="Она давит на жалость![w:6] Не слушай её,[w:3] дорогуша![w:6]\nБензопила завелась,[w:3] [color:8040ff]нападай!"	
			end
			--Encounter.SetVar("deadlyhit",true)
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
				--Encounter.SetVar("chainsaw",true)
				--Encounter.SetVar("FightGoes",false)
				--Encounter.Call("WriteSavio")
			end
			--if diff==24 then
			wav={"imp3/green"}
			--else
			--	wav={"nothing"}
			--end
		elseif GetGlobal("progress") == 66 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			neng={"[func:NoMercy1]You thought I was gonna die,[waitall:4][w:3]didn`t you?[waitall:1][w:3]\n[func:NoCurse]I won`t die this time."}
			nrus={"[func:NoMercy1]Я не могу \nдождаться, [func:BADsmart]когда \nнаступит этот миг[waitall:4][w:3]...[waitall:1][w:3]", "Если ты умрёшь, [func:NoMercy1]то \nмы вернёмся к \nначалу[waitall:4][w:3]...[waitall:1][w:3] И чем \nдальше ты от своей \nцели, [func:angry]тем ближе \nя к своей[waitall:4][w:3]...[waitall:1][w:3]", "[func:NoMercy1]Если бы тебя \nволновал мой мир, \nты бы просто дал \nсебя убить[waitall:4][w:3]...[waitall:1][w:3]\n[func:head4]Но теперь шанс \nупущен.", "[func:Final_7]Вот и настал он[waitall:4][w:3]...[waitall:1][w:3]", "Последний удар.", "Я должна сказать[waitall:4][w:3]...[waitall:1][w:3]\nЧто ты[waitall:4][w:3]...[waitall:1][w:3] был \nхорошим партнёром[waitall:4][w:3]...[waitall:1][w:3]\nКогда-то[waitall:4][w:3]...[waitall:1][w:3] в другой \nреальности[waitall:4][w:3]...[waitall:1][w:3]", "Мне так жаль,  \nчто я[waitall:4][w:3]...[waitall:1][w:3]\n[func:NoCurse][func:TireStand]я потеряла \nтебя[waitall:4][w:3]...[waitall:1][w:3]"}
			rus={"[func:NoMercy1][func:DUB,imp2/12/1][w:5]Я не могу \nдожда[w:1]ться,[w:1] [func:BADsmart]когда \nнаступит этот миг[waitall:4][w:3]...[waitall:1][w:3]", "[func:DUB,imp2/12/2][w:5]Если ты умрёшь, [func:NoMercy1]то \nмы вернёмся к \nначалу[waitall:3][w:2]...[waitall:1][w:2] И чем \nдальше ты от своей[speed:1.09] \nцели, [func:angry]тем ближе \nя к своей[waitall:4][w:3]...[waitall:1][w:3]", "[func:NoMercy1][func:DUB,imp2/12/3][w:5]Если бы тебя \nволновал[w:1] мой мир,[w:1] \nты бы про[w:1]сто дал \nсебя убить[waitall:4][w:3]...[waitall:1][w:3]\n[func:head4]Но [w:1]теперь[w:1] шанс \nупу[w:1]щен.", "[func:Final_7][func:DUB,imp2/12/4][w:5]Вот[w:1] и настал[w:1] он[waitall:4][w:3]...[waitall:1][w:3]", "[func:DUB,imp2/12/5][w:5]По[w:1]сле[w:2]дний удар.", "[func:DUB,imp2/12/6][w:5]Я должна сказать[waitall:4][w:3]...[waitall:1][w:3]\nЧто ты[waitall:4][w:3]...[waitall:1][w:4] был \nхорошим партнёром[waitall:4][w:3]...[waitall:1][w:3]\nКогда-то[waitall:4][w:3]...[waitall:1][w:5] в другой \nреальности[waitall:4][w:3]...[waitall:1][w:3]", "[func:DUB,imp2/12/7][w:5]Мне[w:1] так жаль, \nчто я[waitall:4][w:3]...[waitall:1][w:9]\n[func:NoCurse][func:TireStand]Потеряла \nтебя[waitall:4][w:3]...[waitall:1][w:3]"}
			engcom="HOW DID YOU MISS[w:3], IT WAS A DIRECT HIT!"
			ruscom="Она давит на жалость![w:6] Не слушай её,[w:3] дорогуша![w:6]\nБензопила завелась,[w:3] [color:8040ff]нападай!"	
			end
			--Encounter.SetVar("deadlyhit",true)
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
				--Encounter.SetVar("chainsaw",true)
				--Encounter.SetVar("FightGoes",false)
				--Encounter.Call("WriteSavio")
			end
			--if diff==24 then
			wav={"imp3/purple"}
			--else
			--	wav={"nothing"}
			--end
		elseif GetGlobal("progress") == 67 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			neng={"[func:NoMercy1]You thought I was gonna die,[waitall:4][w:3]didn`t you?[waitall:1][w:3]\n[func:NoCurse]I won`t die this time."}
			nrus={"[func:NoMercy1]Я не могу \nдождаться, [func:BADsmart]когда \nнаступит этот миг[waitall:4][w:3]...[waitall:1][w:3]", "Если ты умрёшь, [func:NoMercy1]то \nмы вернёмся к \nначалу[waitall:4][w:3]...[waitall:1][w:3] И чем \nдальше ты от своей \nцели, [func:angry]тем ближе \nя к своей[waitall:4][w:3]...[waitall:1][w:3]", "[func:NoMercy1]Если бы тебя \nволновал мой мир, \nты бы просто дал \nсебя убить[waitall:4][w:3]...[waitall:1][w:3]\n[func:head4]Но теперь шанс \nупущен.", "[func:Final_7]Вот и настал он[waitall:4][w:3]...[waitall:1][w:3]", "Последний удар.", "Я должна сказать[waitall:4][w:3]...[waitall:1][w:3]\nЧто ты[waitall:4][w:3]...[waitall:1][w:3] был \nхорошим партнёром[waitall:4][w:3]...[waitall:1][w:3]\nКогда-то[waitall:4][w:3]...[waitall:1][w:3] в другой \nреальности[waitall:4][w:3]...[waitall:1][w:3]", "Мне так жаль,  \nчто я[waitall:4][w:3]...[waitall:1][w:3]\n[func:NoCurse][func:TireStand]я потеряла \nтебя[waitall:4][w:3]...[waitall:1][w:3]"}
			rus={"[func:NoMercy1][func:DUB,imp2/12/1][w:5]Я не могу \nдожда[w:1]ться,[w:1] [func:BADsmart]когда \nнаступит этот миг[waitall:4][w:3]...[waitall:1][w:3]", "[func:DUB,imp2/12/2][w:5]Если ты умрёшь, [func:NoMercy1]то \nмы вернёмся к \nначалу[waitall:3][w:2]...[waitall:1][w:2] И чем \nдальше ты от своей[speed:1.09] \nцели, [func:angry]тем ближе \nя к своей[waitall:4][w:3]...[waitall:1][w:3]", "[func:NoMercy1][func:DUB,imp2/12/3][w:5]Если бы тебя \nволновал[w:1] мой мир,[w:1] \nты бы про[w:1]сто дал \nсебя убить[waitall:4][w:3]...[waitall:1][w:3]\n[func:head4]Но [w:1]теперь[w:1] шанс \nупу[w:1]щен.", "[func:Final_7][func:DUB,imp2/12/4][w:5]Вот[w:1] и настал[w:1] он[waitall:4][w:3]...[waitall:1][w:3]", "[func:DUB,imp2/12/5][w:5]По[w:1]сле[w:2]дний удар.", "[func:DUB,imp2/12/6][w:5]Я должна сказать[waitall:4][w:3]...[waitall:1][w:3]\nЧто ты[waitall:4][w:3]...[waitall:1][w:4] был \nхорошим партнёром[waitall:4][w:3]...[waitall:1][w:3]\nКогда-то[waitall:4][w:3]...[waitall:1][w:5] в другой \nреальности[waitall:4][w:3]...[waitall:1][w:3]", "[func:DUB,imp2/12/7][w:5]Мне[w:1] так жаль, \nчто я[waitall:4][w:3]...[waitall:1][w:9]\n[func:NoCurse][func:TireStand]Потеряла \nтебя[waitall:4][w:3]...[waitall:1][w:3]"}
			engcom="HOW DID YOU MISS[w:3], IT WAS A DIRECT HIT!"
			ruscom="Она давит на жалость![w:6] Не слушай её,[w:3] дорогуша![w:6]\nБензопила завелась,[w:3] [color:8040ff]нападай!"	
			end
			--Encounter.SetVar("deadlyhit",true)
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
				--Encounter.SetVar("chainsaw",true)
				--Encounter.SetVar("FightGoes",false)
				--Encounter.Call("WriteSavio")
			end
			--if diff==24 then
			wav={"imp3/cyan"}
			--else
			--	wav={"nothing"}
			--end
		elseif GetGlobal("progress") == 68 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			neng={"[func:NoMercy1]You thought I was gonna die,[waitall:4][w:3]didn`t you?[waitall:1][w:3]\n[func:NoCurse]I won`t die this time."}
			nrus={"[func:NoMercy1]Я не могу \nдождаться, [func:BADsmart]когда \nнаступит этот миг[waitall:4][w:3]...[waitall:1][w:3]", "Если ты умрёшь, [func:NoMercy1]то \nмы вернёмся к \nначалу[waitall:4][w:3]...[waitall:1][w:3] И чем \nдальше ты от своей \nцели, [func:angry]тем ближе \nя к своей[waitall:4][w:3]...[waitall:1][w:3]", "[func:NoMercy1]Если бы тебя \nволновал мой мир, \nты бы просто дал \nсебя убить[waitall:4][w:3]...[waitall:1][w:3]\n[func:head4]Но теперь шанс \nупущен.", "[func:Final_7]Вот и настал он[waitall:4][w:3]...[waitall:1][w:3]", "Последний удар.", "Я должна сказать[waitall:4][w:3]...[waitall:1][w:3]\nЧто ты[waitall:4][w:3]...[waitall:1][w:3] был \nхорошим партнёром[waitall:4][w:3]...[waitall:1][w:3]\nКогда-то[waitall:4][w:3]...[waitall:1][w:3] в другой \nреальности[waitall:4][w:3]...[waitall:1][w:3]", "Мне так жаль,  \nчто я[waitall:4][w:3]...[waitall:1][w:3]\n[func:NoCurse][func:TireStand]я потеряла \nтебя[waitall:4][w:3]...[waitall:1][w:3]"}
			rus={"[func:NoMercy1][func:DUB,imp2/12/1][w:5]Я не могу \nдожда[w:1]ться,[w:1] [func:BADsmart]когда \nнаступит этот миг[waitall:4][w:3]...[waitall:1][w:3]", "[func:DUB,imp2/12/2][w:5]Если ты умрёшь, [func:NoMercy1]то \nмы вернёмся к \nначалу[waitall:3][w:2]...[waitall:1][w:2] И чем \nдальше ты от своей[speed:1.09] \nцели, [func:angry]тем ближе \nя к своей[waitall:4][w:3]...[waitall:1][w:3]", "[func:NoMercy1][func:DUB,imp2/12/3][w:5]Если бы тебя \nволновал[w:1] мой мир,[w:1] \nты бы про[w:1]сто дал \nсебя убить[waitall:4][w:3]...[waitall:1][w:3]\n[func:head4]Но [w:1]теперь[w:1] шанс \nупу[w:1]щен.", "[func:Final_7][func:DUB,imp2/12/4][w:5]Вот[w:1] и настал[w:1] он[waitall:4][w:3]...[waitall:1][w:3]", "[func:DUB,imp2/12/5][w:5]По[w:1]сле[w:2]дний удар.", "[func:DUB,imp2/12/6][w:5]Я должна сказать[waitall:4][w:3]...[waitall:1][w:3]\nЧто ты[waitall:4][w:3]...[waitall:1][w:4] был \nхорошим партнёром[waitall:4][w:3]...[waitall:1][w:3]\nКогда-то[waitall:4][w:3]...[waitall:1][w:5] в другой \nреальности[waitall:4][w:3]...[waitall:1][w:3]", "[func:DUB,imp2/12/7][w:5]Мне[w:1] так жаль, \nчто я[waitall:4][w:3]...[waitall:1][w:9]\n[func:NoCurse][func:TireStand]Потеряла \nтебя[waitall:4][w:3]...[waitall:1][w:3]"}
			engcom="HOW DID YOU MISS[w:3], IT WAS A DIRECT HIT!"
			ruscom="Она давит на жалость![w:6] Не слушай её,[w:3] дорогуша![w:6]\nБензопила завелась,[w:3] [color:8040ff]нападай!"	
			end
			--Encounter.SetVar("deadlyhit",true)
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
				--Encounter.SetVar("chainsaw",true)
				--Encounter.SetVar("FightGoes",false)
				--Encounter.Call("WriteSavio")
			end
			--if diff==24 then
			wav={"imp3/orange"}
			--else
			--	wav={"nothing"}
			--end
		elseif GetGlobal("progress") == 69 then
			wav={"nothing"}
			Encounter.SetVar("deadlyhit",true)
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
				Encounter.SetVar("chainsaw",true)
				Encounter.SetVar("FightGoes",false)
				Encounter.Call("WriteSavio")
			end
		elseif GetGlobal("progress") >= 999 then
			wav= {"laststand5"}
			Encounter.SetVar("arenasize", {155, 130})
		end
	else
		if GetGlobal("curse") and GetGlobal("curse") > 0 then
			SetGlobal("curse", math.floor(GetGlobal("curse") / 2))
		end
		if GetGlobal("progress") == 1 then
			Encounter.SetVar("evadelevel",1)
			--if Encounter.GetVar("diff") == 18 then
			--	wav={"phase1/k_5_new"}
			--else
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
				neng={'"Did she dodge?",[w:3]\n right?', "[func:NoMercy1]Look,[w:3] you're not \nmy prince,[w:3] \nand I'm not \nyour princess.", "[func:Bad]I can defend \nmyself." ,"[func:head][next]"}
				rus={'[func:DUB,phase1/1/1][w:6]"Как она[w:1] \nувернулась?", \n[w:9]верно?', "[func:DUB,phase1/1/2][func:NoMercy1][w:4]Послушай,[w:3] ты же \nне принц,[w:4] а я \nне твоя принцесса.", "[func:DUB,phase1/1/3][func:Bad][w:3]Я умею за себя \nпостоять.","[func:head][next]"}
				nrus={'"Как она \nувернулась?", \n[w:3]верно?', "[func:NoMercy1]Послушай,[w:3] ты же \nне принц,[w:3] а я \nне твоя принцесса.", "[func:Bad]Я умею за себя \nпостоять.","[func:head][next]"}
				ruscom="Настало время для первого акта."
				engcom="It's time for the first act."
			end
				wav={"phase1/k_5_new"}
			--end
		elseif GetGlobal("progress") == 2 then
			--if Encounter.GetVar("diff") == 18 then
			--	wav={"phase1/rain"}
			--else
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
				nrus={"[func:NoMercy1]Позволь задать \nтебе вопрос.", "Ты серьёзно \nдумаешь,[w:3] \n[func:head]что я настолько \nглупа?" }
				neng={"[func:NoMercy1]Let me ask \nyou a question.", "Who do you think \nI am [func:head]to be \nso foolish?"  }
				rus={"[func:DUB,phase1/2/1][func:NoMercy1][w:2]Позволь задать \nтебе вопрос.", "[func:DUB,phase1/2/2][w:3]Ты серьёзно \nдумаешь,[w:2] \n[func:head]что я настолько \nглупа?" }
				ruscom="Вопрос с подвохом?"
				engcom="Is it rhetorical question?"
			end
				wav={"phase1/rain"}
			--end
		elseif GetGlobal("progress") == 3 then
			--if Encounter.GetVar("diff") == 18 then
			--	wav={"phase1/random"}
			--else
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
				nrus={"[func:NoMercy1][waitall:2]Всё,[waitall:1] [w:3]что ты \nнатворил на \nпути сюда[waitall:5][w:3]...[waitall:1][w:5]\nВся эта кровь \nна твоих руках[waitall:5][w:3]...", "Разве я настолько \nдура,[w:3] \n[func:head]чтобы верить тебе?" }
				rus={"[func:DUB,phase1/3/1][func:NoMercy1][waitall:1][w:3]Всё,[waitall:1] что ты \nнатворил на \nпути сюда[waitall:3][w:3]...[waitall:1][w:5]\nВся эта кровь \nна твоих руках[waitall:5][w:3]...", "[func:DUB,phase1/3/2][w:3]Разве я[w:1] настолько[w:2] \nдура,[w:4] \n[func:head]чтобы верить [w:2]тебе?" }
				neng={"[func:NoMercy1][speed:0.55]Everything [speed:1][w:3]you \nhave done on \nyour way there[waitall:5][w:3]...[waitall:1][w:5] \nAll this dust on \nyour hands[waitall:5][w:3]...", "Am I the damn fool \n[func:head]to believe in you?" }
				ruscom="Чара истерично хихикает."
				engcom="Chara hysterically laughs."
			end
				wav={"phase1/random"}
			--end
		elseif GetGlobal("progress") == 4 then
			--if Encounter.GetVar("diff") == 18 then
			--	wav={"phase1/Reaction"}
			--else
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"Мой ответ - [w:6][waitall:2]нет.", "[func:Think]Взгляни вокруг.[w:6] \nТы и я.[w:6] \nОдин на один.", "[func:NoMercy1]Этот коридор \nпропах запахом \nчеловеческой крови.", "На моих руках уже \nесть кровь людей. \n[w:6]Ты - [w:6]не первый [w:6]\nи не последний.", "[func:head]Но только ты \nпричинил столько \nболи.", "И это мой повод \nне опускать руки." }
			rus={"[func:DUB,phase1/4/1][w:5]Мой ответ - [w:2]не[w:1]т.", "[func:DUB,phase1/4/2][func:Think][w:3]Взгляни вокруг.[w:14] \nТы[w:16] и я.[w:15] \nОдин[w:18] на один.", "[func:DUB,phase1/4/3][func:NoMercy1][w:4]Этот коридор[w:2] \nпропах[w:1] запахом \n[w:1]человеческой [w:1]крови.", "[func:DUB,phase1/4/4][w:5]На моих[w:1] руках[w:3] уже[w:2] \nесть [w:1]кровь людей. \n[w:10]Ты - [w:9]не первый [w:9]\nи[w:12] [waitall:1]не пос[w:1]лед[w:1]ний.", "[w:5][func:DUB,phase1/4/5][func:head]Но[w:2] только [w:1]ТЫ[w:3] \nпричинил [w:3]столько[w:1] \nболи!", "[func:DUB,phase1/4/6][w:1]И [w:2]это мой повод \nне [w:1]опускать руки." }
			neng={"My answer - [w:6]no.", "Look around.[w:6]\n[func:Think]It's only you \nand me now.[w:6] \nOne per one.", "[func:NoMercy1]This corridor stinks \nwith the smell of \nhuman blood.", "My hands are dirty \nfrom their blood \nas well.[w:6] You [w:6]are \nnot the first \n[w:6]nor the last.", "[func:head]But only you \ncaused so much pain.", "And that's my reason \nto conquer once \nagain."}
			ruscom="Не забывай о своей миссии."
			engcom="Do not forget about your mission."
			end
			wav={"phase1/Reaction"}
			--end
		elseif GetGlobal("progress") == 5 then
			--if Encounter.GetVar("diff") == 18 then
			--	wav={"phase1/stoplights"}
			--else
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"[func:NoMercy1]И знаешь,[w:3] что?", "[func:head]С меня хватит \nпритворства.", "[func:sad]Это ведь не \nвпервые?[w:6] \nЯ чувствую, [w:3]будто \nвсё повторяется \nраз за разом.", "[func:head4]Это не похоже на \nСбросы.[w:6] \[func:sad]Временная \nлиния остаётся \nвсё той же.", "[func:head4]Будто меняется[waitall:4][w:3]...[waitall:1][w:5]\n[func:Suprise1]Сам [w:3][waitall:3]мир.", "[func:NoMercy1]Это ведь[waitall:4][w:3]...[waitall:1][w:5] \n[func:head]Твоих рук дело?" }
			rus={"[func:NoMercy1][func:DUB,phase1/5/1][w:3]И знаешь, что?", "[func:head][func:DUB,phase1/5/2][w:2]С меня хватит \nпритворства.", "[func:sad][func:DUB,phase1/5/3][w:3]Это ведь не \nвпервые?[w:12] \nЯ чувствую, [w:1]будто \nвсё [w:1]повторяется \nраз[w:2] за разом.", "[func:DUB,phase1/5/4][func:head4][w:3]Это не похоже на \nСбросы.[w:9] \[func:sad]Временная [w:1]\nлиния остаётся \nвсё той же.", "[func:DUB,phase1/5/5][func:head4][w:3]Будто меняется[waitall:4][w:3]...[waitall:1][w:5]\n[func:Suprise1]Сам [w:5][waitall:1]мир.", "[func:NoMercy1][func:DUB,phase1/5/6][w:2]Это ведь[waitall:4][w:1]...[waitall:1][w:5] \n[func:head]Твоих [w:1]рук дело?" }
			neng={"[func:NoMercy1]And ya know what?", "[func:head]I am done with \nall this acting.", "[func:sad]It's not the first \ntime,[w:3]is it? [w:6]I feel \nlike everything is \nrepeating every time.", "[func:head4]It is not Resets.[w:6] [func:sad]\nThe timeline  is still \nthe same.", "[func:head4]It feels like[waitall:4][w:3]...[waitall:1][w:5] [func:Suprise1]the\nwhole [waitall:2]world [waitall:1][w:5]is \nchanging.", "[func:NoMercy1]It is your fault[waitall:4][w:3]...[waitall:1][w:5] [func:head]\nRight?"}
			ruscom="В её словах есть смысл."
			engcom="She has a point."
			end
			wav={"phase1/stoplights"}
			--end
		elseif GetGlobal("progress") == 6 then
			--if Encounter.GetVar("diff") == 18 then
			--	wav={"phase1/NoMercyToYou"}
			--else
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"[func:sad]Ты тоже это \nчувствуешь[waitall:5]...", "[func:head4]Тем не менее[waitall:4]...[waitall:1][w:4] [func:NoMercy1]Есть\nкое-что важнее,[w:10]\nчем мои \nпредчувствия.", "[func:mercy]Ты ведь чувствуешь? [w:15]\n[waitall:2][func:head]Грехи,[waitall:1][w:5] что ползут \nпо твоей спине?"}
			rus={"[func:DUB,phase1/6/1][func:sad][w:4]Ты тоже это \nчувствуешь[waitall:5]...", "[func:head4][func:DUB,phase1/6/2][w:2]Тем не менее[waitall:4]...[waitall:1][w:2] [func:NoMercy1]Есть\n[speed:1.17]кое-что важнее,\nчем мои \nпредчувствия.", "[func:DUB,phase1/6/3][func:mercy][w:3]Ты ведь чувствуешь? [w:15]\n[func:head]Грехи,[w:2] что ползут[w:2] \nпо твоей[w:1] спине."}
			neng={"[func:sad]So you do feel \nthe same[waitall:4][w:3]...", "[func:head4]Nevertheless[waitall:4][w:3]...[waitall:1][w:4]\n[func:NoMercy1]There's something \nmore important than\nmy prejudgments.", "[func:mercy]Do you feel them?[w:15] [func:head]\n[waitall:2]Sins[waitall:1][w:5] on your back?"}
			ruscom="Нас не одурачить этой пугалкой."
			engcom="She can't fool us with those nasty words."
			end
			wav={"phase1/NoMercyToYou"}
			--end
		elseif GetGlobal("progress") == 7 then
			--if Encounter.GetVar("diff") == 18 then
			--	wav={"phase1/k_storm"}
			--else
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"[func:NoMercy1]Так вот.[w:15] Мой тебе \nсовет [w:4]- не \nповорачивайся.", "[func:head]Иначе нож в ту же \nсекунду пронзит \nтвою глотку.", "Я не отпущу тебя \nбез достойной \nбитвы.[w:6] \nТы отплатишь за \nсвои грехи." }
			rus={"[func:NoMercy1][func:DUB,phase1/7(!!!)/1][w:9][speed:0.80]Так вот.[w:7] Мой тебе \nсовет [w:3]-[w:3] не \nповорачивайся.", "[func:head][func:DUB,phase1/7(!!!)/2][w:4][speed:0.80]Иначе нож в ту же \nсекунду пронзит \nтвою глотку.", "[func:DUB,phase1/7(!!!)/3][w:6][speed:1.05]Я не отпущу тебя \nбез достойной \nбитвы.[w:6][speed:0.85] \nТы [w:1]отпла[w:2]тишь[speed:1.05] за \nсвои [w:1]грехи." }
			neng={"[func:NoMercy1]So I have an advice \nfor ya.[w:6] \n[waitall:2]Do not turn around.", "[func:head]Because in that very \nmoment knife will \npierce your thin \nneck.", "I will not let you go \nwithout proper \nfight.[w:6] You will pay \nfor your actions."}
			ruscom="Ну,[w:3] этот совет был хорошим,[w:3] кажется."
			engcom="Welp,[w:3] that advice was solid,[w:3] I wonder."
			end
			wav={"phase1/k_storm"}
			--end
		elseif GetGlobal("progress") == 8 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"[func:sad]Кому я это говорю[waitall:4][w:3]...",  "[func:head4]Ты ведь не слышишь.[w:15] \n[func:sad]Не хочешь [w:5]или \nне можешь [w:5]- не \nважно.", "[func:Final_7]Полагаю[waitall:4][w:3]...[waitall:1][w:4] \n[func:NoMercy1]Мы оба знаем,[w:3] \n[func:head]что будет в конце."}
			rus={"[func:DUB,phase1/8/1][func:sad][w:4]Кому я это говорю[waitall:2].[w:4].[w:4].", "[func:DUB,phase1/8/2][func:head4][w:4][speed:1.17]Ты ведь[speed:1.26] не слы[w:1]шишь.[w:14] \n[func:sad][speed:1.17]Не хо[w:1]чешь [w:2]или \nне можешь [w:6]- [speed:1.25]не \nважно.", "[func:DUB,phase1/8/3][func:Final_7][w:2]Полагаю,[w:4] \n[func:NoMercy1]Мы[w:3][speed:1.17] оба знаем,[w:1] \n[func:head]что [speed:1.25]будет в конце."}
			neng={"[func:sad]Why do I even \nbother[waitall:4][w:3]...", "[func:head4]You don't listen.[w:15] [func:sad]\nDoesn't matter \nif you can't \n[w:6]or you don`t want to", "[func:Final_7]I guess[waitall:4][w:3]...[waitall:1][w:3] [func:NoMercy1]We both \nknow the [func:head]final act \nof our story."}
			ruscom="Осторожнее.[w:6] \nЧто-то с ней не так[waitall:4][w:3]..."
			engcom="Beware[waitall:4][w:3]...[waitall:1][w:3] \nSomething is off about her."
			end
			wav={"phase1/warning"}
		elseif GetGlobal("progress") == 9 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"[func:head4]Ты думаешь, [w:3]что я \nнаивная[waitall:4][w:3]...[waitall:1][w:3]\nпредсказуемая и \nжалкая.", "[func:Look]Думаешь,[w:3] [func:Lookleft]что я \nвообразила из себя \nсудью,[w:3] \n[func:sad]хотя сама ничем \nне лучше тебя[waitall:4][w:3]...", "[func:head4]Может,[w:3] ты и прав.","[func:head][next]"}
			rus={"[func:DUB,phase1/9/1][func:NoMercy1][w:3]Ты думаешь, [w:2]что я \nнаивная,[w:7][speed:1.15]\nпредсказуемая[w:4] и \nжа[w:3]лкая.", "[func:DUB,phase1/9/2][func:Look][w:8]Думаешь,[w:9] [func:Lookleft]что я \nвообразила из себя \nсудью,[w:2] \n[func:sad]хотя сама ничем \nне лучше тебя[waitall:2][w:3]...", "[func:DUB,phase1/9/3][func:head4][w:5][speed:0.87]Может,[w:6] ты и прав.","[func:head][next]"}
			neng={"[func:head4]You think, I am \nnaive[waitall:4][w:3]...[waitall:1][w:3] predictable \nand pity.", "[func:Look]You think,[w:3] [func:Lookleft]I imagined \nmyself as some judge\nof you and [func:sad]still \nI am not better than \nyou[waitall:4][w:3]...", "[func:head4]Maybe,[w:3] you have a \npoint.","[func:head][next]"}
			ruscom="Конечно,[w:3] прав."
			engcom="Of course,[w:3] I have."
			end
			wav={"phase1/BeFast"}
		elseif GetGlobal("progress") == 10 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"Но я не одинока.", "[func:DramaIn][func:head4]Точнее[waitall:4][w:4]...[waitall:1][w:3] была.[w:15]\nНо пусть их и нет \nсо мной[waitall:4][w:4]...", "[func:Final_3]Я чувствую их \nвнутри своей Души.", "[func:Final_4]Каждого,[w:3] кого я \nлюбила и уважала,[w:3]\nи они отвечали \nтем же[waitall:4][w:3]...", "[func:Peachy]Каждый из \nних [w:5]-[w:5] [func:mercy]моя \nсемья.", "[func:DramaOut][func:Peachy]Я многому у них \nнаучилась[waitall:4][w:4]...", "[noskip][func:NoMercy1]Например.[w:16] [speed:0.5][func:head]Этому.[w:30][next]"}
			rus={"[func:DUB,phase1/10/1][w:6][speed:0.75]Но я не [speed:0.8]одинока.", "[func:DUB,phase1/10/2][func:DramaIn][func:head4][w:6]Точнее[waitall:4][w:2]...[waitall:1][w:3] была.[w:15]\nНо пусть их и нет \nсо мной[waitall:4][w:4]...", "[func:DUB,phase1/10/3][func:Final_3][w:4]Я чувствую их \nвнутри своей Души.", "[func:DUB,phase1/10/4][func:Final_4][w:6]Ка[w:1]ждого,[w:1] кого я \nлюбила [w:1]и уважала,[w:9]\nи они отвечали[w:1] \nтем же[waitall:4][w:3]...", "[func:DUB,phase1/10/5][func:Peachy][w:6]Каждый из \nних [w:4]-[w:3] [func:mercy]моя[w:1] \nсемья.", "[func:DUB,phase1/10/6][func:DramaOut][func:Peachy][w:5]Я многому у них \nнаучилась[waitall:4][w:4]...", "[func:DUB,phase1/10/7][noskip][func:NoMercy1][w:6][speed:0.75]Например.[w:20] [speed:0.7][func:head]Э[w:1]тому.[w:30][next]"}
			neng={"But I'm not alone.", "[func:DramaIn][func:head4]Well[waitall:4][w:4]...[waitall:1][w:3] I was[waitall:4][w:4]...[waitall:1][w:15] \nBut even if they are \nnot beside me now[waitall:4][w:4]...", "[func:Final_4]I feel them inside \nmy very soul.", "[func:head4]I feel everyone I \nloved and respected", "[func:Peachy]Every one of them[w:9] [func:mercy]\nis my family.", "[func:DramaOut][func:Peachy]I learned a lot from \nthem.", "[noskip][func:NoMercy1]For example. [w:15][func:head][waitall:2]This.[w:30][next]"}
			ruscom="Ну конечно,[w:3] сила любви.[w:6]\nКак я раньше не понял."
			engcom="Of course,[w:3] power of love.[w:6]\nShould have guessed before."
					--Encounter.SetVar("wavetime",11)
			end
			wav={"phase1/bones0"}
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
				Encounter.SetVar("evadelevel",2)
			end
		elseif GetGlobal("progress") == 11 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"[func:Peachy]Понимаешь,[w:3][func:mercy] я ещё \nне совсем привыкла \nк этой[waitall:4][w:3]...[waitall:1][w:3] силе.", "[func:Remember]Моя решимость \nрезонирует внутри \nмоей души[waitall:4][w:3]...", "[func:Peachy]Я чувствую,[w:3] как \nони[waitall:4][w:3]...[waitall:1][w:3] [func:Remember]поддерживают \nменя. \n[w:6]Заботятся обо мне.", "[func:Peachy]И их сила[waitall:4][w:3]...[waitall:1][w:3] \n[func:mercy]Передалась мне.", "[func:NoMercy1]Ну что?[w:9] [func:head]Готов \nко второму раунду?"}
			rus={"[func:Peachy][func:DUB,phase1/11/1][w:7][speed:1.10]Понимаешь,[speed:1.00][w:3][func:mercy] я ещё \nне [speed:1.20]совсем привыкла \nк [speed:1.00]этой[w:3].[w:3].[w:2].[w:2] [speed:0.80]силе.", "[func:DUB,phase1/11/2][func:Remember][w:3]Моя решимость \nрезонирует внутри \nмоей души[waitall:4][w:3]..", "[func:DUB,phase1/11/3][func:Peachy][w:4][speed:1.20]Я чувствую,[w:2] как \nони[w:1].[w:3].[w:3].[w:3] [func:Remember][speed:0.90]поддерживают \nменя. \n[w:7]Заботятся обо мне.", "[func:DUB,phase1/11/4][func:Peachy][w:3]Их сила[waitall:3][w:3]...[waitall:1][w:4][speed:0.88] \n[func:mercy]Передалась [w:1]мне.", "[func:DUB,phase1/11/5][func:NoMercy1][w:4]Ну[w:2] что?[w:9] [func:head][speed:1.10]Готов \nко второму раунду?[w:9]"}
			neng={"[func:Peachy]Sorry,[w:3] [func:mercy]I am still not \nso good with this[waitall:4][w:3]...[waitall:1][w:3] \npower.", "[func:Remember]My Determination \nresonates \nwithin my soul[waitall:4][w:3]...[waitall:1]", "[func:Peachy]It feels like[waitall:4][w:3]...[waitall:1][w:3] [func:Remember]they \ncheer for me.[w:6] \nCare about me.", "[func:Peachy]And their power[waitall:4][w:3]...[waitall:1][w:3] [func:mercy]\nIs now mine.", "[func:NoMercy1]So? [w:9][func:head]Are you ready \nfor the round two?"}
			ruscom="Она адаптируется к новым силам.[w:6]\nУ нас всё меньше времени,[w:3] \rдорогой актер."
			engcom="She is adapting to new powers.[w:6] \nWe have not so much time left,[w:3] \rdear actor."
			end
			wav={"phase1/bullettest_touhou"}
			--Encounter.SetVar("wavetimer", 13.0)
		elseif GetGlobal("progress") == 12 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"[func:head4]Эта сила[waitall:4][w:3]...", "[func:Final_5]Я будто слышу в \nушах его голос[waitall:4][w:3]...", "[func:Peachy]Такой родной\nи близкий[waitall:4][w:3]...", "Папайрус[waitall:5]...", "[waitall:4][w:3]...", "[func:mercy]Да,[w:3] я совсем забыла \nпро тебя,[w:3] извини.", "[func:NoMercy1]Итак,[w:6][func:head] на чем мы \nостановились?"}
			rus={"[func:head4][func:DUB,phase1/12/1][w:5][speed:0.85]Эта сила[waitall:4][w:3]...", "[func:Final_5][func:DUB,phase1/12/2][w:3]Я будто слышу в \nушах [speed:1.10]его [w:1]го[w:1]лос[waitall:4][w:3]...", "[func:Peachy][func:DUB,phase1/12/3][w:4][speed:0.76]Такой родной[waitall:4][w:1]...[waitall:1][w:1][speed:1.10]\nИ близкий[waitall:4][w:3]...", "[func:DUB,phase1/12/4][w:3][speed:0.74]Папайрус[waitall:5]...", "[waitall:4][w:3]...", "[func:DUB,phase1/12/5][func:mercy][w:4]Да,[w:15] я[w:3] совсем забыла \nпро тебя,[w:3] извини.", "[func:DUB,phase1/12/6][func:NoMercy1][speed:0.90][w:5]И[w:1]так,[w:6][func:head] на чем мы \nостановились?"}
			neng={"[func:head4]This power[waitall:4][w:3]...", "[func:Final_5]I felt like I heared \nhis voice in my \nhead[waitall:4][w:3]...", "[func:Peachy]So close and caring[waitall:4][w:3]...", "Papyrus[waitall:4][w:3]...", "[waitall:4][w:3]...", "[func:mercy]Yeah,[w:3] I almost forgot \nabout you,[w:3] no \noffensive.", "[func:NoMercy1]So,[w:6] [func:head]shall we \nproceed?"}
			ruscom="Мне не нравится новый вектор \rбитвы.[w:6]\nОна стала сильнее."
			engcom="I don't like this new fight \rvector.[w:6] She became too powerful."
			end
			wav={"phase1/bones1"}
			--Encounter.SetVar("wavetimer", 13.0)
		elseif GetGlobal("progress") == 13 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"[func:head4]Он так заботился \nо тебе[waitall:4][w:3]...", "[func:sad]Папайрус глупо \nпросил меня обещать \nему,[w:3] \nчто я не трону \nтебя.", "[func:head4]Ты был ему \nкак брат[waitall:4][w:3]...", "[func:NoMercy1][waitall:4][w:3]...", "Почему мне должно \nбыть стыдно,[w:3][func:mercy] что \nя не сдержала \nклятву?"}
			rus={"[func:head4][func:DUB,phase1/13/1][w:5]Он[w:4][speed:0.92] так заботился \nо тебе[waitall:4][w:3]...", "[func:sad][func:head4][func:DUB,phase1/13/2][w:5]Папайрус глупо \nпросил меня обещать \nему,[w:3] \nчто я не трону \nтебя.", "[func:head4][func:head4][func:DUB,phase1/13/3][w:4]Ты был ему \nкак [w:1]брат[waitall:4][w:3]...", "[waitall:4][w:3]...", "[func:NoMercy1][func:DUB,phase1/13/4][w:5][speed:1.14]Почему мне должно \nбыть[func:head] стыдно, что \nя не сдержала \nклятву?"}
			neng={"[func:head4]He cared about you \nso much...", "[func:sad]Papyrus forced me \nto give an oath to \nnot hurt you.", "[func:head4]You was like brother \nto him...", "...", "How can[waitall:4][w:3]...[waitall:1][w:3] [func:head]How can I \nbe sorry for \nbreaking this oath?"}
			ruscom="У меня одного кости болят?"
			engcom="Am I the only one with boneache?"
					--Encounter.SetVar("wavetime",10.5)
			end
			wav={"phase1/bullettest_chaseorb"}
		elseif GetGlobal("progress") == 14 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"[func:Think]Даже в пылу боя,[w:3] \nон заботился о \nтебе[waitall:4][w:3]...", "[func:head]Я не буду такой \nдоброй,[w:3] не смотри \nна меня.", "[func:head4]Мне так не хватает \nразговоров с ним \nу двери[waitall:4][w:3]...", "Когда я увидела,[w:3] \nчто от двери \nостался лишь \nщебень,[w:3] я поняла,[w:3] \nчто настал [waitall:2][w:2]конец.", "Конец всему[waitall:4][w:3]...[waitall:1][w:3] \n[func:head]Что я любила."}
			rus={"[func:Think][func:DUB,phase1/14/1][w:4][speed:0.87]Даже в пылу[w:1] боя,[w:8] \nон заботился[w:1] о \nтебе[waitall:4][w:3]...", "[func:head][func:DUB,phase1/14/2][w:4]Я[w:2][speed:1.04] не буду такой[speed:1.25] \nдоброй,[w:4][speed:1.04] не смотри \nна меня.", "[func:head4][func:DUB,phase1/14/3][w:5]Мне[w:6] так не хватает \nразговоров[speed:1.25] с ним \nу двери[waitall:4][w:3]...", "[func:DUB,phase1/14/4][w:4][speed:1.15]Когда я увидела, \nчто[w:4] от двери[speed:1.00] \nостался лишь \nщебень,[w:8] я поняла,[w:3] \nчто настал [w:3]ко[w:1]нец.", "[func:DUB,phase1/14/5][w:5][speed:0.80]Конец всему[waitall:2]...[waitall:1][w:3] \n[func:head]Что я [w:1]любила."}
			neng={"[func:Think]Even in the battle \ntendency he cared \nabout you[waitall:4][w:3]...", "[func:head]I won't be so \ngood,[w:3] don't even \ndream.", "[func:head4]I miss so much talking \nto him through the \ndoor[waitall:4][w:3]...", "When I saw ashes \nthat were left \nfrom it,[w:3] I got that \nthis is the [waitall:2][w:2]end.", "[waitall:2][w:1]End [waitall:1][w:9]for everything [func:head]\nI love."}
			ruscom="Чара кажется отчаявшейся."
			engcom="Chara seems desperate."
			end
			wav={"phase1/bones2"}
		elseif GetGlobal("progress") == 15 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"[func:NoMercy1]Любовь[waitall:4][w:3]...", "Конечно,[w:3] [func:head]нас обоих \nсвязала любовь.", "[func:NoMercy1]Не настоящая.[w:6] \nНе семейная.[w:6] \nА та,[w:3] что \nгниёт внутри нас.", "Любовь[waitall:4][w:3]...[waitall:1][w:3][func:head] \nк убийствам.[w:6] \nК ненависти,[w:3] \nживотной натуре.", "[func:Think]В конце концов[waitall:4][w:3]...[waitall:1][w:3] \n[func:NoMercy1]Все мы такие,[w:6][speed:0.5] \n[color:ff0000]люди[color:000000][waitall:4][w:3]...","[func:head][next]"}
			rus={"[func:NoMercy1][func:DUB,phase1/15/1][w:5]Лю[w:2]бовь[waitall:4][w:2].[w:2].[w:2].[w:2]", "[func:DUB,phase1/15/2][w:4]Ко[w:1]не[w:1]чно,[w:9] [func:head]нас обоих \nсвязывала лю[w:1]бовь.", "[func:DUB,phase1/15/3][w:4][func:NoMercy1][speed:0.85]Не настоящая.[w:3][speed:0.90] \nНе семе[w:1]йная.[w:6] \nА та,[w:3][speed:1.04] что \nгниёт[w:1][speed:1.04] внутри[w:1] нас.", "[func:DUB,phase1/15/4][w:5]Лю[w:2]бовь[waitall:4][w:2]...[waitall:1][w:1][func:head] \nК убийствам.[w:6] \nК ненависти,[w:7] \nживо[w:1]тной[w:1] нату[w:1]ре.", "[func:Think][func:DUB,phase1/15/5][w:4][speed:0.92]В конце[w:1] концов[waitall:2][w:2]...[waitall:1][w:2] \n[func:NoMercy1]Все мы такие,[w:15][speed:0.75] \n[color:ff0000]лю[w:5]ди[color:000000][waitall:4][w:3]...","[func:head][next]"}
			neng={"[func:NoMercy1]Love[waitall:4][w:3]...", "Sure,[w:3] [func:head]love has bonded \nus.", "[func:NoMercy1]Not real one.[w:6] \nNot family like.[w:6] \nBut that what is \nrotting inside us.", "Love[waitall:4][w:3]...[waitall:1][w:3] [func:head]to bloodshed.[w:6] \nTo hatred,[w:3] \nto wild hunting.", "[func:Think]In the end[waitall:4][w:3]...[waitall:1][w:3] \n[func:NoMercy1]It's natural for us,[w:6] \n[color:ff0000]humans[color:000000][waitall:4][w:3]...","[func:head][next]"}
			ruscom="Атака фантомных ножей![w:6]\nЭто читы!"
			engcom="The reign of phantom knives![w:6]\nYou got to be cheating!"
			end
			wav={"phase1/nostop"}
		elseif GetGlobal("progress") == 16 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"[func:head4]Голоса в голове[waitall:4][w:3]...[waitall:1][w:3] \nИх слишком много[waitall:4][w:3]...", "Они все[waitall:4][w:3]...[waitall:1][w:3] все \nхотят твоей \nсмерти[waitall:4][w:3]...", "[func:NoMercy1]Но я не дам её тебе \nтак просто.", "[func:closedyesend]Так же,[w:3] как ты \nмучила милую \nАльфис,[w:3] \nты будешь гореть \nв [speed:0.5][w:2]агонии[waitall:4][w:3]...", "[func:head][waitall:3][w:3]Д о л г о[w:4]"}
			rus={"[func:head4][func:DUB,phase1/16/1][w:9][speed:0.80]Голоса[w:1] в голове[waitall:3][w:1]...[waitall:1][w:1][speed:0.92] \nИ[w:2]х слишком много[waitall:4][w:3]...", "[func:DUB,phase1/16/2][w:9][speed:0.75]Они[w:1] все[waitall:4][w:3]...[waitall:1][w:2][speed:0.89] все \nхотят[w:1] твоей \nсме[w:2]рти[waitall:4][w:3]...", "[func:NoMercy1][func:DUB,phase1/16/3][w:5][speed:0.93]Но я не дам[w:1] её тебе \nпро[w:1]сто так.", "[func:closedyesend][func:DUB,phase1/16/4][w:4][speed:1.05]Так же,[speed:0.95] как ты \nмучил[w:1] милую[w:1][speed:0.97] \nА[w:2]льфис,[w:9] \nты будешь гореть \nв [speed:0.80][w:2]агонии[waitall:4][w:3]...", "[func:head][func:DUB,phase1/16/5][w:5][w:3]Д[w:1] о[w:11] л[w:2] г о[w:4]"}
			neng={"[func:head4]Voices in my head[waitall:4][w:3]...[waitall:1][w:3] \nThere's too many of \nthem[waitall:4][w:3]...", "They all[waitall:4][w:3]...[waitall:1][w:3] \nwant you dead[waitall:4][w:3]...", "[func:NoMercy1]But quick exit will be \ntoo merciful for you.", "[func:closedyesend]You will burn in [waitall:2][w:2]agony[waitall:1][w:2]\nas long as you \ntortured cute \nAlphys[waitall:4][w:3]...", "[func:head][waitall:2][w:2]For very \n[waitall:3][w:3]l o n g[waitall:2][w:3] time."}
			ruscom="Голоса[waitall:4][w:3]?..[waitall:1][w:3]\nУ неё крыша поплыла."
			engcom="Voices[waitall:4][w:3]?..[waitall:1][w:3]\nIs she nuts?"
			end
			wav={"phase1/electro_rain"}
		elseif GetGlobal("progress") == 17 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"[func:head4]Они[waitall:4][w:3]...[waitall:1][w:3] взрываются\nв моей голове[waitall:4][w:3]...", "Но эта боль[waitall:4][w:3]...[waitall:1][w:3] \n[func:NoMercy1]Она ничто по \nсравнению с тем,[w:3]\nчто ты причинил\nмне.", "Я[waitall:4][w:3]...[waitall:1][w:3] я справлюсь[waitall:4][w:3]...", "[func:head4]Я[waitall:4][w:3]...[waitall:1][w:3] справлюсь[waitall:4][w:3]...", "[waitall:4][w:3]...", "[func:NoMercy1]Покажем ему,[w:9] \n[func:head]Альфи[waitall:4][w:3]..."}
			rus={"[func:head4][func:DUB,phase1/17/1][w:5]О[w:2]ни[waitall:4][w:3]...[waitall:1][w:3][speed:0.85] взрываются\nв моей голове[waitall:4][w:3]...", "[func:DUB,phase1/17/2][w:6]Но[w:1] эта боль[waitall:4][w:3]...[waitall:1][w:3] \n[func:NoMercy1][speed:0.90]Она ничто по \nсравнению с тем[speed:1.10],\nчто ты причинил\nмне.", "[func:DUB,phase1/17/3][w:5]Я[waitall:4][w:3]...[waitall:1][w:6][speed:0.93] я справлюсь[waitall:4][w:3]...", "[func:head4][func:DUB,phase1/17/4][w:5]Я[waitall:4][w:3]...[waitall:1][w:6][speed:0.85] справлюсь[waitall:4][w:3]...", "[waitall:4][w:3]...", "[func:NoMercy1][func:DUB,phase1/17/5][w:5]По[w:2]кажем[w:1] ему,[w:6] \n[func:head]А[w:2]льфи[waitall:4][w:3]."}
			neng={"[func:head4]They are[waitall:4][w:3]...[waitall:1][w:3] exploding \nin my head[waitall:4][w:3]...", "But this pain[waitall:4][w:3]...[waitall:1][w:3] [func:NoMercy1]\nIs nothing comparing\nto what you have \ndone to me.", "I can[waitall:4][w:3]...[waitall:1][w:3] Deal with it[waitall:4][w:3]...", "[func:head4]I[waitall:4][w:3]...[waitall:1][w:3] Can[waitall:4][w:3]...", "[waitall:4][w:3]...", "[func:NoMercy1]Show him,[w:9] [func:head]Alph[waitall:4][w:3]..."}
			ruscom="В её руках сила твоих погибших врагов[waitall:4][w:3]...[waitall:1][w:3] Она[waitall:3][w:3]...[waitall:1][w:3] Настроена серьёзно."
			engcom="She has the power of your fallen foes[waitall:4][w:3]...[waitall:1][w:3] She is[waitall:3][w:3]...[waitall:1][w:3] serious now."
			end
			wav={"phase1/alph"}
		elseif GetGlobal("progress") == 18 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"[func:NoMercy1][waitall:4][w:3]...", "Скажи,[w:3] [func:head]в чем смысл \nвсего этого?", "[func:sad]Мы встречаемся \nвновь и вновь.[w:9] \nЯ вновь и вновь \nдаю тебе отпор.", "[func:head4]Раз за разом[waitall:4][w:3]...[waitall:1][w:3] \n[func:deadly]Этот бесконечный \nкошмар[waitall:4][w:3]...", "Ты в погоне за \nсилой?[w:13] \n[func:Surprise1]Тебе не нравится \nнаш мир?", "[func:head4]Что[waitall:4][w:3]...[waitall:1][w:3] \n[func:Surprise1]Что тебе нужно?", "[waitall:4][w:4]Чего[waitall:1][w:9] тебе не \nхватает?","[func:head][next]"}
			rus={"[func:NoMercy1][func:DUB,prolog2/f][waitall:4][w:3]...", "[func:DUB,phase1/18/1][w:5]Скажи,[w:10] [func:head][speed:1.07]в чем смысл \nвсего этого?", "[func:Think][func:DUB,phase1/18/2][w:5]Мы встречаемся \nвновь и вновь.[w:5] \n[func:head]Я вновь и вновь[w:1] \nдаю[w:1] тебе[w:1] отпор.", "[func:head4][func:DUB,phase1/18/3][w:4]Раз за разом[waitall:3][w:2]...[waitall:1][w:2] \n[func:deadly]Этот бесконечный \nкошмар[waitall:4][w:3]...", "[func:DUB,phase1/18/4][w:3]Ты в погоне за \nсилой?[w:10] \n[func:Surprise1]Тебе не[speed:1.15] нравится \nнаш[w:1] мир?", "[func:head4][func:DUB,phase1/18/5][w:5]Что?[w:11][speed:0.75][w:3] \n[func:Surprise1]Что[w:1] тебе[w:1][speed:1.20] ну[w:2]жно?", "[func:DUB,phase1/18/6][w:4]Чего[w:5] тебе[w:3] не \nхва[w:1]тает?","[func:head][next]"}
			neng={"[func:NoMercy1][waitall:4][w:3]...", "Say,[w:3] [func:head]what is the \npoint in this?", "[func:Think]We are meeting over \nand over again.[w:9][func:head] \nI conquer you every \ntime.", "[func:head4]Over and over[waitall:4][w:3]...[waitall:1][w:3] \nthis nightmare is \nendless[waitall:4][w:3]...", "Are you chasing the \npower?[w:9] \n[func:Surprise1]Do you not like my \nworld?", "[func:head4]What[waitall:4][w:3]...[waitall:2][w:3] [func:Surprise1]What[waitall:1][w:6] is your \ngoal?", "[waitall:4][w:4]What[waitall:1][w:9] are you \nchasing?","[func:head][next]"}
			ruscom="Ей всё равно не понять.[w:6]\nНе отвлекайся."
			engcom="She won`t get it anyway.[w:6]\nDon't bother."
			end
			wav={"phase1/Quickly"}
		elseif GetGlobal("progress") == 19 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"[func:head4]Твоя цель \nоправдывает \nтвои действия?", "[func:Surprise1]Моя семья погибла \nне напрасно,[w:3] [func:sad]верно?", "[func:Surprise1]Ты рушишь семьи,[w:6]\n[func:head4]ты уничтожаешь мир.", "[func:deadly]Каждый раз ты \nставишь нас на \nколени.", "[func:head4]Азриэль верил,[w:3] что \nв тебе есть что-то \nмогущественное.", "Сила,[w:6] [func:Surprise1]способная \nизменить мир.","[func:head][next]"}
			rus={"[func:head4][func:DUB,phase1/19/1][w:3][speed:1.20]Твоя цель[speed:1.08] \nопра[w:1]вдывает[speed:1.00] \nтвои действия?", "[func:Surprise1][func:DUB,phase1/19/2][w:5]Моя семья погибла[speed:1.15][w:1] \nне напра[w:1]сно,[w:3][speed:0.90] [func:sad]ве[w:1]рно?", "[func:Surprise1][func:DUB,phase1/19/3][w:5][speed:0.88]Ты рушишь се[w:1]мьи,[w:5]\n[func:head4][speed:0.77]ты уничтожаешь[w:1] ми[w:1]р.", "[func:deadly][func:DUB,phase1/19/4][w:3][speed:0.95]Ка[w:2]ждый раз[w:1][speed:1.20] ты \nставишь[w:1][speed:0.90] нас на[w:1] \nко[w:1]ле[w:1]ни!", "[func:head4][func:DUB,phase1/19/5][w:5][speed:1.11]Азриэль верил,[w:3][speed:1.30] что \nв тебе есть [speed:1.00]что-то \nмогущественное.", "[func:DUB,phase1/19/6][w:4][speed:0.90]Сила,[w:1][speed:1.11] [func:Surprise1]способная[w:1] \nизменить[w:1] мир.","[func:head][next]"}
			neng={"[func:head4]Does your goal cost \nyour actions?", "[func:Surprise1]My family wasn't \nsacrificed for \nnothing,[w:3] [func:sad]was it?", "[func:Surprise1]You are destroying \nfamilies,[w:3] \n[func:head4]the entire world \nitself.", "[func:deadly]Every time you are \nbreaking us to \nthe bone.", "[func:head4]Asriel believed,[w:3] that \nyou have something \ngreat.", "That you have the \npower [func:Surprise1]to change \nthe world.","[func:head][next]"}
			ruscom="Чара меланхолично крутит \rножом в руках."
			engcom="Chara is melancholically \rswinging her knife."
			end
			wav={"phase1/rei"}
		elseif GetGlobal("progress") == 20 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			Encounter.SetVar("evadelevel",3)
			neng={"[func:Peachy]Yeah[waitall:4][w:3]...[waitall:1][w:3] I hear you.[w:6] \nEnough bragging[waitall:4][w:3]...", "Rei,[w:3] you always was[waitall:4][w:3]...[waitall:1][w:3] \n[func:head4]such a crybaby[waitall:4][w:3]...", "[waitall:4][w:3]...", "[func:Peachy]Oh,[w:3][func:mercy] did I slip \nagain?", "[func:Peachy]Sorry[waitall:4][w:3]...", "All those voices[waitall:4][w:3]...[waitall:1][w:3] [func:Remember]\nThere's too many of \nthem.", "[func:head4]It's almost like I hear \nyour every victim.", "Every[waitall:4][w:3]...[waitall:1][w:3] [func:sad]And no one \nin the same time[waitall:4][w:3]...", "[func:head4][waitall:4][w:3]...", "[func:head]You won't turn the \ntable,[w:6] don't even \ndream."}
			nrus={"[func:Peachy]Да[waitall:4][w:3]...[waitall:1][w:3] Я слышу тебя.[w:6] \nХватит спорить[waitall:4][w:3]...", "Аззи,[w:3] ты всегда[waitall:4][w:3]...[waitall:1][w:3][func:NoMercy1] \nбыл плаксой[waitall:4][w:3]...", "[waitall:4][w:3]...", "[func:Peachy]Ох,[w:3][func:mercy] я опять \nотвлеклась?", "[func:Peachy]Извини[waitall:4][w:3]...", "Эти голоса[waitall:4][w:3]...[waitall:1][w:3] \n[func:Remember]Их слишком много.", "[func:head4]Я будто слышу \nкаждого монстра,[w:3] \nчто ты убил.", "Каждого[waitall:4][w:3]...[waitall:1][w:3] [func:sad]И никого \nодновременно[waitall:4][w:3]...", "[func:head4][func:head4][waitall:4][w:3]...", "[func:head]Я не дам тебе \nвоспользоваться \nмоими слабостями."}
			rus={"[func:Peachy][func:DUB,phase1/20/1][w:7]Да[waitall:4][w:3]...[waitall:1][w:3] Я[w:4] слышу тебя.[w:8][speed:1.11] \nХватит[speed:0.80] спорить!", "[func:DUB,phase1/20/2][w:5]А[w:4]ззи,[w:6] ты[w:1] все[w:1]гда[waitall:3][w:2]...[w:2][speed:0.80] \nБыл пла[w:1]ксой.", "[func:Peachy][waitall:4][w:3]...", "[func:Peachy][func:DUB,phase1/20/3][w:5]Ох,[w:3][func:mercy][speed:1.30] я опять[speed:1.40] \nотвлеклась?", "[func:Peachy][func:DUB,phase1/20/4][w:5][speed:0.80]Извини[waitall:4][w:3]...", "[func:DUB,phase1/20/5][w:5][speed:0.80]Эти го[w:1]ло[w:1]са[waitall:3][w:2]...[waitall:1][w:1] \n[func:Remember]Их[w:1] слишком[w:1] много.", "[func:head4][func:DUB,phase1/20/6][w:5]Я будто слышу \nка[w:3]ждого мо[w:1]нстра, \nчто[w:1] ты[w:1] убил.", "[func:DUB,phase1/20/7][w:4]Ка[w:3]ждого[waitall:3][w:2]...[waitall:1][w:2] [func:sad]И никого[speed:1.20] \nодновреме[w:1]нно[waitall:4][w:3]...", "[func:head4][func:head4][waitall:4][w:3]...", "[func:DUB,phase1/20/8][w:5][func:head][speed:1.15]Я не дам тебе \nвоспользоваться \nмоими сла[w:1]бостями."}
			ruscom="Чара готовит Бластеры Хаоса[waitall:4][w:3]...[waitall:1][w:5]\nПогоди,[w:3] мне это что-то напомнило[waitall:4][w:3]..."
			engcom="Chara readies Chaos Blasters[waitall:4][w:3]...[waitall:1][w:5]\nWait,[w:3] why does it sound so familiar?"
			end
			wav={"phase1/bullettest_bouncy"}
		elseif GetGlobal("progress")==21 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"[func:NoMercy1]Я изучала тебя.", "[func:Think]Следила за каждым \nтвоим шагом.[w:6] [func:head]И \nпришла к некоторым \nинтересным выводам.", "[func:NoMercy1]Азриэль верил,[w:3] что \nты великий человек.[w:6] \n[func:Think]Так и есть.", "[func:NoMercy1]Но твоя \nвеличественность \nвовсе не во благе.[w:6][func:head]\nА в пороке."}
			rus={"[func:NoMercy1][func:DUB,phase1/21/1][w:5][speed:0.88]Я[w:1] изучала[w:1] тебя[waitall:4][w:3]...", "[func:Think][func:DUB,phase1/21/2][w:3]Следила за ка[w:3]ждым \nтвоим шагом.[w:6] [func:head][speed:1.12]И \nпришла к некоторым \nинтересным выводам.", "[func:NoMercy1][func:DUB,phase1/21/3][w:5][speed:1.20]Азриэль верил,[w:3] что \nты великий человек.[w:9] \n[func:Think][speed:0.88]Так и есть.", "[func:NoMercy1][func:DUB,phase1/21/4][w:5][speed:1.20]Но твоя \nвеличественность[w:1] \nвовсе не во благе.[w:12][func:head][speed:0.90]\nА в поро[w:2]ке."}
			neng={"[func:NoMercy1]I studied you.", "[func:Think]I followed your every\nstep.[w:6] [func:head]And I did come \nto few interesting \nconclusions.", "[func:NoMercy1]Asriel believed \nyou're a great \nperson.[w:6] \n[func:Think]So you are.", "[func:NoMercy1]But your greatness \nis not in your good \nwill,[w:3] [func:head]but in your sin."}
			engcom="Don't hesitate.[w:6] \nIt's battle for exhausting."
			ruscom="Не колеблись.[w:6] \nЭто бой на выносливость."
			end
			wav={"phase1/asrielaser"}
		elseif GetGlobal("progress")==22 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"[func:NoMercy1]Твой порок - \n[func:head]неутолимый голод.", "Ты жаждешь всё \nбольше и больше.", "Твоя жадность \nпоглощает собой \nвесь мир.", "[func:Think]Для тебя нет \n'чужого'.[waitall:1][w:6] [func:head]\nЕсть лишь [waitall:2][w:1]'моё'", "[func:NoMercy1]И именно поэтому \nты раз за разом \nуничтожаешь всё,[w:3] \nчто мне дорого.", "[func:head]Ты ненасытен."}
			rus={"[func:NoMercy1][func:DUB,phase1/22/1][w:4][speed:0.90]Твой порок -[w:1] \n[func:head]неутолимый[speed:0.65] голод.", "[func:DUB,phase1/22/2][w:4][speed:0.98]Ты жаждаешь[speed:0.80] всё \nбо[w:1]льше и бо[w:1]льше.", "[func:DUB,phase1/22/3][w:4][speed:0.96]Твоя жадность \nпоглощает собой[speed:0.70][w:1] \nвесь мир.", "[func:Think][func:DUB,phase1/22/4][w:5]Для тебя нет[speed:0.65] \n'чужого'.[speed:0.85][waitall:1][w:6] [func:head]\nЕсть лишь [w:5][speed:0.35][w:1]'моё'.", "[func:NoMercy1][func:DUB,phase1/22/5][w:2]И[w:1] именно поэтому[w:1] \nты раз[w:2] за ра[w:2]зом \nуничтожа[w:1]ешь всё,[w:1] \nчто мне до[w:1]ро[w:1]го!", "[func:head][func:DUB,phase1/22/6][w:5][speed:0.85]Ты не[speed:0.65]насы[speed:0.50]тен."}
			neng={"[func:NoMercy1]Your sin [w:3]-[w:3] \n[func:head]unstoppable hunger.", "You want more \nand more.", "Your selfishness \nis eating the whole \nworld.", "[func:Think]For you there's \nno <other's>,[waitall:1][w:3] [func:head]but[waitall:2] \n<mine>[waitall:1],[w:3] isn't it?", "[func:NoMercy1]And that's the \nreason to destroy \neverything I love \nover and over.", "[func:head]You're voracious."}
			engcom="All this hunger chatting makes \rme hungry for real[waitall:4][w:3]..."
			ruscom="После этой тирады захотелось \rперекусить[waitall:4][w:3]..."
			end
			wav={"phase1/SoulOfHunger"}
		elseif GetGlobal("progress") == 23 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"[func:head4]Все эти разговоры \nо голоде[waitall:4][w:3]...", "Я[waitall:4][w:3]...[waitall:1][w:3] я вспоминаю \nмамину выпечку[waitall:4][w:3]...", "[func:Peachy]Её голос[waitall:4][w:3]...[waitall:1][w:3] Cамый \nзвонкий.", "Я слышу его \nотчетливее других.", "[func:head4]Он[waitall:4][w:3]...[waitall:1][w:3] он будто \nвыжигает мои уши[waitall:4][w:3]...", "[func:NoMercy1][waitall:4][w:3]...", "Взамен всей этой \nболи я[waitall:4][w:3]...[waitall:1][w:3] [func:head]Я выжгу \nтебя!" }
			rus={"[func:head4][func:DUB,phase1/23/1][w:3][speed:1.20]Все эти разговоры \nо [speed:0.90]голоде[waitall:4][w:3]...", "[func:DUB,phase1/23/2][w:4]Я[waitall:3][w:2]...[waitall:1][w:3][speed:0.90] я вспоминаю \nмамину выпечку[waitall:4][w:3]...", "[func:Peachy][func:DUB,phase1/23/3][w:4][speed:0.70]Её голос[waitall:3][w:2]...[waitall:1][w:3][speed:0.80] Cамый \nзвонкий.", "[func:DUB,phase1/23/4][w:4][speed:0.94]Я слышу его \nотчетливее [w:1]других.", "[func:head4][func:DUB,phase1/23/5][w:3]Он[waitall:4][w:3]...[waitall:1][w:3] он будто[speed:0.80] \nвыжигает мои у[w:1]ши[waitall:4][w:3]...", "[func:NoMercy1][waitall:4][w:3]...", "[func:DUB,phase1/23/6][w:3][speed:0.90]Взамен всей[speed:0.90] этой \nболи я[waitall:3][w:3]...[waitall:1][w:3] [func:head][speed:0.70]Я ВЫЖГУ \nТЕ[w:1]БЯ!" }
			neng={"[func:head4]All this hunger \ntalking[waitall:4][w:3]...", "I[waitall:4][w:3]...[waitall:1][w:3] I remember \nmom's pastries[waitall:4][w:3]...", "[func:Peachy]Her voice[waitall:4][w:3]...[waitall:1][w:3] is the \nloudest one.", "I hear her so \nclearly[waitall:4][w:3]...", "[func:head4]It[waitall:4][w:3]...[waitall:1][w:3] It is burning \nmy ears[waitall:4][w:3]...", "[func:NoMercy1][waitall:4][w:3]...", "Instead of this pain,[w:3] \nI[waitall:4][w:3]...[waitall:1][w:3] [func:head]I will burn you!"}
			engcom="Don't get burned."
			ruscom="Не обожгись."
			end
			wav={"phase1/firespears"}
		elseif GetGlobal("progress") == 24 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"[func:thoughts]Я вижу это пламя[waitall:4][w:3]...", "[func:head4]И перед глазами \nмелькают образы из \nдетства.", "Пожар[waitall:4][w:3]...[waitall:1][w:3] \nДеревня[waitall:4][w:3]...", "[func:trigeredclosed]Гх[waitall:4][w:3]...[waitall:1][w:3] [func:trigered]Почему ты \nне можешь наконец \nсдохнуть?!", "Сгори в аду,[w:3] чёртов \nпсих!"}
			rus={"[func:thoughts][func:DUB,phase1/24/1][w:3][speed:0.85]Я вижу это[w:1] пламя[waitall:4][w:3]...", "[func:head4][func:DUB,phase1/24/2][w:5]И перед глазами[speed:1.10] \nмелькают образы из[speed:0.90] \nдетства.", "[func:DUB,phase1/24/3][w:5][speed:0.60]Пожар[waitall:2][w:1]...[waitall:1][w:1][speed:0.54] \nДеревня[waitall:2][w:1]...", "[func:trigeredclosed][func:DUB,phase1/24/4][w:5]Гх[waitall:3][w:2]...[waitall:1][w:2] [func:trigered][speed:0.65]Почему[speed:0.75] ты \nне можешь наконец \nСДОХНУТЬ?!", "[func:DUB,phase1/24/5][w:5][speed:0.75]С[w:2]гори в аду,[w:1] чёртов \nпсих!"}
			neng={"[func:thoughts]When I see this \nflame[waitall:4][w:3]...", "[func:head4]It's like memories \nof the past are \nin front of me[waitall:4][w:3]...", "Fire[waitall:4][w:3]...[waitall:1][w:3] \nVillage[waitall:4][w:3]...", "[func:trigeredclosed]Ugh[waitall:4][w:3]...[waitall:1][w:3] [func:trigered]Why can't you \njust die already?!", "Burn in hell,[w:3] you \ndamn psycho!"}
			engcom="Chara seems to be mad.[w:6] \nFor some reason[waitall:4][w:3]?.."
			ruscom="Чара выглядит безумной.[w:6] \nПо какой-то причине?"
			end
			wav={"phase1/RandomFire"}
		elseif GetGlobal("progress") == 25 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"[func:Final_1]Погодите[waitall:4][w:3]...", "Я[waitall:4][w:3]...[waitall:1][w:3] [func:NoMercy1]Я поняла.", "[func:closedyesend]Ты такой же,[w:3] \nкак и они[waitall:4][w:3]...", "Жадный и полный \nненависти человек.", "[func:NoMercy1][waitall:4][w:3]...", "Сначала[w:6] я хотела \nтебе верить.[w:6] \n[func:Think]Правда,[w:3] хотела.", "[func:NoMercy1]Но сейчас[waitall:4][w:3]...[waitall:1][w:3] \nНет пощады таким,[w:3] \n[func:head]как ты." }
			rus={"[func:Final_1][func:DUB,phase1/25/1][w:5][speed:0.76]Погодите[waitall:4][w:3]...", "[func:DUB,phase1/25/2][w:5]Я[waitall:4][w:3]...[waitall:1][w:4][speed:0.66] [func:NoMercy1]Я поняла.", "[func:closedyesend][func:DUB,phase1/25/3][w:4][speed:0.80]Ты такой же[waitall:4][w:3]...[waitall:1][w:2][speed:0.80] \nКак и они[waitall:4][w:3]...", "[func:DUB,phase1/25/4][w:5][speed:0.85]Жадный и полный \nненависти человек.", "[func:NoMercy1][waitall:4][w:3]...", "[func:DUB,phase1/25/5][w:4][speed:0.93]Сначала я хотела \nтебе верить.[w:5] \n[func:Think]Правда,[w:1] хотела.", "[func:NoMercy1][func:DUB,phase1/25/6][w:5][speed:0.80]Но сейчас[waitall:3][w:2]...[waitall:1][w:3][speed:0.70] \nНет[speed:0.88] пощады таким,[w:2] \n[func:head]как ты." }
			neng={"[func:Final_1]Wait[waitall:4][w:3]...", "I[waitall:4][w:3]...[waitall:1][w:3] [func:NoMercy1]I got it.", "[func:closedyesend]You are almost like \nthem[waitall:4][w:3]...", "Greedy and hateful \nhuman.", "[func:NoMercy1][waitall:4][w:3]...", "At first[w:6] I wanted to \nbelieve you.[w:6]\n[func:Think]Really,[w:3] wanted.", "[func:NoMercy1]But now[waitall:4][w:3]...[waitall:1][w:3] \nNo mercy for \nsomeone [func:head]like you."}
			engcom="Chara has frozen,[w:3] starring \rinto you. "
			ruscom="Чара замерла,[w:3] пристально глядя \rвам в глаза."
			Encounter.SetVar("evadelevel",2)
			end
			wav={"phase1/NotMiddleRoad"}
		elseif GetGlobal("progress") == 26 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"[func:Final_1]Казалось,[w:3] будто я \nувидела в твоих \nглазах раскаяние[waitall:4][w:3]...", "[noskip][func:QuietMusic][func:Final_5]Лишь на миг,[w:3] но[waitall:4][w:3]...", "Милое зеркальце.[w:9] \nПартнёр.[w:9] \nКомпаньон.", "[func:Final_5]Если ты[waitall:4][w:3]...[waitall:1][w:3] \nЕсли ты слышишь[waitall:4][w:3]...", "[func:Music,spare]Я[waitall:4][w:3]...[waitall:1][w:3][func:Final_1] [func:HideKnife]Я хочу дать \nтебе шанс[waitall:4][w:3]...", "[func:head4]Но если нет[waitall:4][w:3]...[waitall:1][w:3] \nЕсли я ошибаюсь[waitall:4][w:3]...", "[waitall:4][w:3]...", "[func:Final_7]То тогда я \nдействительно \nдура[waitall:4][w:3]...","[func:Peachy][w:10][func:mercy][next]"}
			rus={"[func:Final_1][func:DUB,phase1/26/1][w:5]Казалось,[w:3] будто я \nувидела в [speed:1.10]твоих \nглазах раска[w:2][speed:0.80]яние[waitall:4][w:3]...", "[noskip][func:QuietMusic][func:Final_5][func:DUB,phase1/26/2][w:5]Лишь на миг,[w:3] но[waitall:4][w:3]...", "[func:DUB,phase1/26/3][w:6]М[w:1]илое зеркальце.[w:9][speed:0.90] \nПартнёр.[w:11][speed:0.80] \nКомпаньон.", "[func:Final_5][func:DUB,phase1/26/4][w:5][speed:0.90]Если ты[waitall:4][w:3]...[waitall:1][w:3] \nЕсли ты слы[w:2]шишь[waitall:4][w:3]...", "[func:Music,spare][func:DUB,phase1/26/5][w:5]Я[waitall:4][w:3]...[waitall:1][w:7][func:Final_1] [func:HideKnife]Я хочу дать \nтебе шанс[waitall:4][w:3]...", "[func:head4][func:DUB,phase1/26/6][w:5][speed:0.80]Но если нет[waitall:3][w:2]...[waitall:1][w:1][speed:0.74] \nЕсли я ошиба[w:1]юсь[waitall:4][w:3]...", "[waitall:4][w:3]...", "[func:Final_7][func:DUB,phase1/26/7][w:4]То тогда я[speed:1.25] \nдействительно [speed:1.40]\nдура[waitall:4][w:3]...","[func:Peachy][w:10][func:mercy][next]"}
			neng={"[func:Final_1]I felt like[waitall:4][w:3]...[waitall:1][w:3] \nI saw remorse in \nyour eyes[waitall:4][w:3]...", "[noskip][func:QuietMusic][func:Final_5]Only for a moment,[w:3] \nbut[waitall:4][w:3]...", "Pretty mirror.[w:9] \nPartner.[w:9]\nCompanion.", "[func:Final_5]If you[waitall:4][w:3]...[waitall:1][w:3] \nIf you hear me[waitall:4][w:3]...", "[func:Music,spare]I[waitall:4][w:3]...[waitall:1][w:3] [func:Final_1][func:HideKnife]I want to \ngive you a chance[waitall:4][w:3]...", "[func:head4]But if no[waitall:4][w:3]...[waitall:1][w:3] \nIf I have been \nwrong[waitall:4][w:3]...", "[waitall:4][w:3]...", "[func:Final_7]Then I really am \na fool.","[func:Peachy][w:10][func:mercy][next]"}
			engcom="Chara is giving you second \rchance.[w:10][speed:0.75] \n[color:8040ff]Do not you dare, darling..."
			ruscom="Чара даёт вам второй шанс. \n[w:10][speed:0.75][color:8040ff]Даже не смей, дорогуша..."
			end
			wav={"nothing"}
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
				Encounter.SetVar("forcedfight",true)
				Encounter.SetVar("FightGoes",false)
			end
	------------------------------------------------------------------------
		elseif GetGlobal("progress") == 27 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"Гх!", "[func:deadly][waitall:4][w:3]...", "[func:closedyesend]Ну конечно[waitall:4][w:3]...", "[func:NoMercy1]Даже если ты \nи слышишь[waitall:4][w:3]...[waitall:1][w:3] \n[func:Think]Ты не выше \nпоследствий.", "[func:NoMercy1]Сила нашего с тобой \nУР[waitall:4][w:3]...[waitall:1][w:3] \n[func:Think]Слишком высока,[w:3] \nчтобы ей \nпротивостоять.", "[func:head]У тебя есть высшая \nцель.[w:6] \nКак и у меня.", "[func:Devil]Так что давай не \nбудем отступать от \nнеё."}
			rus={"[func:DUB,phase1/27/1][w:8]Гх!", "[func:deadly][waitall:4][w:3]...", "[func:closedyesend][func:DUB,phase1/27/2][w:5][speed:0.75]Ну [speed:0.65]конечно[waitall:4][w:3]...", "[func:NoMercy1][func:DUB,phase1/27/3][w:4][speed:0.90]Даже если ты \nи слышишь[waitall:3][w:2]...[waitall:1][w:2] \n[func:Think]Ты не выше \nпоследствий.", "[func:NoMercy1][func:DUB,phase1/27/4][w:6]Сила[speed:0.90] нашего с тобой [w:2]\nУ[w:2]Р[w:1] \n[func:Think][speed:1.15]слишком велика,[w:1] \nчтобы ей \nпротивостоять.", "[func:head][func:DUB,phase1/27/5][w:6][speed:0.90]У тебя есть высшая \nцель.[w:9][speed:0.80] \nКак и у меня.", "[func:Devil][func:DUB,phase1/27/6][w:5][speed:1.15]Так что[w:1] давай не \nбудем[speed:1.25] отступать от \nнеё."}
			neng={"Ugh!", "[func:deadly][waitall:4][w:3]...", "[func:closedyesend]Obvious[waitall:4][w:3]...", "[func:NoMercy1]Even if you \nhear me[waitall:4][w:3]...[waitall:1][w:3] \n[func:Think]You're not above \nconsequences.", "[func:NoMercy1]Power of our LV[waitall:4][w:3]...[waitall:1][w:3] \n[func:Think]Is too high for \nresisting.", "[func:head]You have an utter \nmission to complete.[w:6] \nMe as well.", "[func:Devil]So let's not get \ndistracted."}
			ruscom="Чара разочарована в вас."
			engcom="Chara seems disappointed in you."
			end
			wav={"phase1/shadows"}
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
				Encounter.SetVar("forcedfight",false)
				Encounter.SetVar("FightGoes",true)
				Encounter.SetVar("globalstage","2")
				Encounter.Call("WriteSavio")
			end
		elseif GetGlobal("progress") == 28 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"[func:head]Мой папа,[w:3] Асгор,[w:3] \nизучал мою Душу.", "[func:NoMercy1]Он изучал,[w:3] что \nтакое человеческая \nРешимость.", "[func:Think]Он добился \nинтересных \nрезультатов.[w:6] \nКак я считаю.", "[func:NoMercy1]Ты,[w:3] конечно же,[w:3] \n[func:Bad]знаешь о \nфункциональном \nменю и \nСохранениях[waitall:4][w:3]...", "[func:NoMercy1]Но ты понятия не \nимеешь о[waitall:4][w:3]...[waitall:1][w:3] [func:head]\n[waitall:2]Деформировании[waitall:1][w:3]."}
			rus={"[func:head][func:DUB,phase1/28/1][w:6][speed:0.75]Мой папа,[w:6] Асгор,[w:12][speed:0.94] \nизучал мою Душу.", "[func:NoMercy1][func:DUB,phase1/28/2][w:2]Он изучал,[w:3] что \nтакое человеческая \nРешимость.", "[func:Think][func:DUB,phase1/28/3][w:5]Он добился[speed:1.05] \nинтересных \nрезультатов.[w:6] \nКак я считаю.", "[func:NoMercy1][func:DUB,phase1/28/4][w:5][speed:1.10]Ты, конечно же, \n[func:Bad]знаешь о[speed:1.00] \nфункциональном \nменю и \nСохранениях[waitall:4][w:3]...", "[func:NoMercy1][func:DUB,phase1/28/5][w:5][speed:1.05]Но[w:2] ты понятия не \nимеешь[w:2] о[waitall:3][w:2]...[waitall:1][w:2] [func:head][speed:0.90]\nДеформировании[waitall:1][w:3]."}
			neng={"[func:head]My dad,[w:3] Asgore,[w:3] \nstudied my Soul.", "[func:NoMercy1]He studied human \nDetermination.", "[func:Think]And he achieved \ninteresting \nresults.", "[func:NoMercy1]Of course,[w:3] [func:Bad]you \nknow about \nfunctional menu \nand Saving[waitall:4][w:3]...", "[func:NoMercy1]But you have \nno idea[waitall:4][w:3]...[waitall:1][w:3] [func:head]what \n[w:3][waitall:2]Defragmenting[waitall:1][w:3] is."}
			engcom="Now it seems interesting."
			ruscom="Теперь это кажется интересным."
			end
			wav={"phase1/listopad"}
		elseif GetGlobal("progress") == 29 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"[func:NoMercy1]Когда папа смог \nсинтезировать \nискусственную \nРешимость[waitall:4][w:3]...", "[func:head4]Она не прижилась.[w:6] \n[func:sad]Тела монстров были \nобезображены.[w:6] \nОни слились в \nАмальгамов.", "[func:head4]Ты знаешь эту \nисторию.", "Однако[waitall:4][w:3]...[waitall:1][w:3] Был второй \nэксперимент.[w:6] \nПохожий.", "[func:NoMercy1]Но с моей \nРешимостью.", "[func:Think]С естественной.[w:6] Я \nприняла выведенную \nим искусственную \nРешимость.", "[func:NoMercy1]И[waitall:4][w:3]...[waitall:1][w:3] [func:head]и это дало свои \nплоды."}
			rus={"[func:NoMercy1][func:DUB,phase1/29/1][w:5][speed:1.12]Когда папа смог \nсинтезировать \nискусственную \nРешимость[waitall:4][w:3]...", "[func:head4][func:DUB,phase1/29/2][w:5]Она не прижилась.[w:9][speed:0.88] \n[func:sad]Тела монстров были \nобезображены.[w:9] \nОни слились в \nАмальгамов.", "[func:head4][func:DUB,phase1/29/3][w:4]Ты знаешь эту \nисторию.", "[func:DUB,phase1/29/4][w:5][speed:0.90]Одна[w:2]ко,[w:3] был второй [speed:1.05]\nэксперимент.[w:7] \nПохожий.", "[func:NoMercy1][func:DUB,phase1/29/5][w:5][speed:0.80]Но[w:4] с моей \nРешимостью.", "[func:Think][func:DUB,phase1/29/6][w:5]С естественной.[w:6] Я \nприняла[w:1] выведенную \nим[w:2] искусственную \nРешимость.", "[func:NoMercy1][func:DUB,phase1/29/7][w:5]И[waitall:3][w:2]...[waitall:1][w:2] [func:head]это дало свои \nплоды."}
			neng={"[func:NoMercy1]When dad \nsynthesized \nartificial \nDetermination[waitall:4][w:3]...", "[func:head4]It was a failure.[w:6] \n[func:sad]Monsters body were \ndamaged and they \nmelted into \nAmalgamates.", "[func:head4]You know this story.", "Perhaps[waitall:4][w:3]...[waitall:1][w:3] \nThere was another \nexperiment [w:6] \nPretty similar.", "[func:NoMercy1]But based on my \nDetermination.", "[func:Think]Natural type.[w:6] \nI injected his \nartificial \nDetermination.", "[func:NoMercy1]And[waitall:4][w:3]...[waitall:1][w:3] [func:head]And it was \nsuccessful."}
			engcom="Did I hear this story before[waitall:4][w:3]?.."
			ruscom="Мне кажется, или я слышал эту историю[waitall:4][w:3]?.."
			end
			wav={"phase1/krug"}
		elseif GetGlobal("progress") == 30 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			Encounter.SetVar("evadelevel",3)
			nrus={"[func:NoMercy1]Помимо текущего \nтаймлайна \nпараллельно \nсуществует \nмножество других.", "[func:head4]Я[waitall:4][w:3]...[waitall:1][w:3] я увидела их,[w:6][func:sad]\nкогда Решимость \nначала реакцию.", "Я видела хорошие \nконцовки,[w:3] \nальтернативные \nверсии себя[waitall:4][w:3]...", "Даже[waitall:4][w:3]...[waitall:1][w:3] [waitall:2][w:3][func:deadly]себя[waitall:1][w:3] на \nтвоём месте.", "[func:head4]Всё это[waitall:4][w:3]...[waitall:1][w:3] [func:thoughts]не \nукладывалось у меня \nв голове.", "[func:head4]Тогда я не понимала,[w:3] \nк чему были эти \nобразы.", "[func:head4]Сейчас[waitall:4][w:3]...[waitall:1][w:3] [func:NoMercy1]Я всё \nпоняла.[w:6] [func:head]\nНе трудно сложить \nдва и два."}
			rus={"[func:NoMercy1][func:DUB,phase1/30/1][w:3][speed:1.05]Помимо [speed:0.90]текущего[speed:1.05] \nтаймла[w:2]йна \nпараллельно \nсуществует \nмно[w:2]жество других.", "[func:head4][func:DUB,phase1/30/2][w:5]Я[waitall:3][w:3]...[waitall:1][w:2][speed:0.90] я увидела их,[w:6][func:sad]\nкогда [speed:1.00]Решимость[speed:1.15] \nначала [speed:1.00]реакцию.", "[func:DUB,phase1/30/3][w:5]Я[w:2] видела[w:1] хорошие[w:1] \nконцовки,[w:1] \nальтернативные[w:1] \nверсии себя[waitall:4][w:3]...", "[func:DUB,phase1/30/42][w:5]Да[w:2]же[w:4] [func:deadly]се[w:2]бя[waitall:1][w:5] на \nтвоём[w:1] ме[w:2]сте.", "[func:head4][func:DUB,phase1/30/5][w:3]Всё это[waitall:3][w:2]...[waitall:1][w:2] [func:thoughts][speed:1.19]не \nукладывалось у меня \nв голове[waitall:3][w:2]...[waitall:1][w:2]", "[func:head4][func:DUB,phase1/30/6][w:3][speed:1.19]Тогда я не понимала,[w:2] \nк чему были [speed:1.09]эти \nобразы.", "[func:DUB,phase1/30/7][w:4][func:head4][speed:0.80]Сейчас[waitall:3][w:2]...[waitall:1][w:2] [func:NoMercy1]Я всё \nпоняла.[w:6] [speed:1.20][func:head]\nНе трудно сложить[speed:1.60] \nдва и два."}
			neng={"[func:NoMercy1]Besides current \ntimeline another \nones exists as well.", "[func:head4]I[waitall:4][w:3]...[waitall:1][w:3] I did see them.[w:6][func:sad]\nWhen Determination \nbegan reacting.", "I saw good endings,[w:3] \nalternate selves[waitall:4][w:3]...", "Even[waitall:4][w:3]...[waitall:1][w:3] [waitall:2][w:3][func:deadly]Myself[waitall:1][w:3] on \nyour place.", "[func:head4]All of this[waitall:4][w:3]...[waitall:1][w:3] \n[func:thoughts]Blew my mind.", "[func:head4]That day I couldn't \nunderstand what I \nsaw.", "But now[waitall:4][w:3]...[waitall:1][w:3] [func:NoMercy1]I get it \nclearly.[w:6] [func:head]Not so hard \nto sum one and one."}
			engcom="Chara recovered few of her sanity.[w:6] \nBut she is exhausted as well."
			ruscom="Чара восстанавливает ясность ума.[w:6]\nНо настолько же она и устала."
			end
			--Encounter.SetVar("wavetimer", 20.0)
			wav={"phase1/brave"}
		elseif GetGlobal("progress") == 31 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"[func:Peachy]Андайн\nбеспокоилась,[w:3] что \nАсгор зря ввязал \nменя,[w:3] ребёнка,[w:3] в \nсвои работы.", "Она настаивала,[w:3] \nчтобы я больше не \nвмешивалась.", "[func:Remember]Мои силы были \nслишком ценны для \nеё боевой арены.", "[func:Peachy]Она не хотела \nтерять такого \nоппонента,[w:3] как я.", "[func:mercy]Мне льстила такая \nвысокая оценка.", "[func:Peachy]Андайн умела \nподнять боевой \nдух.[w:6] Азриэль всегда \nей вдохновлялся.", "[func:NoMercy1][waitall:2]Теперь[waitall:1][w:6] [func:head]моя очередь."}
			rus={"[func:Peachy][func:DUB,phase1/31/1][w:4]Андайн\nбеспокоилась,[w:1] что \nАсгор зря ввязал \nменя,[w:8] ребёнка,[w:2] в \nсвои[w:1] работы.", "[func:DUB,phase1/31/2][w:5][speed:1.12]Она настаивала, \nчтобы я больше не \nвмешивалась.", "[func:Remember][func:DUB,phase1/31/3][w:4]Мои силы были[speed:0.75] \nслишком [speed:1.00]ценны для \nеё[w:1] боевой[w:1] арены.", "[func:Peachy][func:DUB,phase1/31/4][w:4]Она не хотела \nтерять такого \nоппонента,[w:1] как я.", "[func:mercy][func:DUB,phase1/31/5][w:5]Мне[w:3][speed:1.19] льстила такая \nв[speed:0.90]ысокая оценка.", "[func:Peachy][func:DUB,phase1/31/6][w:3][speed:0.94]Анда[w:1]йн[w:1] умела \nподнять боевой \nдух.[w:6] Азриэль всегда \nей вдохновлялся.", "[func:head][func:DUB,phase1/31/7][w:4][speed:0.85]Теперь моя[speed:0.78] очередь."}
			neng={"[func:Peachy]Undyne worried that \nAsgore was wrong \nwhen pulled me,[w:3] kid,[w:3] \nin experiments.", "She insisted to not \nbother me.", "[func:Remember]My powers were too \nprecious for her \nbattle arena.", "[func:Peachy]She didn't want to \nlose such a \nfighter as me.", "[func:mercy]I was pleased with \nsuch respect.", "[func:Peachy]Undyne could always \nrise your battle \nspirit.[w:6] Asriel was \ninspired by her.", "[func:NoMercy1][waitall:2]Now[waitall:1][w:6] [func:head]so am I."}
			engcom="Sushi are served cold and without knifes."
			ruscom="Суши подаются холодными и без ножей."
			end
			wav={"phase1/und"}
		elseif GetGlobal("progress") == 32 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"[func:NoMercy1]Теперь,[w:3] когда я \nизучаю таймлайны,[w:3] \n[func:Think]я всё больше и \nбольше понимаю, как \nработает моя \nпамять", "[func:NoMercy1]Тот раз,[w:3] когда я \nприняла \nискусственную \nРешимость,[w:3] стал \nрешающим фактором.", "Ты понимаешь,[w:3][func:Bad] о \nчем я?", "[w:2][waitall:2][func:NoMercy1]Да[waitall:4][w:3]...[waitall:1][w:3] Именно в тот \nдень [w:6][func:head]я получила \nспособность читать \nвременные линии."}
			rus={"[func:NoMercy1][func:DUB,phase1/32/1][w:4]Теперь,[w:3] когда я \nизучаю таймлайны,[w:3] \n[func:Think]я всё больше и \nбольше понимаю, как[speed:1.02] \nработает моя \nпамять.", "[func:NoMercy1][func:DUB,phase1/32/2][w:4]Тот раз,[w:2][speed:1.15] когда я \nприняла \nискусственную \nРешимость,[w:5][speed:0.95] стал \nрешающим [w:1]фактором.", "[func:DUB,phase1/32/3][w:4]Ты понимаешь,[w:2][func:Bad] о \nчем[w:1] я?", "[w:5][waitall:2][func:NoMercy1][func:DUB,phase1/32/4][w:3]Да[waitall:4][w:2]...[waitall:1][w:1][speed:0.90] Именно в тот \nдень [func:head]я получила[speed:1.05] \nспособность читать \nвременные линии."}
			neng={"[func:NoMercy1]Now,[w:3] as I studied \nthose timelines,[w:3] [func:Think]I \nhave understood \nmore about my \nmemory.", "[func:NoMercy1]It was a key factor \nto the truth,[w:3] when \nI injected artificial \nDT.", "Did you get [func:Bad]what \nI mean?", "[w:2][waitall:2][func:NoMercy1]Yes[waitall:4][w:3]...[waitall:1][w:3] In that very \nday[w:6] [func:head]I got the power \nto read timelines."}
			engcom="She[waitall:4][w:3]...[waitall:1][w:3] She [waitall:2][w:3]WHAT?"
			ruscom="Она[waitall:4][w:3]...[waitall:1][w:3] Она [waitall:2][w:3]ЧТО?"
			end
			wav={"phase1/k_random1"}
		elseif GetGlobal("progress") == 33 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"[func:head4]Не знаю,[w:3] что это \nбыло.[w:6] Судьба,[w:3] карма.[w:6] \n[func:sad]Без разницы.", "Главное,[w:3] [func:head4]что я \nблагодарю и \nпроклинаю эту силу \nодновременно.", "[func:sad]Из-за неё я вижу \nсмерти близких мне \nлюдей каждый \nраз,[w:3] как открываю \nглаза.", "[func:NoMercy1]Но с другой?[w:6] [func:head]Я как \nникогда ближе к \nтому,[w:3] чтобы изгнать \nтебя.", "[func:NoMercy1]Твоя сила[waitall:4][w:3]...[waitall:1][w:3] [func:Bad]Ты \nзнаешь о других \nтаймлайнах?", "[func:head]Ты как никто другой \nзнаешь,[w:3] что я хочу \nсделать."}
			rus={"[func:head4][func:DUB,phase1/33/1][w:6]Не знаю, что это \nбыло.[w:8] Судьба,[w:12][speed:0.80] ка[w:2]рма.[w:12][speed:0.90] \n[func:sad]Без разницы.", "[func:DUB,phase1/33/2][w:4]Главное, [func:head4]что я[speed:0.95] \nблагодарю и \nпроклинаю эту силу \nодновременно.", "[func:sad][func:DUB,phase1/33/3][w:4]Из-за неё я вижу \nсмерти близких мне \nлюдей[w:1] ка[w:2]ждый \nраз,[w:1] когда открываю \nглаза.", "[func:NoMercy1][func:DUB,phase1/33/4][w:4]Но[w:3] с другой.[w:3].[w:3].[w:3] [func:head]Я как \nникогда ближе к \nтому, чтобы изгнать \nтебя.", "[func:NoMercy1][func:DUB,phase1/33/5][w:7][speed:0.75]Твоя сила[waitall:4][w:3]...[waitall:1][w:3] [func:Bad][speed:1.00]Ты \nзнаешь о других[speed:1.10] \nтаймлайнах?", "[func:head][func:DUB,phase1/33/6][w:4][speed:0.90]Ты как никто другой \nзнаешь, что я хочу \nсделать."}
			neng={"[func:head4]I dunno how to call \nit.[w:6] Fate [w:3]or karma [w:3]-\n[func:sad]whatever.", "What's matter [w:3]- [func:head4]I am \nthanking and hating \nthis power in the \nsame time.", "[func:sad]With it I see my \nrelatives dying every \ntime I open my eyes.", "[func:NoMercy1]But on opposite \nside?[w:6] [func:head]I never \nwas so close to \ndefeating you.", "[func:NoMercy1]Your power[waitall:4][w:3]...[waitall:1][w:3] [func:Bad]You \ndo know about other \ntimelines,[w:3] don't you?", "[func:head]You as no one else\nknow what I am \nintending to do."}
			engcom="She is trying to defeat us with our weapon.[w:6] Catch this dodging squirrel already!"
			ruscom="Она пытается одолеть нас нашим же оружием.[w:6] Поймай же эту изворотливую белку!"
			end
			wav={"phase1/k_random2"}
		elseif GetGlobal("progress") == 34 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"[func:head4]Наш Король[waitall:4][w:3]...", "[func:sad]Я дала ему клятву,[w:3] \nчто остановлю \nлюбого человека,[w:3] \nкоторый станет на \nпути Стражи.", "[func:head4]Он желает твоей \nсмерти так же,[w:3] \nкак и я.", "[func:NoMercy1]Его мотивы,[w:3] а \nтеперь и его сила[waitall:4][w:3]...", "Я будто с ним на \nодной волне.[w:6] [func:head]\nМоя воля никогда \nне была так крепка."}
			rus={"[func:head4][func:DUB,phase1/34/1][w:5][speed:0.75]Наш[w:4] Король[waitall:4][w:3]...", "[func:sad][func:DUB,phase1/34/2][w:4]Я дала ему клятву,[w:2] \nчто остановлю \nлю[w:1]бого человека,[speed:1.10] \nкоторый станет на \nпути [w:1]Стражи.", "[func:head4][func:DUB,phase1/34/3][w:4][speed:0.94]Он желает твоей \nсмерти так же, \nкак и я.", "[func:NoMercy1][func:DUB,phase1/34/4][w:4][speed:0.85]Его моти[w:1]вы[waitall:3][w:2]...[waitall:1][w:2] [speed:0.95]а \nтеперь и его сила[waitall:4][w:3]...", "[func:DUB,phase1/34/5][w:4]Я будто с ним на \nодной волне.[w:11] [func:head]\nМоя воля ни[w:1]ко[w:1]гда \nне была [w:1]так [w:1]крепка."}
			neng={"[func:head4]Our King[waitall:4][w:3]...", "I[func:sad] promised that \nno human will \nget through the \nGuard.", "[func:head4]He wishes you dead \nas well as I do.", "[func:NoMercy1]His motives and \nnow [w:4]- his power[waitall:4][w:3]...", "It's almost like \nhe's beside me.[w:6] \n[func:head]My will never \nwas so strong."}
			engcom="It seems like this situation[waitall:4][w:3]...[waitall:1][w:3] cut her to the bone.[w:6]\nHe-he."
			ruscom="Похоже,[w:3] эта ситуация[waitall:4][w:3]...[waitall:1][w:3] проняла её до костей.[w:6]\nХе-хе."
			end
			wav={"phase1/2lasers"}
		elseif GetGlobal("progress") == 35 then	
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"[func:Final_7]Как иронично,[w:3] что я \nстолько раз видела \nего смерть[waitall:4][w:3]...", "[func:Irony]В тех,[w:3] других \nтаймлайнах[waitall:4][w:3]...", "[func:head4]А в этом[waitall:4][w:3]...[waitall:1][w:3] [func:sad]При \nнашей первой \nвстрече он был \nготов убить меня.", "[func:NoMercy1]И какова ирония[waitall:4][w:3]...[waitall:1][w:3] \n[func:Think]Сейчас я служу ему.[w:6] \n[func:NoMercy1]Зная,[w:3] что скоро \nпробьет его час.", "[func:head4][waitall:4][w:3]...", "Может[waitall:4][w:3]...[waitall:1][w:3] Было бы \nлучше,[w:3] [func:sad]убей он меня \nтогда?","[func:head][next]"}
			rus={"[func:Final_7][func:DUB,phase1/35/1][w:5]Как иронично,[w:1] что я \nстолько раз видела \nего смерть[waitall:4][w:3]...", "[func:Irony][func:DUB,phase1/35/2][w:5]В тех,[w:10][speed:1.15] других \nтаймлайнах[waitall:4][w:3]...", "[func:head4][func:DUB,phase1/35/3][w:5]А в этом[waitall:3][w:2]...[waitall:1][w:2][speed:1.15] [func:sad]При \nнашей встрече \nон был готов \nубить [w:1]меня.", "[func:NoMercy1][func:DUB,phase1/35/4][w:5][speed:0.85]И какова ирония[waitall:3][w:3]...[waitall:1][w:2] \n[func:Think]Сейчас я служу ему.[w:8] \n[func:NoMercy1]Зная,[w:3] что скоро \nпробьет его [w:1]час.", "[func:head4][waitall:4][w:3]...", "[func:DUB,phase1/35/5][w:7]Мо[w:2]жет[waitall:3][w:2]...[waitall:1][w:2] Было бы \nлу[w:2]чше,[w:5] [func:sad]убей [w:1]он меня \nтогда?","[func:head][next]"}
			neng={"[func:Final_7]How ironical,[w:3] I saw \nhis death so many \ntimes[waitall:4][w:3]...", "[func:Irony]In those,[w:3] other \ntimelines.", "[func:head4]But in mine[waitall:4][w:3]...[waitall:1][w:3] [func:sad]He \nintended to kill me \nat the first sight.", "[func:NoMercy1]And how ironical,[w:3] [func:Think]now \nI am at his service.[w:6] \n[func:NoMercy1]And I know that his \ntime is running out.", "[func:head4][waitall:4][w:3]...", "Maybe[waitall:4][w:3]...[waitall:1][w:3] Would it be \nbetter [func:sad]if he killed \nme that day[waitall:4][w:3]?..","[func:head][next]"}
			engcom="Chara smiles gloomy."
			ruscom="Чара печально ухмыляется."
			end
			wav={"phase1/sans3"}
		elseif GetGlobal("progress") == 36 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"[func:head]А ведь он[waitall:4][w:3]...[waitall:1][w:3] [func:NoMercy1]он \nведь даже не \nподозревает.", "[func:Think]Сидит в тронном \nзале, ожидает \nчеловека[waitall:4][w:3]...", "С которым у него \nдолжен пройти бой \nза 'судьбу' монстров.", "[func:NoMercy1]Знал бы он, что на \nсамом деле \nпроисходит[waitall:4][w:3]...", "[func:Final_7]Это был бы слишком \nсильный удар для \nнего[waitall:4][w:3]...","[func:head][next]"}
			rus={"[func:head][func:DUB,phase1/36/1][w:5]А ведь он[waitall:4][w:3]...[waitall:1][w:3] [func:NoMercy1]он \nведь даже[speed:1.15] не \nподозревает.", "[func:Think][func:DUB,phase1/36/2][w:5][speed:0.90]Сидит в тронном \nзале,[w:5] ожидает[speed:0.85] \nчеловека[waitall:4][w:3]...", "[func:DUB,phase1/36/3][w:5]С которым у него \nдолжен пройти бой \nза[w:3][speed:0.60] 'судьбу'[speed:0.70][w:6] монстров.", "[func:NoMercy1][func:DUB,phase1/36/4][w:5]Знал бы он,[w:1] что на \nсамом деле \nпроисходит[waitall:4][w:3]...", "[func:Final_7][func:DUB,phase1/36/5][w:5]Это был бы[speed:0.85] слишком \nсильный удар для \nнего[waitall:4][w:3]...","[func:head][next]"}
			neng={"[func:head]And he[waitall:4][w:3]...[waitall:1][w:3] [func:NoMercy1]He still \nhas no clue what's \ngoing on.", "[func:Think]He sits in the throne \nroom, waiting for a \nhuman[waitall:4][w:3]...", "He waits for the \nbattle that will \ndecide monsters \n'fate'.", "[func:NoMercy1]How pity he doesn't \nknow that there's \nnothing to decide[waitall:4][w:3]...", "[func:Final_7]It would be too \ntough hit for him[waitall:4][w:3]...","[func:head][next]"}
			engcom="Would be better for her if she was thinking how tough will be our hit[waitall:4][w:3]...[waitall:1][w:3]"
			ruscom="Лучше бы подумала о том,[w:3] каким сильным будет наш удар по ней[waitall:4][w:3]...[waitall:1][w:3]"
			end
			wav={"phase1/sansnew"}
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
				currentdialogue = {"[noskip]"}
			end
		elseif GetGlobal("progress") == 37 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"[func:head]Я[waitall:4][w:3]...[waitall:1][w:3] [func:head4]Я не буду врать.", "Я устаю.[w:6] [func:sad]Ты и сам \nэто понимаешь.", "[func:head4]И эти голоса в \nголове[waitall:4][w:3]...[waitall:1][w:3] они \nне утихают.[w:6] Они всё \nгромче и громче.", "[func:sad]Что,[w:3] если даже этой \nсилы будет мало?[w:6] \nЧто,[w:3] если я вновь \nпроиграю?", "[func:NoMercy1]Чёрт,[w:3] если бы я \nзнала.", "Поживем [w:4]- увидим,[w:3][func:head] \nверно?[w:6] Хех[waitall:4][w:3]..."}
			rus={"[func:head][func:DUB,phase1/37/1][w:6]Я[waitall:4][w:3]...[waitall:1][w:4] [func:head4][speed:0.94]Я не буду врать.", "[func:DUB,phase1/37/2][w:5][speed:0.80]Я[w:1] устаю.[w:15] [func:sad][speed:0.85]Ты и сам \nэто понимаешь.", "[func:head4][func:DUB,phase1/37/3][w:5]И эти голоса в \nголове[waitall:3][w:2]...[waitall:1][w:2] Они \nне утихают.[w:9] Они всё \nгромче и громче.", "[func:sad][func:DUB,phase1/37/4][w:5]Что,[w:3] если[w:1] даже[w:1] этой [w:2]\nсилы[w:1] будет мало?[w:9] \nЧто,[w:3] если[w:1] я [w:1]вновь[w:2] \nпроиграю?", "[func:NoMercy1][func:DUB,phase1/37/5][w:5][speed:0.80]Чёрт,[w:10] если бы я \nзнала[waitall:4][w:3]...", "[func:DUB,phase1/37/6][w:5][speed:1.10]Поживем - увидим,[func:head] \nверно?[w:6][speed:0.82] Хе-хе[waitall:4][w:3]..."}
			neng={"[func:head]I[waitall:4][w:3]...[waitall:1][w:3] [func:head4]I'm not gonna \nlie.", "I am growing tired.[w:6] \n[func:sad]And you know it well.", "[func:head4]And those voices in \nmy head[waitall:4][w:3]...[waitall:1][w:3] They \ndidn't calm down.[w:6] \nOn opposite [w:4]- only \ngrew louder.", "[func:sad]What if even this \npower will be not \nenough?[w:6] What if I \nlose again?", "[func:NoMercy1]Hell,[w:3] if I know.", "We'll see in the \nend,[w:3][func:head] right?[w:6] \nHeh[waitall:4][w:3]..."}
			engcom="We highly likely will see it.[w:6]\nI wouldn`t be so sure about her tho."
			ruscom="Мы,[w:3] может,[w:3] и поживём.[w:6]\nОна -[w:3] вряд ли."
			end
			wav={"phase1/kniferain"}
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
				currentdialogue = {"[noskip]"}
			end
		elseif GetGlobal("progress") == 38 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"Хотя,[w:3] [func:NoMercy1]что тебе \nзнать о лишениях?", "[func:head]Ты ведь так жестоко \nрасправился с \nпитомцем Маффет[waitall:4][w:3]...", "Я лично ухаживала \nза ним.[w:6] Он был \nпочти что моим \nпитомцем.", "[func:sad]Если бы Маффет,[w:3] \nконечно,[w:3] знала \nслово [waitall:2][w:3]<делиться>[waitall:4][w:3]...", "[func:NoMercy1]А затем пришел ты.[w:6] [func:head]\nЖестоко \nрасправился с ними \nобоими[waitall:4][w:3]...", "[func:head4]Не знаю,[w:3] почему[waitall:4][w:3]...[waitall:1][w:3] \nНо во мне даже нет \nзлости,[w:3] когда я \nдумаю о Паукексе.", "Только [waitall:2][w:3]звенящая \nпустота[waitall:1][w:3] в груди.", "Интересно.[w:6] [func:sad]\nК чему бы это?","[func:head][next]"}
			rus={"[func:DUB,phase1/38/1][w:4]Хо[w:2]тя,[w:9] [func:NoMercy1][speed:0.93]что тебе \nзнать[speed:0.87] о лишениях?", "[func:head][func:DUB,phase1/38/2][w:4][speed:0.88]Ты [w:1]ведь[w:1] так жестоко[speed:0.95] \nрасправился с \nпитомцем Маффет[waitall:4][w:3]...", "[func:DUB,phase1/38/3][w:4]Я[w:1] ли[w:1]чно ухаживала \nза ним.[w:6] Он был[w:1] \nпочти[w:1] что мои[w:2]м [w:1]\nпитомцем.", "[func:sad][func:DUB,phase1/38/4][w:4][speed:0.90]Если бы Маффет, \nконечно,[w:2] знала \nслово[w:1] [speed:0.88]'делиться'[waitall:4][w:3]...", "[func:NoMercy1][func:DUB,phase1/38/5][w:4][speed:0.88]А затем пришёл ты.[w:6] [func:head]\nЖестоко[speed:0.99] \nрасправился с ними \nобо[w:2]ими[waitall:4][w:3]...", "[func:head4][func:DUB,phase1/38/6][w:5][speed:0.88]Не знаю, почему,[w:5][speed:1.10] \nно во мне даже нет \nзлости,[w:1] когда я[w:1] \nдумаю [w:1]о[w:3][speed:0.90] Пау[w:1]кексе.", "[func:DUB,phase1/38/7][w:5][speed:0.75]То[w:1]лько[waitall:4][w:3]...[waitall:1][w:4][speed:0.63] Звенящая \nпустота[waitall:3][w:2]...[waitall:1][w:1][speed:0.85] в груди.", "[func:DUB,phase1/38/8][w:5][speed:0.93]Интересно,[w:1] [func:sad]\nк чему бы это?","[func:head][next]"}
			neng={"Though [w:3][func:NoMercy1]what do you \neven know of losing \nsomeone?", "[func:head]You so cruelly \ndestroyed Muffet's \npet[waitall:4][w:3]...", "I personally cared \nfor him.[w:6] It was \nalmost like my own \npet.", "[func:sad]It would be,[w:3] if \nMuffet even knew \nthe word [waitall:2][w:3]<share>[waitall:4][w:3]...", "[func:NoMercy1]But you have come.[w:6] [func:head]\nAnd made them both \ngone[waitall:4][w:3]...", "[func:head4]I don't know why[waitall:4][w:3]...[waitall:1][w:3] \nBut I'm not mad \nthinking about \nSpidonut.", "Only [waitall:2][w:3]silent void[waitall:1][w:3] \ninside the chest.", "Interesting.[w:6] [func:sad]\nWhy?","[func:head][next]"}
			engcom="What about a spiderdance?[w:6]\nHow relieving that she forgot that stupid pun."
			ruscom="Как насчёт танца с пауками?[w:6]\nКак хорошо,[w:3] что она избавилась от этой тупой шутки."
			end
			wav={"phase1/muffet"}
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
				currentdialogue = {"[noskip]"}
			end
		elseif GetGlobal("progress") == 39 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"[func:head4]Как сложно просто \nперестать \nзаботиться.", "[func:sad]Перестать \nволноваться \nо пустяках и \nотпустить любую \nмотивацию.", "[func:head4]Бугги смог,[w:3] потому \nчто он бездушный \nцветок[waitall:4][w:3]...", "[func:thoughts]А у меня есть \nстремления.[w:6] Рвения.[w:6] \nНадежды и мечты.", "[func:NoMercy1]Я не могу[waitall:4][w:3]...[waitall:1][w:3] [func:head]Не могу \nпозволить тебе их \nразрушить."}
			rus={"[func:head4][func:DUB,phase1/39/1!!!][w:4][speed:0.95]Как сложно[w:4] просто[speed:1.15] \nперестать[speed:1.00] \nзаботиться[waitall:4][w:3]...", "[func:sad][func:DUB,phase1/39/2][w:4][speed:1.09]Перестать \nволноваться \nо пустяках и \nотпустить[w:2][speed:0.90] любую[w:2] \nмотивацию.", "[func:head4][func:DUB,phase1/39/3][w:3][speed:0.85]Бугги смог,[w:8][speed:0.94] потому \nчто он[speed:1.03] бездушный \nцветок[waitall:4][w:3]...", "[func:thoughts][func:DUB,phase1/39/4][w:4][speed:0.90]А у меня есть \nстремления.[w:12] Рве[w:2]ния.[w:12] \nНаде[w:2]жды[w:2] и мечты.", "[func:NoMercy1][func:DUB,phase1/39/5][w:4]Я не могу[waitall:4][w:3]...[waitall:1][w:3] [func:head]Не могу \nпозволить тебе их \nразрушить."}
			neng={"[func:head4]It's uneasy to just \nlet everything go.", "[func:sad]To stop bother \nabout details and \nforget any \nmotivation.", "[func:head4]Boogie could do it,[w:3] \nbecause he's \nsoulless flower[waitall:4][w:3]...", "[func:thoughts]But I have my own \nmotto.[w:6] Goals.[w:6] \nHopes and dreams.", "[func:NoMercy1]I can't let you[waitall:4][w:3]...[waitall:1][w:3] \n[func:head]Can't let you break \nthem."}
			engcom="Hopes and dreams[waitall:4][w:3]...[waitall:1][w:3] Such a nuisance.[w:6]\nAll that matters [w:3]-[w:3] GLAMOUR."
			ruscom="Надежды и мечты[waitall:4][w:3]...[waitall:1][w:3] Что за вздор.[w:6]\nВсё, что имеет значение [w:3]-[w:3] ГЛАМУР."
			end
			wav={"phase1/field"}
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
				currentdialogue = {"[noskip]"}
			end
		elseif GetGlobal("progress") == 40 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			Encounter.SetVar("evadelevel",4)
			nrus={"[func:NoMercy1]Какое тебе дело до \nнас,[w:3] не так ли?", "[func:head4]Бугги рассказывал \nмне,[w:3] что есть сила,[w:3] \nкоторая \nпревосходит \nРешимость.", "[func:sad]Я ему не поверила.[w:6] \n[func:NoMercy1]Но,[w:3] кажется,[w:3] теперь \nэто очевидно.", "[func:head]Наша с тобой \n[waitall:2][w:3]ЛЮБОВЬ.", "[func:Think]Неважно,[w:3] сколько у \nнас Решимости,[w:3][func:head] лишь \n[waitall:2][w:3]ЛЮБОВЬ[waitall:1] -[w:3] мерило \nнаших сил."}
			rus={"[func:NoMercy1][func:DUB,phase1/40/1][w:5]Какое тебе дело до \nнас, [speed:1.10]не так ли?", "[func:head4][func:DUB,phase1/40/2][w:4]Бугги рассказывал \nмне, что есть сила, \nкоторая \nпревосходит \nРешимость.", "[func:sad][func:DUB,phase1/40/3][w:4]Я ему не поверила.[w:8] \n[func:NoMercy1]Но,[w:2] кажется,[w:1] теперь \nэто очевидно.", "[func:head][func:DUB,phase1/40/4][w:4][speed:0.72]Наша с тобой \n[w:7][speed:0.50]ЛЮБОВЬ.", "[func:Think][func:DUB,phase1/40/5][w:4]Неважно,[w:1] сколько у \nнас Решимости,[w:8][func:head] лишь[w:5] \n[waitall:2][w:3]ЛЮБОВЬ[waitall:1] -[w:5] мерило[w:1] \nнаших[w:1] сил."}
			neng={"[func:NoMercy1]It's not your \nbusiness anyway,[w:3] \nis it?", "[func:head4]Boogie told me \nthere's a power much \ngreater than \nDetermination.", "[func:sad]I didn't believe him \nback then.[w:6] [func:NoMercy1]But now \nthat's obvious.", "[func:head]Our [waitall:2][w:3]LOVE.", "[func:Think]Doesn't matter how \nmuch DT we have,[w:3] \nif we didn't gain \nany [waitall:2][w:3]LOVE[waitall:1][w:3],[w:3][func:head] right?"}
			engcom="Chara seems chaotic neutral."
			ruscom="Чара выглядит хаотично нейтральной."
			end
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
				currentdialogue = {"[noskip]"}
			end
			wav={"phase1/buggy1"}
		elseif GetGlobal("progress") == 41 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"[func:head4]Подобно этим \nсеменам \nразлетелись [func:sad]\nнаши жизни[waitall:4][w:3]...", "[func:head4]Этот танец \nнапоминает мне \nо прошлом,[w:3] что \nбеспощадно \nулизнуло[waitall:4][w:3]...", "У меня больше нет \nни дома,[w:3] \nни семьи,[w:3] \nни цели в жизни[waitall:4][w:3]...", "[func:deadly]И во всём[waitall:4][w:3]...[waitall:1][w:3] [func:closedyesend]\nВиноват[waitall:4][w:3]...[waitall:1][w:3] [func:head]\nТы[waitall:4][w:3]..."}
			rus={"[func:head4][func:DUB,phase1/41/1][w:5]Подобно этим \nсеменам \nразлетались [func:sad]\nнаши[w:1] жи[w:1]зни[waitall:4][w:3]...", "[func:head4][func:DUB,phase1/41/2][w:5]Этот танец[w:1] \nнапоминает мне[w:1] \nо прошлом,[w:5] что \nбеспощадно \nулизнуло[waitall:4][w:3]...", "[func:LostKidFace,sobbing_close,-][func:DUB,phase1/41/3][w:5]У меня больше нет \nни[w:2] до[w:2]ма,[w:10][func:LostKidFace,sobbing,+] \nни[w:2] семьи,[w:12][func:LostKidFace,sobbing_upsmile,+] \nни цели [w:1]в [w:1]жизни[waitall:4][w:3]...", "[func:NoMercy1][func:DUB,phase1/41/4][w:5]И во всём[waitall:4][w:3]...[waitall:1][w:3] [func:closedyesend]\nВиноват[waitall:4][w:3]...[waitall:1][w:5] [func:head]\nТы[waitall:4][w:3]..."} 
			neng={"[func:head4]Our lives flew away \nlike [func:sad]those petals[waitall:4][w:3]...", "[func:head4]This dance reminds \nme about my lost \npast[waitall:4][w:3]...", "I have no home,[w:3] \nno family,[w:3] \nno life goals[waitall:4][w:3]...", "[func:deadly]And this is[waitall:4][w:3]...[waitall:1][w:3] \n[func:closedyesend]all your[waitall:4][w:3]...[waitall:1][w:3] \n[func:head]Fault[waitall:4][w:3]..."}
			engcom="It`s rude to deny your blame."
			ruscom="Невежливо спихивать свои ошибки на других."
			end
			wav={"phase1/buggy2"}
		elseif GetGlobal("progress") == 42 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"[func:head4]Виноват[waitall:4][w:3]...[waitall:1][w:3] [func:NoMercy1]\nДа[waitall:4][w:3]...", "[func:head]Да,[w:3] чёрт возьми!", "А-ха-ха-ха!!", "[func:Think]Я такая дура и \n[func:head]вправду!!", "[func:NoMercy1]Ведь ты[waitall:4][w:3]...[waitall:1][w:3] [func:head]Это ты \nразрушил наш мир[waitall:4][w:3]...[waitall:1][w:3] \n[func:Think]Нет моей вины в \nтом,[w:3] что я не \nсмогла его \nзащитить!", "[func:NoMercy1]Это ты[waitall:4][w:3]...[waitall:1][w:3] [func:head]\nТвоя вина![w:6] \nТвоя вина!!"}
			rus={"[func:head4][func:DUB,phase1/42/1][w:5]Виноват[waitall:3][w:2]...[waitall:1][w:2] [func:NoMercy1]\nДа[waitall:4][w:3]...", "[func:head][func:DUB,phase1/42/2][w:5]Да,[w:3] чёрт[w:2] возьми!", "[func:DUB,phase1/42/3][w:5]А-ха-ха-ха-ха-ха\nха!![w:12]\nХа-ха-ха-ха-ха-ха\nха!!", "[func:Think][func:DUB,phase1/42/4][w:5][speed:0.80]Я такая дура и \n[func:head]вправду!!", "[func:NoMercy1][func:DUB,phase1/42/5][w:5]Ведь ты[waitall:3][w:3]...[waitall:1][w:2] [func:head]Это ты \nразрушил наш мир![w:8] \n[func:Think]Нет моей вины в \nтом,[speed:1.10] что я не \nсмогла его \nзащитить!", "[func:NoMercy1][func:DUB,phase1/42/6][w:5]Это ты[waitall:4][w:3]...[waitall:1][w:3] [func:head][speed:0.85]\nТво[w:2]я[w:2] ви[w:2]на!![w:6]"}
			neng={"[func:head4]Fault[waitall:4][w:3]...[waitall:1][w:3] [func:NoMercy1]\nYa[waitall:4][w:3]...", "[func:head]Yes,[w:3] god damn it!", "A-ha-ha-ha-ha!!", "[func:Think]I'm such a fool,[w:3][func:head] \nreally!!", "[func:NoMercy1]It's you[waitall:4][w:3]...[waitall:1][w:3] [func:head]You have\ndestroyed our world[waitall:4][w:3]...[waitall:1][w:3] \n[func:Think]I'm not the one to \nbe blamed for not \nprotecting it!", "[func:NoMercy1]It's you[waitall:4][w:3]...[waitall:1][w:3] [func:head]\nYour fault![w:6] \nYour fault!!"}
			engcom="Ok,[w:3] now she is chaotic evil."
			ruscom="Окей,[w:3] теперь она хаотично зла."
			end
			wav={"phase1/k_3"}
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
				Encounter.SetVar("evadelevel",5)
			end
		elseif GetGlobal("progress") == 43 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
				Encounter.SetVar("evadelevel",6)
			end
			dodge=false
			block=true
			if GetGlobal("pray")<4 then
				SetGlobal("pray",4)
			end
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"[func:start1][func:head4]Хватит![w:6] [func:trigeredclosed]С меня \nдовольно этих \nдетских игр!!", "Давай,[w:3] покажи,[w:3] \nна что ты способен!", "Я не дам тебе \nпройти дальше![w:6] \nНи [w:3]за [w:3]что!!", "Ты будешь вечно \nумирать и \nвозвращаться,[w:3] \nумирать и \nвозвращаться!", "[func:trigeredclosed]Это мой последний \nоплот!", "[func:Bloodshed][func:trigered]Да начнётся \nкровопролитие!!","[func:MoveToCenter][next]"}
			rus={"[func:start1][func:head4][w:3][func:DUB,phase1.5/1/1][speed:0.93][w:2]Хва[w:2]тит!![w:6] [func:trigeredclosed]С меня[speed:1.05] \nдовольно этих \nдетских и[w:2]гр!", "[func:DUB,phase1.5/1/2][w:5]Давай,[w:3][speed:1.19][func:trigered][func:EpicKnife] покажи, \nна что ты способен!", "[func:DUB,phase1.5/1/3][w:5]Я не дам тебе \nпройти дальше![w:6] \nНи [w:2]за[w:2] что!!", "[func:DUB,phase1.5/1/4][w:5]Ты будешь вечно \nумирать и \nвозвращаться,[w:3] \nумирать и \nвозвращаться!", "[func:trigeredclosed][func:DUB,phase1.5/1/5][w:5]Это мой[w:1] последний \nоплот!", "[func:Bloodshed][func:trigered][func:DUB,phase1.5/1/6][w:5][speed:0.89]Да начнётся \nкровопроли[w:1]тие!!","[func:MoveToCenter][next]"}
			neng={"[func:start1][func:head4]Enough![w:6] [func:trigeredclosed]I'm done \nwith all those \nchild play!!", "Common,[w:3][func:trigered][func:EpicKnife] show me \nwhat you have got!", "I will not let \nyou pass![w:6] \nNever!!", "You will endlessly \ndie and return,[w:3] \ndie and return!", "[func:trigeredclosed]This is my last \nstand!", "[func:Bloodshed][func:trigered]Let the bloodshed \nbegin!!","[func:MoveToCenter][next]"}
			engcom="So she wants to play hard[waitall:4][w:3]...[waitall:1][w:3] \nOkay,[w:3] daddy."
			ruscom="Значит,[w:3] она хочет сыграть по-взрослому[waitall:4][w:3]...[waitall:1][w:3] \nХорошо,[w:3] папик."
			end
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
				Encounter.SetVar("phase",1.5)
			end
			wav={"phase1.5/easy"}
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
				Encounter.SetVar("globalstage","3")
				Encounter.Call("WriteSavio")
			end
			Encounter.SetVar("ghostsnow",{"Asriel_Sprite"})
		elseif GetGlobal("progress") == 44 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"Ты даже \nпредставить себе \nне можешь,[w:3] каково \nэто!", "Ты просто ведёшь \nсебя как кусок \nдерьма!", "[func:trigeredrem]Каждый раз ты \nвтаптываешь меня \nи мой мир в грязь!", "[func:trigered]Да ты сам кусок \nжалкой и мерзкой \nгрязи!!"}
			rus={"[func:DUB,phase1.5/2/1][w:5]Ты даже \nпредставить себе \nне можешь, каково[w:1] \nэто!", "[func:DUB,phase1.5/2/2][w:5]Ты просто ведёшь \nсебя как[w:1] кусок \nдерьма!", "[func:trigeredrem][func:DUB,phase1.5/2/3][w:5][speed:0.80]Каждый раз[speed:0.89] ты \nвтаптываешь меня \nи мой мир в грязь!", "[func:trigered][func:DUB,phase1.5/2/4][w:5][speed:0.86]Да ты сам[w:1] [speed:0.93]кусок [w:1]\nжалкой [w:1]и мерзкой \nгрязи!"}
			neng={"You can't even \nimagine how it \nfeels!", "You're acting like a \ndouche bag!", "[func:trigeredrem]Every time you`re \nbumping me into \nthe mud!", "[func:trigered]But you're the pity \nand ugly dirt as well!!"}
			engcom="She's not kidding now![w:6] Don't be distracted,[w:3] exhaust her!"
			ruscom="Она не шутит![w:6] Не отвлекайся,[w:3] надо её измотать!"
			end
			wav={"phase1.5/BroFight"}
			Encounter.SetVar("ghostsnow",{"Toriel_Sprite","Asgore_Sprite"})
		elseif GetGlobal("progress") == 45 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"Я доверяла не тому \nчеловеку!", "[func:trigeredrem]Может,[w:3] мне вообще \nникому не стоило \nдоверять!", "Все одинаковые![w:6] [func:trigeredclosed]\nЛживые и наивные \nидиоты!", "Никого не волнует,[w:3] \nчто я чувствую! [w:6][func:trigered]\nС меня хватит!!"}
			rus={"[func:DUB,phase1.5/3/1][w:5][speed:0.92]Я доверяла не тому \nчеловеку!", "[func:trigeredrem][func:DUB,phase1.5/3/2][w:5]Может,[w:6] мне[speed:1.09] вообще \nникому не стоило \nдоверять?", "[func:DUB,phase1.5/3/3][w:5][speed:0.85]Все одинаковые.[w:6] [func:trigeredclosed]\nЛживые[w:1] и наивные \nидио[w:1]ты!", "[func:DUB,phase1.5/3/4][w:5][speed:1.10]Никого не волнует, \nчто я чувствую. [w:8][func:trigered][speed:0.90]\nС меня хва[w:1]тит!!"}
			neng={"I trusted the wrong \nperson!", "[func:trigeredrem]Maybe I shouldn't \ntrust anyone!", "They all are the \nsame![w:6] [func:trigeredclosed]\nLying and naive \nidiots!", "No one bothers how \nI feel![w:6] [func:trigered]\nI am done!!"}
			engcom="Burned skin chilling to the bone."
			ruscom="Ожоги прожигают твои кости."
			end
			wav={"phase1.5/firehell"}
			Encounter.SetVar("ghostsnow",{"Alphys_Sprite","Muffet_Sprite","Undyne_Sprite"})
		elseif GetGlobal("progress") == 46 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"[func:trigeredclosed]Мне не стоило ни к \nкому привязываться!", "Завести питомца?![w:9] [func:trigeredrem]\nЗачем?!", "[func:trigeredclosed]Дружить с \nмонстрами?![w:9] \nКак же я была глупа!", "[func:trigered]Все,[w:3] все вы \nодинаковые!", "Никто не понимает \nменя![w:9] \nИ не пытается!"}
			rus={"[func:trigeredclosed][func:DUB,phase1.5/4/1][w:5]Мне не стоило [speed:1.10]ни к \nкому привязываться!", "[func:DUB,phase1.5/4/2][w:5][speed:0.90]Завести питомца?[w:8] [func:trigeredrem]\nЗа[w:2]чем?!", "[func:trigeredclosed][func:DUB,phase1.5/4/3][w:5]Дружить с \nмонстрами?![w:9][speed:0.88] \nКак же я была глупа!", "[func:trigered][func:DUB,phase1.5/4/4][w:5]Все,[w:12] все[w:2] вы[w:1] \nодина[w:2]ковые!", "[func:DUB,phase1.5/4/5][w:5]Ни[w:2]кто[w:1] не понимает \nменя![w:9] \nИ [w:1]не[w:1] пыта[w:2]ет[w:1]ся!"}
			neng={"[func:trigeredclosed]I shouldn't get \nattached to \nanyone!", "Having a pet?![w:9] [func:trigeredrem]\nFor what?!", "[func:trigeredclosed]Befriending with \nmonsters?![w:9] \nI was so damn \nfoolish!", "[func:trigered]You all are the same!", "No one understands \nme,[w:3] you didn't even \ntry to!"}
			engcom="I feel the aroma of rotten blood[waitall:4][w:3]...[waitall:1][w:3]\nWe're at our limit,[w:3] actor."
			ruscom="Я чувствую запах гниющей крови[waitall:4][w:3]...[waitall:1][w:3]\nМы на пределе,[w:3] актер."
			end
			wav={"phase1.5/spidercombo"}
			Encounter.SetVar("ghostsnow",{"Paps_Sprite","Sans_Sprite","Flowey_Sprite"})
		elseif GetGlobal("progress") == 47 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"Знаешь,[w:3] как я сюда \nпопала?![w:6] \n[func:trigeredclosed]Я сбежала!", "Сбежала от пожара,[w:3] \nкоторый сама же и \nустроила!", "[func:trigered]Да,[w:3] твою мать,[w:3] \nя спалила свою \nродную деревню![w:6] \nДотла!![w:6] \nДо тлеющих трупов!!!"}
			rus={"[func:DUB,phase1.5/5/1][w:5]Знаешь, как я сюда \nпопала?![w:8][speed:0.85] \n[func:trigeredclosed]Я сбе[w:1]жа[w:1]ла!", "[func:DUB,phase1.5/5/2][w:5]Сбежала от пожара,[w:1] \nкоторый сама же и[w:1] \nустроила!", "[func:trigered][func:DUB,phase1.5/5/3][w:5][speed:0.90]Да, твою мать, \nя[speed:1.00] спалила свою \nродную деревню![w:7][speed:0.88] \nДотла!![w:6] \nДо [w:1]тлеющих трупов!!"}
			neng={"Do you wanna know \nhow I appeared \nhere?![w:6] [func:trigeredclosed]I ran away!", "I ran away from \nthe fire,[w:3] that \nI began!", "[func:trigered]Yes,[w:3] dammit,[w:3] I \nburned down my own \nvillage![w:6] \nTo the last building!![w:6] \nTo the very burned \ncorpse!!!"}
			end
			dodge=true
			block=false
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			engcom="She[waitall:4][w:3]...[waitall:1][w:3] She [waitall:2][w:3]WHAT?!"
			ruscom="Она[waitall:4][w:3]...[waitall:1][w:3] она [waitall:2][w:3]ЧТО?!"
			end
			wav={"phase1.5/FullBloom"}
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
				Encounter.SetVar("evadelevel",2)
			end
		elseif GetGlobal("progress") == 48 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"[func:trigeredclosed]Да,[w:3] ты правильно \nрасслышал!", "[func:trigered]Я ненавидела их![w:6] \nЯ хотела им смерти!", "[func:trigeredclosed]У меня было всё,[w:3] но \nв один момент жизнь \nотобрала у меня \nэто!", "Семью,[w:3] свободу,[w:3] \nжелание жить!", "Когда весь мой мир,[w:3] \nмоя деревня \nсгорела,[w:3] \nя сбежала \nв Подземелье!", "Раньше я мечтала,[w:3] \nчто покажу миру,[w:3] \nкакие монстры \nдобрые[waitall:4][w:3]...", "[func:trigered]А они -[w:6] ничем не \nлучше людей![w:6] [func:trigeredrem]Они \nхотели меня убить,[w:3] \nпотому что я \nчеловек!", "[func:trigeredclosed]Я ни человек,[w:3] ни \nмонстр!","Я[waitall:4][w:3]...[waitall:1][w:3] \nЯ [waitall:2]Д е м о н,[waitall:1][w:3] \n[func:trigered]понимаешь?!", "Вот моя сущность!"}
			rus={"[func:trigeredclosed][func:DUB,phase1.5/6/1][w:4]Да,[w:2][speed:1.15] ты правильно \nрасслышал!", "[func:trigered][func:DUB,phase1.5/6/2][w:5][speed:0.86]Я ненавидела их![w:8][speed:0.80] \nЯ хотела им сме[w:2]рти!", "[func:trigeredclosed][func:DUB,phase1.5/6/3][w:5]У меня было всё,[w:8] но \nв один [speed:1.09]момент жизнь \nотобрала у меня \nэто!", "[func:DUB,phase1.5/6/4][w:5][speed:0.93]Семью,[w:4] свобо[w:1]ду,[w:1] \nжела[w:1]ние[w:1] жить!", "[func:DUB,phase1.5/6/5][w:5]Когда весь мой мир,[w:3] \nмоя деревня \nсгорела,[w:7][speed:0.90] \nя сбежала \nв Подземелье.", "[func:DUB,phase1.5/6/6][w:5][speed:1.09]Раньше я мечтала,[w:1][speed:1.15] \nчто покажу миру,[speed:1.09] \nкакие монстры \nдо[w:1]брые[waitall:4][w:3]...", "[func:DUB,phase1.5/6/7][w:5][func:trigered][speed:0.90]А они ничем не \nлучше людей![w:6] [func:trigeredrem]Они \nхотели меня убить,[w:1][speed:0.94] \nпотому что я \nчеловек!", "[func:trigeredclosed][func:DUB,phase1.5/6/8][w:6][speed:0.85]Я[w:1] ни человек,[w:4] ни \nмонстр!", "[func:DUB,phase1.5/6/9][w:5]Я[waitall:3][w:3]...[waitall:1][w:2][speed:0.89] \nЯ[w:2] Д е м о н,[w:2][speed:1.15] \n[func:trigered]понимаешь?!", "[func:DUB,phase1.5/6/10][w:5]Вот[w:2] моя[w:2] сущ[w:2]ность!"}
			neng={"[func:trigeredclosed]Yes,[w:3] you heard well!", "[func:trigered]I hated them![w:6] \nI wanted them to die!", "[func:trigeredclosed]I had everything I \ncould dream of,[w:3] but \nlife destroyed them \nall!", "My family,[w:3] my \nfreedom,[w:3] my life will!", "When my entire world,[w:3] \nmy dear village \nburned to the ashes,[w:3] \nI went to \nUnderground", "Not so long before \nthe Fall I thought \nmonsters would be \nnice and caring[waitall:4][w:3]...", "[func:trigered]But they were the \nsame as humans![w:6] [func:trigeredrem]\nThey wanted to kill \nme just because I am \nhuman!", "[func:trigeredclosed]But I am not the \nhuman,[w:3] neither the \nmonster!", "I am[waitall:4][w:3]...[waitall:1][w:3] \nI am the D e m o n,[w:3] [func:trigered]\nyou get it?!", "That's who I am!"}
			engcom="[waitall:4][w:3]...[waitall:1][w:3]She is exhausted."
			ruscom="[waitall:4][w:3]...[waitall:1][w:3]Она вымоталась."
			Encounter.SetVar("evadelevel",2)
			end
			block=false
			dodge=true
			wav={"phase1.5/bereadytodie"}
		elseif GetGlobal("progress") == 49 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
				Encounter.SetVar("evadelevel",2)
				Encounter.SetVar("SuddenStrike",true)
				Encounter.SetVar("CharaIsRaging",false)
			end
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"[noskip][func:trigeredclosed]И теперь[waitall:4][w:3]...", "[noskip][func:head4][func:NoEpicKnife][func:lowpitchmusic]Я не знаю,[w:3] \nзачем я живу[waitall:4][w:3]...", "[noskip]Я[waitall:4][w:3]...[waitall:1][w:3] я больше не \nхочу жить[waitall:4][w:3]...[waitall:1][w:3] \nжить [waitall:2][w:3]так[waitall:4][w:3]...", "[noskip][func:tired][waitall:2][w:5]Я просто хочу \nпокоя[waitall:4][w:3]..."}
			rus={"[noskip][func:trigeredclosed][func:DUB,phase1.5/7/1][w:6][speed:0.70]И[w:1] теперь[waitall:4][w:3]...", "[noskip][func:DUB,phase1.5/7/2][w:10]Я[w:4].[w:4].[w:4].[w:9][func:head4][func:NoEpicKnife][func:lowpitchmusic][speed:0.91] я не знаю,[w:1] \nзачем я живу[waitall:4][w:3]...", "[noskip][func:DUB,phase1.5/7/3][w:8]Я[waitall:4][w:3]...[waitall:1][w:3][speed:0.90] я больше не[w:1] \nхочу[w:2] жить[waitall:3][w:2]...[waitall:1][w:2] \nЖить [waitall:2][w:3]та[w:2]к[waitall:4][w:3]...", "[noskip][func:tired][speed:0.50][func:DUB,phase1.5/7/4][w:6]Я про[w:1]сто[w:1] хочу \nпо[w:1]ко[w:2]я[waitall:4][w:3]..."}
			neng={"[noskip][func:trigeredclosed]And now[waitall:4][w:3]...", "[noskip][func:head4][func:NoEpicKnife][func:lowpitchmusic]I don't even know \nwhy do I still live[waitall:4][w:3]...", "[noskip]I[waitall:4][w:3]...[waitall:1][w:3] I don't wanna \nlive[waitall:4][w:3]...[waitall:1][w:3] \nlive like [waitall:2][w:3]that[waitall:1][w:3] \nanymore.", "[noskip][func:tired][waitall:2][w:5]I just want peace[waitall:4][w:3]..."}
			engcom="The time has come,[w:3] actor![w:6] \nImpact her!"
			ruscom="Сейчас,[w:3] актер![w:6] Нападай!"
			end
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
				Encounter.SetVar("FightGoes",2)
			end
			wav={"nothing"}
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
				Encounter.SetVar("globalstage","4")
				Encounter.Call("WriteSavio")
				Encounter.SetVar("phase",2)
			end
			dodge=false
		elseif GetGlobal("progress") == 50 then
			nrus={"[func:thoughts]Кгха!", "[waitall:2][func:Cough1]*кашель*", "[func:SetMusic,star]Ты[waitall:4][w:3]...[waitall:1][w:3] ты что,[w:3] \nранил меня[waitall:4][w:3]?..", "[func:head4]Я[waitall:4][w:3]...\n[waitall:1][w:3]Кха[waitall:4][w:3]...[waitall:1][w:3] \nНе может быть[waitall:4][w:3]...","[func:thoughts][func:MoveToCenter][next]"}
			rus={"[func:thoughts][func:DUB,phase2/1/1][w:6][speed:2.80]Кгха!", "[func:DUB,phase2/1/2][w:5]*к[w:4]аш[w:4]е[w:7]ль*", "[func:SetMusic,star][func:DUB,phase2/1/3][w:5]Ты[waitall:3][w:2]...[waitall:1][w:2] ты что,[w:9] \nра[w:2]нил [w:1]меня[waitall:4][w:3]?..", "[func:head4][func:DUB,phase2/1/4][w:5]Я[waitall:4][w:3]...\n[waitall:1][w:3]Кха[waitall:3][w:3]...[waitall:1][w:2] \nНе может быть[waitall:4][w:3]...","[func:thoughts][func:MoveToCenter][next]"}
			neng={"[func:thoughts]Ghah!", "[waitall:2][func:Cough1]*cough*", "[func:SetMusic,star]Did you[waitall:4][w:3]...\n[waitall:1][w:3]Did you just \nwound me[waitall:4][w:3]?..", "[func:head4]But I[waitall:4][w:3]...\n[waitall:1][w:3]Gha[waitall:4][w:3]...\n[waitall:1][w:3]But it can't be[waitall:4][w:3]...","[func:thoughts][func:MoveToCenter][next]"}
			engcom="She is wounded!"
			ruscom="Она ранена!"
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
				Encounter.SetVar("evadelevel",6)
			end
		elseif GetGlobal("progress") == 51 then
			nrus={"Я[waitall:4][w:3]...[waitall:1][w:3] [func:head4]Я \nотвлеклась[waitall:4][w:3]?..", "[func:Final_7]И получила по \nзаслугам,[w:3] \nконечно[waitall:4][w:3]...", "[waitall:4][w:3]...", "[noskip][func:NoMercy1][func:SetMusic,none]Но даже если так[waitall:4][w:3]...[waitall:1][w:3]\n[func:head][func:Music2]Наш вопрос ещё не \nзакрыт."}
			rus={"[func:DUB,phase2/2/1][w:5]Я[waitall:4][w:3]...[waitall:1][w:3] [func:head4]\nОтвлеклась[waitall:4]?..", "[func:Final_7][func:DUB,phase2/2/2][w:5][speed:1.15]И получила по \nзаслугам,[w:5] \nконечно[waitall:4][w:3]...", "[waitall:4][w:3]...", "[noskip][func:NoMercy1][func:SetMusic,none][func:DUB,phase2/2/3][w:5]Но[w:1] даже[w:1] если так[waitall:3][w:3]...[waitall:1][w:2][speed:0.98]\n[func:head][func:Music2]Наш вопрос ещё не \nзакрыт."}
			neng={"Did I[waitall:4][w:3]...[waitall:1][w:3] [func:head4]\nDid I slip[waitall:4][w:3]?..", "[func:Final_7]And got punished \nfor that,[w:3] of \ncourse[waitall:4][w:3]...", "[waitall:4][w:3]...", "[noskip][func:NoMercy1][func:SetMusic,none]But even so[waitall:4][w:3]...[waitall:1][w:3] \n[func:head][func:Music2]We still have \nunanswered \nquestions."}
			engcom="What is she talking about?[w:6]\nI have all answers."
			ruscom="О чём она говорит?[w:6]\nМне всё предельно ясно."
			wav={"phase2/netkonzaidejam"}
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
				Encounter.SetVar("FightGoes",true)
			end
		elseif GetGlobal("progress") == 52 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"[func:NoMercy1]Да,[w:3] ты,[w:3] наверное,[w:3] \nне понимаешь,[w:3] но[waitall:4][w:3]...", "[func:Think]Разве ты не хочешь \nопять уничтожить \nмир?", "[func:NoMercy1]Да,[w:3] ведь это твоя \nпервоначальная \nцель[waitall:4][w:3]...", "[func:head]Твоя [waitall:2][w:3]<миссия>[waitall:4][w:3]..."}
			rus={"[func:NoMercy1][func:DUB,phase2/3/1][w:5]Да,[w:3][speed:1.15] ты, наверное, \nне понимаешь,[w:1] но[waitall:4][w:3]...", "[func:Think][func:DUB,phase2/3/2][w:5][speed:1.10]Разве ты не хочешь \nопять уничтожить \nмир?", "[func:NoMercy1][func:DUB,phase2/3/3][w:5]Да,[w:3] ведь это твоя \nпервоначальная \nцель[waitall:4][w:3]...", "[func:head][func:DUB,phase2/3/4][w:5][speed:0.75]Твоя [speed:0.45][w:3]'[w:6]миссия'[w:3][waitall:4][w:4]..."}
			neng={"[func:NoMercy1]Yes,[w:3] probably,[w:3] \nyou don't get it,[w:3] \nbut[waitall:4][w:3]...", "[func:Think]Aren't you going \nto destroy world \nonce again?", "[func:NoMercy1]Yes,[w:3] cuz' that's \nyour utter goal[waitall:4][w:3]...", "[func:head]Your [waitall:2][w:3]<quest>[waitall:4][w:3]..."}
			engcom="Ah yes[waitall:4][w:3]...[waitall:1][w:3] Almost forgot."
			ruscom="Ах да[waitall:4][w:3]...[waitall:1][w:3] Совсем запамятовал."
			end
			wav={"phase2/k_1"} 
		elseif GetGlobal("progress") == 53 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"[func:Bad]Но не думай,[w:3] что \nя сдалась[waitall:4][w:3]...[waitall:1][w:3] \n[func:Final_7]Я истекаю кровью и,[w:3] \nвероятно,[w:3] долго не \nпроживу,[w:3] но[waitall:4][w:3]...", "[noskip][func:ToAngry][waitall:4][w:3]...[w:600][next] " , "[noskip][func:GetsAngry]У меня всё ещё \nесть силы дать \nтебе отпор!", "[func:NoMercy1]Если я и не \nчеловек,[w:3] и не \nмонстр[waitall:4][w:3]...[waitall:1][w:3]","[func:angry]Тогда мне,[w:3] как \nДемону,[w:3] положено \nдраться до \nпоследней капли \nкрови!", "Я положу тебе \nконец,[waitall:2][w:3][func:GiveCurse]проклятая \nкровь!"}
			rus={"[func:Bad][func:DUB,phase2/4/1][w:5]Но не думай, что \nя сдалась[waitall:3][w:2]...[waitall:1][w:2] \n[func:Final_7]Я истекаю кровью и,[w:3] \nвероятно,[w:1] долго не \nпроживу,[w:1] но[waitall:4][w:3]...", "[noskip][func:ToAngry][waitall:4][w:3]...[w:600][next] " , "[noskip][func:GetsAngry][func:DUB,phase2/4/2][w:8][speed:0.90]У меня всё ещё \nесть силы дать \nтебе отпор!", "[func:NoMercy1][func:DUB,phase2/4/3][w:5]Если я и не \nчеловек,[w:3] и не \nмонстр[waitall:4][w:3]...[waitall:1][w:3]","[func:angry][func:DUB,phase2/4/4][w:5]Тогда мне,[w:1] как \nДемону,[w:1] положено \nдраться до \nпоследней[speed:1.15] капли \nкрови!", "[func:DUB,phase2/4/5][w:7]Я положу тебе \nконец,[w:1][func:GiveCurse] проклятая \nкровь!"}
			neng={"[func:Bad]But don't you think \nI already gave up[waitall:4][w:3]?..[waitall:1][w:3] \n[func:Final_7]I am bleeding and,[w:3] \nmaybe,[w:3] will not live \nfor long,[w:3] but[waitall:4][w:3]...", "[noskip][func:ToAngry][waitall:4][w:3]...[w:600][next] ", "[noskip][func:GetsAngry]I still have powers \nto resist you!", "[func:NoMercy1]If I'm neither human \nnor monster[waitall:4][w:3]...[waitall:1][w:3] ","[func:angry]Then,[w:3] as a Demon,[w:3] \nI should fight 'til \nlast drop of my \nblood!", "I will end you,[waitall:2][w:3]\n[func:GiveCurse]cursed blood!"}
			engcom="Damn![w:6] Chainsaw has broken![w:6]\nBe careful,[w:3] i sense a strong curse[waitall:4][w:3]...[waitall:1][w:3]"
			ruscom="Чёрт![w:6] Бензопила замкнулась![w:6]\nОсторожнее,[w:3] я чувствую сильную порчу[waitall:4][w:3]...[waitall:1][w:3]"
			else
				GiveCurse()
			end
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
				Encounter.SetVar("chainsaw",false)
			end
			wav={"phase2/HARD"}
		elseif GetGlobal("progress") == 54 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"[func:NoMercy1]Вместе с моей \nкровью вытекает и \nискусственная \nРешимость[waitall:4][w:3]...", "[func:head4]Очевидно,[w:3] что я \nбольше не соперник \nтебе.[w:6] [func:BADsad]Я потеряла \nвозможность.", "[func:NoMercy1]Но если я смогу \nтебя убить[waitall:4][w:3]...[waitall:1][w:3] \n[func:angry]Я смогу оттолкнуть \nтебя назад.", "Задержать тебя."}
			rus={"[func:DUB,phase2/5/1][w:5][func:NoMercy1]Вместе с моей \nкровью вытекает[speed:1.15] и \nискусственная \nРешимость[waitall:4][w:3]...", "[func:head4][func:DUB,phase2/5/2][w:5][speed:1.10]Очевидно,[w:2] что я \nбольше не соперник \nтебе.[w:7] [func:BADsad][speed:0.78]Я[w:2] потеряла \nвозможность.", "[func:NoMercy1][func:DUB,phase2/5/3][w:5]Но если я смогу \nтебя убить[waitall:4][w:3]...[waitall:1][w:2] \n[func:angry]Я смогу оттолкнуть[speed:1.1ы5] \nтебя назад.", "[func:DUB,phase2/5/4][w:5][speed:0.90]Задержать[w:1] тебя."}
			neng={"[func:NoMercy1]I'm losing artificial \nDetermination with \nmy blood[waitall:4][w:3]...", "[func:head4]It's obvious,[w:3] I am \nno longer an equal \nto you.[w:6] [func:BADsad]I lost the \nopportunity.", "[func:NoMercy1]But if I can kill you[waitall:4][w:3]...[waitall:1][w:3] \n[func:angry]I will push you back.", "I will put you on hold."}
			engcom="This won`t happen,[w:3] naive fool.[w:6]\nI have already won."
			ruscom="Этому не бывать,[w:3] наивная дура.[w:6]\nЯ уже победил."
			end
			wav={"phase2/knives4"}
		elseif GetGlobal("progress") == 55 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"[func:head4]Я просто[waitall:4][w:3]...[waitall:1][w:3] [func:BADsad]Просто \nхочу,[w:3] чтобы в мои \nпоследние минуты \nя ни о чем не \nсожалела.", "[func:head4]Ты понимаешь,[w:3] \n[func:BADthoughts]каково это?", "[func:head4]Когда твой мир \nускользает от тебя,[w:3] \nи ты остаёшься \nодна[waitall:4][w:3]...[waitall:1][w:3] [func:deadly]в темноте[waitall:4][w:3]..."}
			rus={"[func:head4][func:DUB,phase2/6/1][w:5]Я[w:2] просто[waitall:4][w:3]...[waitall:1][w:3] [func:BADsad]Просто \nхочу, чтобы в мои \nпоследующие минуты \nя ни о чем не \nсожалела.", "[func:head4][func:DUB,phase2/6/2][w:5]Ты понимаешь, \n[func:BADthoughts]каково это?", "[func:deadly][func:DUB,phase2/6/3][w:5]Когда твой мир \nускользает от тебя, \nи ты остаёшься \nодна[waitall:4][w:3]...[waitall:1][w:3]"}
			neng={"[func:head4]I just[waitall:4][w:3]...[waitall:1][w:3] [func:BADsad]I just wanted \nto have no regrets \nin last minutes \nof my life.", "[func:head4]Do you even \nunderstand [func:BADthoughts]this \nfeeling?", "[func:head4]Felling when entire \nworld is slipping and \nyou find yourself \nin the darkness[waitall:4][w:3]...[waitall:1][w:3] \n[func:deadly]all alone[waitall:4][w:3]..."}
			engcom="Stop this fuss[waitall:4][w:3]...[waitall:1][w:3]\nDeath never was an option for two of us."
			ruscom="Хватит драматизировать[waitall:4][w:3]...[waitall:1][w:3]\nСмерть [w:3]-[w:3] это роскошь для нас."
			end
			wav={"phase2/StayLow"}
		elseif GetGlobal("progress") == 56 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"[func:Peachy]Хех[waitall:4][w:3]...[waitall:1][w:3] Хах[waitall:4][w:3]...", "[func:BADsmart]Извини,[w:3] я просто \nподумала,[w:3] как \nвойдёт эта битва в \nисторию[waitall:4][w:3]...", "[func:Peachy]Дуэль,[w:3] которой не \nдолжно было быть[waitall:4][w:3]...", "Битва двух \nаномалий[waitall:4][w:3]...[waitall:1][w:3] [func:BADRemember]\nЭто так красиво \nзвучит[waitall:4][w:3]..."}
			rus={"[func:Peachy][func:DUB,phase2/7/1][w:5]Хе[w:1]хе[waitall:4][w:3]...[waitall:1][w:3] Е[w:1]хехе[waitall:4][w:3]...", "[func:BADsmart][func:DUB,phase2/7/2][w:7][speed:0.90]Извини,[w:9] я просто[speed:1.15] \nподумала,[w:1] как эта \nбитва войдёт в \nисторию[waitall:4][w:3]...", "[func:Peachy][func:DUB,phase2/7/3][w:5]Дуэль,[w:3] которой не \nдолжно было быть[waitall:4][w:3]...", "[func:DUB,phase2/7/4][w:5][speed:0.85]Битва двух \nаномалий[waitall:3][w:3]...[waitall:1][w:2] [func:BADRemember][speed:0.84]\nЭто так красиво \nзвучит[waitall:4][w:3]..."}
			neng={"[func:Peachy]Hehe[waitall:4][w:3]...[waitall:1][w:3] Ahah[waitall:4][w:3]...", "[func:BADsmart]Sorry,[w:3] I thought for \na moment,[w:3] how \nhistory has its \neyes on us[waitall:4][w:3]...", "[func:Peachy]This is duel that \nshouldn't have \nhappened[waitall:4][w:3]...", "Battle of two \nanomalies[waitall:4][w:3]...[waitall:1][w:3] [func:BADRemember]\nThis sounds so \npoetic[waitall:4][w:3]..."}
			engcom="She is losing herself[waitall:4][w:3]...[waitall:1][w:3]\nShe has no strength.[w:3] Cut out this nonsense"
			ruscom="Она бредит[waitall:4][w:3]...[waitall:1][w:3]\nСилы покидают её.[w:3] Кончай этот балаган."
			end
			wav={"phase2/BadKnifes"}
		elseif GetGlobal("progress") == 57 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			neng={"[func:head4][waitall:4][w:3]...", "I no longer hear \nvoices[waitall:4][w:3]...[waitall:1][w:3] [func:BADsad]They have \ndisappeared.", "[func:head4]I hear only the beat \nof my heart which \nit stealing leftovers \nof my oxygen[waitall:4][w:3]...", "[waitall:2][func:Cough1]*hard [w:8][func:Cough2]coughing*[w:9] [func:head4]\nDammit[waitall:4][w:3]...[waitall:1][w:3] \n[func:BADweak]I have no time left[waitall:4][w:3]..."}
			nrus={"[func:head4][waitall:4][w:3]...", "Я больше не слышу \nголоса[waitall:4][w:3]...[waitall:1][w:3] [func:BADsad]Они \nзатихли[waitall:4][w:3]...", "[func:head4]Лишь стук моего \nумирающего сердца \nпродолжает жадно \nотбирать мой \nкислород[w:4].[w:4].[w:4].[w:4]", "[waitall:2][func:Cough1]Кхах[w:4].[w:4].[w:4].[w:4] [func:Cough2][waitall:2]Кха-кха![w:9][waitall:1] [func:head4]\nЧёрт[w:4].[w:4].[w:4].[w:4] \n[func:BADweak]У меня совсем не \nосталось времени[w:4].[w:4].[w:4].[w:4]"}
			rus={"[func:head4][func:DUB,prolog2/f][waitall:4][w:3]...", "[func:DUB,phase2/8/1][w:5]Я[w:1] больше[w:1] не слышу \nголоса[waitall:4][w:3]...[waitall:1][w:3] [func:BADsad]Они[w:2] \nзатихли[waitall:4][w:3]...", "[func:head4][func:DUB,phase2/8/2][w:5][speed:1.09]Лишь[w:2] стук моего[w:1] \nумирающего[w:1] сердца[w:1] \nпродолжает жадно \nотбирать[w:1] мой \nкислород[w:4].[w:4].[w:4].[w:4]", "[func:Cough1][func:DUB,phase2/8/3][speed:1.70][w:6]Кхах.[w:4].[w:4].[w:7] [func:Cough2]Кха-[w:5]кха.[w:4].[w:4].[w:8] [speed:1.05][func:head4]\nЧёрт[w:3].[w:3].[w:3].[w:3] \n[func:BADweak]У меня совсем не \nосталось времени[w:4].[w:4].[w:4].[w:4]"}
			engcom="Good point."
			ruscom="Хорошо подмечено."
			end
			wav={"phase2/AllAround"}
		elseif GetGlobal("progress") == 58 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"[func:head4]Знаешь[w:3].[w:3].[w:3].[w:3] После \nстольких смертей[w:3].[w:3].[w:3].[w:3] \n[func:BADsad]Я больше не боюсь \nвида крови[waitall:4][w:3]...", "В детстве я \nненавидела кровь[w:3].[w:3].[w:3].[w:3] \n[func:head4]Меня тошнило при \nвиде неё...", "А сейчас[w:3].[w:3].[w:3].[w:3] [func:Final_7]Всё \nравно,[w:3] что вода на \nладонях[w:3].[w:3].[w:3].[w:3] Только \nочень горячая[waitall:4][w:3]...", "[func:BADIrony]Почти как кипяток[w:3].[w:3].[w:3].[w:3] \n[func:Final_7]Но я не чувствую \nболи[waitall:4][w:3]..."}
			rus={"[func:DUB,phase2/9/1][w:5][func:head4]Знаешь[w:3].[w:3].[w:3].[w:6] После \nстольких смертей[w:3].[w:3].[w:3].[w:3] \n[func:BADsad]Я больше не боюсь \nвида крови[waitall:4][w:3]...", "[func:DUB,phase2/9/2][w:5]В детстве я \nненавидела кровь[w:2].[w:2].[w:2].[w:2] \n[func:head4]Меня тошнило при \nвиде неё[w:3].[w:3].[w:3].[w:3]", "[func:DUB,phase2/9/3][w:5]А сейчас[w:3].[w:3].[w:3].[w:3] [func:Final_7]Всё \nравно, что вода на \nладонях[w:3].[w:3].[w:2].[w:2] Только[w:4] \nочень[w:1] горя[w:2]чая[waitall:4][w:3]...", "[func:BADIrony][func:DUB,phase2/9/4][w:5]Почти[w:1] как[w:1] кипяток[w:3].[w:3].[w:2].[w:2] \n[func:Final_7]Но я не чувствую \nболи[waitall:4][w:3]..."}
			neng={"[func:head4]Ya'know[w:3].[w:3].[w:3].[w:3] After \nso many deaths[w:3].[w:3].[w:3].[w:3] \n[func:BADsad]I no longer fear \nblood[waitall:4][w:3]...", "I hated the sight \nof blood in \nchildhood[w:3].[w:3].[w:3].[w:3] \n[func:head4]I was sick of it[waitall:4][w:3]...", "And now[w:3].[w:3].[w:3].[w:3] [func:Final_7]It's \nalmost like water on \nmy palms[w:3].[w:3].[w:3].[w:3] \nBut very hot[waitall:4][w:3]...", "[func:BADIrony]Almost boiling[w:3].[w:3].[w:3].[w:3] \n[func:Final_7]But I don't feel pain \nat all[waitall:4][w:3]..."}
			engcom="Maybe,[w:3] she is dying at last?[w:6]\nI wouldn`t be against it."
			ruscom="Может,[w:3] она наконец умирает?[w:6]\nЯ был бы не против."
			end
			wav={"phase2/CopyCat"}
		elseif GetGlobal("progress") == 59 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"[func:head4]Ты[w:3].[w:3].[w:3].[w:3] [func:BADweak]всё ещё \nживой[w:3]?[w:3].[w:3].[w:3] [func:head4]Живучий \nоднако[w:3].[w:3].[w:3].[w:3]", "Хотя не исключено,[w:3] \n[func:sad][func:NoCurse]что я уже ослабла \nдаже больше,[w:3] \nчем ты устал[w:3].[w:3].[w:3].[w:3]", "[func:head4]Тогда[w:3].[w:3].[w:3].[w:3] Мне не \nостаётся ничего,[w:3] \nкроме как[w:3].[w:3].[w:3].[w:3]", "[func:angry][func:GiveCurse]Показать свой \n[w:3][waitall:3]максимум."}
			rus={"[func:head4][func:DUB,phase2/10/1][w:6]Ты[w:4].[w:4].[w:4].[w:3] [func:BADweak]всё ещё \nживой[w:3]?[w:3].[w:3].[w:3] [func:head4]Живу[w:2]чий[w:1] \nодна[w:2]ко[w:3].[w:3].[w:3].[w:3]", "[func:DUB,phase2/10/2][w:5]Хо[w:2]тя[w:3].[w:3].[w:3].[w:2] не исключено,[w:1] \n[func:sad][func:NoCurse]что я уже ослабла \nдаже больше, \nчем ты устал[w:3].[w:3].[w:3].[w:3]", "[func:head4][func:DUB,phase2/10/3][w:5]Тогда мне не \nостаётся ничего,[w:1] \nкроме как[w:3].[w:3].[w:3].[w:3]", "[func:angry][func:GiveCurse][func:DUB,phase2/10/4][w:5]Показать свой \nмаксимум."}
			neng={"[func:head4]Are[w:3].[w:3].[w:3].[w:3] [func:BADweak]Are you \nstill alive[w:3]?[w:3].[w:3].[w:3] \n[func:head4]Whatever[w:3].[w:3].[w:3].[w:3]", "Still it could be [func:sad][func:NoCurse]that \nI have weakened \neven more than you \nhave tired[w:3].[w:3].[w:3].[w:3]", "[func:head4]If so[w:3].[w:3].[w:3].[w:3] I have no \nother choice but[w:3].[w:3].[w:3].[w:3]", "[func:angry][func:GiveCurse]But to show you \nmy [w:3][waitall:3]maximum."}
			engcom="What?[w:6] Is it this boring <special attack> again?[w:6]\nNo one fears it this day."
			ruscom="Что?[w:6] Опять её <специальная атака>?[w:6] Никого больше это не пугает,[w:3] дорогуша."
			end
			wav={"phase2/MovingKnifes"}
		elseif GetGlobal("progress") == 60 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			nrus={"[func:Final_7]Я вижу по твоим \nглазам,[w:3] [func:BADBad]что ты \nнедооцениваешь \nменя[w:3].[w:3].[w:3].[w:3] [func:Final_7]Что же,[w:3] это \nк лучшему.", "Когда я умру,[w:3] моя \nдуша расколется[w:3].[w:3].[w:3].[w:3] \n[func:BADsmart]Но остатки \nискусственной \nрешимости не дадут \nей распасться.", "[func:Final_7]Резонанс энергии \nвзорвётся и \nвысвободит мощный \nвсплеск магии.[w:6] \n[func:NoMercy1]И эта атака[w:3].[w:3].[w:3].[w:3]", "[func:angry][speed:0.75]Станет твоей \nпогибелью."}
			rus={"[func:Final_7][func:DUB,phase2/11/1][w:5]Я уже вижу по твоим \nглазам,[w:3] [func:BADBad]что ты \nнедооцениваешь \nменя[w:3].[w:3].[w:3].[w:3] [func:Final_7]Что[w:3] же,[w:9] это \nк лучшему.", "[func:DUB,phase2/11/2][w:5]Когда я умру,[w:1] моя \nдуша раско[w:2]лется.[w:6] \n[func:BADsmart]Но остатки \nискусственной \nрешимости не дадут \nей распасться.", "[func:Final_7][func:DUB,phase2/11/3][w:5]Резонанс энергии \nвзорвётся[w:1] и \nвысвободит [w:1]мощный \nвсплеск [w:1]ма[w:1]гии.[w:10] \n[func:NoMercy1]И[w:1] эта[w:1] ата[w:2]ка[w:3].[w:3].[w:3].[w:3]", "[func:angry][speed:0.75][func:DUB,phase2/11/4][w:5]Станет твоей \nпогибелью."}
			neng={"[func:Final_7]I see it in your \neyes [w:3]- [func:BADBad]you're \nmisjudging me[w:3].[w:3].[w:3].[w:3] \n[func:Final_7]Well,[w:3] that's for \nbetter.", "When I will die,[w:3] my \nsoul will break[w:3].[w:3].[w:3].[w:3] \n[func:BADsmart]But leftovers of \nartificial DT won't \nlet it shred \nto pieces.", "[func:Final_7]Energy collapse will \nblow up in powerful \nmagic strike.[w:6] [func:NoMercy1]And \nthis strike[w:3].[w:3].[w:3].[w:3]", "[func:angry][speed:0.75]Will be my last \nstrike back at \nthis point."}
			engcom="Wait,[w:3] actor,[w:3] i am trying to undestand what she said[waitall:4][w:3]...[waitall:2][w:3]\nOh no."
			ruscom="Погоди,[w:3] актёр,[w:3] я пытаюсь понять,[w:3] что она пытается сказать[waitall:4][w:3]...[waitall:2][w:3]\nО нет."
			end
			wav={"phase2/k_4"} 
		elseif GetGlobal("progress") == 61 then
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
			neng={"[func:NoMercy1]I can't wait for \n[func:BADsmart]this moment to \ncome[waitall:4][w:3]...[waitall:1][w:3]", "When you will die, [func:NoMercy1]we \nwill return to\nbeginning[waitall:4][w:3]...[waitall:1][w:3]" , "[func:NoMercy1]And while you will \nbe losing your goal, \n[func:angry]I will become \ncloser to mine[waitall:4][w:3]...[waitall:1][w:3]", "[func:NoMercy1]If you cared about \nus for a little, you \nwould let me kill you[waitall:4][w:3]...[waitall:1][w:3]\n[func:head4]But now there's no \ngoing back.", "[func:Final_7]Here it is[waitall:4][w:3]...[waitall:1][w:3]", "Last strike.", "I must say[waitall:4][w:3]...[waitall:1][w:3] that[waitall:4][w:3]...[waitall:1][w:3] \nyou was a good \npartner[waitall:4][w:3]...[waitall:1][w:3] somewhere[waitall:4][w:3]...[waitall:1][w:3]\nin another reality[waitall:4][w:3]...", "I am sorry that I[waitall:4][w:3]...[waitall:1][w:3]\n[func:NoCurse]I lost you[waitall:4][w:3]..."}
			nrus={"[func:NoMercy1]Я не могу \nдождаться, [func:BADsmart]когда \nнаступит этот миг[waitall:4][w:3]...[waitall:1][w:3]", "Если ты умрёшь, [func:NoMercy1]то \nмы вернёмся к \nначалу[waitall:4][w:3]...[waitall:1][w:3] И чем \nдальше ты от своей \nцели, [func:angry]тем ближе \nя к своей[waitall:4][w:3]...[waitall:1][w:3]", "[func:NoMercy1]Если бы тебя \nволновал мой мир, \nты бы просто дал \nсебя убить[waitall:4][w:3]...[waitall:1][w:3]\n[func:head4]Но теперь шанс \nупущен.", "[func:Final_7]Вот и настал он[waitall:4][w:3]...[waitall:1][w:3]", "Последний удар.", "Я должна сказать[waitall:4][w:3]...[waitall:1][w:3]\nЧто ты[waitall:4][w:3]...[waitall:1][w:3] был \nхорошим партнёром[waitall:4][w:3]...[waitall:1][w:3]\nКогда-то[waitall:4][w:3]...[waitall:1][w:3] в другой \nреальности[waitall:4][w:3]...[waitall:1][w:3]", "Мне так жаль,  \nчто я[waitall:4][w:3]...[waitall:1][w:3]\n[func:NoCurse][func:TireStand]я потеряла \nтебя[waitall:4][w:3]...[waitall:1][w:3]"}
			rus={"[func:NoMercy1][func:DUB,phase2/12/1][w:5]Я не могу \nдожда[w:1]ться,[w:1] [func:BADsmart]когда \nнаступит этот миг[waitall:4][w:3]...[waitall:1][w:3]", "[func:DUB,phase2/12/2][w:5]Если ты умрёшь, [func:NoMercy1]то \nмы вернёмся к \nначалу[waitall:3][w:2]...[waitall:1][w:2] И чем \nдальше ты от своей[speed:1.09] \nцели, [func:angry]тем ближе \nя к своей[waitall:4][w:3]...[waitall:1][w:3]", "[func:NoMercy1][func:DUB,phase2/12/3][w:5]Если бы тебя \nволновал[w:1] мой мир,[w:1] \nты бы про[w:1]сто дал \nсебя убить[waitall:4][w:3]...[waitall:1][w:3]\n[func:head4]Но [w:1]теперь[w:1] шанс \nупу[w:1]щен.", "[func:Final_7][func:DUB,phase2/12/4][w:5]Вот[w:1] и настал[w:1] он[waitall:4][w:3]...[waitall:1][w:3]", "[func:DUB,phase2/12/5][w:5]По[w:1]сле[w:2]дний удар.", "[func:DUB,phase2/12/6][w:5]Я должна сказать[waitall:4][w:3]...[waitall:1][w:3]\nЧто ты[waitall:4][w:3]...[waitall:1][w:4] был \nхорошим партнёром[waitall:4][w:3]...[waitall:1][w:3]\nКогда-то[waitall:4][w:3]...[waitall:1][w:5] в другой \nреальности[waitall:4][w:3]...[waitall:1][w:3]", "[func:DUB,phase2/12/7][w:5]Мне[w:1] так жаль, \nчто я[waitall:4][w:3]...[waitall:1][w:9]\n[func:NoCurse][func:TireStand]Потеряла \nтебя[waitall:4][w:3]...[waitall:1][w:3]"}
			engcom="Don't listen to her whining,[w:3] darling![w:6] Chainsaw back in action,[w:3] strike her!"
			ruscom="Она давит на жалость![w:6] Не слушай её,[w:3] дорогуша![w:6]\nБензопила завелась,[w:3] [color:8040ff]нападай!"	
			else
				NoCurse()
			end
			Encounter.SetVar("deadlyhit",true)
			if  Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") then
				Encounter.SetVar("chainsaw",true)
				Encounter.SetVar("FightGoes",false)
				Encounter.Call("WriteSavio")
			end
			wav={"nothing"}
		elseif GetGlobal("progress") >= 999 then
			wav= {"laststand"}
			Encounter.SetVar("arenasize", {155, 130})
		end
	end
	if Encounter.GetVar("diff") == 24 then
		--currentdialogue={""}
		--neng={""}
		--rus={""}
		--nrus={""}
		--ruscom={""}
		--engcom={""}
		--State("DEFENDING")
	end
	if weak==true then
		def=30
		weak=false
	end
	local dub=Encounter.GetVar("dubbing")
	if lang=="rus" then
		rus=AddLine(rus,"[novoice]")
		if dub==true then
			currentdialogue=rus
			else
			currentdialogue=nrus
		end
		Encounter.SetVar("comm",ruscom)
		else
		eng=AddLine(eng,"[novoice]")
		currentdialogue=neng
		Encounter.SetVar("comm",engcom)
	end
	if not currentdialogue then
		else
		if goneto<prog and not Encounter.GetVar("dialogSkip") then
			goneto=prog
			Encounter.Call("WriteSavio")
			currentdialogue=EveryDial(currentdialogue,"[noskip][effect:none]","")
			Encounter.SetVar("SkipVoice",false)
			else
			currentdialogue=EveryDial(currentdialogue,"[effect:none]","")
			Encounter.SetVar("SkipVoice",true)
		end
	end
	Encounter.SetVar("arenasize", {155, 130})
	Encounter.SetVar("nextwaves", wav)
	if hp<2 then
		OnDeath()
	end
	if Encounter.GetVar("diff") == 18 and prog > 1 then
		--currentdialogue={""}
		--neng={""}
		--rus={""}
		--nrus={""}
		--ruscom={""}
		--engcom={""}
		--State("DEFENDING")
	end
end

function SetMusic(ingo)
	Encounter.Call("SetMusic",ingo)
end

function SAVEMUSIC()
	Encounter.Call("SetMusic","SAVE1")
	Encounter.SetVar("PlaysIntro",true)
end
--if Encounter ~= nil then
--	if Encounter.GetVar("diff") == 18 and GetGlobal("progress") ~= 1 then
--		currentdialogue={""}
--		neng={""}
--		rus={""}
--		nrus={""}
--		ruscom={""}
--		engcom={""}
--		State("DEFENDING")
--	end
--end
function Betrayel()
end
function Curse()
	SetGlobal("cursed",1)
end
prayheal = 100
-- This handles the commands; all-caps versions of the commands list you have above.
function HandleCustomCommand(command)
    if command == "МОЛИТВА" or command=="PRAY" then
	local pray=GetGlobal("pray")
	local lang=Encounter.GetVar("lang")
	SetGlobal("pray",pray+1)
	if GetGlobal("Song2") == "insane2" then
		if Encounter.GetVar("diff")==13 or Encounter.GetVar("diff")==14 or Encounter.GetVar("diff")==15 or Encounter.GetVar("diff")==17 then
			if lang=="rus" then
				BattleDialog({"[color:8040ff]Что?[w:6] Уже чувствуешь себя неуютно?[w:6]\nНе робей.","Вы вспомнили начало молитвы.[w:6]\n[health:99]Вы восстановили ОЗ."})
			else
				BattleDialog({"[color:8040ff]What?[w:6] Are you already feeling nervous?[w:6]\nStay cool.","You remembered the beginning of a prayer.[w:6]\n[health:99]You restored 99 HP.","You lost 1 MaxHP!"})
			end
			--prayheal=prayheal-5
			Encounter.SetVar("MaxHP", Encounter.GetVar("MaxHP") - 1)
			Player.hp = Encounter.GetVar("MaxHP")
		elseif Encounter.GetVar("diff")==21 then
			if lang=="rus" then
				BattleDialog({"[color:8040ff]Что?[w:6] Уже чувствуешь себя неуютно?[w:6]\nНе робей.","Вы вспомнили начало молитвы.[w:6]\n[health:99]Вы восстановили ОЗ."})
			else
				BattleDialog({"[color:8040ff]What?[w:6] Are you already feeling nervous?[w:6]\nStay cool.","You remembered the beginning of a prayer.[w:6]\n[health:1]You restored 135 HP.","You lost 5 MaxHP!"})
			end
			--prayheal=prayheal-5
			Encounter.SetVar("MaxHP", Encounter.GetVar("MaxHP") - 5)
			Encounter.SetVar("everythingModeTrueMaxHp", Encounter.GetVar("MaxHP"))
			Player.hp = Encounter.GetVar("MaxHP")
		elseif Encounter.GetVar("diff")==12 or Encounter.GetVar("diff")==11 or Encounter.GetVar("diff")==16 then
			if lang=="rus" then
				BattleDialog({"[color:8040ff]Что?[w:6] Уже чувствуешь себя неуютно?[w:6]\nНе робей.","Вы вспомнили начало молитвы.[w:6]\n[health:99]Вы восстановили ОЗ."})
			else
				BattleDialog({"[color:8040ff]What?[w:6] Are you already feeling nervous?[w:6]\nStay cool.","You remembered the beginning of a prayer.[w:6]\n[health:99]You restored 99 HP.","You lost 1 LV!"})
			end
			--prayheal=prayheal-5
			Player.lv=Player.lv-1
			if Player.lv>=20 then
			elseif Player.lv==19 then
				Player.hp = 92
				Encounter.SetVar("MaxHP", 92)
			else
				--Player.hp = Player.hp - 4
				Encounter.SetVar("MaxHP", Encounter.GetVar("MaxHP") - 4)
			end
			Player.hp = Encounter.GetVar("MaxHP")
		elseif pray==0 then
			Encounter.Call("GotAchivement",8)
			local dial={}
			if lang=="rus" then
				dial={"[color:8040ff]Так-так,[w:3] остановись-ка,[w:3] дорогуша.[w:6]\nС каких пор ты взываешь к Богу?","[color:8040ff]Я для тебя больше не авторитет,[w:3] хах[waitall:4][w:3]?..","В любом случае[waitall:4][w:3]... [waitall:1][w:3][color:8040ff]\nКто сказал,[w:3] что Бог услышит твои молитвы[waitall:4][w:3]?..","Тебе это не поможет.[w:6] [color:8040ff]Ты давно отбросил свою веру.\nНе трать наше время на глупости."}
				else
				dial={"[color:8040ff]Well-well,[w:3] stop right there,[w:3] darling.\nSince when are you praying to God?","[color:8040ff]Am I no longer an authority for you,[w:3] huh[waitall:4][w:3]?..","Anyway[waitall:4][w:3]...[waitall:1][w:3][color:8040ff]\nWho said that God will hear your prayers[waitall:4][w:3]?..","This won't help you.[w:6] [color:8040ff]You have lost your faith long time ago.[w:6]\nDon't waste our time on nonsense."}
			end
			local a=Encounter.GetVar("Achivements")
			for i=1,#dial do
				dial[i]="[noskip]"..dial[i]
			end
			if a[8]=="0" then
				dial[#dial]=dial[#dial].."[func:GotAchivement8][w:90]"
			end
			BattleDialog(dial)
			else
			if lang=="rus" then
				BattleDialog("[color:8040ff]Я сказал[waitall:4][w:3]...[waitall:2][w:3] Х в а т и т[w:4].")
				else
				BattleDialog("[color:8040ff]I said[waitall:4][w:3]...[waitall:2][w:3] E n o u g h[w:4].")
			end
		end
		--elseif GetGlobal("curse")>0 then
		--if lang=="rus" then
		--	BattleDialog("Проклятие умылось!")
		--	else
		--	BattleDialog("Proklyatie umilosь!")
		--end
		SetGlobal("judge",true)
		--SetGlobal("CURSE_AWAY",true)
		elseif GetGlobal("Song3") == "devil2" then
			if pray < 99 then
				if lang=="rus" then
					BattleDialog("Ты молишься[waitall:4][w:3]...[w:6][color:8040ff]\n...[waitall:1][w:3]Но никто тебя не услышал.")
				else
					BattleDialog("You pray[waitall:4][w:3]...[w:6][color:8040ff]\n...[waitall:1][w:3][health:20]Max HP increased to 20!")
				end
				--SetGlobal("pray",pray+999)
				Encounter.SetVar("MaxHP",20)
			else
				if lang=="rus" then
					BattleDialog("Ты молишься[waitall:4][w:3]...[w:6][color:8040ff]\n...[waitall:1][w:3]Но никто тебя не услышал.")
				else
					BattleDialog("You pray[waitall:4][w:3]...[w:6][color:8040ff]\n...[waitall:1][w:3]But nobody heard it.")
				end
			end
			
		elseif hp<1490 and Encounter.GetVar("diff")~= 5 and GetGlobal("curse") >= Player.hp then
		if lang=="rus" then
			BattleDialog("Ты молишься[waitall:4][w:3]...[w:6][color:8040ff]\n...[waitall:1][w:3]Но никто тебя не услышал.")
			else
			BattleDialog("You pray[waitall:4][w:3]...[w:6][color:8040ff]\n...[waitall:1][w:3]But nobody heard it.")
		end
		elseif hp<1490 and GetGlobal("curse") < Player.hp and Encounter.GetVar("prog") > 52 then
		if lang=="rus" then
			BattleDialog({"[color:8040ff]Что?[w:6] Уже чувствуешь себя неуютно?[w:6]\nНе робей.","Вы вспомнили начало молитвы.[w:6]\n[health:100]Вы восстановили 99 ОЗ?"})
			else
			BattleDialog({"[color:8040ff]...[w:6] You bare through the curse.[w:6]","You read the prayer[waitall:4][w:3]...[waitall:1][w:3]\n[health:100]You healed to FULL![w:6]\nSort of."})
		end
		Player.Heal(math.ceil((Encounter.GetVar("MaxHP") - Player.hp)))
		Player.hp = Encounter.GetVar("MaxHP")
		 SetGlobal("curse", Encounter.GetVar("MaxHP"))
		elseif pray==0 then
		if lang=="rus" then
			BattleDialog({"[color:8040ff]Что?[w:6] Уже чувствуешь себя неуютно?[w:6]\nНе робей.","Вы вспомнили начало молитвы.[w:6]\n[health:20]Вы восстановили 20 ОЗ."})
			else
			BattleDialog({"[color:8040ff]What?[w:6] Are you already feeling nervous?[w:6]\nStay cool.","You remembered the beginning of a prayer.[w:6]\n[health:20]You restored 20 HP."})
		end
		Encounter.SetVar("cursedwater",true)
		elseif pray==1 then
		if lang=="rus" then
			BattleDialog({"Чара хищно ухмыляется вам в ответ.","Вы читаете молитву[waitall:4][w:3]...[waitall:1][w:3]\n[health:20]Вы восстановили 20 ОЗ."})
			else
			BattleDialog({"Chara smiles predatory down at you.","You read the prayer[waitall:4][w:3]...[waitall:1][w:3]\n[health:20]You restored 20 HP."})
		end
		Encounter.SetVar("cursedwater",true)
		elseif pray==2 then
		if lang=="rus" then
			BattleDialog({"[color:8040ff]Ну хватит уже ныть[waitall:4][w:3]...[waitall:1][w:3]\nТы справишься.","Вы читаете молитву[waitall:4][w:3]...[waitall:1][w:3]\n[health:40]Вы восстановили 40 ОЗ."})
			else
			BattleDialog({"[color:8040ff]C'mon,[w:3] stop whining already[waitall:4][w:3]...[waitall:1][w:3]\nYou can handle it.","You read the prayer[waitall:4][w:3]...[waitall:1][w:3]\n[health:40]You restored 40 HP."})
		end
		Encounter.SetVar("cursedwater",true)
		elseif pray==3 then
		if lang=="rus" then
			BattleDialog({"Кровь сочится из свежих ран[waitall:4][w:3]...[waitall:1][w:3]\nВы читаете молитву[waitall:4][w:3]...[waitall:1][w:3]\n[health:40]Вы восстановили 40 ОЗ."})
			else
			BattleDialog({"Blood spoils from open wounds[waitall:4][w:3]...[waitall:1][w:3]","You read the prayer[waitall:4][w:3]...[waitall:1][w:3]\n[health:40]You restored 40 HP."})
		end
		Encounter.SetVar("cursedwater",true)
		elseif pray==4 then
		if lang=="rus" then
			BattleDialog({"[color:8040ff]Неужели так трудно победить эту истеричку?","Вы читаете молитву[waitall:4][w:3]...[waitall:1][w:3]\n[health:60]Вы восстановили 60 ОЗ."})
			else
			BattleDialog({"[color:8040ff]Is it really so hard beating up this bitch?","You read the prayer[waitall:4][w:3]...[waitall:1][w:3]\n[health:60]You restored 60 HP."})
		end
		Encounter.SetVar("cursedwater",true)
		elseif pray==5 then
		if lang=="rus" then
			BattleDialog({"Ваше тело онемело от пронзающей его боли.","Вы читаете молитву[waitall:4][w:3]...[waitall:1][w:3]\n[health:60]Вы восстановили 60 ОЗ."})
			else
			BattleDialog({"Your body grew numb after all this pain.","You read the prayer[waitall:4][w:3]...[waitall:1][w:3]\n[health:60]You restored 60 HP."})
		end
		Encounter.SetVar("cursedwater",true)
		elseif pray==6 then
		if lang=="rus" then
			BattleDialog({"[color:8040ff]Ладно,[w:3] хватит уже.[w:6] Бог тебя не слышит,[w:3] хватит мучиться.","[color:8040ff]Только ты и можешь себе помочь.[w:6]\n[health:80]Ты восстановил 80 ОЗ."})
			else
			BattleDialog({"[color:8040ff]Alright,[w:3] quit it.[w:6]\nGod will never hear you,[w:3] stop struggling.","[color:8040ff]You are the only one to help yourself.[w:6]\n[health:80]You regain 80 HP."})
		end
		Encounter.SetVar("cursedwater",true)
		elseif pray==7 then
		if lang=="rus" then
			BattleDialog({"[color:8040ff]Её мир лишь сцена для меня.[w:6]\nПусть не зазнаётся.","[color:8040ff]А ты мой лучший актёр.[w:6]\nНе сдавайся.[w:6]\n[health:80]Ты восстановил 80 ОЗ."})
			else
			BattleDialog({"[color:8040ff]Her world is just a scene for me to act.[w:6]\nDon't get her cocky.","[color:8040ff]But You're my favourite actor.[w:6]\nDon't let down![w:6]\n[health:80]You regain 80 HP."})
		end
		Encounter.SetVar("cursedwater",true)
		elseif pray==8 then
		if lang=="rus" then
			BattleDialog({"[color:8040ff]Чара насмехается над твоими ошибками.","Но твои ошибки сделали тебя сильнее,[w:3] дорогуша.","[color:8040ff]Пусть смеётся.[w:6]\nКульминация совсем близко.","[color:8040ff]Время для эндшпиля! =)[w:12]\n[color:ffffff][health:99]Решимость переполняет вас, восстанавливая ОЗ."})
			else
			BattleDialog({"[color:8040ff]Chara laughs after your fails.","[color:8040ff]But those made you stronger,[w:3] darling.","[color:8040ff]Let her be.[w:6]\nWe're approaching the climax part.","[color:8040ff]It's endgame time,[w:3] check-mate! =)[w:12]\n[health:99]DETERMINATION overwhelms you,[w:3] restoring your HP."})
		end
		Encounter.SetVar("cursedwater",true)
		elseif pray==9 and GetGlobal("Song2") == "insane" then
		if lang=="rus" then
			BattleDialog({"[color:8040ff]Чара насмехается над твоими ошибками.","Но твои ошибки сделали тебя сильнее,[w:3] дорогуша.","[color:8040ff]Пусть смеётся.[w:6]\nКульминация совсем близко.","[color:8040ff]Время для эндшпиля! =)[w:12]\n[color:ffffff][health:99]Решимость переполняет вас, восстанавливая ОЗ."})
			else
			BattleDialog({"[color:8040ff]Chara laughs after your fails.","[color:8040ff]But those made you stronger,[w:3] darling.","[color:8040ff]Let her be.[w:6]\nWe're approaching the climax part.","[color:8040ff]It's endgame time,[w:3] check-mate! =)[w:12]\n[health:99]DETERMINATION overwhelms you,[w:3] restoring your HP."})
		end
		Encounter.SetVar("cursedwater",true)
		else
		if lang=="rus" then
			BattleDialog("Ты молишься[waitall:4][w:3]...[w:6][color:8040ff]\n...[waitall:1][w:3]Но никто тебя не услышал.")
			else
			BattleDialog("You pray[waitall:4][w:3]...[w:6][color:8040ff]\n...[waitall:1][w:3]But nobody heard it.")
		end
	
	end
	--if Encounter.GetVar("diff")<3 then
	--	Encounter.SetVar("cursedwater",true)
	--else
	--	Encounter.SetVar("cursedwater",false)
	--end
    end
	
    if command == "ПРОВЕРИТЬ" or command=="INSPECT" then
		SetInspectChoise()
    end
	if command == "КОНЦЕНТРАЦИЯ" or command=="CONCENTRATION" then
		local lang=Encounter.GetVar("lang")
		if weak then
			if lang=="rus" then
				BattleDialog({"Вы концентрируетесь на битве...\nНо это бесполезно.","[starcolor:8040ff][color:8040ff]Продолжай шоу , дорогой!"})
				else
				BattleDialog({"You concentrate on battle...\nBut it`s useless.","[starcolor:8040ff][color:8040ff]Continue the show, darling!"})
			end
			else
			if lang=="rus" then
				BattleDialog({"Вы концентрируетесь на битве...\nУрон следующей атаки ПОВЫШЕН!"})
				else
				BattleDialog({"You concentrate on battle...\nDamage of next attack gets HIGHER!"})
			end
			def=26
			weak=true
		end
	end
end

function Achivement()
	Encounter.Call("GotAchivement",4)
	Encounter.SetVar("globalstage","6")
	Encounter.Call("WriteSavio")
end

function OnDeath()
	local lang=Encounter.GetVar("lang")
	if Encounter.GetVar("wons")==0 then
		SetGlobal("charaisdead", 1)
		Encounter.SetVar("BestDifficultyValueBeaten",GetGlobal("DifficultyPoints"))
		Encounter.Call("GotAchivement",13)

		commands = {}
		local wav={}
		if Encounter.GetVar("quick")==true then
			--wav= {"nothing"})
			wav= {"laststrike","laststand"}
			else
			wav= {"laststrike","laststand"}
		end
		if Encounter.GetVar("quick")==true and Encounter.GetVar("diff")==20 then
			--wav= {"nothing"})
			wav= {"laststrike","laststand2"}
		elseif Encounter.GetVar("diff")==22 then
			wav= {"laststrike","laststand2"}
		end
		if Encounter.GetVar("quick")==true and Encounter.GetVar("diff")==22 then
			--wav= {"nothing"})
			wav= {"laststrike","laststand3"}
		elseif Encounter.GetVar("diff")==22 then
			wav= {"laststrike","laststand3"}
		end
		if Encounter.GetVar("diff")==23 or Encounter.GetVar("diff")==24 or Encounter.GetVar("diff")==35 then
			--wav= {"nothing"})
			wav= {"laststrike2","laststand4"}
		end
		if Encounter.GetVar("diff")==25 or Encounter.GetVar("diff")==26 or Encounter.GetVar("diff")==27 or Encounter.GetVar("diff")==28 or Encounter.GetVar("diff")==29 or Encounter.GetVar("diff")==30 or Encounter.GetVar("diff")==36 then
			--wav= {"nothing"})
			wav= {"laststrike3","laststand5"}
		end
		hp = 2
		if Encounter.GetVar("diff")==33 and Encounter.GetVar("prog")<5 then
			--wav= {"nothing"})
			wav= {"laststrike4","laststand5"}
			hp = 500000
		end
		if Encounter.GetVar("diff")==33 and Encounter.GetVar("prog")>=5 then
			--wav= {"nothing"})
			wav= {"laststrike3","laststand5"}
			--hp = 500000
		end
		if Player.hp<10 then
			Encounter.Call("GotAchivement",12)
		end
		Encounter.SetVar("arenasize", {155, 130})
		Encounter.SetVar("nextwaves",wav)
		--Encounter.SetVar("wavetimer", 999)
		local songs=Encounter.GetVar("songs")
		NewAudio.Pause(songs[3])
		Encounter.SetVar("FightGoes",false)
		SetGlobal("progress",999)
		currentdialogue={""}
		State("DEFENDING")
		State("NONE")
		else
		local dial={}
		SetMusic("finale")
		Encounter.SetVar("DoesPellets",false)
		local dubbing=Encounter.GetVar("dubbing")
		local lang=Encounter.GetVar("lang")
		if Encounter.GetVar("LostMercy")<8 then
			if lang=="rus" then
				if dubbing==true then
					dial={"[func:LostKidFace,base,+][waitall:4][w:3]...[waitall:1][w:3]","[func:LostKidFace,base_close,-][func:DUB,die1/1][w:6][speed:0.80]Ясно[waitall:4][w:3]...[waitall:1][w:8] [func:LostKidFace,base_left,+]Значит, это \nбы[w:1]ло обы[w:2]чное \nлюбопы[w:2]тство[waitall:4][w:3]...[waitall:1][w:3]","[func:LostKidFace,base_up,+][func:DUB,die1/2][w:6][speed:0.90]Знаешь,[w:3] я отча[w:1]сти[w:3] \nне разочаро[w:2]вана.[w:6]","[func:LostKidFace,base_left,+][func:DUB,die1/3][w:6][speed:1.00]В конце концов[waitall:4][w:3]...[waitall:1][w:3] [func:LostKidFace,base_close,-][speed:1.06]\nПочему я вообще \nдумала, что в этот \nраз что-то будет \nиначе?.[w:6].[w:6]", "[func:LostKidFace,sobbing_close,-][func:DUB,die1/4][w:6][speed:1.00]Что ты выслушаешь \nменя[waitall:4][w:3]...[waitall:1][w:5][func:LostKidFace,sobbing,+] Попробуешь \nизмени[w:2]ться[waitall:4][w:3]...[waitall:1][w:2] [func:LostKidFace,crying,+]Стать[w:8] \nлу[w:3]ч[w:1]ше?[w:6]", "[func:LostKidFace,base_close,-][func:DUB,die1/5][w:6][speed:0.65]Эх[waitall:4][w:3]...[waitall:1][w:3]", "[func:LostKidFace,base_up,+][func:DUB,die1/6][w:6][speed:0.80]Из[w:1]ви[w:1]ни,[w:9] А[w:2]зриэль[waitall:4][w:3]...[waitall:1][w:3] [color:808080][effect:shake][func:LostKidFace,base_close,-]\n[func:QuietMusic]Я[w:1] скоро[w:1] вернусь[waitall:4][w:3]...[waitall:1][w:3][func:dead][w:60][func:WON] "}
					else
					dial={"[func:LostKidFace,base,+][waitall:4][w:3]...[waitall:1][w:3]","[func:LostKidFace,base_close,-]Ясно[waitall:4][w:3]...[waitall:1][w:3] [func:LostKidFace,base_left,+]Значит,[w:3] это \nбыло обычное \nлюбопытство[waitall:4][w:3]...[waitall:1][w:3]","[func:LostKidFace,base_up,+]Знаешь,[w:3] я отчасти \nне разочарована.[w:6]","[func:LostKidFace,base_left,+]В конце концов[waitall:4][w:3]...[waitall:1][w:3] [func:LostKidFace,base_close,-]\nПочему я вообще \nдумала,[w:3] что в этот \nраз что-то будет \nиначе?.[w:6].[w:6]", "[func:LostKidFace,sobbing_close,-]Что ты выслушаешь \nменя[waitall:4][w:3]...[waitall:1][w:3][func:LostKidFace,sobbing,+] Попробуешь \nизмениться[waitall:4][w:3]...[waitall:1][w:3] [func:LostKidFace,crying,+]Стать \nлучше?", "[func:LostKidFace,base_close,-]Эх[waitall:4][w:3]...[waitall:1][w:3]", "[func:LostKidFace,base_up,+]Извини,[w:3] Азриэль[waitall:4][w:3]...[waitall:1][w:3] [color:808080][effect:shake][func:LostKidFace,base_close,-]\n[func:QuietMusic]Я скоро вернусь[waitall:4][w:3]...[waitall:1][w:3][func:dead][w:60][func:WON] "}
				end
				else
				dial={"[func:LostKidFace,base,+][waitall:4][w:3]...[waitall:1][w:3]","[func:LostKidFace,base_close,-]So that's how it is[waitall:4][w:3]...[waitall:1][w:3] [func:LostKidFace,base_left,+]\nJust a common \ncuriosity,[w:3] right?","[func:LostKidFace,base_up,+]Y'know,[w:3] I am kinda \nnot dissapointed.","[func:LostKidFace,base_left,+]In the end[waitall:4][w:3]...[waitall:1][w:3] [func:LostKidFace,base_close,-]Why \nhave I even thought \nthat something \nwill change?","[func:LostKidFace,sobbing_close,-]That you will listen \nto me[waitall:4][w:3]...[waitall:1][w:3] [func:LostKidFace,sobbing,+]Try to turn[waitall:4][w:3]...[waitall:1][w:3] [func:LostKidFace,crying,+]\non the better side?","[func:LostKidFace,base_close,-]*sigh*[waitall:4][w:3]...[waitall:1][w:3]","[func:LostKidFace,base_up,+]I am sorry,[w:3] Asriel[waitall:4][w:3]...[waitall:1][w:3] [func:LostKidFace,base_close,-]\n[color:808080][effect:shake][func:QuietMusic]I will come back \nsoon[waitall:4][w:3]...[waitall:1][w:3][func:dead][w:60][func:WON] "}
			end
			elseif Encounter.GetVar("LostMercy")<22 then
			if lang=="rus" then
				if dubbing==true then
					dial={"[func:DUB,die2/1][w:6][speed:1.85][func:LostKidFace,crying_loud,-]Кх[waitall:4][w:3]...[waitall:1][w:3]", "[func:LostKidFace,crying,+][func:DUB,die2/2][w:6][speed:0.70]Это[w:1] было[w:1] грубо[waitall:2][w:2]...[waitall:1][w:2] [func:LostKidFace,sobbing,+] \nПрерывать меня \nпосреди пути[waitall:4][w:3]...[waitall:1][w:3]", "[func:LostKidFace,base,+][func:DUB,die2/3][w:6][speed:1.00]Я ведь[waitall:3][w:1]...[waitall:1][w:2] [func:LostKidFace,confused,+]Даже[w:1] не \nатаковала тебя[waitall:4][w:3]...[waitall:1][w:3]", "[func:DUB,die2/4][w:9][speed:1.00][func:LostKidFace,base_left,+]Сам[w:1] напросился на \nсказку, [w:1][func:LostKidFace,base,+]а потом \nобрываешь?[w:4].[w:4].[w:4].[w:4] [func:LostKidFace,sobbing,+][speed:0.80]Я так и \nзна[w:2]ла,[w:6] что ты[w:3].[w:3].[func:LostKidFace,sobbing_smile,+][w:3].[w:3][speed:0.70] \nАморальный[speed:0.85] сукин \nсын,[w:2][speed:0.80] кукловод[waitall:4][w:3]...[waitall:1][w:3]", "[func:LostKidFace,sobbing_upsmile,+][func:DUB,die2/5][w:12][speed:0.70]Хе-хе[waitall:4][w:3]...[speed:0.70][w:6] [func:LostKidFace,sobbing_thinking,+]Раз так[waitall:3][w:3]...[waitall:1][w:3] [func:LostKidFace,sobbing,+][speed:0.90] \nТо и[w:1] чёрт[w:1] с тобой.[w:6]", "[func:LostKidFace,sobbing_close,-][func:QuietMusic][func:DUB,die2/6][w:6][speed:0.80]До следующей \nвстречи[waitall:3][w:3]...[w:3] [func:LostKidFace,sobbing_smile_close2,-] [color:808080][effect:shake][speed:0.70]\nКукловод.[w:6][func:dead][w:60][func:WON] "}
					else
					dial={"[func:LostKidFace,crying_loud,-]Кх[waitall:4][w:3]...[waitall:1][w:3]", "[func:LostKidFace,crying,+]Это было грубо[waitall:4][w:3]...[waitall:1][w:3] [func:LostKidFace,sobbing,+] \nПрерывать меня \nпосреди пути[waitall:4][w:3]...[waitall:1][w:3]", "[func:LostKidFace,base,+]Я ведь[waitall:4][w:3]...[waitall:1][w:3] [func:LostKidFace,confused,+] Даже не \nатаковала тебя[waitall:4][w:3]...[waitall:1][w:3]", "[func:LostKidFace,base_left,+]Сам напросился на \nсказку,[w:6] [func:LostKidFace,base,+] а потом \nобрываешь?.[w:6].[w:6] [func:LostKidFace,sobbing,+]Я так и \nзнала,[w:6] что ты [func:LostKidFace,sobbing_smile,+] \nаморальный сукин \nсын,[w:6] кукловод[waitall:4][w:3]...[waitall:1][w:3]", "[func:LostKidFace,sobbing_upsmile,+]Хе[waitall:4][w:3]...[waitall:1][w:3] Хе[waitall:4][w:3]...[waitall:1][w:3]", "[func:LostKidFace,sobbing_thinking,+]Раз так[waitall:4][w:3]...[waitall:1][w:3] [func:LostKidFace,sobbing,+] То и \nчёрт с тобой.[w:6]", "[func:LostKidFace,sobbing_close,-][func:QuietMusic]До следующей \nвстречи[waitall:4][w:3]...[waitall:1][w:3] [func:LostKidFace,sobbing_smile_close2,-] [color:808080][effect:shake]Кукловод.[w:6][func:dead][w:60][func:WON] "}
				end
				else
				dial={"[func:LostKidFace,crying_loud,-]Ugh[waitall:4][w:3]...[waitall:1][w:3]","[func:LostKidFace,crying,+]It was rude[waitall:4][w:3]...[waitall:1][w:3]","[func:LostKidFace,sobbing,+]To interrupt me on \nthe mid-way[waitall:4][w:3]...[waitall:1][w:3]","[func:LostKidFace,base,+]I didn't[waitall:4][w:3]...[waitall:1][w:3] [func:LostKidFace,confused,+]I didn't \neven hurt you[waitall:4][w:3]...[waitall:1][w:3]","[func:LostKidFace,base_left,+]You asked for this \nby yourself[waitall:4][w:3]...[waitall:1][w:3] [func:LostKidFace,base,+]and \nnow messing with me?.[w:6].[w:6]","[func:LostKidFace,sobbing,+]I knew that you're \na [func:LostKidFace,sobbing_smile,+]cruel bastard,[w:3] \npuppeteer[waitall:4][w:3]...[waitall:1][w:3]","[func:LostKidFace,sobbing_upsmile,+]Heh[waitall:4][w:3]...[waitall:1][w:3] Heh[waitall:4][w:3]...[waitall:1][w:3]","[func:LostKidFace,sobbing_thinking,+]If so[waitall:4][w:3]...[waitall:1][w:3] [func:LostKidFace,sobbing,+]Damn you.[w:6]","[func:LostKidFace,sobbing_close,-][func:QuietMusic]Good riddance[waitall:4][w:3]...[waitall:1][w:3] [func:LostKidFace,sobbing_smile_close2,-]\nPuppeteer.[w:6][func:dead][w:60][func:WON] "}
			end
			else
			if lang=="rus" then
				if dubbing==true then
					dial={"[func:LostKidFace,sobbing,+][waitall:4][w:3]...[waitall:1][w:3]", "[func:LostKidFace,sobbing_up,+][waitall:5][w:4]...[waitall:1][func:DUB,die3/1][w:5][speed:0.70]Спасибо.[w:6]","[func:QuietMusic][func:LostKidFace,sobbing_upsmile,+][color:808080][effect:shake][waitall:4][w:3]..[w:6].[func:DUB,die3/2][speed:0.80][w:6]Партнёр[waitall:4][w:3]...[waitall:1][w:3][func:LostKidFace,sobbing_upsmile_close2,-][func:dead][w:60][func:WON] "}
					else
					dial={"[func:LostKidFace,sobbing,+][waitall:4][w:3]...[waitall:1][w:3]", "[func:LostKidFace,sobbing_up,+][waitall:4][w:3]...[waitall:1][w:3]Спасибо.[w:6]","[func:QuietMusic][func:LostKidFace,sobbing_upsmile,+][color:808080][effect:shake][waitall:4][w:3]...[waitall:1][w:3]партнёр[waitall:4][w:3]...[waitall:1][w:3][func:LostKidFace,sobbing_upsmile_close2,-][func:dead][w:60][func:WON] "}
				end
				else
				dial={"[func:LostKidFace,sobbing,+][waitall:4][w:3]...[waitall:1][w:3]","[func:LostKidFace,sobbing_up,+][waitall:4][w:3]...[waitall:1][w:3]Thank you.[w:6]","[func:QuietMusic][func:LostKidFace,sobbing_upsmile,+][color:808080][effect:shake][waitall:4][w:3]...[waitall:1][w:3]partner[waitall:4][w:3]...[waitall:1][w:3][func:LostKidFace,sobbing_upsmile_close2,-][func:dead][w:60][func:WON] "}
			end
		end
		for i=1,#dial do
			if lang=="rus" then
				if dubbing==true then
					dial[i]="[noskip][novoice][effect:none]"..dial[i]
					else
					dial[i]="[noskip][effect:none]"..dial[i]
				end
				else
				dial[i]="[noskip][effect:none]"..dial[i]
			end
		end
		currentdialogue=dial
		SetGlobal("charaisdead",999)
		if diff~=24 and Encounter.GetVar("songs")[4] ~= "wound86" and not (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare") and not (diff == 21 and (Encounter.GetVar("evrerythingModeEffect") == "Nightmare" or Encounter.GetVar("evrerythingModeEffectPre") == "Nightmare")) then
			State("ENEMYDIALOGUE")
		else
			State("DEFENDING")
		end
		--currentdialogue="[noskip][func:nohope4][func:dead][w:60][func:WON][next]"
	end
end

function Outro()
	currentdialogue = {outro1,outro2,outro3,outro4,outro5,outro6,outro7,outro8,outro9,outro10,outro11,outro12,outro13,outro14}
	State("ENEMYDIALOGUE")
end

function JUMP()
	Encounter.Call("SetMusic","none")
	Audio.PlaySound("jumpscare")
end

function Vietnam()
	Encounter.SetVar("FlashBack",1)
	State("NONE")
end

function MercyLostChild(ingo)
	local prog=GetGlobal("progress")
	local wav={"nothing"}
	local nrus={}
	local neng={}
	local rus={""}
	local eng={}
	local engcom=""
	local ruscom=""
	local lang=Encounter.GetVar("lang")
	if ingo==1 then
		rus={"[func:LostKidFace,base_close,-]Пусть ты и убил \nменя однажды[waitall:4][w:3]...", "[func:LostKidFace,base_left,+]Сейчас ты \nпредпочитаешь \nменя игнорировать?",  "[func:LostKidFace,base,+]Неужели я наконец \nтебе наскучила?[w:9] [func:LostKidFace,confused,+] \nИли же наоборот?",  "[func:LostKidFace,base_up,+]Наконец-то в моей \nжизни появился для \nтебя смысл?","[func:LostKidFace,base,+][next]"}
		nrus={"[func:LostKidFace,base_close,-][func:DUB,lost/2/1][speed:0.87][w:11]Пусть ты и убил \nменя одна[w:2]жды[waitall:4][w:3]...", "[func:LostKidFace,base_left,+][func:DUB,lost/2/2][w:7][speed:0.92]Сейчас ты \nпредпочитаешь \nменя игнорировать?", "[func:LostKidFace,base,+][func:DUB,lost/2/3][w:10][speed:0.86]Неужели я тебе \nнаконец [w:1]наскучила?[w:12] [func:LostKidFace,confused,+] \nИли же наоборот?",  "[func:LostKidFace,base_up,+][func:DUB,lost/2/4][w:9][speed:0.88]Наконец-то в моей \nжизни появился \nсмы[w:1]сл для тебя?","[func:LostKidFace,base,+][next]"}
		ruscom="Точно подмечено."
		neng={"[func:LostKidFace,base_close,-]Even if you killed me \nonce[waitall:4][w:3]...", "[func:LostKidFace,base_left,+]Now you didn't hurt \nme?", "[func:LostKidFace,base,+]Did you already grew \nbored of me? [func:LostKidFace,confused,+]\nOr on opposite?", "[func:LostKidFace,base_up,+]Did my life finally \ncost something \nfor you?","[func:LostKidFace,base,+][next]"}
		eng="Clever point."
		wav={"phase child/k_3"}
		elseif ingo==2 then
		neng={"[func:LostKidFace,base_left,+][waitall:4][w:3]...[waitall:1][w:3]I don't speak to \nyou,[w:3] partner.[w:6]", "[func:LostKidFace,base,+]I am talking to the \none pulling the \nstrings here.[w:6]", "[func:LostKidFace,angry,+]You're watching us,[w:3] \naren't you? \nDisturbing our \npeaceful life.[w:6]","[func:LostKidFace,base,+][next]"}
		eng="Must have guessed[waitall:4][w:3]...[waitall:1][w:3] \nOf course,[w:3] she knew you're not the only one in control."
		wav={"phase child/BeFast"}
		nrus={"[func:LostKidFace,base_left,+][waitall:4][w:3][func:DUB,lost/3/1]...[waitall:1][w:7]Я не к тебе \nобращаюсь,[w:2] партнёр.[w:9]", "[func:LostKidFace,base,+][func:DUB,lost/3/2][w:7]Я говорю с тем,[w:3] кто \nдёргает за ниточки.[w:9]", "[func:LostKidFace,angry,+][func:DUB,lost/3/3][w:6]Ты ведь[speed:1.25] следишь[speed:1.05] за \nнами![w:9][speed:1.07] \nМешаешь нам жить \nспоко[w:1]йно.[w:9]", "[func:LostKidFace,base,+][next]"}
		rus={"[func:LostKidFace,base_left,+][waitall:4][w:3]...[waitall:1][w:3]Я не к тебе \nобращаюсь,[w:6] партнёр.[w:9]", "[func:LostKidFace,base,+]Я говорю с тем,[w:6] кто \nдёргает за ниточки.[w:9]", "[func:LostKidFace,angry,+]Ты ведь следишь за \nнами.[w:9] \nМешаешь нам жить \nспокойно.[w:9]", "[func:LostKidFace,base,+][next]"}
		ruscom="Должен был догадаться[waitall:4][w:3]...[waitall:1][w:3] \nКонечно,[w:3] она в курсе,[w:3] что не ты здесь главный."
		elseif ingo==3 then
		neng={"[func:LostKidFace,base_close,-]Whathever[waitall:4][w:3]...", "[func:LostKidFace,confused,+]Everything is \nmeaningless now.[w:6]", "[func:LostKidFace,base_close,-]All my efforts[waitall:4][w:3]...[waitall:1][w:3] [func:LostKidFace,base,+]lead \nto my end.[w:6]", "[func:LostKidFace,base_left,+]You see,[w:3] you've \nsaved in the moment \nof my powers \nawakening.[w:6]", "[func:LostKidFace,base_close,-]So when you \nreturned[waitall:4][w:3]...", "[func:LostKidFace,base,+]I remembered my \ndeath as well.[w:6]"}
		eng="So that's how her power works[waitall:4][w:3]...[waitall:1][w:3]\nCurious."
		wav={"phase child/rain"}
		nrus={"[func:LostKidFace,base_close,-][func:DUB,lost/4/1][w:12][speed:0.75]Как бы то ни было[waitall:4][w:3]...",  "[func:LostKidFace,confused,+][func:DUB,lost/4/2][w:6][speed:0.85]Ничего больше не \nимеет [w:1]смысл.",  "[func:LostKidFace,base_close,-][func:DUB,lost/4/3][w:4][speed:0.80]Все мои старания[waitall:3][w:2]...[waitall:1][w:2][func:LostKidFace,base,+][speed:0.85] \nКончатся моей \nсмертью.", "[func:LostKidFace,base_left,+][func:DUB,lost/4/4][w:4][speed:0.92]Ви[w:1]дишь[w:1] ли,[w:4] твоё \nсохранение \nприходится именно \nна момент \nпробуждения моих \nсил.", "[func:LostKidFace,base_close,-][func:DUB,lost/4/5][w:4][speed:0.92]Поэтому сейчас,[w:2] \nкогда ты вернулся[waitall:4][w:3]...", "[func:LostKidFace,base,+][func:DUB,lost/4/6][w:5]Я вспомнила,[w:3] как \nты меня убил."}
		rus={"[func:LostKidFace,base_close,-]Как бы то ни было[waitall:4][w:3]...",  "[func:LostKidFace,confused,+]Ничего больше не \nимеет смысл.",  "[func:LostKidFace,base_close,-]Все мои старания[waitall:4][w:3]...[waitall:1][w:3][func:LostKidFace,base,+] \nКончатся моей \nсмертью.", "[func:LostKidFace,base_left,+]Видишь ли,[w:6] твоё \nсохранение \nприходится именно \nна момент \nпробуждения моих \nсил.", "[func:LostKidFace,base_close,-]Поэтому сейчас,[w:6] \nкогда ты вернулся[waitall:4][w:3]...", "[func:LostKidFace,base,+]Я вспомнила,[w:6] как \nты меня убил."}
		ruscom="Вот так,[w:3] значит,[w:3] работают её силы[waitall:4][w:3]...[waitall:1][w:3]\nЛюбопытно."
		elseif ingo==4 then
		neng={"[func:LostKidFace,base_left,+]I haven't so much \ntime to think about \nmy death.[w:6]", "[func:LostKidFace,confused,+]To be completely \nhonest,[w:3] it even \nwasn't me.[w:6]", "[func:LostKidFace,base_left,+]It was other Chara.[w:6] [func:LostKidFace,base,+]\nFrom previous world \nyou have already \ndestroyed.[w:6]", "[func:LostKidFace,base_close,-]And every time other \nCharas dies,[w:3] you \nmove to the next \nworld.[w:6]", "[func:LostKidFace,base_left,+]In fact[waitall:4][w:3]...[waitall:1][w:3] I will share \ntheir destiny once."}
		eng="Hm,[w:3] sounds good.[w:6] \nI need to get name for such script[waitall:4][w:3]..."
		wav={"phase child/stoplights"}
		ruscom="Хм,[w:3] звучит.[w:6] \nНадо подумать над названием для такой пьесы[waitall:4][w:3]...[waitall:1][w:3]"
		rus={"[func:LostKidFace,base_left,+]У меня не было \nмного времени,[w:6] \nчтобы обдумать \nмою смерть.",  "[func:LostKidFace,confused,+]Если уж совсем \nчестно,[w:6] это даже \nбыла не я.",  "[func:LostKidFace,base_left,+]Это была другая \nЧара.[w:9] [func:LostKidFace,base,+]Из прошлого \nмира, который ты \nокончательно сломал.", "[func:LostKidFace,base_close,-]И каждый раз как \nЧара умирает, ты \nпереходишь в новый \nмир.",  "[func:LostKidFace,base_left,+]Формально[waitall:4][w:3]...[waitall:1][w:3] Та же \nучасть [func:LostKidFace,base,+]ждёт и меня."}
		nrus={"[func:LostKidFace,base_left,+][func:DUB,lost/5/1][w:4][speed:1.04]У меня не было \nмного времени, \nчтобы обдумать \nмою смерть.",  "[func:LostKidFace,confused,+][func:DUB,lost/5/2][w:6][speed:0.92]Если уж совсем \nчестно,[w:7] это[w:1] даже \nбыла не я.",  "[func:LostKidFace,base_left,+][func:DUB,lost/5/3][w:4][speed:0.92]Это была другая \nЧара.[w:7] [func:LostKidFace,base,+][speed:1.10]Из предыдущего[w:1] \nмира,[w:6] [speed:0.90]который ты[speed:1.11] \nокончательно \nсломал.", "[func:LostKidFace,base_close,-][func:DUB,lost/5/4][w:4][speed:0.92]И каждый раз [w:2]как \nЧара умирает,[w:4][speed:1.09] ты \nпереходишь в новый \nмир.",  "[func:LostKidFace,base_left,+][func:DUB,lost/5/5][w:5][speed:0.92]Формально[waitall:3][w:2]...[waitall:1][w:2] Та же \nучасть[w:1] [func:LostKidFace,base,+]ждёт[w:1] и меня."}
		elseif ingo==5 then
		neng={"[func:LostKidFace,base_close,-]I didn't think about \nit before[waitall:4][w:3]...", "[func:LostKidFace,base,+]But sooner I end my \nexistance,[w:3] the \nbetter it will be.[w:6]", "[func:LostKidFace,confused,+]I am not that Chara \nwho could stop you.[w:6]", "[func:LostKidFace,base_close,-]And when I die,[w:3] I will \nno longer exist.[w:6]", "I will no longer feel \nthat pain in the \nchest[waitall:4][w:3]..."}
		eng="[color:8040ff]Try it."
		wav={"phase child/brave"}
		ruscom="[color:8040ff]Попробуем это."
		nrus={"[func:LostKidFace,base_close,-][func:DUB,lost/6/1][w:7]Раньше я об этом \nне думала[waitall:4][w:3]...",  "[func:LostKidFace,base,+][func:DUB,lost/6/2][w:8][speed:0.98]Но чем раньше я \nпрекращу своё[w:1] \nсуществование,[w:4] \nтем[w:1] лучше.",  "[func:LostKidFace,confused,+][func:DUB,lost/6/3][w:8][speed:0.92]Я ведь не та[w:2] Ча[w:1]ра[waitall:3][w:2]...[waitall:1][w:2] \nЧто способна тебя \nодолеть.",  "[func:LostKidFace,base_close,-][func:DUB,lost/6/4][w:9][speed:0.92]А когда я умру,[w:11] \nя перестану \nсуществовать.",  "[func:LostKidFace,confused,+][func:DUB,lost/6/5][w:9][speed:0.92]Перестану \nиспытывать эту \nболь в груди[waitall:4][w:3]..."}
		rus={"[func:LostKidFace,base_close,-]Раньше об этом я \nне думала[waitall:4][w:3]...",  "[func:LostKidFace,base,+]Но чем раньше я \nпрекращу своё \nсуществование,[w:6] \nтем лучше.",  "[func:LostKidFace,confused,+]Я ведь не та Чара,[w:6] \nчто способна тебя \nодолеть.",  "[func:LostKidFace,base_close,-]А когда я умру,[w:6] \nя перестану \nсуществовать.",  "[func:LostKidFace,crying,+]Перестану \nиспытывать эту \nболь в груди[waitall:4][w:3]..."}
		elseif ingo==6 then
		neng={"[func:LostKidFace,sobbing_close,-]If you wonder[waitall:4][w:3]...[waitall:1][w:3] [func:LostKidFace,base,+]I \nhave nothing left \nfor you.[w:6]", "[func:LostKidFace,base_left,+]All cards are on the\ntable now.[w:6]", "My powers.[w:6] \nMy attacks.[w:6] [func:LostKidFace,base_close,-]\nMy feelings.[w:6]", "[func:LostKidFace,base,+]Just kill me.[w:6] And skip \nthe formalities.[w:6]"}
		eng="So soon?[w:6] \nI am a little disappointed."
		Encounter.SetVar("FightGoes",false)
		ruscom="Так быстро?[w:12] \nЯ даже разочарован отчасти[waitall:4][w:3]...[waitall:1][w:3]"
		rus={"[func:LostKidFace,sobbing_close,-]Если тебе \nинтересно[waitall:4][w:3]...[waitall:1][w:3] [func:LostKidFace,base,+]\nМне больше нечего \nтебе предложить",  "[func:LostKidFace,base_left,+]Все карты перед \nтобой.[w:9] \nМои силы.[w:9] \nМои атаки.[w:9] [func:LostKidFace,base_close,-] \nМои чувства.",  "[func:LostKidFace,base,+]Просто убей меня.[w:9] \nИ покончим с \nформальностями."}
		nrus={"[func:LostKidFace,sobbing_close,-][func:DUB,lost/7/1][w:9][speed:0.80]Если тебе \nинтересно[waitall:3][w:2]...[waitall:1][w:1] [func:LostKidFace,base,+]\nМне больше нечего \nтебе предложить[waitall:3][w:2]...[waitall:1][w:2]",  "[func:LostKidFace,base_left,+][func:DUB,lost/7/2][w:5][speed:0.87]Все карты перед \nтобой.[w:9] \nМои си[w:2]лы.[w:14] \nМои[w:1] ата[w:3]ки.[w:10] [func:LostKidFace,base_close,-] \nМои [w:2]чувства.",  "[func:LostKidFace,base,+][func:DUB,lost/7/3][w:8][speed:0.92]Просто убей меня.[w:9] \nИ [speed:1.00]покончим с \nформальностями."}
		elseif ingo==7 then
		neng={"[func:LostKidFace,base_left,+][waitall:4][w:3]...", "[func:LostKidFace,base,+][waitall:4][w:3]...[waitall:1][w:3]If you want to \nspend more time \nwith me[waitall:4][w:3]...", "[func:LostKidFace,confused,+]I can tell you a \nstory.[w:6] Fairytale,[w:3] if \nyou want to call \nit so.[w:6]", "[func:LostKidFace,base_close,-]I named it[waitall:4][w:3]...[waitall:1][w:3] [func:LostKidFace,base,+]\n<The Lost Child>.[w:6]"}
		eng="No one read me fairytales before the sleep,[w:3] even cousin[waitall:4][w:3]...[waitall:1][w:3] \nI am interested again."
		rus={"[func:LostKidFace,base_left,+][waitall:4][w:3]...",  "[func:LostKidFace,base,+][waitall:4][w:3]...[waitall:1][w:3]Если тебе хочется \nещё провести со \nмной время[waitall:4][w:3]...", "[func:LostKidFace,confused,+]Я могу рассказать \nтебе историю.[w:9] \nСказку,[w:6] если можно \nтак сказать.",  "[func:LostKidFace,base_close,-]Я называю её[waitall:4][w:3]...[waitall:1][w:3] [func:LostKidFace,base,+] \n[speed:0.5]'Потерянное дитя'."}
		nrus={"[func:LostKidFace,base_left,+][waitall:4][novoice][w:3]...",  "[func:LostKidFace,base,+][speed:0.91][waitall:4]..[func:DUB,lost/8/1].[waitall:1][w:3][speed:0.92]Если тебе хочется \nещё провести со \nмной время[waitall:4][w:3]...", "[func:LostKidFace,confused,+][func:DUB,lost/8/2][speed:0.98][w:7]Я могу рассказать \nтебе историю.[w:10] \nСказку,[w:2] если можно \nтак сказать.",  "[func:LostKidFace,base_close,-][func:DUB,lost/8/3][speed:0.74][w:7]Я называю её[waitall:3][w:2]...[waitall:1][w:2][speed:0.90] [func:LostKidFace,base,+] \n'Потерянное [w:1]дитя'."}
		ruscom="Сказки на ночь мне ещё никто не читал,[w:3] даже кузен[waitall:4][w:3]...[waitall:1][w:3] \nЯ снова заинтригован."
		elseif ingo==8 then
		neng={"[func:LostKidFace,base_close,-]Thus story began \nlong-long time ago[waitall:4][w:3]...", "[func:LostKidFace,base_left,+]It was the time when \nworld was pure and \nfair.[w:6]", "[func:LostKidFace,base,+]World was filled with \npeace and love[waitall:4][w:3]..."}
		eng="Sounds like the beginning of soap drama[waitall:4][w:3]...[waitall:1][w:3]\nI like them in fact."
		rus={ "[func:LostKidFace,base_close,-]Эта история \nначалась \nдавным-давно[waitall:4][w:3]...",  "[func:LostKidFace,base_left,+]Это было во \nвремена,[w:6] когда \nмир казался чище и \nсправедливее.",  "[func:LostKidFace,base,+]В мире царила \nлюбовь и гармония[waitall:4][w:3]..."}
		nrus={ "[func:LostKidFace,base_close,-][func:DUB,lost/9/1][waitall:4][w:3]...[waitall:1][w:3]Эта история \nначалась \nдавным-давно[waitall:4][w:3]...",  "[func:LostKidFace,base_left,+][func:DUB,lost/9/2][w:8][speed:1.05]Это было во \nвремена,[w:2] когда \nмир казался[w:1] чище[w:1] и[w:1] \nсправедливее.",  "[func:LostKidFace,base,+][func:DUB,lost/9/3][w:6][speed:0.94]В мире царила[speed:0.80] \nлюбовь и гармония[waitall:4][w:3]..."}
		ruscom="Звучит,[w:3] как начало сопливой драмы[waitall:4][w:3]...[waitall:1][w:3] \nЯ люблю такое."
		elseif ingo==9 then
		neng={"[func:LostKidFace,base_left,+]There was the little \ngirl in one village.[w:6]", "She liked to draw,[w:3] \nnature and [func:LostKidFace,base,+]chocolate.[w:6]", "She had many friends.[w:6] [func:LostKidFace,sobbing,+]\nFriendly family.[w:6]", "The girl was happy.[w:6]", "[func:LostKidFace,sobbing_close,-]But world itself\n works so that no \none deserves true \nhappiness.[w:6]", "[func:LostKidFace,base,+]And one day the \ngirl's life changed a \nlot[waitall:4][w:3]...[waitall:1][w:3] \nForever[waitall:4][w:3]..."}
		eng="I had a family too ages ago.[w:6]\nBut I don't remember them at all."
		rus={ "[func:LostKidFace,base_left,+]В одной деревне \nжила маленькая \nдевочка.", "Она любила \nрисовать,[w:6] природу и [func:LostKidFace,base,+]\nшоколад.", "У девочки было \nмного друзей.[w:9] \nУ неё была [func:LostKidFace,sobbing,+] \nдружная семья.", "Девочка была \nсчастлива.",  "[func:LostKidFace,sobbing_close,-]Но мир устроен так,[w:6] \nчто не все мы \nзаслуживаем счастья.",  "[func:LostKidFace,base,+]В один день жизнь \nдевочки сильно \nизменилась[waitall:4][w:3]...[waitall:2][w:3] \nНавсегда[waitall:4][w:3]..."}
		nrus={"[func:LostKidFace,base_left,+][func:DUB,lost/10/1][w:5][speed:0.95]В одной деревне \nжила[w:1] маленькая \nдевочка.", "[func:DUB,lost/10/2][w:5][speed:0.89]Она любила \nрисовать,[w:8] природу[w:7] и [func:LostKidFace,base,+]\nшоколад.", "[func:DUB,lost/10/3][w:5]У девочки было \nмного друзей.[w:9] \nУ неё была [func:LostKidFace,sobbing,+] \nдружная семья.", "[func:DUB,lost/10/4][w:5][speed:0.90]Девочка была \nсчастлива.", "[func:LostKidFace,sobbing_close,-][func:DUB,lost/10/5][w:5]Но[w:2] мир устроен так,[w:4] \nчто[w:10][speed:1.10] не все мы[speed:1.20] \nзаслуживаем \nсчастья.",  "[func:LostKidFace,base,+][func:DUB,lost/10/6][w:5]В один день[w:3] жизнь \nдевочки[w:2] си[w:3]льно \nизменилась[waitall:3][w:3]...[waitall:1][w:2] \nНа[w:2]все[w:2]гда[waitall:4][w:3]..."}
		ruscom="Когда я ещё был жив,[w:3] у меня тоже была семья.[w:6] \nНо я её совсем не помню."
		elseif ingo==10 then
		neng={"[func:LostKidFace,sobbing,+]One day her father \nhad passed away.[w:6]", "He quit life quietly.[w:6] \nModestly.[w:6] [func:LostKidFace,sobbing_close,-]With family \nby his side.[w:6]", "He was ill for so \nlong.[w:6] Dreading away \nwith each day.[w:6]", "[func:LostKidFace,sobbing,+]That's when the girl's \nlife changed.[w:6]", "[func:LostKidFace,sobbing_thinking,+]Her mother almost \nwent crazy from \nsorrow.[w:6]", "[func:LostKidFace,base_close,-]She was horrified by \nthe idea of her only \nchild leaving her as \nher husband.[w:6]", "[func:LostKidFace,sobbing,+]She tied the girl,[w:3] \nforced to sleep in \nthe cellar on the \nlock.[w:6]", "[func:LostKidFace,sobbing_thinking,+]She was provided \nwith food only in \ncertain times and \nsaw world through \nclosed window.[w:6]", "Step by step[waitall:4][w:3]...[waitall:1][w:3] [func:LostKidFace,base,+]Her \nemotions faded away.[w:6] \nThe blade of her \nSoul broke.[w:6]"}
		eng="[waitall:4][w:3]...[waitall:1][w:3]I read the book with same plot.[w:6] \nI kinda pity it's character." 
		ruscom="[waitall:4][w:3]...[waitall:1][w:3]Я помню,[w:3] как читал книгу с таким сюжетом.[w:6]\nБыло очень жалко героиню."
		rus={ "[func:LostKidFace,sobbing,+]Однажды отец \nдевочки умер.", "Он ушёл из жизни \nтихо.[w:9] \nСкромно.[w:9] [func:LostKidFace,sobbing_close,-] \nВ кругу семьи.", "Он долго болел.[w:8] \nУвядал день ото дня.",  "[func:LostKidFace,sobbing,+]Тогда жизнь девочки \nи изменилась.", "[func:LostKidFace,sobbing_thinking,+]Её мать будто бы \nобезумела от горя.",  "[func:LostKidFace,base_close,-]Она боялась,[w:6] что \nпотеряет и \nединственного \nребёнка.",  "[func:LostKidFace,sobbing,+]Она связывала \nдевочку,[w:6] заставляла \nеё ночевать в \nподвале под замком.",  "[func:LostKidFace,sobbing_thinking,+]Она питалась только \nпо расписанию и \nвидела мир лишь \nиз окна.",  "[func:LostKidFace,sobbing_close,-]Постепенно[waitall:4][w:3]...[waitall:1][w:3][func:LostKidFace,base,+] Её \nчувства огрубели.[w:9] \nЛезвие её души \nзатупилось."}
		nrus={"[func:LostKidFace,sobbing,+][func:DUB,lost/11/1][w:5]Однажды[w:1] отец[w:1] \nдевочки [w:1]умер.", "[func:DUB,lost/11/2][w:11]Он ушёл[w:1] из жи[w:1]зни \nти[w:2]хо.[w:11][speed:0.75] \nСкромно.[w:10] [func:LostKidFace,sobbing_close,-][speed:1.00] \nВ [w:1]кругу [w:1]семьи.", "[func:DUB,lost/11/3][w:5][speed:0.90]Он долго болел.[speed:0.75][w:11] \nУвяда[w:2]л[w:1] день ото дня.",  "[func:LostKidFace,sobbing,+][func:DUB,lost/11/4][w:3]Тогда жизнь девочки \nи изменилась.", "[func:LostKidFace,sobbing_thinking,+][func:DUB,lost/11/5][w:5]Её мать[w:1] будто бы [w:1]\nобезу[w:1]мела[w:1] от го[w:1]ря.",  "[func:LostKidFace,base_close,-][func:DUB,lost/11/6][w:5][speed:0.94]Она[w:1] боялась,[w:1] [speed:1.05]что \nпотеряет \nединственного \nребё[w:1]нка.",  "[func:LostKidFace,sobbing,+][func:DUB,lost/11/7][w:5]Она свя[w:2]зывала[w:2] \nдевочку,[w:8] заставляла \nеё ночевать[w:1] в \nподвале[w:1] под замком.",  "[func:LostKidFace,sobbing_thinking,+][func:DUB,lost/11/8][w:5]Она питалась [w:1]только[w:1] \nпо расписанию [w:2]и \nвидела мир[w:1] лишь[w:1] \nчерез окна.",  "[func:LostKidFace,sobbing_close,-][func:DUB,lost/11/9][w:4][speed:0.80]Постепенно[waitall:4][w:3]...[waitall:1][w:4][func:LostKidFace,base,+] Её \nчувства огрубели.[w:18][speed:0.70] \nЛезвие её души[speed:0.81] \nзатупилось."}
		elseif ingo==11 then
		neng={"[func:LostKidFace,base_up,+]One day,[w:3] watching \ninto the window,[w:3] girl \nthought.[w:6]", "<Mt.[w:6] Ebott[waitall:4][w:3]...[waitall:1][w:3] It's \nso huge.[w:6]>", "<[func:LostKidFace,base_left,+]What if monster \nfrom the legends \ntruly live beneath \nit?>", "[func:LostKidFace,base,+]Girl was curious \nfinding it out.[w:6]", "[func:LostKidFace,base_close,-]But mother would \nnever let her go to \nmountain.[w:6] \nEven to the street.[w:6]", "[func:LostKidFace,base_left,+]Loneliness was \nsuffocating the girl.[w:6] [func:LostKidFace,base_close,-]\nShe felt herself \nleft behind in \nthose four walls.[w:6]", "[func:LostKidFace,base,+]She wanted to run \naway.[w:6] As far as she \ncan.[w:6]", "[func:LostKidFace,sobbing_close,-]To be free.[w:6]","[func:LostKidFace,sobbing,+][next]"}
		eng="To be fair?[w:6]\nI am almost touched."
		ruscom="Честно?[w:12] \nЯ почти растрогался."
		nrus={"[func:LostKidFace,base_up,+][func:DUB,lost/12/1][w:5][speed:0.89]Однажды, глядя в \nокно, девочка \nзадумалась.", "[func:DUB,lost/12/2][w:5][speed:0.85]'Гора Эботт[waitall:2][w:2]...[waitall:1][w:1][speed:0.85] Она[w:1] \nтакая[w:1] большая[waitall:3][w:2]...[waitall:1]'",  "[func:LostKidFace,base_left,+][func:DUB,lost/12/3][w:4]'А вдруг в её \nне[w:1]драх живут[w:1] \nстрашные [w:1]монстры \nиз легенд[waitall:3][w:2]...?[waitall:1]'",  "[func:LostKidFace,base,+][func:DUB,lost/12/4][w:5]Девочке[w:1] было \nлюбопытно,[w:1] есть ли \nчто-нибудь под \nгорой.",  "[func:LostKidFace,base_close,-][func:DUB,lost/12/5][w:5]Но мама ни[w:2]ко[w:2]гда бы[speed:1.10] \nне отпустила её к \nгоре.[speed:0.93][w:8] Даже на улицу [w:1]\nвыпускала[w:1] редко.",  "[func:LostKidFace,base_left,+][func:DUB,lost/12/6][w:7][speed:1.10]Одиночество[w:1] \nугнетало[w:1] девочку. [func:LostKidFace,base_close,-][w:8][speed:1.10] \nОна чувствовала \nсебя брошенной в \nчетырёх стенах.",  "[func:LostKidFace,base,+][func:DUB,lost/12/7][w:5]Она захотела \nубежать \nкак мо[w:1]жно да[w:2]льше.",  "[func:LostKidFace,sobbing_close,-][func:DUB,lost/12/8][w:5]Чтобы стать \nсвободной[waitall:4][w:3]...[waitall:1][w:4]","[func:LostKidFace,sobbing,+][next]"}
		rus={ "[func:LostKidFace,base_up,+]Однажды, глядя в \nокно, девочка \nзадумалась.", "'Гора Эботт... Она \nтакая большая.'",  "[func:LostKidFace,base_left,+]'А вдруг в её \nнедрах живут \nстрашные монстры \nиз легенд?'",  "[func:LostKidFace,base,+]Девочке было \nлюбопытно, есть ли \nчто-нибудь под \nгорой.",  "[func:LostKidFace,base_close,-]Но мама никогда бы \nне отпустила её к \nгоре. Даже на улицу \nвыпускала редко.",  "[func:LostKidFace,base_left,+]Одиночество \nугнетало девочку. [func:LostKidFace,base_close,-] \nОна чувствовала \nсебя брошенной в \nчетырёх стенах.",  "[func:LostKidFace,base,+]Она захотела \nубежать. \nКак можно дальше.",  "[func:LostKidFace,sobbing_close,-]Чтобы стать \nсвободной.","[func:LostKidFace,sobbing,+][next]"}
		elseif ingo==12 then
		neng={"But girl didn't know \nconsequences of this \ndecision.[w:6]", "[func:LostKidFace,sobbing_close,-]She didn't know what \nwill cause her \nrecklessness and \nnaivety[waitall:4][w:3]...", "[func:LostKidFace,sobbing,+]The girl distracted \nmom by setting fire \nin the barn.[w:6]", "[func:LostKidFace,sobbing_close,-]Girl's mother feared \nof her life and ran \ninto fire without \nknowing[waitall:4][w:3]...", "[func:LostKidFace,sobbing_thinking,+][waitall:4][w:3]...[waitall:1][w:3]that girl was \nalready very far \naway.[w:6]", "[func:LostKidFace,sobbing,+]And in the end her \nmother[waitall:4][w:3]...", "[func:LostKidFace,crying,+][waitall:4][w:3]..."}
		eng="[waitall:4][w:3]...[waitall:1][w:3]She died in a fire settled by her daughter.[w:6] Such tragical finale."
		ruscom="[waitall:4][w:3]...[waitall:1][w:3]Она сгорела в огне,[w:3] который разожгла её дочь.[w:12] \nТрагичный финал."
		rus={"Но девочка не \nзнала,[w:6] что этот \nплан не стоил \nтого.",  "[func:LostKidFace,sobbing_close,-]Она не знала,[w:6] что \nповлечёт за собой \nеё опрометчивость и \nнаивность[waitall:4][w:3]...",  "[func:LostKidFace,sobbing,+]Девочка отвлекла \nмаму,[w:6] подпалив \nскатерть в хлеву.",  "[func:LostKidFace,sobbing_close,-]Мама девочки \nиспугалась за жизнь \nдочери и помчалась \nза ней,[w:6] даже \nне представляя[waitall:4][w:3]...",  "[func:LostKidFace,sobbing_thinking,+][waitall:4][w:3]...[waitall:1][w:3]что девочка уже \nдавно сбежала из \nдома.",  "[func:LostKidFace,sobbing,+]И мама девочки в \nитоге[waitall:4][w:3]...",  "[func:LostKidFace,crying,+][waitall:4][w:3]..."}
		nrus={"[func:DUB,lost/13/1][w:5]Но девочка не \nзнала, что \nэтот план \n[w:4]не стоил[w:1] того.",  "[func:LostKidFace,sobbing_close,-][func:DUB,lost/13/2][w:5]Она не знала, что \nповлечёт за собой \nеё опрометчивость и \nнаивность[waitall:4][w:3]...",  "[func:LostKidFace,sobbing,+][func:DUB,lost/13/3][w:5]Девочка отвлекла \nмаму,[w:3] подпалив \nскатерть [w:1]в хлеву.",  "[func:LostKidFace,sobbing_close,-][func:DUB,lost/13/4][w:5]Мама девочки \nиспугалась за жизнь \nдочери [w:2]и помчалась \nза ней[waitall:4][w:3]...[waitall:1][w:3] даже \nне[w:1] представляя[waitall:4][w:3]...",  "[func:LostKidFace,sobbing_thinking,+][waitall:4][w:3]...[waitall:1][func:DUB,lost/13/5][w:9][speed:0.90]Что девочка уже \nдавно[w:1] сбежала[w:1] из \nдому.",  "[func:LostKidFace,sobbing,+][func:DUB,lost/13/6][w:5][speed:0.85]И мама[w:1] де[w:1]во[w:1]чки[w:8] в \nи[w:1]тоге[waitall:4][w:3]...",  "[func:LostKidFace,crying,+][waitall:4][w:3]..."}
		elseif ingo==13 then
		neng={"[func:LostKidFace,sobbing_close,-]But girl didn't know \nit.[w:6]", "She was running \ninside the forest \nnight,[w:3] breathing \ndeeply fresh evening \nbreeze.[w:6]", "[func:LostKidFace,sobbing_upsmile,+]She was laughing in \nall her voice and \ncrying from \nhappiness.[w:6]", "[func:LostKidFace,sobbing,+]Crying from the \nfeeling of her bare \nfeet got tingled by \ngrass.[w:6] [func:LostKidFace,sobbing_close,-]\nFrom rustle of \nthe bushes.[w:6]", "[func:LostKidFace,sobbing_smile,+]Crying from freedom.[w:6]"}
		eng="Freedom is very relative.[w:6]\nEven she should understand that."
		ruscom="Свобода - вещь относительная.[w:6] \nДаже она должна это понимать."
		nrus={"[func:LostKidFace,sobbing_close,-][func:DUB,lost/14/1][w:5]Но[w:1] девочка [w:2]ничего \nне знала.", "[func:DUB,lost/14/2][w:5]Она бежала по \nночному лесу,[w:4] дыша \nполной грудью \n[w:3]свежей[w:4] вечерней[w:4] \nпрохладой.",  "[func:LostKidFace,sobbing_upsmile,+][func:DUB,lost/14/3][w:4]Она смеялась во \nвесь голос и \nплакала от \nрадости.",  "[func:LostKidFace,sobbing,+][func:DUB,lost/14/4][w:5]Плакала от того,[w:2] \nчто[w:4] босые[w:1] ноги[w:1] \nщекочет [w:2]трава.[w:9] [func:LostKidFace,sobbing_close,-] \nОт того,[w:4] что слышит \nшорох[w:1] кустов.", "[func:LostKidFace,sobbing_smile,+][func:DUB,lost/14/5][w:12]От[w:1] того,[w:3] что она[w:1] \nбыла[w:3].[w:3].[w:3].[w:4] Сво[w:1]бо[w:2]д[w:1]на."}
		rus={ "[func:LostKidFace,sobbing_close,-]Но девочка ничего \nне знала.", "Она бежала по \nночному лесу,[w:6] дыша \nполной грудью \nсвежей вечерней \nпрохладой.",  "[func:LostKidFace,sobbing_upsmile,+]Она смеялась во \nвесь голос и \nплакала от \nрадости.",  "[func:LostKidFace,sobbing,+]Плакала от того,[w:6] \nчто босые ноги \nщекочет трава.[w:9] [func:LostKidFace,sobbing_close,-] \nОт того,[w:6] что слышит \nшорох кустов.", "[func:LostKidFace,sobbing_smile,+]От того,[w:6] что она \nбыла свободна."}
		elseif ingo==14 then
		neng={"[func:LostKidFace,base_close,-]She was on her way \nto mountain[waitall:4][w:3]...", "[func:LostKidFace,base_up,+]She was chanted by \nthe sight of stars,[w:3] \nwhile climbing up the \nrocks.[w:6]", "[func:LostKidFace,base_close,-]She dreamed how she \nfinds elder monsters,[w:3] \nbefriends with them \nand [func:LostKidFace,base_left,+]show to \neveryone they're \nnot scary.[w:6]", "[func:LostKidFace,base_up,+]She dreamed about \nshowing something \nthis world had never \nseen before.[w:6]", "[func:LostKidFace,base_close,-]Her Soul was filled \nwith hopes and \ndreams.[w:6] \nShe was burning \nwith shining \nDetermination[waitall:4][w:3]..."}
		eng="Oh no,[w:3] I get where this is going.[w:6]\nSounds no good."
		ruscom="О нет,[w:3] я понял,[w:3] к чему она ведёт.[w:6] \nЗвучит не весело."
		nrus={"[func:LostKidFace,base_close,-][func:DUB,lost/15/1][w:5]Её[w:1] путь[w:1] держал[w:1] к \nгоре[waitall:4][w:3]...",  "[func:LostKidFace,base_up,+][func:DUB,lost/15/2][w:5]Она заворожено \nсмотрела на звёзды,[w:2] \nвзбираясь по камням.",  "[func:LostKidFace,base_close,-][func:DUB,lost/15/3][w:5]Она [speed:1.10]замечталась о \nтом, как найдёт \nдревних монстров,[w:6] \nподружится с ними \nи[func:LostKidFace,base_left,+] покажет всем,[w:2] что \nони[w:1] не[w:1] страшные.",  "[func:LostKidFace,base_up,+][func:DUB,lost/15/4][w:5]Она мечтала о том, \nчто покажет всему \nмиру то, чего они \nещё не видели.",  "[func:LostKidFace,base_close,-][func:DUB,lost/15/5][w:9][speed:0.90]Её Душа[w:2] была полна \nмечта[w:1]ний[w:1] и надежд.[w:15] \nОна [w:1]горе[w:2]ла[w:1] я[w:3]ркой[w:2] \nРе[w:1]ши[w:3]мос[w:1]тью[waitall:4][w:3]..."}
		rus={ "[func:LostKidFace,base_close,-]Её путь лежал к \nгоре[waitall:4][w:3]...",  "[func:LostKidFace,base_up,+]Она заворожено \nсмотрела на звёзды,[w:6] \nвзбираясь по камням.",  "[func:LostKidFace,base_close,-]Она замечталась о \nтом,[w:6] как найдёт \nдревних монстров, \nподружится с ними \nи [func:LostKidFace,base_left,+] покажет всем,[w:6] что \nони не страшные.",  "[func:LostKidFace,base_up,+]Она мечтала о том,[w:6] \nчто покажет всему \nмиру то,[w:9] чего они \nещё не видели.",  "[func:LostKidFace,base_close,-]Её Душа была полна \nмечтаний и надежд.[w:9] \nОна горела яркой \nРешимостью[waitall:4][w:3]..."}
		elseif ingo==15 then
		neng={"[func:LostKidFace,base,+][waitall:4][w:3]...[waitall:1][w:3]Of course,[w:3] she \nfound nothing but \nthis old cave.", "[func:LostKidFace,base_left,+]But she wasn't upset.", "[func:LostKidFace,base_close,-]In that every moment \nshe felt herself the \nmost free human in \nthe entire world.", "[func:LostKidFace,base_up,+]There,[w:3] on the highest \npeak of mountain,[w:3] \nbreathing the smell \nof ether[waitall:4][w:3]...", "[func:LostKidFace,sobbing,+]But then her nose \nwas touched but \nsomething sturdy \nand rude[waitall:4][w:3]..."}
		eng="[waitall:4][w:3]...[waitall:1][w:3]Smell of ash.[w:6] \nThe fire."
		ruscom="[waitall:4][w:3]...[waitall:1][w:3]Запах гари.[w:6] \nПожар."
		nrus={"[func:LostKidFace,base,+][waitall:4][w:3]..[func:DUB,lost/16/1].[waitall:1][w:3]Есте[w:1]ственно,[w:7] \nничего, кроме \nстарой пещеры,[w:1] \nдевочка[w:1] не нашла.",  "[func:LostKidFace,base_left,+][func:DUB,lost/16/2][w:6]Но [w:1]это её[w:1] не \nволновало.",  "[func:LostKidFace,base_close,-][func:DUB,lost/16/3][w:5][speed:1.10]В тот миг она [speed:1.20]\nчувствовала себя[speed:1.10][w:1] \nса[w:2]мой[w:1] свободной \nна све[w:2]те.",  "[func:LostKidFace,base_up,+][func:DUB,lost/16/4][w:6]Там,[w:4] на вершине \nгоры,[w:6] под звёздами,[w:2] \nвдыхая [w:1]запах[w:1] небес[waitall:4][w:3]...",  "[func:LostKidFace,sobbing,+][func:DUB,lost/16/5][w:5][speed:0.79]Но затем её носа \nкоснулся жёсткий и \nрезкий аромат[waitall:4][w:3]..."}
		rus={ "[func:LostKidFace,base,+][waitall:4][w:3]...[waitall:1][w:3]Естественно,[w:6] \nничего,[w:6] кроме \nстарой пещеры, \nдевочка не нашла.",  "[func:LostKidFace,base_left,+]Но её это не \nволновало.",  "[func:LostKidFace,base_close,-]В тот миг она \nчувствовала себя \nсамой свободной \nна свете.",  "[func:LostKidFace,base_up,+]Там,[w:6] на вершине \nгоры,[w:6] под звёздами,[w:6] \nвдыхая запах небес[waitall:4][w:3]...",  "[func:LostKidFace,sobbing,+]Но затем её носа \nкоснулся жёсткий и \nрезкий аромат[waitall:4][w:3]..."}
		elseif ingo==16 then
		neng={"[func:LostKidFace,base_close,-]The girl looked \naround for what \nwas causing such \nsmell.", "[func:LostKidFace,base,+]And only then she \nsaw how her village \nwas being burned \nwith crimson fire.", "[func:LostKidFace,base_left,+]Paralyzed by fear,[w:3] \nthe girl could do \nnothing[waitall:4][w:3]...[waitall:1][w:3] [func:LostKidFace,confused,+]She felt \ndown on her knees \nand began to shake\n her entire body[waitall:4][w:3]...", "[func:LostKidFace,sobbing,+]Her Determination in \none moment was torn \nto shreds.", "[func:LostKidFace,sobbing_close,-]Her head was flooded \nwith fear about \nthe destiny of her \nmother,[w:3] village,[w:3] \nfriends and every \nvillager.", "[func:LostKidFace,sobbing_up,+]And in this every \nmoment she realized[waitall:4][w:3]..."}
		eng="This is only her fault."
		ruscom="Это только её вина."
		nrus={"[func:LostKidFace,base_close,-][func:DUB,lost/17/1][w:5]Девочка заозиралась \nв поисках источника[w:1] \nзапаха.",  "[func:LostKidFace,base,+][func:DUB,lost/17/2][w:5][speed:0.94]И лишь тогда \nзаметила, как её \nдеревня сверкала[w:2] \nалыми[w:1] языками \nпламени.", "[func:LostKidFace,base_left,+][func:DUB,lost/17/3][w:6][speed:1.10]Девочка от страха \nне могла[speed:0.95] \nпошевелиться[waitall:3][w:2]...[waitall:1][w:2] [func:LostKidFace,confused,+][speed:1.10]Она \nрухнула на колени \nи затряслась всем \nтелом[waitall:4][w:3]...[waitall:1][w:3]",  "[func:LostKidFace,sobbing,+][func:DUB,lost/17/4][w:5]Её Решимость в миг \nразбилась о [w:1]зе[w:1]млю.",  "[func:LostKidFace,sobbing_close,-][func:DUB,lost/17/5][w:5]Её голову \nзахлестнул страх о \nматери,[w:8] о деревне,[w:2] \nо друзьях,[w:6] о всех, \nкто остался с \nней.", "[func:LostKidFace,sobbing_up,+][func:DUB,lost/17/6][w:5]И в этот [w:1]момент \nона поняла[waitall:4][w:3]..."}
		rus={ "[func:LostKidFace,base_close,-]Девочка заозиралась \nв поисках источника \nзапаха.",  "[func:LostKidFace,base,+]И лишь тогда \nзаметила,[w:6] как её \nдеревня сверкала \nалыми языками \nпламени", "[func:LostKidFace,base_left,+]Девочка от страха \nне могла \nпошевелиться[waitall:4][w:3]...[waitall:1][w:3] [func:LostKidFace,confused,+] Она \nрухнула на колени \nи затряслась всем \nтелом[waitall:4][w:3]...[waitall:1][w:3]",  "[func:LostKidFace,sobbing,+]Её Решимость в миг \nразбилась об землю.",  "[func:LostKidFace,sobbing_close,-]Её голову \nзахлестнул страх о \nматери,[w:6] о деревне,[w:6] \nо друзьях,[w:6] о всех,[w:6] \nкто остался в \nдеревне.", "[func:LostKidFace,sobbing_up,+]И в этот момент \nона поняла[waitall:4][w:3]...[waitall:1][w:3]"}
		elseif ingo==17 then
		neng={"[func:LostKidFace,sobbing_close,-]She spent the entire \nnight on her knees.", "[func:LostKidFace,sobbing,+]Fear left her \nmotionless.[w:6] \nTears were dropping \nfrom her eyes \nunstoppable.", "[func:LostKidFace,sobbing_up,+]She could do nothing.[w:6] \nShe couldn't save \nanyone.", "[func:LostKidFace,sobbing_close,-]And it is only her \nfault that her village \nturned into the pile \nof ash.", "[func:LostKidFace,sobbing,+]By the morning fire \nspread on spruce \nforest so fast as if \nabsorbing the entire \nworld.", "[func:LostKidFace,sobbing_close,-]And in that burning \nworld[waitall:4][w:3]...[waitall:1][w:3] [func:LostKidFace,sobbing_smile,+]The girl was \nleft all alone."}
		eng="I don't get it[waitall:4][w:3]...[waitall:1][w:3] \nI am not supposed to feel compassion,[w:3] but[waitall:4][w:3]..."
		ruscom="Я не понимаю[waitall:4][w:3]...[waitall:1][w:3] \nЯ не должен испытывать сострадания,[w:3] но[waitall:4][w:3]...[waitall:1][w:3]"
		nrus={"[func:LostKidFace,sobbing_close,-][func:DUB,lost/18/1][w:5][speed:0.88]Девочка[w:1] стояла на \nколенях всю ночь.",  "[func:LostKidFace,sobbing,+][func:DUB,lost/18/2][w:5]Страх парализовал \nеё.[w:12][speed:0.88] Слёзы градом \nлились[w:1] из её[w:1] глаз.", "[func:DUB,lost/18/3][w:5][speed:0.92]Она ничего не могла \nподелать.[w:9][func:LostKidFace,sobbing_up,+] Она не \nмогла никого \nспасти.",  "[func:LostKidFace,sobbing_close,-][func:DUB,lost/18/4][w:5]И только она \nвиновата в том,[speed:0.91] что \nвся [w:1]деревня \nобратилась[w:1] кучей \nпраха.", "[func:LostKidFace,sobbing,+][func:DUB,lost/18/5][w:5][speed:0.90]К утру пожар \nперебросился на \nлес,[w:10] будто поглощая \nсобой весь мир.",  "[func:LostKidFace,sobbing_close,-][func:DUB,lost/18/6][w:5]И в этом мире[waitall:4][w:3]...[waitall:1][w:3] [func:LostKidFace,sobbing_smile,+] \nДевочка осталась \nсовсем [w:1]одна."}
		rus={ "[func:LostKidFace,sobbing_close,-]Девочка стояла на \nколенях всю ночь.",  "[func:LostKidFace,sobbing,+]Страх парализовал \nеё.[w:9] Слёзы градом \nлились из её глаз.", "Она ничего не могла \nподелать.[w:9][func:LostKidFace,sobbing_up,+] Она не \nмогла никого спасти.",  "[func:LostKidFace,sobbing_close,-]И только она \nвиновата в том,[w:6] что \nвся деревня \nобратилась кучей \nпраха.", "[func:LostKidFace,sobbing,+]К утру пожар \nперебросился на \nлес,[w:6] будто поглощая \nсобой весь мир.",  "[func:LostKidFace,sobbing_close,-]И в этом мире[waitall:4][w:3]...[waitall:1][w:3] [func:LostKidFace,sobbing_smile,+] \nДевочка осталась \nсовсем одна."}
		elseif ingo==18 then
		neng={"[func:LostKidFace,sobbing_up,+]When she was looking \non this fire,[w:3] the \nfeeling grew inside \nher that it's meant \nto be like this.[w:6]", "[func:LostKidFace,sobbing_close,-]In that moment she \nresigned herself \nthat the world hates \nher.[w:6]", "[func:LostKidFace,sobbing_thinking,+]How could it be the \nother way?[w:6] Life \nitself took \neverything from \nher.[w:6]", "[func:LostKidFace,sobbing,+]Her family,[w:3] friends,[w:3] \nvillage[waitall:4][w:3]...", "[func:LostKidFace,sobbing_close,-]And that was all her \nfault.[w:6]", "[func:LostKidFace,sobbing,+]That's when she \nrealized[waitall:4][w:3]...[waitall:1][w:3] [func:LostKidFace,sobbing_thinking,+]She didn't \nknow how to move \nforward.[w:6]", "She was lost in those \neternal corridors of \nlife.[w:6]"}
		eng="I shouldn't sympathy her[waitall:4][w:3]...[waitall:1][w:3]\nI can't![w:6]\nShut her up,[w:3] actor!"
		ruscom="Я не могу сострадать ей[waitall:4][w:3]...[waitall:1][w:3] \nНе могу! \nЗаткни её,[w:3] актёр!"
		nrus={"[func:LostKidFace,sobbing_up,+][func:DUB,lost/19/1][w:5][speed:1.09]Когда она смотрела \nна этот огонь,[w:4] \nвнутри неё росло \nчувство,[w:6] что так и \nдолжно быть.",  "[func:LostKidFace,sobbing_close,-][func:DUB,lost/19/2][w:5]В тот миг она \nсмирилась с тем,[w:2] \nбудто весь мир был \nнастроен [w:1]против[w:1] \nнеё.",  "[func:LostKidFace,sobbing_thinking,+][func:DUB,lost/19/3][w:5][speed:0.75]А как иначе?[w:12][speed:0.95] Жизнь \nотобрала у неё всё, \nчто она имела.",  "[func:LostKidFace,sobbing,+][func:DUB,lost/19/4][w:5][speed:0.75]Семью,[w:10] друзей,[w:12] \nдеревню[waitall:4][w:3]...[waitall:1][w:3]",  "[func:LostKidFace,sobbing_close,-][func:DUB,lost/19/5][w:5][speed:0.88]И всё это[w:3] была[w:2] \nтолько [w:2]её вина.",  "[func:LostKidFace,sobbing,+][func:DUB,lost/19/6][w:5]В тот миг девочка \nпоняла[waitall:3][w:2]...[waitall:1][w:2] [func:LostKidFace,sobbing_thinking,+]Что совсем \nне знает, как быть \nдальше.", "[func:DUB,lost/19/7][w:5]Она [w:1]потерялась в \nэтих бесконечных \nперипетиях [w:1]жизни."}
		rus={"[func:LostKidFace,sobbing_up,+]Когда она смотрела \nна этот огонь,[w:6] \nвнутри неё росло \nчувство,[w:6] что так и \nдолжно быть.",  "[func:LostKidFace,sobbing_close,-]В тот миг она \nсмирилась с тем,[w:6] \nбудто весь мир был \nнастроен против \nнеё.",  "[func:LostKidFace,sobbing_thinking,+]А как иначе? Жизнь \nотобрала у неё всё,[w:6] \nчто она имела.",  "[func:LostKidFace,sobbing,+]Семью,[w:6] друзей,[w:6] \nдеревню[waitall:4][w:3]...[waitall:1][w:3]",  "[func:LostKidFace,sobbing_close,-]И всё это была \nтолько её вина.",  "[func:LostKidFace,sobbing,+]В тот миг девочка \nпоняла[waitall:4][w:3]...[waitall:1][w:3] [func:LostKidFace,sobbing_thinking,+]Что совсем \nне знает,[w:6] как быть \nдальше.", "Она потерялась в \nэтих бесконечных \nперипетиях жизни."}
		elseif ingo==19 then
		neng={"[func:LostKidFace,base,+]She dreamed to be \nfree.", "[func:LostKidFace,angry,+]Free from sorrow for \nher father.[w:6] From her \nmother's ropes.", "She wanted to decide \nher fate by herself \nand find in it her \nhappiness.", "[func:LostKidFace,base,+]And that's when she \nrealized that when \nher life[waitall:4][w:3]...[waitall:1][w:3] [func:LostKidFace,base_close,-]ends,[w:3] \nshe would be free as \nwell.", "[func:LostKidFace,base,+]She would have \nnothing to decide[waitall:4][w:3]...[waitall:1][w:3] [func:LostKidFace,base_left,+]\nTo find answers in[waitall:4][w:3]...", "[func:LostKidFace,base,+]If she really died \nthat day,[w:3] [func:LostKidFace,base_up,+]the girl \nwould be free."}
		eng="[func:state,NONE][color:8040ff][noskip]I beg you,[w:6][waitall:2][func:Shake] ENOUGH![w:30][func:ENOUGH]"
		ruscom="[func:state,NONE][color:8040ff][noskip]Прошу,[w:6] [waitall:2][func:Shake]ХВАТИТ![w:30][func:ENOUGH]"
		nrus={"[func:LostKidFace,base,+][func:DUB,lost/20/1][w:5][speed:0.85]Она мечтала быть \nсвободной.",  "[func:LostKidFace,angry,+][func:DUB,lost/20/2][w:7][speed:0.9]От ско[w:2]рби по отцу.[w:9]\nОт[w:1] ве[w:1]рё[w:1]вок ма[w:2]те[w:1]ри.", "[func:DUB,lost/20/3][w:5]Она хотела сама \nрешать[speed:1.05] свою судьбу \nи найти в ней своё [speed:1.10]\nсчастье.",  "[func:LostKidFace,base,+][func:DUB,lost/20/4][w:6]И тогда [w:1]она [w:1]поняла,[w:7] \nчто если [w:1]её [w:1]жизнь[waitall:3][w:2]...[waitall:1][w:1] [func:LostKidFace,base_close,-] \nОборвё[w:3]тся,[w:16] то она [w:1]\nснова [w:1]будет \nсвободна.", "[func:LostKidFace,base,+][func:DUB,lost/20/5][w:5]Не надо будет \nничего решать[waitall:3][w:2]...[waitall:1][w:2] [func:LostKidFace,base_left,+]\nНе надо будет \nискать ответы[waitall:4][w:3]...[waitall:1][w:3]", "[func:LostKidFace,base,+][func:DUB,lost/20/6][w:5]Если бы она умерла \nв тот день,[w:9] [func:LostKidFace,base_up,+]девочка[w:1] \nстала бы [w:1]свобо[w:2]дна."}
		rus={ "[func:LostKidFace,base,+]Она мечтала быть \nсвободной.",  "[func:LostKidFace,angry,+]От скорби по отцу.[w:9]\nОт верёвок матери.", "Она хотела сама \nрешать свою судьбу \nи найти в ней своё \nсчастье.",  "[func:LostKidFace,base,+]И тогда она поняла,[w:6] \nчто если её жизнь[waitall:4][w:3]...[waitall:1][w:3] [func:LostKidFace,base_close,-] \nоборвётся,[w:6] то она \nснова будет \nсвободна.", "[func:LostKidFace,base,+]Не надо будет \nничего решать[waitall:4][w:3]...[waitall:1][w:3] [func:LostKidFace,base_left,+]\nНе надо будет \nискать ответы[waitall:4][w:3]...[waitall:1][w:3]", "[func:LostKidFace,base,+]Если бы она умерла \nв тот день,[w:6] [func:LostKidFace,base_up,+] девочка \nстала бы свободной."}
		elseif ingo==20 then
		neng={"[func:LostKidFace,base,+]The girl returned to \ncave.[w:6] And found a \npit in it.", "[func:LostKidFace,base_close,-]Very deep pit.[w:6] So \ndeep that she \ncouldn't see the end \nof it.", "[func:LostKidFace,base,+]And she made step \nto freedom.", "[func:LostKidFace,base_close,-]Lost in this world \nchild wanted to be \nfree."}
		eng="[waitall:4][w:3]..."
		ruscom="[waitall:4][w:3]..."
		nrus={"[func:LostKidFace,base,+][func:DUB,lost/21/1][w:7]Девочка вернулась \nв пещеру.[w:12] \nОна [w:1]нашла [w:1]я[w:2]му.",  "[func:LostKidFace,base_close,-][func:DUB,lost/21/2][w:5][speed:0.75]О[w:3]чень глубокую яму[waitall:4][w:3]...[waitall:1][w:3][func:DUB,lost/21/3][w:3] [speed:0.85]\nТакую глубокую, [speed:0.98]что \nне было видно ей \nконца.",  "[func:LostKidFace,base,+][func:DUB,lost/21/4][w:4][speed:0.85]И сделала шаг \nнавстречу свободе.",  "[func:LostKidFace,base_close,-][func:DUB,lost/21/5][w:5]Потерянное в мире \nдитя хотело \nобрести [w:1]покой."}
		rus={ "[func:LostKidFace,base,+]Девочка вернулась \nв пещеру.[w:9] \nОна нашла яму.",  "[func:LostKidFace,base_close,-]Очень глубокую яму.[w:9] \nТакую глубокую,[w:6] что \nне было видно ей \nконца.",  "[func:LostKidFace,base,+]И сделала шаг \nнавстречу свободе.",  "[func:LostKidFace,base_close,-]Потерянное в мире \nдитя хотело \nобрести покой."}
		elseif ingo==21 then
		neng={"[func:LostKidFace,base,+]And the end of this \ntale[waitall:4][w:3]...", "[func:LostKidFace,base_left,+]You already know it,[w:3] \ndon't you?", "[func:LostKidFace,base,+]The girl was found by \nmonsters down there.[w:6] [func:LostKidFace,base_close,-]\nThey saved her.", "[func:LostKidFace,base,+]They healed her \nwounds.[w:6] Welcomed to \ntheir family.", "[func:LostKidFace,sobbing_close,-]Not for so long[waitall:4][w:3]...[waitall:1][w:3] \nThe girl believed \nthat she found \nfreedom.", "[func:LostKidFace,sobbing,+]Found place where \nshe wants to be.", "[func:LostKidFace,sobbing_smile,+]She found[waitall:4][w:3]...[waitall:1][w:3] new \nhome.[w:6] \nNew family."}
		eng="[waitall:4][w:3]...[waitall:1][w:3]Actor[waitall:4][w:3]...[waitall:1][w:3] Are you[waitall:4][w:3]...[waitall:1][w:3] Going against me?"
		ruscom="[waitall:4][w:3]...[waitall:1][w:3]Актёр.[w:6] Ты что[waitall:4][w:3]...[waitall:1][w:3] Задумал предать меня?"
		nrus={"[func:LostKidFace,base,+][func:DUB,lost/22/1][w:6]А продолжение[w:1] этой \nсказки[waitall:4][w:3]...[waitall:1][w:3]",  "[func:LostKidFace,base_left,+][func:DUB,lost/22/2][w:9]Тебе известно,[w:6] \nне так ли?",  "[func:LostKidFace,base,+][func:DUB,lost/22/3][w:5][speed:0.88]Девочку нашли \nобитавшие здесь \nмонстры.[w:9] [func:LostKidFace,base_close,-] \nОни спасли её.",  "[func:LostKidFace,base,+][func:DUB,lost/22/4][w:5][speed:0.89]Они залечили её \nра[w:2]ны.[w:9] \nОни приняли[w:1] её[w:1] в \nсемью.",  "[func:LostKidFace,sobbing_close,-][func:DUB,lost/22/5][w:6][speed:0.78]Ненадолго, [w:8]девочка[speed:0.89] \nповерила,[w:1][speed:1.05] будто \nсмогла [w:1]найти[w:1] \nсвободу.",  "[func:LostKidFace,sobbing,+][func:DUB,lost/22/6][w:6]Место, [w:1]где она \nхотела бы быть.",  "[func:LostKidFace,sobbing_smile,+][func:DUB,lost/22/7][w:6]Она нашла[waitall:4][w:3]...[waitall:1][w:2][speed:0.85] новый \nдом.[w:12][speed:0.75] \nНовую [w:1]семью."}
		rus={ "[func:LostKidFace,base,+]А продолжение этой \nсказки[waitall:4][w:3]...[waitall:1][w:3]",  "[func:LostKidFace,base_left,+]Тебе известно,[w:6] \nне так ли?",  "[func:LostKidFace,base,+]Девочку нашли \nобитавшие здесь \nмонстры.[w:9] [func:LostKidFace,base_close,-] \nОни спасли её.",  "[func:LostKidFace,base,+]Они залечили её \nраны.[w:9] \nОни приняли её в \nсемью.",  "[func:LostKidFace,sobbing_close,-]Ненадолго[waitall:4][w:3]...[waitall:1][w:3] девочка \nповерила,[w:6] будто \nсмогла найти \nсвободу.",  "[func:LostKidFace,sobbing,+]Место,[w:6] где она \nхотела бы быть.",  "[func:LostKidFace,sobbing_smile,+]Она нашла[waitall:4][w:3]...[waitall:1][w:3] новый \nдом.[w:9] \nНовую семью."}
		elseif ingo==22 then
		neng={"[func:LostKidFace,sobbing_close,-]And thus lost child \nfound her home.", "[func:LostKidFace,base,+]Found goal in life \nand what she wants \nto protect until her \nlast breath.", "[func:LostKidFace,angry,+][waitall:4][w:3]...", "And you took all \nthat away from me.", "You left me again \nwith nothing by my \nside.", "[func:LostKidFace,base,+]Was it worth \nsomething?", "[func:LostKidFace,base_left,+]Hell,[w:3] if I know[waitall:4][w:3]...", "[func:LostKidFace,base,+]But this is the end \nof my fairytale.", "[func:LostKidFace,base_close,-]Of my story.", "[func:LostKidFace,base,+]I am done talking.[w:6] \nI am ready to accept \nmy death.", "[func:LostKidFace,base_close,-]C'mon,[w:3] partner.[w:6] Only \none step[waitall:4][w:3]...[waitall:1][w:3] \nAnd we will end this.[w:6]"}
		eng="I give you your last chance,[w:3] actor.[w:6]\nDon't play with fire."
		ruscom="Я даю тебе последний шанс,[w:3] актёр.[w:6] \nНе играй с огнём."
		nrus={"[func:LostKidFace,sobbing_close,-][func:DUB,lost/23/1][w:6][speed:0.95]И та[w:2]к [w:2]потерянное \nдитя нашла \nсвой дом.",  "[func:LostKidFace,base,+][func:DUB,lost/23/2][w:6][speed:0.89]Нашла цель в жизни[w:6] \nи то,[w:3] что она будет \nзащищать[speed:0.99] до \nпоследнего вздоха.",  "[func:LostKidFace,angry,+][waitall:4][w:3]...[waitall:1][w:3]", "[func:DUB,lost/23/3][w:6][speed:1.15]А ты всё [w:1]это [w:1]забрал \nу меня!", "[func:DUB,lost/23/4][w:5][speed:1.05]Ты вновь[w:1] лишил меня \nвсего!",  "[func:LostKidFace,base,+][func:DUB,lost/23/5][w:7]Стоило ли это того?",  "[func:LostKidFace,base_left,+][func:DUB,lost/23/6][w:6]Чёрт,[w:2] если бы я \nзнала[waitall:4][w:3]...[waitall:1][w:3]",  "[func:LostKidFace,base,+][func:DUB,lost/23/7][w:6][speed:0.90]Но таков конец моей \nсказки.",  "[func:LostKidFace,base_close,-][func:DUB,lost/23/8][w:6][speed:0.82]Моей истории.",  "[func:LostKidFace,base,+][func:DUB,lost/23/9][w:6][speed:0.92]Я выговорилась.[w:12] \nЯ готова[speed:1.00] принять \nсвою смерть.",  "[func:LostKidFace,base_close,-][func:DUB,lost/23/10][w:6]Давай, партнёр.[w:4] \nВсего один шаг[waitall:3][w:2]...[waitall:1][w:2] \nИ мы покончим с \nэтим."}
		rus={ "[func:LostKidFace,sobbing_close,-]И так потерянное \nдитя нашла \nсвой дом.",  "[func:LostKidFace,base,+]Нашла цель в жизни \nи то,[w:6] что она будет \nзащищать до \nпоследнего вздоха.",  "[func:LostKidFace,angry,+][waitall:4][w:3]...[waitall:1][w:3]", "А ты всё это забрал \nу меня.", "Ты вновь лишил меня \nвсего.",  "[func:LostKidFace,base,+]Стоило ли это того?",  "[func:LostKidFace,base_left,+]Чёрт,[w:6] если бы я \nзнала[waitall:4][w:3]...[waitall:1][w:3]",  "[func:LostKidFace,base,+]Но таков конец моей \nсказки.",  "[func:LostKidFace,base_close,-]Моей истории.",  "[func:LostKidFace,base,+]Я выговорилась.[w:9] \nЯ готова принять \nсвою смерть.",  "[func:LostKidFace,base_close,-]Давай,[w:6] партнёр.[w:9] \nВсего один шаг[waitall:4][w:3]...[waitall:1][w:3] \nИ мы покончим с \nэтим."}
		elseif ingo==23 then
		neng={"[func:LostKidFace,sobbing_close,-][waitall:4][w:3]...[waitall:1][w:3]Why are you \nhesitating?", "[func:LostKidFace,sobbing,+]Come on.[w:6] Stop giving \nme false hope.", "[func:LostKidFace,crying,+]I already accepted \nmy fate[waitall:4][w:3]...[waitall:1][w:3] I[waitall:4][w:3]...[waitall:1][w:3] [func:LostKidFace,crying_loud,-]\nI let go the destiny \nof the entire world!", "[func:LostKidFace,crying,+]Please[waitall:4][w:3]...[waitall:1][w:3] Let me die[waitall:4][w:3]...", "[func:LostKidFace,sobbing_thinking,+]I can't live in the \nworld where I am \nlost[waitall:4][w:3]...", "[func:LostKidFace,sobbing,+]In the world where I \nhave no family[waitall:4][w:3]...", "[func:LostKidFace,sobbing_up,+]No home[waitall:4][w:3]...", "[func:LostKidFace,sobbing_upsmile,+]And no you[waitall:4][w:3]...","[func:LostKidFace,sobbing,+][func:AngerMetta][next]"}
		eng="[noskip]I got you.[w:6] You prefered her instead of me.[w:6] [func:LowerMusic]If so[waitall:4][w:3]...[waitall:1][w:3] It's time for your retire.[w:45][func:METTANAME][w:9000]"
		ruscom="[noskip]Я тебя понял.[w:6] Ты предпочёл меня ей.[w:6] [func:LowerMusic]Раз так[waitall:4][w:3]...[waitall:1][w:3]\nНастала пора тебя уволить.[w:45][func:METTANAME][w:9000]"
		nrus={"[func:LostKidFace,sobbing_close,-][waitall:4][w:3]...[waitall:1][func:DUB,lost/24/1][w:5][speed:0.80]Почему ты \nколебаешься?",  "[func:LostKidFace,sobbing,+][func:DUB,lost/24/2][w:7]Ну же.[w:12][speed:1.05] \nХватит давать мне \nложную надежду.", "[func:LostKidFace,crying,+][func:DUB,lost/24/3][w:6]Я смирилась со \nсвоей смертью.[w:9] Я[waitall:5][w:4]...[waitall:1][w:10] [func:LostKidFace,crying_loud,-][speed:0.83] \nЯ отпустила судьбу \nвсего мира[waitall:4][w:3]...[waitall:1][w:3]",  "[func:LostKidFace,crying,+][func:DUB,lost/24/4][w:6]Пожалуйста![w:4] Дай [w:1]\nмне[w:1] умереть![w:3]",  "[func:LostKidFace,sobbing_thinking,+][func:DUB,lost/24/5][w:5]Я не могу жить в \nмире, в котором \nпотерялась[waitall:4][w:3]...[waitall:1][w:3]",  "[func:LostKidFace,sobbing,+][func:DUB,lost/24/6][w:6]В мире, где у меня \nнет ни семьи[waitall:4][w:3]...[waitall:1][w:3]",  "[func:LostKidFace,sobbing_up,+][func:DUB,lost/24/7][w:6]Ни [w:2]дома[waitall:4][w:3]...[waitall:1][w:3]",  "[func:LostKidFace,sobbing_upsmile,+][func:DUB,lost/24/8][w:6]Ни [w:1]те[w:2]бя[w:2][waitall:4][w:3]...[waitall:1][w:3]","[func:LostKidFace,sobbing,+][func:AngerMetta][next]"}
		rus={ "[func:LostKidFace,sobbing_close,-][waitall:4][w:3]...[waitall:1][w:3]Почему ты \nколеблешься?",  "[func:LostKidFace,sobbing,+]Ну же.[w:9] \nХватит давать мне \nложную надежду.", "[func:LostKidFace,crying,+]Я смирилась со \nсвоей смертью.[w:9] Я[waitall:4][w:3]...[waitall:1][w:3] [func:LostKidFace,crying_loud,-] \nЯ отпустила судьбу \nвсего мира!",  "[func:LostKidFace,crying,+]Пожалуйста[waitall:4][w:3]...[waitall:1][w:3] Дай \nмне умереть[waitall:4][w:3]...[waitall:1][w:3]",  "[func:LostKidFace,sobbing_thinking,+]Я не могу жить в \nмире,[w:6] в котором \nпотерялась[waitall:4][w:3]...[waitall:1][w:3]",  "[func:LostKidFace,sobbing,+]В мире,[w:6] где у меня \nнет ни семьи[waitall:4][w:3]...[waitall:1][w:3]",  "[func:LostKidFace,sobbing_up,+]Ни дома[waitall:4][w:3]...[waitall:1][w:3]",  "[func:LostKidFace,sobbing_upsmile,+][speed:0.5][w:6]Ни тебя[waitall:4][w:3]...[waitall:1][w:3]","[func:LostKidFace,sobbing,+][func:AngerMetta][next]"}
	end
	if ingo>5 then
		wav={"nothing"}
	end
	if not wav then
		else
		Encounter.SetVar("nextwaves",wav)
	end
	local dub=Encounter.GetVar("dubbing")
	if lang=="rus" and dub then
		nrus=AddLine(nrus,"[novoice]")
	end
	local dial={}
	if lang=="rus" then
		Encounter.SetVar("comm",ruscom)
		if dub then
			dial=nrus
		else
			dial=rus
		end
		else
		Encounter.SetVar("comm",eng)
		dial=neng
	end
	for i=1,#dial do
		dial[i]="[effect:none]"..dial[i]
	end
	currentdialogue=dial
end

function AngerMetta()
	BattleDialogue(Encounter.GetVar("comm"))
end

function SetInspectChoise()
	local lang=Encounter.GetVar("lang")
	local wons=Encounter.GetVar("wons")
	local songs=Encounter.GetVar("songs")
	local prog=Encounter.GetVar("prog")
	local text={}
	if diff==34 or diff==35 or diff==36 then
		prog = prog + 1
		Player.hp=20
	end 
	if wons==0 then
		if prog==26 then
			if lang=="rus" then
				text={"Чара Дриимурр 1 УР[w:6]?[w:6]\nПоверь,[w:3] актёр,[w:3] её пощада не стоит ни гроша.","Давай не отвлекаться на сентиментальности и просто закончим начатое?"}
				else
				text={"Chara Dreemurr 1 LV[w:6]?[w:6]\nTrust me,[w:3] actor,[w:3] her mercy is worth nothing.","Let's not get distracted by unnecessary sentiments and finish what we've started."}
			end
			elseif prog<43 then
			if lang=="rus" then
				text={"Чара Дриимурр 1 УР[w:6]?[w:6]\nПервый павший человек.[w:6] Последняя\rвыжившая из рода Дриимурров.[w:6]\nЧеловек в шкуре монстра.","Эта назойливая сучка не будет\rдля нас помехой,[w:3] если не давать\rей поблажек.","Я достаточно понятно объяснил?[color:8040ff][w:6]\nНе смей её жалеть,[w:3] дорогуша."}
				else
				text={"Chara Dreemurr 1 LV[w:6]?[w:6]\nFirst Fallen Human.[w:6] Still the last one from Dreemurr's family.[w:6]\nHuman in monster's skin.","This nasty bitch can't be a nuisance,[w:3] if we won't give her indulgences.","Did I make it clear for you?[w:6][color:8040ff]\nDon't even dare to mercy her, darling."}
			end
			elseif prog<49 then
			if lang=="rus" then
				text={"Чара Дриимурр 19 УР.[w:6]\nНе самое логичное решение\rпотратить ход в таких условиях\rна проверку[waitall:4][w:3]...","Но если тебе интересно мое мнение,[w:3] дорогуша[waitall:4][w:3]...[waitall:1][w:3]\nОна свихнулась.","Следи за движениями.[w:6] Она бьет\rбез разбору,[w:3] пытаясь нанести\rмаксимальный урон.","Не теряй Решительности.[w:6][color:8040ff]\nСрази Голиафа."}
				elseif lang=="eng" then
				text={"Chara Dreemurr 19 LV.[w:6]\nIt wasn't very clever to waste your turn on inspecting her[waitall:4][w:3]...","But if you want my expertise[waitall:4][w:3]...[waitall:1][w:3]\nShe's gone mad.","Look after her moves.[w:6] She strikes on right and left trying to deal the maximum damage.","Don't lose Determination.[w:6][color:8040ff]\nStrike down the Goliath."}
			end
			elseif prog==49 then
			if lang=="rus" then
				text={"Чара Дриимурр 19 УР.[w:6]\nОна выдохлась[waitall:4][w:3]...[waitall:1][w:3]\nТеперь точно.","Не мешкай,[w:3] это может быть наш единственный шанс задеть её."}
				else
				text={"Chara Dreemurr 19 УР.[w:6]\nShe's exhausted[waitall:4][w:3]...[waitall:1][w:3]\nNow for sure.","Don't hesitate, it could be our only chance to hit her."}
			end
			else
			if lang=="rus" then
				text={"Чара Дриимурр 19 УР.[w:6]\nМы наконец смогли её ранить,[w:3] но\rлюди не так просты, как\rмонстры[waitall:4][w:3]...","Не опускай руки,[w:3] дорогуша.[w:6]\rНастал час для эндшпиля.[w:6][color:8040ff]\nПоставим ей шах и мат!"}
				elseif lang=="eng" then
				text={"Chara Dreemurr 19 LV.[w:6]\nWe could finally wound her,[w:3] but humans are much tougher than monsters[waitall:4][w:3]...","Don't give up,[w:3] darling.[w:6]\nIt's time for endgame.[w:6]\n[color:8040ff]This is our check-mate!"}
			end
		end
		elseif wons==1 then
		local p=Encounter.GetVar("LostMercy")
		if p<7 then
			if lang=="rus" then
				text={"Чара Дриимурр 1 УР.[w:6]\nБольше не представляет угрозы","Тебе решать,[w:3] что с ней делать,[w:3] актёр."}
				else
				text={"Chara Dreemurr 1 LV.[w:6]\nNo longer a threat for us.","It's up to you what to do with her."}	
			end
			elseif p<19 then
			if lang=="rus" then
				text={"Чара Дриимурр 1 УР.[w:6]\nВ чем-то сомневаешься?[w:6] Но ладно,[w:3] напомню.","Первый Падший.[w:6] Последний выживший из рода Дриимурров.[w:6]\nБольше не представляет угрозы.","[color:8040ff]Пока от неё есть толк,[w:3] пусть живет[waitall:4][w:3]..."}
				else
				text={"Chara Dreemurr 1 LV.[w:6]\nDid you forget something?[w:6] 'kay,[w:3] here's a quick reminder.","The First Fallen. Still the last one from Dreemurr's family.[w:6]\nNo longer a threat for us.","[color:8040ff]While she's useful,[w:3] let her be[waitall:4][w:3]..."}
			end
			else
			if lang=="rus" then
				text={"Чара Дриимурр 1 УР.[w:6]\nЭта мнительная сучка опять портит все мои планы[waitall:4][w:3]...","[color:8040ff]Это должно было быть моё шоу![w:6] Мой сценарий![w:6] А не её импровизированная драма!","Она вечно всё портит[waitall:4][w:3]...[waitall:1][w:3]\nТерпеть её не могу!","Покончи с ней по-быстрее,[w:3] дорогуша.[w:6][color:8040ff]\nНет сил слушать её нытье."}
				elseif lang=="eng" then
				text={"Chara Dreemurr 19 LV.[w:6]\nThis spleeny bitch once again interferes in my plans[waitall:4][w:3]...","[color:8040ff]It was meant to be my show![w:6] My script![w:6] But not her drama improvisation!","She always spoils everything[waitall:4][w:3]...[waitall:1][w:3]\nI can't tolerate it!","End her fast.[waitall:4][w:3]...[waitall:1][w:3][color:8040ff]\nCan't listen her whining anymore."}
 			end
		end
	end
	BattleDialogue(text)
end