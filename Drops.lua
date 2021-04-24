--- Made by GaryTheGoat --- 
--- Please do not amend / upload / copy any content without permission
--- feedback welcome samcaunt@hotmail.co.uk

local ScenarioUtils = import('/lua/sim/ScenarioUtilities.lua')
local ScenarioFramework = import('/lua/ScenarioFramework.lua')

local Markers = import("/maps/survival_stranded.v0018/Markers.lua")
local Platoons = import("/maps/survival_stranded.v0018/Platoons.lua")
-- added for AI Brain safe path finding
local AIAttackUtils = import('/lua/ai/aiattackutilities.lua')

-- pick a random transport platoon  -- check
-- pick a random transport spawn    -- check
-- pick a random transport target   -- check
-- spawn units
-- attach units to transport
-- issue unload for transport
-- issue move back for transport
-- destroy transports once out of map
-- move transportees into commander to take that dude out (to dinner) -- check

-- wait time before drops starts to spawn
local seconds = 110 + ScenarioInfo.Options.opt_Survival_BuildTime

-- todo: make this an actual loop
--function OnStart()

    --local maximum = 1000
    --local thread = ForkThread(KeepThemDroppingThread, maximum)

--end

function KeepThemDroppingThread()
   
    WaitSeconds(seconds)
    
           -- tell the user about drops / other attacks
           ScenarioFramework.Dialogue(import('/maps/X1CA_002/X1CA_002_strings.lua').X02_M02_090,nil,true)-- enemy forces are converging
    while true do
        -- local count = 0
        --while count < maximum do
    
        -- time between group spawns
        WaitSeconds (ScenarioInfo.Options.opt_Survival_DropSpawnInterval)
        --count = count + 1
        --if count > maximum then
        --break
        --end

        local function OnDetachedThread(units, callback)
            -- keep running until no longer attached
            local attached = true;
            while attached do
                WaitSeconds(1)
                attached = false
                for k, unit in units do
                    if not unit.Dead then
                        if unit:IsUnitState('Attached') then
                            -- keep checking until they are _all_ free.
                            attached = true
                            break
                        end
                    end                
                end
            end

            -- do a callback
            callback(units)
        end

        -- determine all the locations
        local spawn = Markers.PickRandomPosition(Markers.spawnTransportMarkers)
        local drop = Markers.PickRandomPosition(Markers.dropTransportMarkers)
        local attack = Markers.PickRandomPosition(Markers.dropAttackMarkers)

        --LOG(repr(attack))

        -- spawn the units and attach them
        local army = "ARMY_ENEMY"
        local group = Platoons.RandomArmyGroup()
        local transports, transportees = Platoons.SpawnArmyGroup(group, army, spawn)
        ScenarioFramework.AttachUnitsToTransports(transportees, transports)

        -- Implement SAFE Paths to drop transports
        local aiBrain = GetArmyBrain(army)
        local layer = 'Air'
        local path, reason = AIAttackUtils.PlatoonGenerateSafePathTo(
            aiBrain, layer, spawn, drop, 200 
            
        )

        if ScenarioInfo.Debug then
            LOG("Generator.Drops: " .. repr(path)) 
        end

        --**** Do not forget to import the markers**** give the transports their commands to navugate to safe points from spawn to target
        for k, point in path do 
            IssueMove(transports, point)
        end

        -- give the transports their commands
        IssueTransportUnload(transports, drop)
        IssueMove(transports, spawn)
        -- Destroy the transport after moving back to spawn
        IssueDestroySelf(transports)
        

        -- tell the units to attack once dropped
        ForkThread(
            OnDetachedThread,
            transportees, 
            function (units) 
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
        )
    

    end
    ----- break here
end
