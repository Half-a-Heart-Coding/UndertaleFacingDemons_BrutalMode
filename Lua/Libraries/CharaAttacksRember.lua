function getAttackName(number, phase, difficulty)--nextwaves = {CharaAttacksRember.getAttackName(prog, phase, songs[1])}
	switchDiff = {"phase1", "phase1.5", "phase2", "phase3", "phase3.5", "phase4", "imp", "imp1.5", "imp2", "imp3"}
	if difficulty == "night" then
		switchDiff = {[1] = "phase1", [1.5] = "phase1.5", [2] = "phase2"}
	elseif difficulty == "insa" then
		switchDiff = {[1] = "phase3", [1.5] = "phase3.5", [2] = "phase4"}
	else
		switchDiff = {[1] = "imp", [1.5] = "imp1.5", [2] = "imp2", [3] = "imp3"}
	end
	if phase == -1 then
		--if number>61 and diff>24 then
		--	SetMusic("last")
		if number>50 then
			phase = 2
		elseif number>42 then
			phase = 1.5
		elseif number>26 then
			phase = 1
		else
			phase = 1
		end
	end
	filePath = switchDiff[phase]

	nameOfAttack = "nicetomeetya"
	--before attempting 630 mode, it is reccomended to first no-hit each brutal mode attack via practice mode, and to beat 7 x 3 x 5 x 3 first (check readme)
	--enable punchcard mode (removes most dialog), as you will die alot, and unskipable dialog won't help
	--?brutal mode: turtle tea? == reccomended for no-hit (preference)
	--brutal mode: turtle tea == vital for no-hit (very difficult without it, or very easy with it)
	--!brutal mode: turtle tea! == required for no-hit
	--This goes in order
	if number == 1 then
		nameOfAttack = "k_5_new"--brutal mode: turtle tea
	elseif number == 2 then
		nameOfAttack = "rain"--brutal mode: turtle tea, hold down left at start
	elseif number == 3 then
		nameOfAttack = "random"--Despite being called random, this attack has little important rng to 630 mode--?brutal mode: turtle tea?
	elseif number == 4 then
		nameOfAttack = "Reaction"--?brutal mode: turtle tea?
	elseif number == 5 then
		nameOfAttack = "stoplights"--?brutal mode: turtle tea?
	elseif number == 6 then
		nameOfAttack = "NoMercyToYou"--stay in center (after each attack)
	elseif number == 7 then
		nameOfAttack = "k_storm"--DO NOT USE TURTLE TEA
	elseif number == 8 then
		nameOfAttack = "warning"--!brutal mode: turtle tea!
	elseif number == 9 then
		nameOfAttack = "BeFast"--brutal mode: turtle tea
	elseif number == 10 then
		nameOfAttack = "bones0"
	elseif number == 11 then
		nameOfAttack = "bullettest_touhou"--brutal mode: turtle tea
	elseif number == 12 then
		nameOfAttack = "bones1"--?brutal mode: turtle tea?
	elseif number == 13 then
		nameOfAttack = "bullettest_chaseorb"
	elseif number == 14 then
		nameOfAttack = "bones2"
	elseif number == 15 then
		nameOfAttack = "nostop"
	elseif number == 16 then
		nameOfAttack = "electro_rain"
	elseif number == 17 then
		nameOfAttack = "alph"--Fire when it is about to hit you, not while it is above the line--?brutal mode: turtle tea?
	elseif number == 18 then
		nameOfAttack = "Quickly"--brutal mode: turtle tea
	elseif number == 19 then
		nameOfAttack = "rei"--brutal mode: turtle tea
	elseif number == 20 then
		nameOfAttack = "bullettest_bouncy"--?brutal mode: turtle tea?
	elseif number == 21 then
		nameOfAttack = "asrielaser"--?brutal mode: turtle tea?
	elseif number == 22 then
		nameOfAttack = "SoulOfHunger"--brutal mode: turtle tea
	elseif number == 23 then
		nameOfAttack = "firespears"--?brutal mode: turtle tea?
	elseif number == 24 then
		nameOfAttack = "RandomFire"
	elseif number == 25 then
		nameOfAttack = "NotMiddleRoad"--!brutal mode: turtle tea!
	elseif number == 26 then
		nameOfAttack = "nothing"
		return "nothing"
	elseif number == 27 then--phase 2
		nameOfAttack = "shadows"
	elseif number == 28 then
		nameOfAttack = "listopad"
	elseif number == 29 then
		nameOfAttack = "krug"
	elseif number == 30 then
		nameOfAttack = "brave"--brutal mode: turtle tea
	elseif number == 31 then
		nameOfAttack = "und"
	elseif number == 32 then
		nameOfAttack = "k_random1"--?brutal mode: turtle tea?
	elseif number == 33 then
		nameOfAttack = "k_random2"
	elseif number == 34 then
		nameOfAttack = "2lasers"--DO NOT USE TURTLE TEA
	elseif number == 35 then
		nameOfAttack = "sans3"
	elseif number == 36 then
		nameOfAttack = "sansnew"
	elseif number == 37 then
		nameOfAttack = "kniferain"
	elseif number == 38 then
		nameOfAttack = "muffet"
	elseif number == 39 then
		nameOfAttack = "field"--?brutal mode: turtle tea?
	elseif number == 40 then
		nameOfAttack = "buggy1"--!brutal mode: turtle tea!
	elseif number == 41 then
		nameOfAttack = "buggy2"--brutal mode: turtle tea
	elseif number == 42 then
		nameOfAttack = "k_3"--?brutal mode: turtle tea?
	elseif number == 43 then--phase 3 (no items)
		nameOfAttack = "easy"--?brutal mode: turtle tea? (you can use items on this attack)  WATCH OUT, menu attacks start after this!
	elseif number == 44 then
		nameOfAttack = "BroFight"--(no items)
	elseif number == 45 then
		nameOfAttack = "firehell"--(no items)
	elseif number == 46 then
		nameOfAttack = "spidercombo"--(no items)
	elseif number == 47 then
		nameOfAttack = "DEATH2"--/FullBloom
		if difficulty == "night" then
			return "phase1.5/FullBloom"
		elseif difficulty == "insa" then
			return "phase3.5/FullBloom"
		else
			return "imp/DEATH2"--(no items)
		end
	elseif number == 48 then
		nameOfAttack = "bereadytodie"--(no items) 
	elseif number == 49 then--phase intermission
		nameOfAttack = "nothing"
		return "nothing"
	elseif number == 50 then
		nameOfAttack = "nothing"
		return "nothing"
	elseif number == 51 then--phase 4
		nameOfAttack = "netkonzaidejam"--brutal mode: turtle tea
	elseif number == 52 then
		nameOfAttack = "k_1"--brutal mode: turtle tea
	elseif number == 53 then
		nameOfAttack = "HARD"--630 mode tip: LOOK AT THE TOP, Use periphrial for rest--brutal mode: turtle tea
	elseif number == 54 then
		nameOfAttack = "knives4"--DO NOT USE TURTLE TEA (you need to move slowly)
	elseif number == 55 then
		nameOfAttack = "StayLow"
	elseif number == 56 then
		nameOfAttack = "BadKnifes"
	elseif number == 57 then
		nameOfAttack = "AllAround"
	elseif number == 58 then
		nameOfAttack = "CopyCat"--?brutal mode: turtle tea?
	elseif number == 59 then
		nameOfAttack = "MovingKnifes"--?brutal mode: turtle tea?
	elseif number == 60 then
		nameOfAttack = "k_4"--?brutal mode: turtle tea?
	elseif number == 61 then
		nameOfAttack = "nothing"
		return "nothing"
	elseif number == 62 and difficulty == "insa" then--   =)
		nameOfAttack = "WrathOnly"
	elseif number > 62 and difficulty == "insa" then--the finale (hardmode)
		nameOfAttack = "laststand4"
		return "laststand4"
	elseif number > 61 and difficulty ~= "night2" then--the finale (normal mode)
		nameOfAttack = "laststand"
		return "laststand"
	elseif number == 62 then--phase 5 (brutal mode only)  SCRAPPED
		nameOfAttack = "red"--SCRAPPED (practice mode only)
		return "imp3/red"
	elseif number == 63 then
		nameOfAttack = "yellow"--SCRAPPED
		return "imp3/yellow"
	elseif number == 64 then
		nameOfAttack = "blue"--SCRAPPED
		return "imp3/blue"
	elseif number == 65 then
		nameOfAttack = "green"--SCRAPPED
		return "imp3/green"
	elseif number == 66 then
		nameOfAttack = "purple"--SCRAPPED
		return "imp3/purple"
	elseif number == 67 then
		nameOfAttack = "cyan"--SCRAPPED
		return "imp3/cyan"
	elseif number == 68 then
		nameOfAttack = "orange"--SCRAPPED
		return "imp3/orange"
	elseif number >= 69 then--the finale (brutal mode)
		nameOfAttack = "laststand5"
		return "laststand5"
	end

	return filePath.."/"..nameOfAttack
end