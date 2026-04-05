CREDITS:
Original game by IGB Team

This is a fan-made mod and is not affiliated with or endorsed by the original developers.
(If the original developers request this mod to be taken down, I will comply.)

All original assets (music, sprites, etc.) belong to their respective owners.

This mod does not include the base game (only the files it changes or adds)
You must download the original game separately (and paste these files over, press replace when asked).

Check the Mod_Install_Instructions.txt file for install instructions

KNOWN ISSUES:
- Game must be relaunched after changing difficulty
- Checkpoints may require relaunching
- Russian version will break features
- Punchcard mode may break some item behavior (meant for no-hits)

NOTE: This mod only covers 1 route/ending of the base fangame

Difficulties menu (rows):
1 - attack versions (normal, hard, brutal)  Diff point multipliers: 1, 3, 7
2 - prayer effect (default, harder pray patterns and -1 use, disabled)  Diff point multipliers: 1, 2, 3 
3 - hp (92 + heal 10 per attack, 92, 20, get dunked on / 1)  Diff point multipliers: 1, 2, 5, 10
4 - checkpoints (every attack, between phases, none)  Diff point multipliers: 0, 1, 3
(second one for each is default for mod install, and is reccomended for 1st playthrough)
(Pray on 1 max hp = set max hp to 20 for 1 attack, once per checkpoint)

Since this is a mod, no vanilla achievements, so the button is replaced by difficulty points (current settings) and high score
Having all enabled = 630 points, in which the game becomes hell (but managable)  [Check libraries/CharaAttacksRember.lua for tips on how to beat this]
(I have not beaten 630 mode, but I have tested each attack to ensure it's possible)
Only plan on playing once? Then try Brutal Mode x Deist x Standard Hp (or regenerative) x checkpoints every phase


Items:
Home-Made Lasagna - Heal 1/3 of damage taken next turn, at the end of the attack (NOTE: You will not heal if fully cursed)  (modified vanilla)
Spider Donut - increases i-frames for 1 turn  (vanilla)
Turtle Tea - move speed up for 1 attack  (vanilla) 
Snowman Piece - resist burn effect for 1 attack  (vanilla)
Iron Berries - fatal knives only deal 5 damage per frame, and most slash attacks deal 33 damage + give i-frames (instead of 999), for 1 attack  (modded)
Chocolate - Allows hp to go below 1, excess damage is towards max hp  (modded) 
Cursed Water - heal 10 hp, and add 15 curse in phase 4  (modified vanilla)
Holy Water - remove all curse  (modified vanilla)


Knife Damage (per frame):
Fake - 0 (lime green) 
Purple - 0 (slow down)
*Normal - 1  (vanilla) [1 curse in phase 4]
*Deadly - 2  (golden) [1 curse in phase 4]
Lethal - 3  (dark purple and green) [2 curse in phase 4]
*Fatal - 999 OR 5 if you used iron berries (item)    (jagged) [2 curse in phase 4]
Mutant - 999 (always)   (you'll know when you see it)
*These ones have blue and orange varients


REWORKS:
You cannot use items in phase 3

Items can be used unlimited times each (you have 1 of each item), but only 1 item per turn

Phase 4-
|You can now pray during phase 4, it has unlimited uses, heals you to full, but maxes out curse
|Curse no longer kills you when it maxes out, instead it prevents pray and item usage (and disables regeneration)
|50% of curse is removed when you attack
|No more menu hell


Enjoy =)

Side notes:
RNG is reduced to make attacks more consistently no-hittable, especially for brutal mode (all attacks have been tested, and a no-hit is possible)

Punchcard mode reduces dialog wait + removes a lot (meant for dunked on mode, may break hp-based features)

The MIT liscense is the least restrictive license I could find, and only applies to the code that I made (it's not even good code) (sprites added are mostly resprites).
Feel free to use the files how you wish, as long as the original developers are fine with it, then so am I, CHECK WITH THEM, NOT ME. 
You are free to use, modify, and share this code as much as your soul desires (as long as its ok with the IGB team).

Stuck?  Check over the lua/libraries/CharaAttacksRember.lua file for how to get through some attacks with ease, or try a lower difficulty (there are over 100 combinations)