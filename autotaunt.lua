------------------------------------------------------------------------
-- Garry's Mod Auto Taunt Addon                                       --
-- https://github.com/fladna9/Gmod-autotaunt                          --
--                                                                    --
-- Francis Team, All Rights Reserved (2016)                           --
--                                                                    --
-- This addon's license is GNU/GPL v3                                 --
-- You can find it here : http://www.gnu.org/licenses/gpl-3.0.en.html --
------------------------------------------------------------------------



-- IF YOU'RE NOT FAMILIAR WITH LUA, EDIT JUST BELOW THE SETTINGS FOR THE ADDON --

-- Change here the time you want between 2 taunts
local timeBetweenTwoTaunts = 60
-- Change here how many times you want this auto taunt be be executed in a round
local howManyTimes = 5
-- Change here how many taunts your server have
local maxTaunts = 75

-- END OF SETTINGS --



-- Initializing seed for random number
math.randomseed(os.time())
local tauntPathsTable = {}
local autoTauntTimerNameBase = "Francis_Auto_Taunt_Timer"


-- Function to execute the taunt
local function PlayTaunt(ply, sound)
	local team = ply:Team()
	local tauntPaths = tauntPathsTable[team]

	if GAMEMODE:InRound() && IsValid(ply) && ply:IsPlayer() && ply:Alive() && ply.last_taunt_time + TAUNT_DELAY <= CurTime()
		&& tauntPaths ~= nil  then
		local autoTauntSound = tauntPaths[sound]
		ply.last_taunt_time = CurTime()
		ply.last_taunt = autoTauntSound

		ply:EmitSound(autoTauntSound, 100)
	end
end


-- Main autoTaunt function
local function autoTauntInit( ply )
	-- Auto_Taunt only if prop
	if(ply != nil && ply:Team() == TEAM_PROPS) then
		local autoTauntTimerName = autoTauntTimerNameBase .."-" .. ply:Nick()
		-- Creation of the timer
		timer.Create(autoTauntTimerName, timeBetweenTwoTaunts, howManyTimes, function() 
			if(ply != nil && ply:Team() == TEAM_PROPS) then
				-- Generate a random number between 1 and the number of taunts
				local tauntNumber = math.random(#tauntPathsTable[TEAM_PROPS])
				PlayTaunt ( ply, tauntNumber )
				print( ply:Nick() .. " has just auto taunted number " .. tauntNumber )
			end
		end)
	end
end


-- Used to remove the timer on player death
local function removeAutoTaunt( ply )
	if(ply != nil && ply:Team() == TEAM_PROPS) then
		local autoTauntTimerName = autoTauntTimerNameBase .. "-" .. ply:Nick()
		timer.Remove(autoTauntTimerName)
	end
end


-- Detect changes in the taunt list
local function UpdateTauntList()
	-- If we don't have Tauntpack loader installed, we only have the global taunt tables used by Prop Hunt itself.
	if (GAMEMODE.Hunter_Taunts == nil) or (GAMEMODE.Prop_Taunts == nil) then
		if (tauntPathsTable[TEAM_HUNTERS] ~= HUNTER_TAUNTS)
			or (tauntPathsTable[TEAM_PROPS] ~= PROP_TAUNTS) then

			-- Tables that hold sound paths, see Prop Hunt, sh_config.lua:70-168
			tauntPathsTable[TEAM_HUNTERS] = HUNTER_TAUNTS
			tauntPathsTable[TEAM_PROPS] = PROP_TAUNTS
		end

	-- Tauntpack loader replaces the old table with a new instance whenever it reloads the taunts.
	-- This means we can use reference equality to detect changes quickly here.
	-- For reference see sv_ph_tauntpack_loader.lua:55-56
	elseif (tauntPathsTable[TEAM_HUNTERS] ~= GAMEMODE.Hunter_Taunts)
		or (tauntPathsTable[TEAM_PROPS] ~= GAMEMODE.Prop_Taunts) then

		-- Tables that hold sound paths, see Prop Hunt, sh_config.lua:70-168
		tauntPathsTable[TEAM_HUNTERS] = HUNTER_TAUNTS
		tauntPathsTable[TEAM_PROPS] = PROP_TAUNTS
	end
end


-- Update taunt list here, on gamemode initializing (better than on each tick for the server)
hook.Add( "Initialize", "PH_TauntMenu_StringPooling", UpdateTauntList )
-- Create the timer for each spawned player
hook.Add("PlayerSpawn", "Player_Spawned_AutoTaunt", autoTauntInit )
-- Delete the timer for each dead player
hook.Add("PlayerDeath", "Player_Died_AutoTaunt", removeAutoTaunt  )
