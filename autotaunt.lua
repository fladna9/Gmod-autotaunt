local function autoTaunt( ply )
        if(ply:Team() == TEAM_PROPS) then
                timer.Create("Auto_Taunt", 60, 5, function ()
                        ply:ConCommand( "ph_taunt team_props 20" )
                        print( ply:Nick().. " has just auto taunted to help hunters !" )
                end)
        end
end

local function removeAutoTaunt( ply )
        if(ply:Team() == TEAM_PROPS) then
                timer.Remove("Auto_Taunt")
        end
end

hook.Add("PlayerSpawn", "Player_Spawned_AutoTaunt", autoTaunt )
hook.Add("PlayerDeath", "Player_Died_AutoTaunt", removeAutoTaunt )
