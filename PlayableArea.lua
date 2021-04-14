--- Made by GaryTheGoat --- 
--- Please do not amend / upload / copy any content without permission
--- feedback welcome samcaunt@hotmail.co.uk

local ScenarioUtils = import('/lua/sim/ScenarioUtilities.lua')
local ScenarioFramework = import('/lua/ScenarioFramework.lua')

do 
    -- make all the players aware of this area and playable
    ScenarioFramework.SetPlayableArea('PLAYABLE_AREA2', false)

    -- make the AI unaware of this box # replace ENEMY_1 with army name
    ScenarioFramework.SetIgnorePlayableRect("ARMY_ENEMY", true)
end
