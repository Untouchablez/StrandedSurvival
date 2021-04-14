local Markers = import("/maps/survival_stranded.v0015/Markers.lua")
local Utilities = import('/lua/utilities.lua')
local ScenarioUtils = import('/lua/sim/ScenarioUtilities.lua')
local ScenarioFramework = import('/lua/ScenarioFramework.lua')
local Gateplatoons = import("/maps/survival_stranded.v0015/Gateplatoons.lua")



function OnStart()   



		
		local r = Utilities.GetRandomInt(1,4)
		local gateFaction
        local armies = ListArmies();
        local players = { };
		
        if (r == 1) then
			gateFaction = 'UAB0304'
		elseif (r == 2) then
			gateFaction = 'URB0304'
		elseif (r == 3) then
			gateFaction = 'UEB0304'
		else
			gateFaction = 'XSB0304'
		end
		
        local pos = ScenarioUtils.MarkerToPosition("gate-1")
        --spawn gate 1
        EnemyGate1 = CreateUnitHPR( gateFaction, "ARMY_ENEMY", pos[1], pos[2], pos[3], 0,0,0)
		EnemyGate1:SetMaxHealth(110000)
		EnemyGate1:SetHealth(nil,110000)
		EnemyGate1:SetReclaimable(false)
		EnemyGate1:SetCapturable(false)
		EnemyGate1:SetProductionPerSecondEnergy(9999)
		EnemyGate1:SetProductionPerSecondMass(9999)
		EnemyGate1:SetCustomName("Enemy Gate 1")

        local pos = ScenarioUtils.MarkerToPosition("gate-2")
        --spawn gate 2
        EnemyGate2 = CreateUnitHPR( gateFaction, "ARMY_ENEMY", pos[1], pos[2], pos[3], 0,0,0)
		EnemyGate2:SetMaxHealth(110000)
		EnemyGate2:SetHealth(nil,110000)
		EnemyGate2:SetReclaimable(false)
		EnemyGate2:SetCapturable(false)
		EnemyGate2:SetProductionPerSecondEnergy(9999)
		EnemyGate2:SetProductionPerSecondMass(9999)
		EnemyGate2:SetCustomName("Enemy Gate 2")
        --ScenarioFramework.CreateVisibleAreaAtUnit(visionRadius, unit, 0, GetArmyBrain(armyName))
        --ScenarioFramework.CreateVisibleAreaAtUnit(60, ScenarioInfo.ArnoldCDR, 0, ArmyBrains[Player1])
        --ScenarioFramework.CreateVisibleAreaAtUnit(60, EnemyGate1, 0, GetArmyBrain("ARMY_1"))
        
        --- make the unit visable to all human allied armys in the game
        for v, army in armies do
            if (army == "ARMY_1" or army == "ARMY_2" or army == "ARMY_3" or army == "ARMY_4"  or army == "ARMY_5"  or army == "ARMY_6") then
                table.insert(players, army)
             end
        end
        for k, player in players do   
        ScenarioFramework.CreateVisibleAreaAtUnit(15, EnemyGate1, 0, GetArmyBrain(player))
        ScenarioFramework.CreateVisibleAreaAtUnit(15, EnemyGate2, 0, GetArmyBrain(player))
        end

          -- maximum number of group spawns
    local maximum = 1000
    local thread = ForkThread(Spawntheunitsthread, maximum)

end




function Spawntheunitsthread(maximum)

    -- wait time before Land starts to spawn default 35 + )
    local seconds = 10 + ScenarioInfo.Options.opt_Survival_BuildTime
 
    --- seconds before Land starts to attack
    WaitSeconds (seconds)
    -- Warn of incomming Land attacks
    --ScenarioFramework.Dialogue(import('/maps/X1CA_001/X1CA_001_strings.lua').X01_M02_045, nil, true) 
   
        -- get number of human armies
        --local armies = ListArmies()
        --local playerCount = table.getn(armies) - 1

        local count = 0
        while count < maximum do
        
            --- adjust number of units dependant on players in game
        --if  playerCount == 1 then
        --   WaitSeconds (ScenarioInfo.Options.opt_Survival_GateSpawnInterval * 2)
        --end

        -- seconds in between each Land group spawn  
        WaitSeconds (ScenarioInfo.Options.opt_Survival_GateSpawnInterval) 
        count = count + 1
       
        if count > maximum then
            break
        elseif EnemyGate1.Dead and EnemyGate2.Dead then
            break
        end

       -- if unit.Dead then
       --     break
       --   end

        --function OnStart()
        local r = Utilities.GetRandomInt(1,2)
        if (r == 1) then
			if EnemyGate1.Dead then
                spawn = ScenarioUtils.MarkerToPosition("gate-2")
            else
            spawn = ScenarioUtils.MarkerToPosition("gate-1")
            end
		elseif (r == 2) then
            if EnemyGate2.Dead then
                spawn = ScenarioUtils.MarkerToPosition("gate-1")
            else
			spawn = ScenarioUtils.MarkerToPosition("gate-2")
            end
        end    

        local attack = Markers.PickRandomPosition(Markers.dropAttackMarkers)
        -- identify the AI 
        local army = "ARMY_ENEMY"
        -- Call Landplatoons lua and pick a random army group
        local group = Gateplatoons.RandomArmyGroup()    
        local units = Gateplatoons.SpawnArmyGroup(group, army, spawn)
 
            -- Randomizer pick a random function - In this case a radmon attack more for groups of units. 
            function a()
                local rand = Utilities.GetRandomInt(1,3)
                if (rand == 1) then
                    position = ScenarioUtils.MarkerToPosition("attackpointrand1")
                    IssueFormAggressiveMove(units, position, 'GrowthFormation', 0)
                elseif (rand == 2) then
                    IssueFormAggressiveMove(units, attack, 'GrowthFormation', 0)
                elseif (rand == 3) then
                    IssueFormMove(units, attack, 'AttackFormation', 0)    
                end
            end

            function b()
                local rand = Utilities.GetRandomInt(1,3)
                if (rand == 1) then
                    position = ScenarioUtils.MarkerToPosition("attackpointrand2")
                    IssueFormAggressiveMove(units, position, 'GrowthFormation', 0)
                elseif (rand == 2) then
                    IssueFormAggressiveMove(units, attack, 'GrowthFormation', 0)
                elseif (rand == 3) then
                    IssueFormMove(units, attack, 'AttackFormation', 0)
                end
                
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


            --- local formationTable = {
           -- 'AttackFormation',
           -- 'GrowthFormation',
           -- 'SixWideFormation',
           -- 'TravellingFormation',
           -- }

end
---- break here
end
