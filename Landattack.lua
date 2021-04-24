--- Made by GaryTheGoat --- 
--- Please do not amend / upload / copy any content without permission
--- feedback welcome samcaunt@hotmail.co.uk

local ScenarioUtils = import('/lua/sim/ScenarioUtilities.lua')
local ScenarioFramework = import('/lua/ScenarioFramework.lua')

local Markers = import("/maps/survival_stranded.v0017/Markers.lua")
local Landplatoons = import("/maps/survival_stranded.v0017/Landplatoons.lua")
local Areas = import("/maps/survival_stranded.v0017/Areas.lua")

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

--* function OnStart()
    
    -- maximum number of group spawns
    --* local maximum = 1000
    --* local thread = ForkThread(Spawntheunitsthread, maximum)
    --* local thread = ForkThread(Spawntheunitsthread)
  --* Spawntheunitsthread()
--* end


 -- * function Spawntheunitsthread(maximum)
function Spawntheunitsthread()
                --- seconds before Land starts to attack
 WaitSeconds (seconds)
                -- Warn of incomming Land attacks
                --ScenarioFramework.Dialogue(import('/maps/X1CA_001/X1CA_001_strings.lua').X01_M02_045, nil, true) 
   
                --* local count = 0
                --* while count < maximum do
    while true do
            -- seconds in between each Land group spawn    
            WaitSeconds (ScenarioInfo.Options.opt_Survival_LandSpawnInterval)
            --* count = count + 1
            --* if count > maximum then
            --*
            --* break
            --* end
        

            --function OnStart()


            local area = Areas.PickRandomArea(Areas.spawnLandArea)
            local spawn = Areas.PickRandomPointInArea(area)
            local attack = Markers.PickRandomPosition(Markers.dropAttackMarkers)
            local army = "ARMY_ENEMY"
            local group = Landplatoons.RandomArmyGroup()    
            local units = Landplatoons.SpawnArmyGroup(group, army, spawn) 
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
        --*break
        --+ end
        ---- break here
end


    

    
