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



local autoTauntTimerNameBase = "Francis_Auto_Taunt_Timer"
-- Initializing seed for random number
math.randomseed(os.time())

-- Main autoTaunt function
local function autoTauntInit( ply )
	-- Auto_Taunt only if prop
	if(ply != nil && ply:Team() == TEAM_PROPS) then
		local autoTauntTimerName = autoTauntTimerName .."-" .. ply:Nick()
		-- Creation of the timer
		timer.Create(autoTauntTimerName, timeBetweenTwoTaunts, howManyTimes, function() 
			if(ply != nil && ply.Team() == TEAM_PROPS) then
				-- Generate a random number between 1 and maxTaunts
				local tauntNumber = math.random(maxTaunts)
				ply:ConCommand( "ph_taunt team_props " .. tauntNumber )
				print( ply:Nick() .. " has just auto taunted to help hunters !" )
			end
		end)
	end
end

-- Used to remove the timer on player death
local function removeAutoTaunt( ply )
	if(ply != nil && ply:Team() == TEAM_PROPS) then
		local autoTauntTimerName = autoTauntTimerName .. "-" .. ply:Nick()
		timer.Remove(autoTauntTimerName)
	end
end

-- Add functions to hooks
hook.Add("PlayerSpawn", "Player_Spawned_AutoTaunt", autoTauntInit )
hook.Add("PlayerDeath", "Player_Died_AutoTaunt", removeAutoTaunt  )
