save1={"ДОМ ЛАЗ","ПАУ ПОН","ПАУ ПОН","ЧЕРЕП ЧАЙ"}
save2={"ЧЕРЕП ЧАЙ","КУС СНЕГ","СВЯТ ВОД","СВЯТ ВОД"}
save3={"СВЯТ ВОД","СВЯТ ВОД","СВЯТ ВОД","СВЯТ ВОД"}
names={"ДОМ ЛАЗ","ПАУ ПОН","ПАУ ПОН","ЧЕРЕП ЧАЙ","ЧЕРЕП ЧАЙ","КУС СНЕГ","СВЯТ ВОД","СВЯТ ВОД","СВЯТ ВОД","СВЯТ ВОД","СВЯТ ВОД","СВЯТ ВОД"}
if Encounter.GetVar("diff") == 6 then
rus={"ДОМ ЛАЗ","ПАУ ПОН","ПАУ ПОН","ЧЕРЕП ЧАЙ","ЧЕРЕП ЧАЙ","КУС СНЕГ","СВЯТ ВОД","СВЯТ ВОД","СВЯТ ВОД","СВЯТ ВОД","СВЯТ ВОД","СВЯТ ВОД", "ДОМ ЛАЗ","ПАУ ПОН","ПАУ ПОН","ЧЕРЕП ЧАЙ","ЧЕРЕП ЧАЙ","КУС СНЕГ","СВЯТ ВОД","СВЯТ ВОД","СВЯТ ВОД","СВЯТ ВОД","СВЯТ ВОД","СВЯТ ВОД"}
eng={"MAD LAS","SPI DON","SPI DON","TUR TEA","TUR TEA","SNOW PIE","HOL WAT","HOL WAT","HOL WAT","HOL WAT","HOL WAT","HOL WAT", "MAD LAS","SPI DON","SPI DON","TUR TEA","TUR TEA","SNOW PIE","HOL WAT","HOL WAT","HOL WAT","HOL WAT","HOL WAT","HOL WAT","MAD LAS","SPI DON","SPI DON","TUR TEA","TUR TEA","SNOW PIE","HOL WAT","HOL WAT","HOL WAT","HOL WAT","HOL WAT","HOL WAT", "MAD LAS","SPI DON","SPI DON","TUR TEA","TUR TEA","SNOW PIE","HOL WAT","HOL WAT","HOL WAT","HOL WAT","HOL WAT","HOL WAT","MAD LAS","SPI DON","SPI DON","TUR TEA","TUR TEA","SNOW PIE","HOL WAT","HOL WAT","HOL WAT","HOL WAT","HOL WAT","HOL WAT", "MAD LAS","SPI DON","SPI DON","TUR TEA","TUR TEA","SNOW PIE","HOL WAT","HOL WAT","HOL WAT","HOL WAT","HOL WAT","HOL WAT","MAD LAS","SPI DON","SPI DON","TUR TEA","TUR TEA","SNOW PIE","HOL WAT","HOL WAT","HOL WAT","HOL WAT","HOL WAT","HOL WAT", "MAD LAS","SPI DON","SPI DON","TUR TEA","TUR TEA","SNOW PIE","HOL WAT","HOL WAT","HOL WAT","HOL WAT","HOL WAT","HOL WAT"}

commands = save1
page=1
used=false
NewAudio.CreateChannel("dubber")
sprite = "empty" --Always PNG. Extension is added automatically.
name = "Вещи"
hp = 1
atk = 1
def = 99
check = "Она использует силу\rПОДЗЕМЕЛЬЯ"
dialogbubble = "rightwide"
canspare = false
cancheck = false
number={true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true}
else
rus={"ДОМ ЛАЗ","ПАУ ПОН","ЧЕРЕП ЧАЙ","КУС СНЕГ","ПРОК ВОД","СВЯТ ВОД","СВЯТ ВОД","СВЯТ ВОД"}
eng={"MAD LAS","SPI DON","TUR TEA","SNOW PIE","IRON BERRIES","CHOCOLATE","CUR WAT","HOL WAT"}

commands = save1
page=1
used=false
NewAudio.CreateChannel("dubber")
sprite = "empty" --Always PNG. Extension is added automatically.
name = "Вещи"
hp = 1
atk = 1
def = 99
check = "Она использует силу\rПОДЗЕМЕЛЬЯ"
dialogbubble = "rightwide"
canspare = false
cancheck = false
number={true,true,true,true,true,true,true,true}
end
-- This handles the commands; all-caps versions of the commands list you have above.


function ChangeLanguage(ingo)
	if ingo=="rus" then
		save1={rus[1],rus[2],rus[3],rus[4]}
		save2={rus[5],rus[6],rus[7],rus[8]}
		save3={rus[9],rus[10],rus[11],rus[12]}
		for i=1,12 do
			names[i]=rus[i]
		end
		else
		save1={eng[1],eng[2],eng[3],eng[4]}
		save2={eng[5],eng[6],eng[7],eng[8]}
		save3={eng[9],eng[10],eng[11],eng[12]}
		for i=1,12 do
			names[i]=eng[i]
		end
	end
end
function Reasign()
	target=1
	save1={}
	save2={}
	save3={}
	for i=1,12 do
		if number[i]==true then
			if target<5 then
				save1[target]=names[i]
				elseif target<9 then
				save2[target-4]=names[i]
				else save3[target-8]=names[i]
			end
			target=target+1
		end
	end
	if target==1 then
		used=true
		else used=false
	end
end
function Recharge()
	for i=1,12 do
		number[i]=true
	end
	for i=7,12 do
		if Encounter.GetVar("lang")=="rus" then
			names[i]="СВЯТ ВОД"
			else
			names[i]="HOL WAT"
		end
	end
	Reasign()
end
function Firstpage()
	page=1
	commands=save1
end
function Pager(name)
	if name==1 then
		commands=save1
		page=1
		else--if name==2 then
		commands=save2
		page=2
		--else
		--commands=save3
		--page=3
	end
	Encounter.SetVar("page",page)
	State("ACTMENU")
end
function HandleCustomCommand(command)
	local bet=0
	local usedItem = true
	if GetGlobal("PreviousItem") == command and Encounter.GetVar("diff") == 17 then
		BattleDialog({"You can`t use the same item\ntwo turns in a row."})
		usedItem=false
	end
	if Encounter.GetVar("lives")<4 then
		bet=true
		else bet=false
	end
	if GetGlobal("curse") and GetGlobal("curse") >= Player.hp then
		if Encounter.GetVar("lang")=="rus" then
			BattleDialog("Прекрати,[w:3] актёр.[w:6]\nПредметы не казённые.[w:6] Она не стоит их использования.")
			else
			BattleDialog("The curse overwhelms you, you cannot use items.")
		end
	elseif Encounter.GetVar("wons")==1 and Encounter.GetVar("diff") == 6 then
		if Encounter.GetVar("lang")=="rus" then
			BattleDialog("Прекрати,[w:3] актёр.[w:6]\nПредметы не казённые.[w:6] Она не стоит их использования.")
			else
			BattleDialog("Stop right here,[w:3] actor.[w:6]\nItems worth too much for this pitty trash named human.")
		end
		elseif Encounter.GetVar("eated")==false or Encounter.GetVar("diff") == 6 then
		if Encounter.GetVar("diff") ~= 6 and Encounter.GetVar("diff") ~= 17 then
			Encounter.SetVar("itemamount",Encounter.GetVar("itemamount")-1)
		end
		if command=="ДОМ ЛАЗ" then
			local l=Encounter.GetVar("lastface")
			if Encounter.GetVar("prog")<42 then
				SetGlobal("facial_expression",65)
				BattleDialog({"Ты съел Домашнюю лазанью[waitall:4][w:3]...[waitall:1][w:3]\nЭнергия переполняет тебя!","Чара смотрит на вас с презрением.","[func:RestoreFace][next]"})
			else
				BattleDialog({"Ты съел Домашнюю лазанью[waitall:4][w:3]...[waitall:1][w:3]\nЭнергия переполняет тебя!","[func:RestoreFace][next]"})
			end
			Encounter.SetVar("quiche",true)
			Encounter.SetVar("quichehp",Player.hp)
			Encounter.SetVar("eated",true)
			number[1]=false
			elseif command=="ПАУ ПОН" then
			BattleDialog({"Ты съел Паучий пончик[waitall:4][w:3]...[waitall:1][w:3]\nНа вкус,[w:3] как пауки[waitall:4][w:3]...[waitall:1][w:3] Впрочем,[w:3] на вид тоже.","Неуязвимость была повышена!"})
			Encounter.SetVar("ghostresistance",true)
			Encounter.SetVar("eated",true)
			if number[2]==true then
				number[2]=false
				else number[3]=false
			end
			elseif command=="ЧЕРЕП ЧАЙ" then
			BattleDialog({"Ты выпил Черепаший чай[waitall:4][w:3]...[waitall:1][w:3]\nКажется,[w:3] мой мозг начал работать на все 100%?","Чувствую себя быстрее."})
			Encounter.SetVar("eated",true)
			Encounter.SetVar("movefast",true)
			if number[4]==true then
				number[4]=false
				else number[5]=false
			end
			elseif command=="КУС СНЕГ" then
			BattleDialog({"Ты съел Кусок снеговика[waitall:4][w:3]...[waitall:1][w:3]\nПрискорбно,[w:3] его приключение окончилось,[w:3] чтобы завершилось наше.","Ожоги теперь нам не страшны."})
			Encounter.SetVar("burnresistance",true)
			number[6]=false
			Encounter.SetVar("eated",true)
			elseif command=="СВЯТ ВОД" then
			local curse="Зачем она вообще?"
			if Encounter.GetVar("prog")>52 then
				curse="Проклятие было замедленно."
			end
			SetGlobal("curse",0)
			BattleDialog({"Ты выпил Святую воду[waitall:4][w:3]...[waitall:1][w:3]\nКажется,[w:3] призракам такое не очень полезно.",curse})
			if Player.hp>5 then
				Player.Hurt(5,0)
				else Player.Hurt(Player.hp-1)
			end
			Encounter.SetVar("curseresistance",true)
			Encounter.SetVar("eated",true)
			local n=false
			for i=0,5 do
				if number[12-i]==true then
					number[12-i]=n
					n=true
				end
			end
			elseif command=="ПРОК ВОД" then
			BattleDialog({"Ты выпил Проклятую воду[waitall:4][w:3]...[waitall:1][w:3]\nИнтересно,[w:3] кто её проклял?","Восстановлено 10 ОЗ."})
			Player.Heal(10)
			local n=false
			Encounter.SetVar("eated",true)
			for i=7,12 do
				if number[i]==true then
					number[i]=n
					n=true
				end
			end
			elseif command=="MAD LAS" and (Encounter.GetVar("diff") ~= 17 or GetGlobal("PreviousItem") ~= command) then
			if Encounter.GetVar("prog")<42 then
				SetGlobal("facial_expression",65)
				BattleDialog({"You ate the Home-Made Lasagna[waitall:4][w:3]...[waitall:1][w:3]\nEnergy overwhelms you!","Chara looks at you with disdain.","[func:RestoreFace][next]"})
			else
				BattleDialog({"You ate the Home-Made Lasagna[waitall:4][w:3]...[waitall:1][w:3]\nEnergy overwhelms you!","[func:RestoreFace][next]"})
			end
			SetGlobal("PreviousItem", "MAD LAS")
			if Encounter.GetVar("diff") == 17 then
				SetGlobal("curse2", 1)
				Encounter.SetVar("eated",true)
			else
				Encounter.SetVar("quiche",true)
				Encounter.SetVar("quichehp",Player.hp)
				Encounter.SetVar("eated",true)
			end
			--number[1]=Encounter.GetVar("diff") == 6 or Encounter.GetVar("diff") == 17
			elseif command=="SPI DON" and (Encounter.GetVar("diff") ~= 17 or GetGlobal("PreviousItem") ~= command) then
			BattleDialog({"You ate Spider Donut[waitall:4][w:3]...[waitall:1][w:3]\nTastes like spiders[waitall:4][w:3]...[waitall:1][w:3] Looks like too, though.","Invulnerability has been increased!"})
			Encounter.SetVar("ghostresistance",true)
			Encounter.SetVar("eated",true)
			SetGlobal("PreviousItem", "SPI DON")
			--if number[2]==true then
			--	number[2]=Encounter.GetVar("diff") == 6 or Encounter.GetVar("diff") == 17
			--	else number[3]=Encounter.GetVar("diff") == 6 or Encounter.GetVar("diff") == 17
			--end
			elseif command=="TUR TEA" and (Encounter.GetVar("diff") ~= 17 or GetGlobal("PreviousItem") ~= command) then
			BattleDialog({"You drank Turtle Tea[waitall:4][w:3]...[waitall:1][w:3]\nDoes my brain seem to start working 100%?","I feel faster."})
			Encounter.SetVar("eated",true)
			Encounter.SetVar("movefast",true)
			SetGlobal("PreviousItem", "TUR TEA")
			--if number[4]==true then
			--	number[4]=Encounter.GetVar("diff") == 6 or Encounter.GetVar("diff") == 17
			--	else number[5]=Encounter.GetVar("diff") == 6 or Encounter.GetVar("diff") == 17
			--end
			elseif command=="SNOW PIE" and (Encounter.GetVar("diff") ~= 17 or GetGlobal("PreviousItem") ~= command) then
			BattleDialog({"You ate Snowman Piece[waitall:4][w:3]...[waitall:1][w:3]\nSadly,[w:3] his adventure is over for ours to continue.","We are not afraid of burns now."})
			Encounter.SetVar("burnresistance",true)
			--number[6]=Encounter.GetVar("diff") == 6 or Encounter.GetVar("diff") == 17
			Encounter.SetVar("eated",true)
			SetGlobal("PreviousItem", "SNOW PIE")
			elseif command=="IRON BERRIES" and (Encounter.GetVar("diff") ~= 17 or GetGlobal("PreviousItem") ~= command) then
			BattleDialog({"You ate the Iron Berries[waitall:4][w:3]...[waitall:1][w:3]\n[w:3]They taste like rust.","Fatal attacks will not instakill!"})
			SetGlobal("KnifeProtection",true)
			--number[7]=Encounter.GetVar("diff") == 6 or Encounter.GetVar("diff") == 17
			Encounter.SetVar("eated",true)
			SetGlobal("PreviousItem", "IRON BERRIES")
			elseif command=="CHOCOLATE" and (Encounter.GetVar("diff") ~= 17 or GetGlobal("PreviousItem") ~= command) then
			BattleDialog({"You ate the Chocolate[waitall:4][w:3]...[waitall:1][w:3]\n[w:3]It`s bitter","HP can go below 1, but will reduce Max HP!"})
			SetGlobal("ChoclateDamage",true)
			--Player.Heal(math.ceil((Encounter.GetVar("MaxHP") - Player.hp) / 2))
			--number[7]=Encounter.GetVar("diff") == 6 or Encounter.GetVar("diff") == 17
			Encounter.SetVar("eated",true)
			SetGlobal("PreviousItem", "CHOCOLATE")
			elseif command=="HOL WAT" and (Encounter.GetVar("diff") ~= 17 or GetGlobal("PreviousItem") ~= command) then
			local curse="Why is it needed at all?"
			if Encounter.GetVar("prog")>52 then
				curse="The curse was slowed down."
			end
			BattleDialog({"You drank Holy Water[waitall:4][w:3]...[waitall:1][w:3]\nIt seems to be not very useful for ghosts[waitall:4][w:3]...[waitall:1][w:3]",curse})
			SetGlobal("curse",0)--math.floor(GetGlobal("curse") / 2)
			--Encounter.SetVar("curseresistance",true)
			Encounter.SetVar("eated",true)
			SetGlobal("PreviousItem", "HOL WAT")
			--Encounter.SetVar("MaxHP", Encounter.GetVar("MaxHP") - 4)
			local n=Encounter.GetVar("diff") == 6 or Encounter.GetVar("diff") == 17
			--for i=0,4 do--NOTE THIS MAY BE WRONG
			--	if number[12-i]==true then--NOTE THIS MAY BE WRONG
			--		number[12-i]=n--NOTE THIS MAY BE WRONG
			--		n=true--NOTE THIS MAY BE WRONG
			--	end--NOTE THIS MAY BE WRONG
			--end--NOTE THIS MAY BE WRONG
			elseif command=="CUR WAT" and (Encounter.GetVar("diff") ~= 17 or GetGlobal("PreviousItem") ~= command) then
			BattleDialog({"You drank Cursed Water[waitall:4][w:3]...[waitall:1][w:3]\nI wonder who cursed it.","Recovered 10 HP."})	
			Player.Heal(10)
			if Encounter.GetVar("prog")>52 then
				SetGlobal("curse",GetGlobal("curse") + 15)
			end
			--SetGlobal("curseantiresistance", 1)
			SetGlobal("PreviousItem", "CUR WAT")
			local n=Encounter.GetVar("diff") == 6 or Encounter.GetVar("diff") == 17
			Encounter.SetVar("eated",true)
			--for i=6,12 do--NOTE THIS MAY BE WRONG
			--	if number[i]==true then--NOTE THIS MAY BE WRONG
			--		number[i]=n--NOTE THIS MAY BE WRONG
			--		n=true--NOTE THIS MAY BE WRONG
			--	end--NOTE THIS MAY BE WRONG
			--end--NOTE THIS MAY BE WRONG
		end
		local n=true
		--for i=1,12 do--NOTE THIS MAY BE WRONG
		--	if number[i]==true then--NOTE THIS MAY BE WRONG
		--		n=Encounter.GetVar("diff") == 6--NOTE THIS MAY BE WRONG
		--	end--NOTE THIS MAY BE WRONG
		--end--NOTE THIS MAY BE WRONG
		if n==true and Encounter.GetVar("phase")==1 then
			Encounter.Call("GotAchivement",7)
		end
		else
		if Encounter.GetVar("lang")=="rus" then
			BattleDialog({"Вы не можете использовать \nдва предмета за ход."})
			else
			BattleDialog({"You can`t use two items\nin one turn."})
		end
	end
	--Reasign()--NOTE THIS MAY BE WRONG
	--if usedItem then
		Encounter.SetVar("itemed",true)
	--end
end
	

function RestoreFace()
	SetGlobal("facial_expression",Encounter.GetVar("lastface"))
end

function CursedWater()
	if 1==2 then
		if number[7]==true and names[7]=="СВЯТ ВОД" then
			names[7]="ПРОК ВОД"
			elseif number[8]==true and names[8]=="СВЯТ ВОД" then
			names[8]="ПРОК ВОД"
			elseif number[9]==true and names[9]=="СВЯТ ВОД" then
			names[9]="ПРОК ВОД"
			elseif number[10]==true and names[10]=="СВЯТ ВОД" then
			names[10]="ПРОК ВОД"
			elseif number[11]==true and names[11]=="СВЯТ ВОД" then
			names[11]="ПРОК ВОД"
			elseif number[12]==true and names[12]=="СВЯТ ВОД" then
			names[12]="ПРОК ВОД"
		end
		if number[7]==true and names[7]=="HOL WAT" then
			names[7]="CUR WAT"
			elseif number[8]==true and names[8]=="HOL WAT" then
			names[8]="CUR WAT"
			elseif number[9]==true and names[9]=="HOL WAT" then
			names[9]="CUR WAT"
			elseif number[10]==true and names[10]=="HOL WAT" then
			names[10]="CUR WAT"
			elseif number[11]==true and names[11]=="HOL WAT" then
			names[11]="CUR WAT"
			elseif number[12]==true and names[12]=="HOL WAT" then
			names[12]="CUR WAT"
		end
		Reasign()
	end
end
