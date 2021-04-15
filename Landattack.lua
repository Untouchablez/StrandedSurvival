--- Made by GaryTheGoat --- 
--- Please do not amend / upload / copy any content without permission
--- feedback welcome samcaunt@hotmail.co.uk

local ScenarioUtils = import('/lua/sim/ScenarioUtilities.lua')
local ScenarioFramework = import('/lua/ScenarioFramework.lua')

local Markers = import("/maps/survival_stranded.v0016/Markers.lua")
local Landplatoons = import("/maps/survival_stranded.v0016/Landplatoons.lua")
local Areas = import("/maps/survival_stranded.v0016/Areas.lua")

-- pick a random transport platoon  -- check
-- pick a random transport spawn    -- check
-- pick a random transport target   -- check
-- spawn units
-- attach units to transport
-- issue unload for transport
-- issue move back for transport
-- destroy transports once out of map
-- move transportees into commander to take that dude out (to dinner) -- check

-- wait time before Land starts to spawn default 35 + )
local seconds = 35 + ScenarioInfo.Options.opt_Survival_BuildTime

function OnStart()
    
    -- maximum number of group spawns
    local maximum = 1000
    local thread = ForkThread(Spawntheunitsthread, maximum)

end


function Spawntheunitsthread(maximum)
    --- seconds before Land starts to attack
    WaitSeconds (seconds)
    -- Warn of incomming Land attacks
    --ScenarioFramework.Dialogue(import('/maps/X1CA_001/X1CA_001_strings.lua').X01_M02_045, nil, true) 
   
        local count = 0
        while count < maximum do
        -- seconds in between each Land group spawn    
        WaitSeconds (ScenarioInfo.Options.opt_Survival_LandSpawnInterval)
        count = count + 1
        if count > maximum then
        break
        end
    

        --function OnStart()


         -- determine all the locations
        ---this is used to spawn units inside a random area specified in area.lua rather from a marker
        local area = Areas.PickRandomArea(Areas.spawnLandArea)

        local spawn = Areas.PickRandomPointInArea(area)
        --USe this if you want to use markers instead of areas
        --local spawn = Markers.PickRandomPosition(Markers.Landspawnmarkers)
        local attack = Markers.PickRandomPosition(Markers.dropAttackMarkers)
        -- identify the AI 
        local army = "ARMY_ENEMY"
        -- Call Landplatoons lua and pick a random army group
        local group = Landplatoons.RandomArmyGroup()    
        local units = Landplatoons.SpawnArmyGroup(group, army, spawn)


        --PrintText(count, 25 + 10, '00bfff', 9, 'center');
        
        --LOG("WHERE IT FAILS")
        --blueprint, army, x, y, z, pitch, yaw, roll
        --CreateUnitHPR(blueprint, army, 10, 10, 10, 0, 0, 0)
        --CreateUnitHPR('UEB0101','ARMY_ENEMY',270,50,440,0,0,0)
        --CreateUnitHPR('UEB0101','ARMY_ENEMY',260,40,420,0,0,0)
        --local SpawnArmyGroup = 
        --local SpawnArmyGroup(group, army, spawn)
        --LOG(repr(Landplatoons))
        
        ---Landplatoons.SpawnArmyGroup(group, army, spawn)
        --local LandPlatoons.SpawnArmyGroup(group, army, spawn)
        --CreateArmyGroup(self.AIBrain.Name, groupName, true)
        --CreateArmyGroup('ARMY_ENEMY', group, true);
        --PrintText("WORKING UO TO HERE")
        --local Landplatoons = Landplatoons.SpawnArmyGroup(group, army, spawn)
        
            --local math = require("math")

-- Randomizer pick a random function - In this case a radmon attack more for groups of units. 
            function a()
                IssueFormMove(units, attack, 'GrowthFormation', 0)
            end

            function b()
                IssueFormAggressiveMove(units, attack, 'GrowthFormation', 0)
            end

            function execute_random(f_tbl)
                local random_index = math.floor(Random() * table.getn(f_tbl)) + 1 --pick random index from 1 to #f_tbl
                f_tbl[random_index]() --execute function at the random_index we've picked
            end

            -- prepare/fill our function table
            local funcs = {a, b}

            for i = 0, 20 do
                execute_random(funcs)
            end


end
---- break here
end


    

    
